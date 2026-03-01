#' Generate joint ensemble design for parameter sampling
#' Creates a joint ensemble design that maintains parameter correlations across
#' all sites in a multi-site run. This function generates sample indices that
#' are shared across sites to ensure consistent parameter sampling.
#'
#' @details
#' Note on internal dependencies
#'
#' This function does not load `samples.Rdata` and does not call
#' `get.parameter.samples()` internally. Parameter samples must be prepared
#' upstream and passed explicitly via `samples`.
#'
#' In practice this means:
#' - parameter distributions and trait MCMC chains are resolved before this call;
#' - this function uses only `run`, `ensemble`, `ensemble_size`, and `samples`;
#' - no implicit file lookup or database fallback occurs in this step.
#'
#' Difference from `generate_OAT_SA_design`: this function samples non-parameter
#' inputs according to the configured sampling space (random/quasi-random or
#' parent-linked methods), while `generate_OAT_SA_design` holds non-parameter
#' inputs constant to isolate parameter effects.
#'
#' @param run List containing run inputs (`run$inputs`).
#' @param ensemble List containing ensemble sampling space (`ensemble$samplingspace`).
#' @param ensemble_size Integer specifying the number of ensemble members.
#'   The input_design is generated once for the entire model run. You might
#'   want to recycle existing ensemble_samples when splitting larger runs
#'   into smaller jobs while keeping the same parameters.
#' @param samples Structured samples list produced by `get.parameter.samples()`.
#' @param sobol Logical. If TRUE, returns a \code{sensitivity::soboljansen}
#'   object for Sobol sensitivity analysis.#'
#' @return A list containing ensemble samples and indices.
#'   If \code{sobol = FALSE}, returns \code{list(X = design_matrix)}.
#'   If \code{sobol = TRUE}, returns a \code{sensitivity::soboljansen()}
#'   result object with the design matrix in \code{$X} plus additional
#'   components for Sobol index calculations.
#'
#' @export
generate_joint_ensemble_design <- function(run, ensemble, ensemble_size, samples, sobol = FALSE) {
  if (missing(run) || is.null(run) || missing(ensemble) || is.null(ensemble)) {
    stop("`run` and `ensemble` are required.")
  }
  if (missing(samples) || is.null(samples)) {
    stop("`samples` is required. Build samples first with get.parameter.samples().")
  }
  if (isTRUE(sobol)) {
    ensemble_size <- as.numeric(ensemble_size) * 2
  }

  samp <- ensemble$samplingspace
  parents <- lapply(samp, "[[", "parent")
  order <- names(samp)[
    lapply(parents, function(tr) which(names(samp) %in% tr)) %>%
      unlist()
  ]
  samp.ordered <- samp[c(order, names(samp)[!(names(samp) %in% order)])]

  design_list <- list()
  sampled_inputs <- list()

   # loop over inputs.
  for (i in seq_along(samp.ordered)) {
    input_tag <- names(samp.ordered)[i]
    parent_name <- samp.ordered[[i]]$parent

    parent_ids <- if (!is.null(parent_name)) {
      sampled_inputs[[parent_name]]
    } else {
      NULL
    }

    input_result <- PEcAn.uncertainty::input.ens.gen(
      run = run,
      ensemble_size = ensemble_size,
      input = input_tag,
      method = samp.ordered[[i]]$method,
      parent_ids = parent_ids
    )

    sampled_inputs[[input_tag]] <- input_result
    design_list[[input_tag]] <- input_result$ids
  }
  # Here we assumed the length of parameters is identical to the ensemble size.
  # TODO: detect if they are identical. If not, we will need to resample the 
  # parameters with replacement.
  design_list[["param"]] <- seq_len(ensemble_size)
  design_matrix <- data.frame(design_list)

  if (sobol) {
    half <- floor(ensemble_size / 2)
    X1 <- design_matrix[1:half, , drop = FALSE]
    X2 <- design_matrix[(half + 1):ensemble_size, , drop = FALSE]
    sobol_obj <- sensitivity::soboljansen(model = NULL, X1 = X1, X2 = X2)
    return(sobol_obj)
  }
  # This ensures that regardless of whether the sobol or non-sobol version is called 
  # that the output is a list that includes the design as X. In the sobol version the 
  # list includes additional info beyond just X that's required by the function that 
  # does the sobol index calculations, but not required to do the runs themselves.
  return(list(X = design_matrix))
}
