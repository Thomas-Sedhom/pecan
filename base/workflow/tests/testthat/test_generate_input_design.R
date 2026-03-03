test_that("runModule.run.write.configs requires explicit input_design bundle", {
  expect_error(
    PEcAn.workflow::runModule.run.write.configs(
      settings = list(),
      input_design = NULL,
      samples = list(),
      dbCon = NULL
    ),
    "requires `input_design` as a list"
  )
})

test_that("generate_input_design requires non-NULL samples", {
  expect_error(
    PEcAn.workflow::generate_input_design(settings = list(), samples = NULL),
    "requires a non-NULL `samples` object"
  )
})

test_that("generate_input_design assembles designs for Settings", {
  gen_input_design <- PEcAn.workflow::generate_input_design

  mockery::stub(gen_input_design, "PEcAn.settings::is.MultiSettings", function(...) FALSE)
  mockery::stub(gen_input_design, "PEcAn.settings::is.Settings", function(...) TRUE)
  mockery::stub(gen_input_design, ".validate_runwrite_samples", function(...) invisible(TRUE))
  mockery::stub(gen_input_design, ".prepare_input_designs", function(...) {
    list(ensemble = data.frame(param = c(1, 2)), sensitivity = NULL)
  })

  settings <- list(
    pfts = list(list(name = "pftA")),
    outdir = tempdir(),
    run = list(inputs = list()),
    ensemble = list(size = 2, samplingspace = list(parameters = list(method = "uniform"))),
    sensitivity.analysis = NULL,
    host = list(name = "localhost")
  )
  samples <- list(
    trait.samples = list(pftA = list(Vcmax = c(40, 45))),
    sa.samples = list(),
    ensemble.samples = list(),
    runs.samples = list(),
    env.samples = list()
  )

  out <- gen_input_design(settings = settings, samples = samples)

  expect_true(is.list(out))
  expect_true("ensemble" %in% names(out))
  expect_true(is.data.frame(out$ensemble))
})
