
# R/run_sobol_analysis.R



settings <- PEcAn.settings::read.settings("/projectnb/dietzelab/bthomas/pecan_runs/sipnet_test/pecan_updated.xml")
ensemble_size = settings$ensemble$size
base_settings <- if (PEcAn.settings::is.MultiSettings(settings)) settings[1] else settings
samples <- PEcAn.uncertainty::get.parameter.samples(settings = base_settings, ensemble.size = ensemble_size)
sobol_obj <- PEcAn.uncertainty::generate_joint_ensemble_design(
      run = base_settings$run,
      ensemble = base_settings$ensemble,
      ensemble_size = ensemble_size,
      samples = samples,
      sobol = TRUE
)

dbCon <- NULL
if (!is.null(settings$database$bety)) {
  maybe_con <- try(PEcAn.DB::db.open(settings$database$bety), silent = TRUE)
  if (!inherits(maybe_con, "try-error")) {
    dbCon <- maybe_con
    on.exit(try(PEcAn.DB::db.close(dbCon), silent = TRUE), add = TRUE)
  }
}
  
designs <- PEcAn.workflow::generate_input_design(
  settings,
  samples = samples,
  input_design = sobol_obj$X,
)
config_stage <- PEcAn.workflow::runModule.run.write.configs(
  settings,
  input_design = designs,
  samples = samples,
  dbCon = dbCon
)
settings <- config_stage$settings
samples <- config_stage$samples
 
  
PEcAn.workflow::runModule_start_model_runs(settings, stop.on.error = stop_on_error)
  
 

sobol_results <- PEcAn.uncertainty::compute_sobol_indices(outdir = settings$outdir, 
                                   sobol_obj = sobol_obj, 
                                   var = "GPP") 
  

 
