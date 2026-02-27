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

    shared_samples <- .prepare_samples(settings[1], dbCon)
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

  if (!is.null(settings$ensemble) && is.null(settings$ensemble$samplingspace$parameters$method)) {
    settings$ensemble$samplingspace$parameters$method <- "uniform"
  }

  samples <- NULL
  if (is.list(input_design) && !is.null(input_design$samples)) {
    samples <- input_design$samples
  } else {
    samples <- .prepare_samples(settings, dbCon)
  }

  designs <- .prepare_input_designs(
    run = settings$run,
    ensemble = settings$ensemble,
    sensitivity = settings$sensitivity.analysis,
    samples = samples,
    input_design = input_design
  )

  write_to_db <- isTRUE(settings$database$bety$write)
  posterior.files <- settings$pfts %>%
    purrr::map_chr("posterior.files", .default = NA_character_)

  current_overwrite <- overwrite
  settings_final <- settings

  if ("sensitivity.analysis" %in% names(settings) && !is.null(designs$sensitivity)) {
    PEcAn.logger::logger.info("Writing configs for Sensitivity Analysis...")

    settings_sa <- settings
    settings_sa$ensemble <- NULL

    settings_sa_out <- PEcAn.workflow::run.write.configs(
      settings = settings_sa,
      ensemble.size = 1,
      input_design = designs$sensitivity,
      samples = samples,
      write = write_to_db,
      posterior.files = posterior.files,
      overwrite = current_overwrite
    )

    settings_final$sensitivity.analysis <- settings_sa_out$sensitivity.analysis
    settings_final$pfts <- settings_sa_out$pfts
    current_overwrite <- FALSE
  }

  if ("ensemble" %in% names(settings) && !is.null(designs$ensemble)) {
    PEcAn.logger::logger.info("Writing configs for Ensemble...")

    settings_ens <- settings
    settings_ens$sensitivity.analysis <- NULL

    ensemble_size <- nrow(designs$ensemble)

    settings_ens_out <- PEcAn.workflow::run.write.configs(
      settings = settings_ens,
      ensemble.size = ensemble_size,
      input_design = designs$ensemble,
      samples = samples,
      write = write_to_db,
      posterior.files = posterior.files,
      overwrite = current_overwrite
    )

    settings_final$ensemble <- settings_ens_out$ensemble
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
#' @keywords internal
.prepare_input_designs <- function(run, ensemble, sensitivity, samples, input_design) {
  if (is.list(input_design) && any(c("ensemble", "sensitivity") %in% names(input_design))) {
    return(list(
      ensemble = input_design$ensemble,
      sensitivity = input_design$sensitivity
    ))
  }

  designs <- list(ensemble = NULL, sensitivity = NULL)

  if (is.data.frame(input_design)) {
    designs$ensemble <- input_design
  }

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

  if (is.null(designs$sensitivity) && !is.null(sensitivity)) {
    design_result <- PEcAn.uncertainty::generate_OAT_SA_design(
      ensemble = ensemble,
      samples = samples
    )
    designs$sensitivity <- design_result$X
  }

  designs
}

#' Assemble explicit sample objects used by design and config-writing modules
#' @keywords internal
.prepare_samples <- function(settings, dbCon = NULL) {
  host <- settings$host$name %||% NULL
  posterior.files <- settings$pfts %>%
    purrr::map_chr("posterior.files", .default = NA_character_)

  local_con <- NULL
  if (is.null(dbCon) && !is.null(settings$database$bety)) {
    maybe_con <- try(PEcAn.DB::db.open(settings$database$bety), silent = TRUE)
    if (!inherits(maybe_con, "try-error")) {
      local_con <- maybe_con
      on.exit(try(PEcAn.DB::db.close(local_con), silent = TRUE), add = TRUE)
    }
  }
  active_con <- dbCon %||% local_con

  distns <- PEcAn.uncertainty:::get.distns(
    pfts = settings$pfts,
    outdir = settings$outdir,
    dbCon = active_con,
    host = host,
    posterior.files = posterior.files
  )
  trait.mcmc <- PEcAn.uncertainty:::get.trait.mcmc(
    pfts = settings$pfts,
    outdir = settings$outdir,
    dbCon = active_con,
    host = host
  )

  ensemble_size <- settings$ensemble$size %||% 1
  ens_method <- settings$ensemble$samplingspace$parameters$method %||% "uniform"

  PEcAn.uncertainty::get.parameter.samples(
    pfts = settings$pfts,
    outdir = settings$outdir,
    sensitivity = settings$sensitivity.analysis,
    trait.mcmc = trait.mcmc,
    distns = distns,
    ensemble = settings$ensemble,
    ensemble.size = ensemble_size,
    ens.sample.method = ens_method,
    write.legacy.file = FALSE
  )
}

#' infer ensemble size from explicit objects
#' @keywords internal
.infer_ensemble_size <- function(ensemble, samples) {
  if (!is.null(ensemble$size)) {
    return(as.integer(ensemble$size))
  }
  if (!is.null(samples$ensemble.samples) && length(samples$ensemble.samples) > 0) {
    first_pft <- samples$ensemble.samples[[1]]
    if (is.data.frame(first_pft) || is.matrix(first_pft)) {
      return(nrow(first_pft))
    }
  }
  1L
}
