# Tests for generate_joint_ensemble_design.R
# shared fixtures in helper-input_design.R

test_that("generate_joint_ensemble_design returns correct structure", {
 settings <- make_test_settings()
 samples <- make_test_samples()

 mockery::stub(generate_joint_ensemble_design, "input.ens.gen",
   function(...) list(ids = sample(1:2, 5, replace = TRUE)))

 result <- generate_joint_ensemble_design(
   run = settings$run,
   ensemble = settings$ensemble,
   ensemble_size = 5,
   samples = samples
 )
 
 expect_true("X" %in% names(result))
 expect_equal(nrow(result$X), 5)
 expect_true("param" %in% names(result$X))
})

test_that("ensemble design allows variation in non-param columns unlike OAT", {
 settings <- make_test_settings()
 samples <- make_test_samples()
 
 # get OAT design for comparison (uses shared fixture)
 sa_result <- generate_OAT_SA_design(
   ensemble = settings$ensemble,
   samples = samples
 )
 
 # test that ensemble design STRUCTURE allows variation in non-param columns
 settings$run <- list(inputs = list(met = list(path = c("m1.nc", "m2.nc", "m3.nc"))))
 mockery::stub(generate_joint_ensemble_design, "input.ens.gen",
   function(...) list(ids = c(1, 2, 3, 1, 2))) # varied indices
 
 ens_result <- generate_joint_ensemble_design(
   run = settings$run,
   ensemble = settings$ensemble,
   ensemble_size = 5,
   samples = samples
 )
 
 # key structural difference: SA constant, ensemble varies
 expect_equal(length(unique(sa_result$X$met)), 1)
 expect_true(length(unique(ens_result$X$met)) > 1)
})
