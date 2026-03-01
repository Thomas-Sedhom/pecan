#' Convert priors / MCMC samples to chains that can be sampled
#'   for model parameters
#'
#' @param settings Deprecated compatibility input (PEcAn settings object).
#' @param ensemble.size number of runs in model ensemble
#' @param posterior.files list of filenames to read from (legacy mode)
#' @param ens.sample.method one of "halton", "sobol", "torus", "lhc", "uniform"
#' @param pfts List of PFT objects.
#' @param outdir Workflow output directory.
#' @param sensitivity Sensitivity settings list (typically `settings$sensitivity.analysis`).
#' @param trait.mcmc Named list of trait MCMC chains by PFT.
#' @param distns Named list of prior/posterior distributions by PFT.
#' @param ensemble Optional ensemble settings list (typically `settings$ensemble`).
#' @param ensemble.samples Optional pre-computed ensemble samples.
#' @param runs.samples Optional runs samples payload.
#' @param env.samples Optional environmental samples payload.
#' @param write.legacy.file logical: write `samples.Rdata` to outdir (deprecated side effect).
#' @export
#'
#' @author David LeBauer, Shawn Serbin, Istem Fer
#' @importFrom rlang %||%
get.parameter.samples <- function(settings = NULL,
                                  ensemble.size = 1,
                                  posterior.files = if (!is.null(settings)) rep(NA, length(settings$pfts)) else NULL,
                                  ens.sample.method = "uniform",
                                  pfts = NULL,
                                  outdir = NULL,
                                  sensitivity = NULL,
                                  trait.mcmc = NULL,
                                  distns = NULL,
                                  ensemble = NULL,
                                  write.legacy.file = FALSE) {

  legacy_mode <- !is.null(settings)

  if (legacy_mode) {
    .Deprecated(msg = paste(
      "Passing `settings` to get.parameter.samples() is deprecated.",
      "Pass explicit objects: pfts, outdir, sensitivity, trait.mcmc, distns, and ensemble instead."
    ))

    ### Identify PFTs in the input settings.xml file
    pfts <- settings$pfts
    outdir <- settings$outdir
    sensitivity <- sensitivity %||% settings$sensitivity.analysis
    ensemble <- ensemble %||% settings$ensemble

    ## Open database connection
    con <- try(PEcAn.DB::db.open(settings$database$bety))
    on.exit(try(PEcAn.DB::db.close(con), silent = TRUE), add = TRUE)

    # If we fail to connect to DB then we set to NULL
    if (inherits(con, "try-error")) {
      con <- NULL
      PEcAn.logger::logger.warn(
        "We were not able to successfully establish a connection with Bety "
      )
    }

    if (is.null(distns)) {
      distns <- get.distns(
        pfts = pfts,
        outdir = outdir,
        dbCon = con,
        host = settings$host$name %||% NULL,
        posterior.files = posterior.files
      )
    }
    if (is.null(trait.mcmc)) {
      trait.mcmc <- get.trait.mcmc(
        pfts = pfts,
        outdir = outdir,
        dbCon = con,
        host = settings$host$name %||% NULL
      )
    }
    write.legacy.file <- TRUE
  }

  if (is.null(pfts)) {
    stop("`pfts` is required.")
  }

  ### extract pft names
  pft.names <- vapply(pfts, function(p) p$name %||% "NULL", FUN.VALUE = character(1))
  names(pft.names) <- pft.names
  PEcAn.logger::logger.info("Selected PFT(s): ", pft.names)

  ## Generate empty list arrays for output.
  trait.samples <- sa.samples <- ensemble.samples <- env.samples <- list()
  runs.samples <- param.names <- list()

  # flag determining whether samples are independent
  # (e.g. when params fitted individually)
  independent <- TRUE

  ## Load PFT priors and posteriors
  for (i in seq_along(pfts)) {
    pft.name <- unlist(pft.names[i])
    pft.dist <- distns[[i]] %||% list()
    pft_trait_mcmc <- trait.mcmc[[i]] %||% trait.mcmc[[pft.name]]

    ### When no ma for a trait, sample from prior
    ### Trim all chains to shortest mcmc chain, else 20000 samples
    if (!is.null(distns$prior.distns)) {
      priors <- rownames(distns$prior.distns)
    } else {
      priors <- NULL
    }
    if (!is.null(pft_trait_mcmc)) {
      trait_mcmc_file <- attr(pft_trait_mcmc, "source_file")
      # PDA samples are fitted together, to preserve correlations downstream
      # let workflow know they should go together
      if (!is.null(trait_mcmc_file) && grepl("mcmc.pda", trait_mcmc_file)) {
        independent <- FALSE
      }
      param.names[[i]] <- names(pft_trait_mcmc)
      names(param.names)[i] <- pft.name
      samples.num <- min(sapply(pft_trait_mcmc, function(x) nrow(as.matrix(x))))
      ## report which traits use MA results, which use priors
      if (length(param.names[[i]]) > 0) {
        PEcAn.logger::logger.info(
          "PFT", pft.names[i], "has MCMC samples for:\n",
          paste0(param.names[[i]], collapse = "\n ")
        )
      }
      if (!all(priors %in% param.names[[i]])) {
        PEcAn.logger::logger.info(
          "PFT", pft.names[i], "will use prior distributions for:\n",
          paste0(priors[!priors %in% param.names[[i]]], collapse = "\n ")
        )
      }
    } else {
      param.names[[i]] <- list()
      samples.num <- 20000
      PEcAn.logger::logger.info("No MCMC results for PFT", pft.names[i])
      PEcAn.logger::logger.info(
        "PFT", pft.names[i], "will use prior distributions for",
        priors
      )
    }
    if (is.null(priors)) priors <- param.names[[i]]

    PEcAn.logger::logger.info("using ", samples.num, "samples per trait")
    if (ens.sample.method == "halton") {
      q_samples <- randtoolbox::halton(n = samples.num, dim = length(priors))
    } else if (ens.sample.method == "sobol") {
      q_samples <- randtoolbox::sobol(
        n = samples.num, 
        dim = length(priors), 
        scrambling = 3
        )
    } else if (ens.sample.method == "torus") {
      q_samples <- randtoolbox::torus(n = samples.num, dim = length(priors))
    } else if (ens.sample.method == "lhc") {
      q_samples <- PEcAn.emulator::lhc(
        t(matrix(0:1, ncol = length(priors), nrow = 2)), 
        samples.num
        )
    } else if (ens.sample.method == "uniform") {
      q_samples <- matrix(
        stats::runif(samples.num * length(priors)),
        samples.num,
        length(priors)
      )
    } else {
      PEcAn.logger::logger.info(
        "Method ", ens.sample.method,
        " has not been implemented yet, using uniform random sampling"
      )
      # uniform random
      q_samples <- matrix(
        stats::runif(samples.num * length(priors)),
        samples.num,
        length(priors)
      )
    }

    for (prior in priors) {
      if (!is.null(pft_trait_mcmc) && prior %in% param.names[[i]]) {
        samples <- pft_trait_mcmc[[prior]] %>%
          purrr::map(~ .x[, "beta.o"]) %>%
          unlist() %>%
          as.matrix()
      } else {
        samples <- PEcAn.priors::get.sample(
          pft_dist$prior.distns[prior, ],
          samples.num,
          q_samples[, priors == prior]
        )
      }
      trait.samples[[pft.name]][[prior]] <- samples
    }
  } ### End for loop

  # if samples are independent, set param.names to NULL
  # this is important for downstream, when param.names is not NULL
  # MCMC will be sampled accordingly
  if (independent) {
    param.names <- NULL
  }

  if (!is.null(sensitivity)) {
    ### Get info on the quantiles to be run in the sensitivity analysis
    ### (if requested)
    quantiles <- PEcAn.utils::get.quantiles(sensitivity$quantiles)
    PEcAn.logger::logger.info(
      "\n Selected Quantiles: ",
      PEcAn.utils::vecpaste(round(quantiles, 3))
    )

    ### Generate list of sample quantiles for SA run
    sa.samples <- PEcAn.utils::get.sa.sample.list(
      pft = trait.samples,
      env = env.samples,
      quantiles = quantiles
    )
  }

  if (!is.null(ensemble)) {
    if (ensemble.size == 1) {
      ## run at median if only one run in ensemble
      ensemble.samples <- PEcAn.utils::get.sa.sample.list(
        pft = trait.samples,
        env = env.samples,
        quantiles = 0.5
      )
    } else if (ensemble.size > 1) {
      ## subset the trait.samples to ensemble size using Halton sequence
      ensemble.samples <- get_ensemble_samples(
        ensemble.size = ensemble.size,
        trait.samples = trait.samples,
        env.samples = env.samples,
        ens.sample.method = ens.sample.method,
        param.names = param.names
      )
    }
  }

  samples <- list(
    trait.samples = trait.samples,
    sa.samples = sa.samples,
    ensemble.samples = ensemble.samples,
    runs.samples = runs.samples,
    env.samples = env.samples,
    param.names = param.names
  )

  if (isTRUE(write.legacy.file) && !is.null(outdir)) {
    PEcAn.logger::logger.warn(
      "Writing samples.Rdata from get.parameter.samples() is deprecated and will be removed in a future release."
    )
    save(
      samples$ensemble.samples,
      samples$trait.samples,
      samples$sa.samples,
      samples$runs.samples,
      samples$env.samples,
      file = file.path(outdir, "samples.Rdata")
    )
  }

  return(samples)
}# get.parameter.samples
