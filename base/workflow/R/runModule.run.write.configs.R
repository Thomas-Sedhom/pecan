#' Generate model-specific run configuration files for one or more PEcAn runs
#'
#' This function serves as the orchestration layer between PEcAn workflows and
#' the config-writing machinery. It generates appropriate input designs
#' (ensemble and/or SA) if not provided. For MultiSettings, it generates designs once
#' from the first site then shares across all sites for consistent sampling. Finally,
#' it delegates to \code{\link{run.write.configs}} for actual config generation.
#' The input design determines how parameter samples and input files (met, soil,
#' etc.) are coordinated across runs. Ensemble designs typically use random or
#' quasi-random sampling, while SA designs hold non-parameter inputs constant
#' (OAT methodology).
#'
#' Internal flow (new modular path):
#' \enumerate{
#'   \item Prepare explicit in-memory samples via \code{.prepare_samples()}, which
#'         returns a structured list (trait/SA/ensemble samples and metadata).
#'   \item Build or normalize design matrices via \code{.prepare_input_designs()},
#'         using explicit \code{run}/\code{ensemble}/\code{sensitivity} inputs
#'         plus the prepared samples.
#'   \item Call \code{\link{run.write.configs}} for sensitivity and/or ensemble
#'         with explicit \code{samples} and design objects (no hidden sample
#'         loading in the primary path).
#'   \item Merge returned settings fields (ensemble IDs, sensitivity IDs, and
#'         updated PFT metadata) into a final settings object.
#' }
#'
#' @param settings a PEcAn Settings or MultiSettings object
#' @param overwrite logical: Replace config files if they already exist?
#' @param input_design Optional design input. Can be a data.frame (ensemble) or
#'   a list with `ensemble`/`sensitivity` entries.
#' @param dbCon Optional open database connection.
#' @return A modified settings object, invisibly
#'
#' @importFrom dplyr %>%
#' @importFrom rlang %||%
#' @export
runModule.run.write.configs <- function(settings,
                                        overwrite = TRUE,
                                        input_design = NULL,
                                        dbCon = NULL) {

  if (PEcAn.settings::is.MultiSettings(settings)) {
    if (overwrite && file.exists(file.path(settings$rundir, "runs.txt"))) {
      PEcAn.logger::logger.warn("Existing runs.txt file will be removed.")
      unlink(file.path(settings$rundir, "runs.txt"))
    }

    # Get structured in-memory samples object
    shared_samples <- .prepare_samples(
      pfts = settings[1]$pfts,
      outdir = settings[1]$outdir,
      ensemble = settings[1]$ensemble,
      sensitivity = settings[1]$sensitivity.analysis,
      host = settings[1]$host$name %||% NULL,
      dbCon = dbCon
    )

    # prepare designs once for all sites (consistent sampling)
    designs <- .prepare_input_designs(
      run = settings[1]$run,
      ensemble = settings[1]$ensemble,
      sensitivity = settings[1]$sensitivity.analysis,
      samples = shared_samples,
      input_design = input_design
    )
    designs$samples <- shared_samples

    return(PEcAn.settings::papply(
      settings,
      runModule.run.write.configs,
      overwrite = FALSE,
      input_design = designs,
      dbCon = dbCon
    ))
  }

  if (!PEcAn.settings::is.Settings(settings)) {
    stop("runModule.run.write.configs only works with Settings or MultiSettings")
  }

  if (is.null(settings$ensemble$samplingspace$parameters$method)) {
    settings$ensemble$samplingspace$parameters$method <- "uniform"
  }

  # Get structured in-memory samples object
  samples <- NULL
  if (is.list(input_design) && !is.null(input_design$samples)) {
    samples <- input_design$samples
  } else {
    samples <- .prepare_samples(
      pfts = settings$pfts,
      outdir = settings$outdir,
      ensemble = settings$ensemble,
      sensitivity = settings$sensitivity.analysis,
      host = settings$host$name %||% NULL,
      dbCon = dbCon
    )
  }

  # prepare designs (may already be normalized from MultiSettings)
  designs <- .prepare_input_designs(
    run = settings$run,
    ensemble = settings$ensemble,
    sensitivity = settings$sensitivity.analysis,
    samples = samples,
    input_design = input_design
  )

  write_to_db <- isTRUE(settings$database$bety$write)

  # check to see if there are posterior.files tags under pft
  posterior.files <- settings$pfts %>%
    purrr::map_chr("posterior.files", .default = NA_character_)

  # track overwrite state: first call uses overwrite param, subsequent appends
  current_overwrite <- overwrite

  # start with original settings for final merge
  settings_final <- settings
# ---------------- SENSITIVITY ANALYSIS CALL ----------------------
  if ("sensitivity.analysis" %in% names(settings) && !is.null(designs$sensitivity)) {
    PEcAn.logger::logger.info("Writing configs for Sensitivity Analysis...")

    # create settings with ONLY sensitivity.analysis (no ensemble)
    settings_sa <- settings
    settings_sa$ensemble <- NULL

    settings_sa_out <- PEcAn.workflow::run.write.configs(
      settings = settings_sa,
      ensemble.size = 1,
      write = write_to_db,
      posterior.files = posterior.files,
      overwrite = current_overwrite,
      input_design = designs$sensitivity,
      samples = samples
    )

    # capture SA ensemble.id
    settings_final$sensitivity.analysis <- settings_sa_out$sensitivity.analysis

    # also capture any pft$outdir modifications
    settings_final$pfts <- settings_sa_out$pfts

    # subsequent calls should append, not overwrite
    current_overwrite <- FALSE
  }
# ------------------- ENSEMBLE CALL ----------------------
  if ("ensemble" %in% names(settings) && !is.null(designs$ensemble)) {
    PEcAn.logger::logger.info("Writing configs for Ensemble...")

    # create settings with ONLY ensemble (no sensitivity.analysis)
    settings_ens <- settings
    settings_ens$sensitivity.analysis <- NULL

    # determine ensemble size from design
    ensemble_size <- if (!is.null(designs$ensemble)) {
      nrow(designs$ensemble)
    } else {
      settings$ensemble$size %||% 1
    }

    settings_ens_out <- PEcAn.workflow::run.write.configs(
      settings = settings_ens,
      ensemble.size = ensemble_size,
      write = write_to_db,
      posterior.files = posterior.files,
      overwrite = current_overwrite,
      input_design = designs$ensemble,
      samples = samples
    )
    # capture ensemble.id
    settings_final$ensemble <- settings_ens_out$ensemble

    # capture pft$outdir if SA didn't already
    if (!"sensitivity.analysis" %in% names(settings)) {
      settings_final$pfts <- settings_ens_out$pfts
    }
  }

  return(invisible(settings_final))
}

#' Prepare input designs for ensemble and sensitivity analysis
#' Normalizes and generates input design matrices. This helper ensures
#' consistent handling of the various input_design formats and
#' auto-generates designs when needed.
#'
#' @param run Single-site run list (`settings$run`)
#' @param ensemble Ensemble list (`settings$ensemble`)
#' @param sensitivity Sensitivity list (`settings$sensitivity.analysis`)
#' @param samples Samples list from `get.parameter.samples`
#' @param input_design User-provided design specification
#' @return List with `ensemble` and `sensitivity` data.frames
#'
#' @details
#' Input normalization rules:
#' \itemize{
#'   \item If \code{input_design} is already a list with \code{ensemble}/\code{sensitivity}
#'         keys, return as-is
#'   \item If \code{input_design} is a single data.frame, interpret as ensemble design
#'   \item If NULL and \code{settings$ensemble} exists, generate via
#'         \code{generate_joint_ensemble_design}
#'   \item If NULL and \code{settings$sensitivity.analysis} exists, generate via
#'         \code{generate_OAT_SA_design}
#' }
#'
#' @keywords internal
.prepare_input_designs <- function(run, ensemble, sensitivity, samples, input_design) {

  # already normalized? return as-is
  if (is.list(input_design) && any(c("ensemble", "sensitivity") %in% names(input_design))) {
    return(list(
      ensemble = input_design$ensemble,
      sensitivity = input_design$sensitivity
    ))
  }

  designs <- list(ensemble = NULL, sensitivity = NULL)

   # single data.frame = ensemble design
  if (is.data.frame(input_design)) {
    designs$ensemble <- input_design
  }

  # generate ensemble design if needed
  if (is.null(designs$ensemble) && !is.null(ensemble)) {
    ensemble_size <- .infer_ensemble_size(ensemble = ensemble, samples = samples)
    design_result <- PEcAn.uncertainty::generate_joint_ensemble_design(
      run = run,
      ensemble = ensemble,
      ensemble_size = ensemble_size,
      samples = samples
    )
    designs$ensemble <- design_result$X
  }

  # generate SA design if needed
  if (is.null(designs$sensitivity) && !is.null(sensitivity)) {
    design_result <- PEcAn.uncertainty::generate_OAT_SA_design(
      ensemble = ensemble,
      samples = samples
    )
    designs$sensitivity <- design_result$X
  }

  return(designs)
}

#' Assemble explicit sample objects used by design and config-writing modules
#' @keywords internal
#'
#' @param pfts PFT list (`settings$pfts`)
#' @param outdir Workflow output directory (`settings$outdir`)
#' @param ensemble Ensemble settings list (`settings$ensemble`)
#' @param sensitivity Optional sensitivity settings (`settings$sensitivity.analysis`)
#' @param host Optional host name (`settings$host$name`)
#' @param dbCon a valid, open DB connection provided by caller.
#' @return Structured samples list from \code{PEcAn.uncertainty::get.parameter.samples}.
#' @description
#' Internal helper that assembles explicit sampling inputs (distributions, trait
#' MCMC chains, ensemble metadata) and returns a structured in-memory samples
#' object for downstream design/config steps. This function intentionally avoids
#' hidden file side effects (no \code{samples.Rdata} read/write) and requires
#' the DB connection to be passed from the caller.
.prepare_samples <- function(pfts, outdir, ensemble, sensitivity = NULL, host = NULL, dbCon) {
  if (is.null(dbCon)) {
    stop(
      ".prepare_samples requires a non-NULL `dbCon`.",
      " Open the DB connection before calling runModule.run.write.configs()."
    )
  }

  posterior.files <- pfts %>%
    purrr::map_chr("posterior.files", .default = NA_character_)

  distns <- PEcAn.uncertainty:::get.distns(
    pfts = pfts,
    outdir = outdir,
    dbCon = dbCon,
    host = host,
    posterior.files = posterior.files
  )
  trait.mcmc <- PEcAn.uncertainty:::get.trait.mcmc(
    pfts = pfts,
    outdir = outdir,
    dbCon = dbCon,
    host = host
  )

  ensemble_size <- ensemble$size %||% 1
  ens_method <- ensemble$samplingspace$parameters$method %||% "uniform"

  PEcAn.uncertainty::get.parameter.samples(
    pfts = pfts,
    outdir = outdir,
    sensitivity = sensitivity,
    trait.mcmc = trait.mcmc,
    distns = distns,
    ensemble = ensemble,
    ensemble.size = ensemble_size,
    ens.sample.method = ens_method,
    write.legacy.file = FALSE
  )
}

#' Infer Ensemble Size From Explicit Objects
#'
#' internal helper to determine the ensemble size from explicit inputs,
#' preferring the declared ensemble size and falling back to sample dimensions.
#'
#' @param ensemble Ensemble settings list (`settings$ensemble`).
#' @param samples Structured samples list from `get.parameter.samples`.
#' @return Integer ensemble size used to build design matrices.
#' @keywords internal
.infer_ensemble_size <- function(ensemble, samples) {
  # Prefer explicit size from settings when available.
  if (!is.null(ensemble$size)) {
    return(as.integer(ensemble$size))
  }

  # Fallback: infer size from first PFT in ensemble samples.
  if (!is.null(samples$ensemble.samples) && length(samples$ensemble.samples) > 0) {
    first_pft <- samples$ensemble.samples[[1]]
    if (is.data.frame(first_pft) || is.matrix(first_pft)) {
      return(nrow(first_pft))
    }
  }

  # Final fallback for minimal/single-run workflows.
  1L
}
