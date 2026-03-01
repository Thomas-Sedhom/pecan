#' Generate One-At-a-Time (OAT) Design for Sensitivity Analysis
#'
#' Creates an input design matrix for sensitivity analysis where non-parameter
#' inputs (met, IC, soil, etc.) are held constant while parameters vary
#' one-at-a-time across quantiles. This differs from ensemble design where
#' all inputs vary together.
#'

#' @param ensemble Ensemble settings list with `samplingspace`.
#' @param samples Structured samples list from `get.parameter.samples()`.
#'   Must include `sa.samples`.
#'
#' @details
#' ## Required Inputs
#'
#' This function uses only explicit objects:
#' \itemize{
#'   \item \code{ensemble$samplingspace}: defines which input columns appear in
#'         the design matrix.
#'   \item \code{samples$sa.samples}: sensitivity samples used to determine total
#'         SA run count.
#' }
#'
#' No \code{settings} object is used, and there is no implicit file loading or
#' database access inside this function.
#'
#' ## OAT Design Logic
#'
#' For one-at-a-time sensitivity analysis, parameter effects are isolated by:
#' \itemize{
#'   \item setting \code{param} to sequential indices
#'         (\code{1, 2, 3, ...}) matching SA run order;
#'   \item fixing all non-parameter input columns (\code{met}, \code{soil},
#'         \code{ic}, etc.) to \code{1}, meaning \"use the first input file\".
#' }
#'
#' This keeps non-parameter inputs constant across SA runs while parameters vary.
#'
#' @return list with component X: a data.frame with columns for each input type
#'   and one row per SA run. Non-parameter columns are all 1 (constant).
#' @examples
#' \dontrun{
#' samples <- PEcAn.uncertainty::get.parameter.samples(...)
#' sa_design <- generate_OAT_SA_design(
#'   ensemble = settings$ensemble,
#'   samples = samples
#' )
#' }

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
#' @author Akash B V
#' @importFrom rlang %||%

generate_OAT_SA_design <- function(ensemble, samples) {
  if (missing(ensemble) || is.null(ensemble)) {
    stop("`ensemble` is required.")
  }
  if (missing(samples) || is.null(samples) || is.null(samples$sa.samples)) {
    stop("`samples$sa.samples` is required for OAT design generation.")
  }

  sa_samples <- samples$sa.samples

  # calculate total number of SA runs
  # 1 median + (traits * non-median quantiles) per PFT
  MEDIAN <- "50"
  num_sa_runs <- 1 # start with median run

  for (pft_name in names(sa_samples)) {
    if (pft_name == "env") next
    pft_samples <- sa_samples[[pft_name]]
    n_traits <- ncol(pft_samples)
    quantile_names <- rownames(pft_samples)
    n_non_median <- sum(quantile_names != MEDIAN)

    # add runs for this pft: (traits) * (non-median quantiles)
    num_sa_runs <- num_sa_runs + (n_traits * n_non_median)
  }

  # get input types from samplingspace
  samp <- ensemble$samplingspace
  input_types <- names(samp)
  input_types[input_types == "parameters"] <- "param"
  if (!("param" %in% input_types)) {
    input_types <- c("param", input_types)
  }

  # build design matrix
  # key difference from ensemble design:
  # - ensemble: all columns get random/quasi-random indices
  # - SA (OAT): param column = sequential index, ALL other columns = 1
  #
  # the "1" means: use the FIRST (and only) input file for that type.
  # this ensures all SA runs use the SAME met, same ic, etc.
  design_list <- list()
  for (input_type in input_types) {
    if (input_type == "param") {
      # sequential indices map to SA run order
      #   1 = median run
      #   2 = first (pft, trait, quantile) combination
      #   3 = second (pft, trait, quantile) combination
      #   ...
      design_list[[input_type]] <- seq_len(num_sa_runs)
    } else {
       # all other inputs constant(always use first input file)
      design_list[[input_type]] <- rep(1L, num_sa_runs)
    }
  }

  design_matrix <- data.frame(design_list)
  return(list(X = design_matrix))
}
