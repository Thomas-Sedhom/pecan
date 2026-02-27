#' Generate One-At-a-Time (OAT) design for sensitivity analysis
#'
#' @param ensemble Ensemble settings list with `samplingspace`.
#' @param samples Samples list produced by `get.parameter.samples()`.
#' @param settings Deprecated compatibility parameter.
#' @param sa_samples Deprecated compatibility parameter.
#'
#' @return list with component `X`: a data.frame design matrix.
#' @export
#' @importFrom rlang %||%

generate_OAT_SA_design <- function(ensemble = NULL,
                                   samples = NULL,
                                   settings = NULL,
                                   sa_samples = NULL) {
  if (!is.null(settings)) {
    .Deprecated(msg = paste(
      "Passing `settings`/`sa_samples` to generate_OAT_SA_design() is deprecated.",
      "Pass `ensemble` and `samples` explicitly."
    ))
    ensemble <- ensemble %||% settings$ensemble

    if (is.null(samples) && !is.null(sa_samples)) {
      samples <- list(sa.samples = sa_samples)
    }

    if (is.null(samples)) {
      samples_file <- file.path(settings$outdir, "samples.Rdata")
      if (file.exists(samples_file)) {
        env <- new.env(parent = emptyenv())
        load(samples_file, envir = env)
        samples <- list(sa.samples = env$sa.samples)
      }
    }
  }

  if (is.null(ensemble)) {
    stop("`ensemble` is required.")
  }
  if (is.null(samples) || is.null(samples$sa.samples)) {
    stop("`samples$sa.samples` is required for OAT design generation.")
  }

  sa_samples <- samples$sa.samples

  MEDIAN <- "50"
  num_sa_runs <- 1

  for (pft_name in names(sa_samples)) {
    if (pft_name == "env") next
    pft_samples <- sa_samples[[pft_name]]
    n_traits <- ncol(pft_samples)
    quantile_names <- rownames(pft_samples)
    n_non_median <- sum(quantile_names != MEDIAN)
    num_sa_runs <- num_sa_runs + (n_traits * n_non_median)
  }

  samp <- ensemble$samplingspace
  input_types <- names(samp)
  input_types[input_types == "parameters"] <- "param"
  if (!("param" %in% input_types)) {
    input_types <- c("param", input_types)
  }

  design_list <- list()
  for (input_type in input_types) {
    if (input_type == "param") {
      design_list[[input_type]] <- seq_len(num_sa_runs)
    } else {
      design_list[[input_type]] <- rep(1L, num_sa_runs)
    }
  }

  design_matrix <- data.frame(design_list)
  return(list(X = design_matrix))
}
