# Shared test fixtures for input design tests
# Automatically sourced by testthat before running tests

make_test_settings <- function() {
  list(
    outdir = "/fake/output/path",
    pfts = list(list(name = "pft1")),
    run = list(inputs = list(met = list(path = c("met1.nc", "met2.nc", "met3.nc")))),
    ensemble = list(
      samplingspace = list(
        parameters = list(method = "uniform"),
        met = list(method = "sampling")
      )
    )
  )
}

mock_sa_samples <- list(
  pft1 = structure(
    matrix(1:9, nrow = 3, ncol = 3),
    dimnames = list(c("25", "50", "75"), c("trait1", "trait2", "trait3"))
  )
)

make_test_samples <- function() {
  list(
    trait.samples = list(
      pft1 = list(
        trait1 = c(1, 2, 3, 4, 5),
        trait2 = c(2, 3, 4, 5, 6),
        trait3 = c(3, 4, 5, 6, 7)
      )
    ),
    sa.samples = mock_sa_samples,
    ensemble.samples = list(
      pft1 = data.frame(trait1 = c(1, 2, 3), trait2 = c(2, 3, 4), trait3 = c(3, 4, 5))
    ),
    runs.samples = list(),
    env.samples = list()
  )
}
