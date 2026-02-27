#' Generate joint ensemble design for parameter sampling
#' Creates a joint ensemble design that maintains parameter correlations across
#' all sites in a multi-site run.
#'
#' @param run List containing run inputs (`run$inputs`).
#' @param ensemble List containing ensemble sampling space (`ensemble$samplingspace`).
#' @param ensemble_size Integer specifying number of ensemble members.
#' @param samples Samples list produced by `get.parameter.samples()`.
#' @param sobol Logical. If TRUE, returns a `sensitivity::soboljansen` object.
#' @param settings Deprecated compatibility parameter.
#'
#' @return If `sobol = FALSE`, returns `list(X = design_matrix)`.
#'   If `sobol = TRUE`, returns Sobol object that contains `$X`.
#' @export

generate_joint_ensemble_design <- function(run = NULL,
                                           ensemble = NULL,
                                           ensemble_size,
                                           samples = NULL,
                                           sobol = FALSE,
                                           settings = NULL) {
  if (!is.null(settings)) {
    .Deprecated(msg = paste(
      "Passing `settings` to generate_joint_ensemble_design() is deprecated.",
      "Pass `run`, `ensemble`, and `samples` explicitly."
    ))
    run <- run %||% settings$run
    ensemble <- ensemble %||% settings$ensemble
    if (is.null(samples)) {
      samples_file <- file.path(settings$outdir, "samples.Rdata")
      if (file.exists(samples_file)) {
        env <- new.env(parent = emptyenv())
        load(samples_file, envir = env)
        samples <- list(
          trait.samples = env$trait.samples,
          sa.samples = env$sa.samples,
          ensemble.samples = env$ensemble.samples,
          runs.samples = env$runs.samples,
          env.samples = env$env.samples,
          param.names = NULL
        )
      }
    }
  }

  if (is.null(run) || is.null(ensemble)) {
    stop("`run` and `ensemble` are required.")
  }
  if (is.null(samples)) {
    stop("`samples` is required. Build samples first with get.parameter.samples().")
  }

  if (sobol) {
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

  for (i in seq_along(samp.ordered)) {
    input_tag <- names(samp.ordered)[i]
    parent_name <- samp.ordered[[i]]$parent

    parent_ids <- if (!is.null(parent_name)) sampled_inputs[[parent_name]] else NULL

    input_result <- PEcAn.uncertainty::input.ens.gen(
      run = run,
      ensemble_size = ensemble_size,
      input = input_tag,
      method = samp.ordered[[i]]$method,
      parent_ids = parent_ids
    )

    if (!is.null(input_result)) {
      sampled_inputs[[input_tag]] <- input_result
      design_list[[input_tag]] <- input_result$ids
    }
  }

  design_list[["param"]] <- seq_len(ensemble_size)
  design_matrix <- data.frame(design_list)

  if (sobol) {
    half <- floor(ensemble_size / 2)
    X1 <- design_matrix[1:half, ]
    X2 <- design_matrix[(half + 1):ensemble_size, ]
    sobol_obj <- sensitivity::soboljansen(model = NULL, X1 = X1, X2 = X2)
    return(sobol_obj)
  }

  return(list(X = design_matrix))
}
