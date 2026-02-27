#' Generate One-At-a-Time (OAT) design for sensitivity analysis
#'

#' @param ensemble Ensemble settings list with `samplingspace`.
#' @param samples Samples list produced by `get.parameter.samples()`.
#' @param settings Deprecated compatibility parameter.
#' @param sa_samples Deprecated compatibility parameter.
#'
#' @return list with component `X`: a data.frame design matrix.
' @details 
#' ## Settings requirements
#' 
#' This function directly uses:
#' \itemize{
#'   \item \code{settings$outdir} - Output directory path for samples.Rdata
#'   \item \code{settings$pfts} - List of PFTs (extracts \code{posterior.files})
#'   \item \code{settings$ensemble$samplingspace} - Input types to include in design
#' }
#' 
#' When \code{sa_samples = NULL}, settings is passed to
#' \code{\link{get.parameter.samples}} which additionally requires:
#' \itemize{
#'   \item \code{settings$sensitivity.analysis} - SA quantile configuration
#'   \item \code{settings$database$bety} - Database connection (optional)
#'   \item \code{settings$host$name} - Host name for dbfile.check (optional)
#' }
#'
#' ## OAT design logic
#' For sensitivity analysis, we must isolate the effect of each 
#' parameter by holding all other inputs constant. The param column contains
#' sequential indices (1, 2, 3, ...) matching the SA run order in 
#' \code{write.sa.configs}. All other columns (met, ic, soil, etc.) are set to 1,
#' meaning the first input file is always used.
#'
#' Note on internal dependencies
#'
#' If sa_samples is NULL we hand off to get.parameter.samples(), which does
#' the work of finding and loading parameter distributions.
#'
#' In practice it:
#' - uses pft$posterior.files directly when it is defined (an Rdata file with
#'   post.distns or prior.distns),
#' - otherwise figures out an output directory from pft$outdir or, if needed,
#'   via pft$posteriorid in the database,
#' - then looks in that directory for post.distns.Rdata, falling back to
#'   prior.distns.Rdata,
#' - and, for MCMC posteriors, looks up trait.mcmc*.Rdata linked to the same
#'   posteriorid or a trait.mcmc.Rdata file in that directory.
#'
#' @param settings PEcAn settings object. See details for required elements.
#' @param sa_samples Optional. Pre-loaded SA samples (named list with one
#'   element per PFT, each a matrix with quantiles as rows and traits as columns).
#'   If NULL (default), samples are generated via \code{get.parameter.samples}.
#'
#' @return list with component X: a data.frame with columns for each input type
#'   and one row per SA run. Non-parameter columns are all 1 (constant).
#'
#' @examples
#' \dontrun{
#' # Generate SA design for a multi-site run
#' sa_design <- generate_OAT_SA_design(settings)
#' 
#' # View the design matrix
#' print(sa_design$X)
#' #   param met ic soil
#' # 1     1   1  1    1   # Median run
#' # 2     2   1  1    1   # trait1 @ q=2.3%
#' # 3     3   1  1    1   # trait1 @ q=15.9%
#' # 4     4   1  1    1   # trait1 @ q=84.1%
#' # ...
#' 
#' # With pre-loaded sa_samples (skips get.parameter.samples call)
#' load("samples.Rdata")
#' sa_design <- generate_OAT_SA_design(settings, sa_samples = sa.samples)
#' }
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
