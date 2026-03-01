# Internal helpers for modular sample assembly.

.resolve_pft_outdirs <- function(pfts, outdir = NULL, dbCon = NULL) {
  outdirs <- vector("list", length(pfts))
  for (i in seq_along(pfts)) {
    if (!is.null(pfts[[i]]$outdir) && !is.na(pfts[[i]]$outdir)) {
      outdirs[[i]] <- pfts[[i]]$outdir
      next
    }
    if (!is.null(outdir) && !is.null(pfts[[i]]$name)) {
      outdirs[[i]] <- file.path(outdir, "pfts", pfts[[i]]$name)
      next
    }
    if (!is.null(dbCon) && !is.null(pfts[[i]]$posteriorid)) {
      paths <- PEcAn.DB::dbfile.check(
        type = "Posterior",
        container.id = pfts[[i]]$posteriorid,
        con = dbCon
      )$file_path
      outdirs[[i]] <- unique(paths)[1]
      next
    }
    outdirs[[i]] <- NULL
  }
  outdirs
}

#' Internal helper to load prior/posterior distributions per PFT
#' @keywords internal
get.distns <- function(pfts, outdir = NULL, dbCon = NULL, host = NULL,
                       posterior.files = rep(NA_character_, length(pfts))) {
  outdirs <- .resolve_pft_outdirs(pfts = pfts, outdir = outdir, dbCon = dbCon)
  distns <- vector("list", length(pfts))
  names(distns) <- vapply(
    pfts,
    function(p) p$name %||% "NULL",
    FUN.VALUE = character(1)
  )

  for (i in seq_along(pfts)) {
    dist_env <- new.env(parent = emptyenv())
    ## Load posteriors
    if (!is.na(posterior.files[i])) {
      # Load specified file
      load(posterior.files[i], envir = dist_env)
      if (is.null(dist_env$prior.distns) && !is.null(dist_env$post.distns)) {
        dist_env$prior.distns <- dist_env$post.distns
      }
      distns[[i]] <- as.list(dist_env)
      next
    }

    pft_outdir <- outdirs[[i]]
    if (is.null(pft_outdir)) {
      distns[[i]] <- list(prior.distns = NULL, post.distns = NULL)
      next
    }

    # Default to most recent posterior in the workflow,
    # or the prior if there is none
    post_file <- file.path(pft_outdir, "post.distns.Rdata")
    prior_file <- file.path(pft_outdir, "prior.distns.Rdata")
    if (file.exists(post_file)) {
      load(post_file, envir = dist_env)
      if (is.null(dist_env$prior.distns) && !is.null(dist_env$post.distns)) {
        dist_env$prior.distns <- dist_env$post.distns
      }
    } else if (file.exists(prior_file)) {
      load(prior_file, envir = dist_env)
    }
    distns[[i]] <- as.list(dist_env)
  }
  distns
}

#' Internal helper to Load trait mcmc data (if exists, either from MA or PDA)
#' @keywords internal
get.trait.mcmc <- function(pfts, outdir = NULL, dbCon = NULL, host = NULL,
                           outdirs = NULL) {
  if (is.null(outdirs)) {
    outdirs <- .resolve_pft_outdirs(pfts = pfts, outdir = outdir, dbCon = dbCon)
  }

  chains <- vector("list", length(pfts))
  names(chains) <- vapply(
    pfts,
    function(p) p$name %||% "NULL",
    FUN.VALUE = character(1)
  )

  for (i in seq_along(pfts)) {
    trait_file <- NULL
    if (!is.null(dbCon) && !is.null(pfts[[i]]$posteriorid)) {
      # first check if there are any files associated with posterior ids
      files <- PEcAn.DB::dbfile.check(
        "Posterior",
        pfts[[i]]$posteriorid,
        dbCon,
        host,
        return.all = TRUE
      )
      tid <- grep("trait.mcmc.*Rdata", files$file_name)
      if (length(tid) > 0) {
        trait_file <- file.path(files$file_path[tid][1], files$file_name[tid][1])
      }
    }
    if (is.null(trait_file) && !is.null(outdirs[[i]]) &&
        file.exists(file.path(outdirs[[i]], "trait.mcmc.Rdata"))) {
      trait_file <- file.path(outdirs[[i]], "trait.mcmc.Rdata")
    }
    if (is.null(trait_file)) {
      chains[[i]] <- NULL
      next
    }
    env <- new.env(parent = emptyenv())
    load(trait_file, envir = env)
    chains[[i]] <- env$trait.mcmc
    attr(chains[[i]], "source_file") <- trait_file
  }

  chains
}

#' Internal helper to generate ensemble samples from trait samples
#' @keywords internal
get_ensemble_samples <- function(ensemble.size, trait.samples, env.samples = list(),
                                 ens.sample.method = "uniform", param.names = NULL) {
  sampled <- PEcAn.uncertainty::get.ensemble.samples(
    ensemble.size = ensemble.size,
    pft.samples = trait.samples,
    env.samples = env.samples,
    method = ens.sample.method,
    param.names = param.names
  )
  sampled[[1]]
}

#' Internal validation for samples object passed through config workflow
#' @keywords internal
.validate_samples_list <- function(samples) {
  required <- c("trait.samples", "sa.samples", "ensemble.samples", "runs.samples", "env.samples")
  missing <- setdiff(required, names(samples))
  if (length(missing) > 0) {
    stop("samples is missing required entries: ", paste(missing, collapse = ", "))
  }
  invisible(TRUE)
}
