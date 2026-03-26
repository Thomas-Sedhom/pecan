# workflow Refactor Plan

Package path: `base/workflow`

## Function Inventory

- [do_conversions](#function-do_conversions)
- [generate_input_design](#function-generate_input_design)
- [run.write.configs](#function-runwriteconfigs)
- [runModule.get.trait.data](#function-runmodulegettraitdata)
- [runModule.run.write.configs](#function-runmodulerunwriteconfigs)
- [runModule_start_model_runs](#function-runmodule_start_model_runs)
- [start_model_runs](#function-start_model_runs)

## Function: do_conversions

### Refactor Summary


| Aspect                  | Old                                                                                                     | New                                                                                                    |
| ----------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| Parameters              | `do_conversions(settings)`                                                                              | `do_conversions(settings, dbCon = NULL)`                                                               |
| Load files              | Loads `pecan.METProcess.xml` when no conversions run                                                    | Same behavior, now documented as a compatibility load path                                             |
| Save files              | Writes `pecan.METProcess.xml` when conversions run                                                      | Same side effect; remains explicit and documented                                                      |
| Settings-derived inputs | Passed full `settings` into every downstream function                                                   | Orchestrates only; passes explicit inputs and optional `dbCon` downstream                              |
| Flow                    | Loop inputs, skip when `input$path` exists and `input$force` is not set, downstream opens DB internally | Same loop/skip logic, but forwards explicit `dbCon` and uses compatibility DB opens only with warnings |
| Return                  | Updated `settings` (paths and run inputs)                                                               | Updated `settings`; compatibility load may override in-memory settings when no conversions run         |


### Test Refactor


| Test area                         | Legacy coverage                                  | Required update                                                                                               |
| --------------------------------- | ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------- |
| Happy path                        | Conversion tests assumed internal DB opens       | Add tests that explicit `dbCon` is passed to `ic_process`, `fia.to.psscss`, `soil_process`, and `met.process` |
| Edge cases                        | Skip/force and no-op behavior covered indirectly | Add tests for skip when `input$path` exists and for `pecan.METProcess.xml` load when no conversions run       |
| Side effects / integration points | XML write/load not isolated                      | Assert `pecan.METProcess.xml` write on conversion and compatibility load on no-op; warn when `dbCon` missing  |


### Call Flow Comparison

Old flow:

```text
do_conversions(settings)
  -> loop inputs
      -> skip if input$path exists and input$force is NULL
      -> ic_process() opens DB internally
      -> fia.to.psscss() opens BETY + FIA internally
      -> soil_process() opens DB internally
      -> extract_phenology_MODIS() queries DB implicitly when lat/lon missing
      -> met.process() opens DB internally
  -> write pecan.METProcess.xml if conversions ran
  -> else load pecan.METProcess.xml if it exists
```

New flow:

```text
Caller
  -> optional dbCon <- db.open(...)
  -> do_conversions(settings, dbCon = dbCon)
      -> loop inputs
          -> skip if input$path exists and input$force is NULL
          -> ic_process(..., dbCon)
          -> fia.to.psscss(..., dbCon)
          -> soil_process(..., dbCon)
          -> extract_phenology_MODIS(site_info = explicit, dbCon)
          -> met.process(..., dbCon)
      -> write pecan.METProcess.xml if conversions ran
      -> else load pecan.METProcess.xml if it exists
  -> close dbCon if opened by caller
```

### Refactored Dependency References


| Called function | Source of truth                                                                                 | Caller update after dependency refactor                             |
| --------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `ic_process`    | [data.land.md - Function: ic_process](../modules/data.land.md#function-ic_process)              | Pass explicit `dbCon` and only required settings-derived inputs.    |
| `fia.to.psscss` | [data.land.md - Function: fia.to.psscss](../modules/data.land.md#function-fiatopsscss)          | Pass explicit BETY `dbCon` instead of opening internally.           |
| `soil_process`  | [data.land.md - Function: soil_process](../modules/data.land.md#function-soil_process)          | Pass explicit site/model/db inputs plus `dbCon` in the strict path. |
| `met.process`   | [data.atmosphere.md - Function: met.process](../modules/data.atmosphere.md#function-metprocess) | Forward `dbCon` and explicit inputs; avoid internal DB open.        |


### Caller References


| Caller function            | Location                                                                                |
| -------------------------- | --------------------------------------------------------------------------------------- |
| `submitWorkflow`           | `apps/api/R/ma.R`                                                                       |
| `do_conversions`           | `base/workflow/R/do_conversions.R`                                                      |
| `workflow.R`               | `web/workflow.R`                                                                        |
| `workflow.wcr.assim.R`     | `scripts/workflow.wcr.assim.R`                                                          |
| `workflow.template.R`      | `modules/assim.sequential/inst/WillowCreek/workflow.template.R`                         |
| `NoDataWorkflow.R`         | `modules/assim.sequential/inst/WillowCreek/NoDataWorkflow.R`                            |
| `workflow_2.R`             | `modules/assim.sequential/inst/sda_backup/sserbin/workflow_2.R`                         |
| `workflow.R`               | `modules/assim.sequential/inst/sda_backup/sserbin/workflow.R`                           |
| `workflow_doconversions.R` | `modules/assim.sequential/inst/sda_backup/sserbin/R_scripts_2/workflow_doconversions.R` |


## Function: generate_input_design

### Refactor Summary


| Aspect                  | Old          | New                                                                                                                                                                   |
| ----------------------- | ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | New Function | `settings, samples, input_design = NULL`                                                                                                                              |
| Load files              | New Function | No primary-path file loading; explicit `samples` are passed in                                                                                                        |
| Save files              | New Function | Returns design objects in memory                                                                                                                                      |
| Settings-derived inputs | New Function | Uses only required settings-derived values for `run`, `ensemble`, and `sensitivity` normalization                                                                     |
| Flow                    | New Function | Dedicated pre-write step that validates `Settings` or `MultiSettings`, normalizes optional overrides, and builds ensemble/sensitivity designs from explicit `samples` |
| Return                  | New Function | `list(expected_design, samples)`                                                                                                                             |


### Test Refactor


| Test area                         | Legacy coverage | Required update                                                                                                                 |
| --------------------------------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Happy path                        | New Function    | Add direct tests that `generate_input_design()` returns normalized `ensemble` or `sensitivity` design from explicit `samples` |
| Edge cases                        | New Function    | Add tests for missing `samples`
| Side effects / integration points | New Function    | Assert no implicit sampling or file access occurs in this function          |


### Call Flow Comparison

New flow:

```text
Caller
  -> samples <- .prepare_samples(settings, dbCon)
  -> generate_input_design(settings, samples, input_design = NULL)
      -> .prepare_input_designs(run, ensemble, sensitivity, samples, input_design)
          -> generate_joint_ensemble_design(run, ensemble, ensemble_size, samples, sobol = FALSE)
          -> generate_OAT_SA_design(ensemble, samples)
      -> return list(expected_design, samples)
```

### Refactored Dependency References


| Called function                  | Source of truth                                                                                                                | Caller update after dependency refactor                                                     |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------- |
| `generate_joint_ensemble_design` | [uncertainty.md - Function: generate_joint_ensemble_design](../modules/uncertainty.md#function-generate_joint_ensemble_design) | Pass `run`, `ensemble`, `ensemble_size`, and explicit `samples` instead of full `settings`. |
| `generate_OAT_SA_design`         | [uncertainty.md - Function: generate_OAT_SA_design](../modules/uncertainty.md#function-generate_oat_sa_design)                 | Pass `ensemble` and explicit `samples` only.                                                |


### Caller References

- New function

## Function: run.write.configs

### Refactor Summary


| Aspect                  | Old                                                                              | New                                                                                                                           |
| ----------------------- | -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `settings, ...` with implicit dependency on `samples.Rdata`                      | `settings, input_design, samples, dbCon = NULL, ...` with explicit `samples` requirement and caller-owned DB connection       |
| Load files              | Loaded `samples.Rdata` from disk                                                 | No primary-path sample file load; consumes explicit `samples` and `input_design`                                              |
| Save files              | Wrote configs only through side effects                                          | Writes configs plus `runs_manifest.csv`; returns explicit manifest data            |
| Settings-derived inputs | Used full `settings` together with hidden file-backed sample state               | Uses only the settings-derived values needed for config writing plus explicit design/sample objects                           |
| Flow                    | Loaded `samples.Rdata` from disk, then wrote configs using implicit shared state and downstream internal DB opens | Writes configs from explicit `input_design` and `samples`, forwards caller-owned `dbCon` downstream, builds the run manifest explicitly, and writes `runs_manifest.csv` |
| Return                  | Updated settings via side effects                                                | `list(settings = updated_settings, runs_manifest = run_manifest_df)`                                                           |


### Test Refactor


| Test area                         | Legacy coverage                                            | Required update                                                                                                  |
| --------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Happy path                        | Existing workflow coverage assumed disk-backed samples     | Add tests that `run.write.configs()` succeeds when explicit `samples` are provided and returns manifest data    |
| Edge cases                        | Missing explicit-object validation was not covered         | Add tests that calling without `samples` follows only the temporary deprecated compatibility path                |
| Side effects / integration points | Config writing verified without asserting object contracts | Assert config output writing still occurs, `runs_manifest.csv` is written, and returned manifest metadata matches |


### Call Flow Comparison

Old flow:

```text
runModule.run.write.configs(settings)
  -> run.write.configs(settings, ...)
      -> load samples.Rdata
      -> write.sa.configs()/write.ensemble.configs() open DB internally when needed
      -> write configs
```

New flow:

```text
Caller
  -> samples <- .prepare_samples(settings, dbCon)
  -> designs <- generate_input_design(settings, samples, input_design = NULL)
  -> run.write.configs(settings, input_design = designs, samples = samples, dbCon = dbCon, ...)
      -> validate explicit design + samples contract
      -> forward caller-owned dbCon to write.sa.configs()/write.ensemble.configs()
      -> write configs
      -> write runs_manifest.csv
      -> return list(settings = updated_settings, runs_manifest = run_manifest_df)
```

### Refactored Dependency References

| Refactored dependency | Location                                                                                 | Caller update after dependency refactor                                                                                   |
| --------------------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `write.sa.configs`    | [uncertainty.md - Function: write.sa.configs](../modules/uncertainty.md#function-writesaconfigs) | Pass explicit SA design/sample inputs and shared `dbCon`, and collect returned manifest metadata rather than relying on hidden workflow state |
| `write.ensemble.configs` | [uncertainty.md - Function: write.ensemble.configs](../modules/uncertainty.md#function-writeensembleconfigs) | Pass explicit ensemble design/sample inputs and shared `dbCon`, and collect returned manifest metadata rather than relying on hidden workflow state |

### Caller References


| Caller function               | Location                                                          |
| ----------------------------- | ----------------------------------------------------------------- |
| `runModule.run.write.configs` | `base/workflow/R/runModule.run.write.configs.R`                   |
| `make_settings`               | `base/workflow/tests/testthat/test_run.write.configs_multisite.R` |
| `hop_test`                    | `modules/assim.sequential/R/hop_test.R`                           |
| `kill.tunnel`                 | `scripts/workflow.bm.R`                                           |
| `status.skip`                 | `scripts/workflow.pda.R`                                          |


## Function: runModule.get.trait.data

### Refactor Summary


| Aspect                  | Old                                                                                             | New                                                                                                                                                          |
| ----------------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Parameters              | `settings` only                                                                                 | `settings, trait_inputs_by_pft = NULL, trait_data_flat = NULL, dbcon = NULL, ...`                                                                            |
| Load files              | Wrapper behavior depended on downstream hidden DB/file loading                                  | No strict-path workflow file load; explicit per-PFT inputs are prepared or passed in                                                                         |
| Save files              | Workflow files and DB registration happened implicitly downstream                               | Returns structured per-PFT results and file metadata; wrapper-controlled persistence remains explicit                                                        |
| Settings-derived inputs | Full workflow settings object was passed through implicitly                                     | Extracts only required settings-derived attrs such as `pfts`, `model$type`, `database$dbfiles`, update/write flags, and `trait.names`                        |
| Flow                    | Delegated to `get.trait.data()` with hidden DB/file behavior and implicit per-PFT orchestration | Wrapper extracts only required attrs, optionally builds `trait_inputs_by_pft`, owns the per-PFT loop, and calls `get.trait.data.pft()` with explicit objects |
| Return                  | Updated `settings` only                                                                         | Updated `settings` plus `results_by_pft` and `files_written_by_pft`                                                                 |


### Test Refactor


| Test area                         | Legacy coverage                                           | Required update                                                                                           |
| --------------------------------- | --------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| Happy path                        | Existing tests emphasized workflow side effects           | Add tests that the explicit-object path is used when `trait_inputs_by_pft` is passed                      |
| Edge cases                        | Fallback/loading behavior not isolated                    | Add tests for deprecated fallback when explicit objects are missing                                       |
| Side effects / integration points | Per-PFT calls and returned payloads not asserted directly | Add tests that the wrapper calls `get.trait.data.pft()` once per PFT and returns structured file metadata |


### Call Flow Comparison

Old flow:

```text
runModule.get.trait.data(settings)
  -> get.trait.data(pfts, modeltype, dbfiles, database, forceupdate, ...)
      -> loop over pfts inside core
      -> get.trait.data.pft(...)
```

New flow:

```text
Caller
  -> optional explicit objects: trait_inputs_by_pft, trait_data_flat, dbcon
  -> runModule.get.trait.data(settings, trait_inputs_by_pft, trait_data_flat, dbcon, ...)
      -> if explicit objects missing: deprecated wrapper-side fallback with warning
      -> extract attrs from settings
      -> get.trait.data(pfts, modeltype, trait.names, trait_data_flat, dbcon, ...)
          -> build or normalize trait_inputs_by_pft
      -> loop over pfts
          -> get.trait.data.pft(pft, pft_members, prior.distns, trait.data, ...)
      -> return updated settings plus structured per-PFT payloads
```

### Refactored Dependency References


| Called function      | Source of truth                                                        | Caller update after dependency refactor                                                             |
| -------------------- | ---------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `get.trait.data`     | [db.md - Function: get.trait.data](db.md#function-gettraitdata)        | Use it as the preparation step for explicit per-PFT objects instead of the full orchestration step. |
| `get.trait.data.pft` | [db.md - Function: get.trait.data.pft](db.md#function-gettraitdatapft) | Call it per PFT with explicit `pft_members`, `prior.distns`, and `trait.data` after preparation.    |


### Caller References


| Caller function        | Location                                                        |
| ---------------------- | --------------------------------------------------------------- |
| `submitWorkflow`       | `apps/api/R/ma.R`                                               |
| `workflow.R top-level` | `web/workflow.R`                                                |
| `workflow.wcr.assim.R` | `scripts/workflow.wcr.assim.R`                                  |
| `workflow.template.R`  | `modules/assim.sequential/inst/WillowCreek/workflow.template.R` |
| `NoDataWorkflow.R`     | `modules/assim.sequential/inst/WillowCreek/NoDataWorkflow.R`    |
| `workflow_2.R`         | `modules/assim.sequential/inst/sda_backup/sserbin/workflow_2.R` |
| `workflow.R`           | `modules/assim.sequential/inst/sda_backup/sserbin/workflow.R`   |


## Function: runModule.run.write.configs

### Refactor Summary


| Aspect                  | Old                                                                                    | New                                                                                                                                              |
| ----------------------- | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Parameters              | `settings, ...`                                                                        | `settings, input_design = design, samples = samples, dbCon = dbCon, write = TRUE, ...`                                                       |
| Load files              | Design generation and sample loading could happen implicitly inside the workflow chain | No strict-path file load; shared `samples` and one explicit `input_design` are passed in                                                        |
| Save files              | Configs were written via side effects and sample state persisted in `samples.Rdata`    | Wrapper delegates config writes, preserves `runs_manifest.csv` as the workflow artifact, and returns aggregated manifest metadata               |
| Settings-derived inputs | Used full workflow settings object for generation and writing steps                    | Uses only required settings-derived values for dispatch while shared design/sample objects are injected                                          |
| Flow                    | Generated designs internally and relied on downstream hidden `samples.Rdata` coupling  | Accepts one pre-generated design at a time, reuses shared `samples`, delegates to `run.write.configs()`, and combines returned manifest payloads |
| Return                  | Updated settings through side effects                                                  | `list(settings = settings_final, runs_manifest = combined_runs_manifest)`                                                                        |


### Test Refactor


| Test area                         | Legacy coverage                                                | Required update                                                                                                      |
| --------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Happy path                        | Integration coverage existed through legacy workflow execution | Add tests that explicit `samples` and one `input_design` are accepted and that manifest payloads are returned       |
| Edge cases                        | Shared object reuse and validation were not asserted directly  | Add tests for missing `samples`, malformed `input_design`, and per-design invocation behavior                        |
| Side effects / integration points | Config writing behavior not separated from sample generation   | Assert orchestration only: no internal sample generation/load in the strict path and manifest outputs are combined   |


### Call Flow Comparison

Old flow:

```text
runModule.run.write.configs(settings)
  -> .prepare_input_designs(settings, input_design)
      -> generate_joint_ensemble_design(settings, ...)
          -> get.parameter.samples(settings, ...)
              -> write samples.Rdata
  -> run.write.configs(settings, ...)
      -> load samples.Rdata
      -> write configs
```

New flow:

```text
Caller
  -> dbCon <- db.open(...)
  -> samples <- .prepare_samples(settings, dbCon)
  -> design_stage <- generate_input_design(settings, samples, input_design = NULL, design_type = "ensemble" | "sensitivity")
  -> runModule.run.write.configs(settings, input_design = design_stage$design, samples = samples, dbCon = dbCon, write = TRUE)
      -> validate required input_design contract
      -> if MultiSettings: dispatch over sites with the same shared samples and the requested design
      -> call run.write.configs(settings, ..., input_design, samples)
      -> collect returned manifest payloads across calls
      -> return list(settings = settings_final, runs_manifest = combined_runs_manifest)
```

### Refactored Dependency References


| Called function     | Source of truth                                                        | Caller update after dependency refactor                                       |
| ------------------- | ---------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `run.write.configs` | [workflow.md - Function: run.write.configs](#function-runwriteconfigs) | Delegate only config writing once explicit designs and samples are available. |
| `generate_input_design` | [workflow.md - Function: generate_input_design](#function-generate_input_design) | Generate input design and return (Design, samples) |


### Caller References


| Caller function                    | Location                                                              |
| ---------------------------------- | --------------------------------------------------------------------- |
| `workflow.R`                       | `web/workflow.R`                                                      |
| `EFI_workflow.R`                   | `scripts/EFI_workflow.R`                                              |
| `workflow.wcr.assim.R`             | `scripts/workflow.wcr.assim.R`                                        |
| `sobol_analysis.R`                 | `modules/uncertainty/inst/sobol/sobol_analysis.R`                     |
| `workflow.variance.partitioning.R` | `modules/assim.sequential/inst/workflow.variance.partitioning.R`      |
| `workflow.variance.partitioning.R` | `modules/assim.sequential/inst/workflow.variance.partitioning.R`      |
| `workflow.variance.partitioning.R` | `modules/assim.sequential/inst/workflow.variance.partitioning.R`      |
| `workflow_2.R`                     | `modules/assim.sequential/inst/sda_backup/sserbin/workflow_2.R`       |
| `workflow.R`                       | `modules/assim.sequential/inst/sda_backup/sserbin/workflow.R`         |
| `04_ForwardOnlyForecast.R`         | `modules/assim.sequential/inst/hf_landscape/04_ForwardOnlyForecast.R` |


## Function: runModule_start_model_runs

### Refactor Summary


| Aspect                  | Old                                                                                                                                                     | New                                                                                                                                                                          |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `settings` only                                                                                                                                         | `settings, runs = NULL, dbCon = NULL, rundir = NULL, modeloutdir = NULL, host = NULL, model_type = NULL, stop.on.error = TRUE, write = NULL`                                 |
| Load files              | Relied on downstream internal `runs.txt` loading and hidden DB open behavior                                                                            | No strict-path file load; `runs` and optional `dbCon` are passed explicitly, with fallback isolated in the wrapper                                                           |
| Save files              | Side effects included remote syncs, log/output transfers, and DB timestamp writes                                                                       | Returns structured execution metadata, `files_written`, and `files_synced`; side effects remain explicit orchestration outputs                                               |
| Settings-derived inputs | Full `settings` object plus `settings$database$bety$write` drove the stage implicitly                                                                   | Uses `settings` only for orchestration/compatibility and extracts required inputs such as `rundir`, `modeloutdir`, `host`, and `model_type`                                  |
| Flow                    | Derived `write` from settings, delegated directly to `start_model_runs(settings, ...)`, and relied on hidden `runs.txt` and DB open behavior downstream | Wrapper keeps `settings` for orchestration, accepts explicit run inputs, owns deprecated fallbacks for missing `runs` and `dbCon`, and dispatches `MultiSettings` explicitly |
| Return                  | Mostly side effects                                                                                                                                     | Structured result with execution metadata, `files_written`, and `files_synced`                                                                                               |


### Test Refactor


| Test area                         | Legacy coverage                                                | Required update                                                                  |
| --------------------------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| Happy path                        | Minimal tests only covered missing or empty `runs.txt`         | Add tests that explicit `runs` and `dbCon` drive the strict path                 |
| Edge cases                        | Deprecated fallback paths were not isolated                    | Add tests for `runs.txt` fallback warning and wrapper-opened DB fallback warning |
| Side effects / integration points | MultiSettings behavior and returned metadata were not asserted | Add tests for explicit per-site dispatch and structured return payloads          |


### Call Flow Comparison

Old flow:

```text
runModule_start_model_runs(settings)
  -> derive write from settings$database$bety$write
  -> start_model_runs(settings, write, ...)
      -> hidden file/DB behavior downstream
```

New flow:

```text
Caller
  -> prepare explicit inputs: runs, rundir, modeloutdir, host, model_type, optional dbCon
  -> runModule_start_model_runs(settings, runs, dbCon, ...)
      -> if runs missing: deprecated fallback loads runs.txt
      -> if dbCon missing and write enabled: deprecated fallback opens dbCon
      -> if MultiSettings: dispatch per site explicitly
      -> start_model_runs(runs, rundir, modeloutdir, host, model_type, dbCon, ...)
      -> close deprecated fallback dbCon if wrapper opened it
      -> return list(results, files_written, files_synced, metadata)
```

### Refactored Dependency References


| Called function    | Source of truth                                                        | Caller update after dependency refactor                                    |
| ------------------ | ---------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| `start_model_runs` | [workflow.md - Function: start_model_runs](#function-start_model_runs) | Pass explicit run-launch inputs and keep wrapper-only fallback logic here. |


### Caller References


| Caller function                    | Location                                                              |
| ---------------------------------- | --------------------------------------------------------------------- |
| `workflow.R`                       | `web/workflow.R`                                                      |
| `workflow.wcr.assim.R`             | `scripts/workflow.wcr.assim.R`                                        |
| `EFI_workflow.R`                   | `scripts/EFI_workflow.R`                                              |
| `sobol_analysis.R`                 | `modules/uncertainty/inst/sobol/sobol_analysis.R`                     |
| `workflow.variance.partitioning.R` | `modules/assim.sequential/inst/workflow.variance.partitioning.R`      |
| `workflow.variance.partitioning.R` | `modules/assim.sequential/inst/workflow.variance.partitioning.R`      |
| `workflow.variance.partitioning.R` | `modules/assim.sequential/inst/workflow.variance.partitioning.R`      |
| `workflow_2.R`                     | `modules/assim.sequential/inst/sda_backup/sserbin/workflow_2.R`       |
| `workflow.R`                       | `modules/assim.sequential/inst/sda_backup/sserbin/workflow.R`         |
| `04_ForwardOnlyForecast.R`         | `modules/assim.sequential/inst/hf_landscape/04_ForwardOnlyForecast.R` |


## Function: start_model_runs

### Refactor Summary


| Aspect                  | Old                                                                                                                                                                       | New                                                                                                                                                                                                                           |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `start_model_runs(settings, write = TRUE, ...)`                                                                                                                           | `start_model_runs(runs, rundir, modeloutdir, host, model_type = NULL, dbCon = NULL, ...)`                                                                                                                                     |
| Load files              | Read `runs.txt` internally                                                                                                                                                | No strict-path run file load; `runs` are passed explicitly                                                                                                                                                                    |
| Save files              | Produced launcher/job files, remote syncs, logs, and DB stamps as hidden side effects                                                                                     | Returns explicit execution metadata plus `files_written`, `files_synced`, and DB event information                                                                                                                            |
| Settings-derived inputs | Used the full settings object, including host/model/database state                                                                                                        | Uses only required settings-derived inputs supplied explicitly by the wrapper: `rundir`, `modeloutdir`, `host`, `model_type`, and optional `dbCon`                                                                            |
| Flow                    | Read `runs.txt`, opened DB internally, mutated submission strings inside `settings$host`, synced remote inputs/outputs, and submitted jobs using the full settings object | Launch orchestration works from explicit inputs, normalizes submission context without mutating the caller, performs optional remote sync/submission/polling, and uses explicit `dbCon` only when timestamp writing is needed |
| Return                  | `NULL` or side effects                                                                                                                                                    | `list(results = ..., files_written = ..., files_synced = ..., metadata = ...)`                                                                                                                                                |


### Test Refactor


| Test area                         | Legacy coverage                                                               | Required update                                                                                                               |
| --------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Happy path                        | Only limited core coverage existed                                            | Add tests that strict-path calls require explicit `runs` and return execution metadata                                        |
| Edge cases                        | DB open and run file loading were not isolated                                | Add tests that no internal DB open occurs when `dbCon` is provided and no internal `runs.txt` read occurs in the primary path |
| Side effects / integration points | Remote sync, modellauncher artifacts, and rabbitmq runtime config were hidden | Add tests around returned `files_written`, `files_synced`, and explicit runtime configuration boundaries                      |


### Call Flow Comparison

Old flow:

```text
start_model_runs(settings, write, ...)
  -> read runs.txt
  -> open db connection
  -> mutate qsub/modellauncher strings in settings$host
  -> remote.copy.to(...)
  -> submit runs
  -> poll completion
  -> stamp BETY timestamps
  -> remote.copy.from(...)
```

New flow:

```text
start_model_runs(runs, rundir, modeloutdir, host, model_type, dbCon, ...)
  -> normalize submission context without mutating caller host
  -> sync remote inputs if needed
  -> submit runs / prepare modellauncher artifacts
  -> poll completion
  -> sync remote outputs and logs
  -> optionally stamp DB timestamps through explicit dbCon
  -> return execution metadata + files_written + files_synced + db_events
```


### Caller References


| Caller function              | Location                                           |
| ---------------------------- | -------------------------------------------------- |
| `runModule_start_model_runs` | `base/workflow/R/start_model_runs.R`               |
| `pda.bayesian.tools`         | `modules/assim.batch/R/pda.bayesian.tools.R`       |
| `pda.emulator`               | `modules/assim.batch/R/pda.emulator.R`             |
| `pda.mcmc`                   | `modules/assim.batch/R/pda.mcmc.R`                 |
| `pda.mcmc.bs`                | `modules/assim.batch/R/pda.mcmc.bs.R`              |
| `hop_test`                   | `modules/assim.sequential/R/hop_test.R`            |
| `sda.enkf.original`          | `modules/assim.sequential/R/sda.enkf.R`            |
| `sda.enkf.multisite`         | `modules/assim.sequential/R/sda.enkf_MultiSite.R`  |
| `sda.enkf`                   | `modules/assim.sequential/R/sda.enkf_refactored.R` |
| `kill.tunnel`                | `scripts/workflow.bm.R`                            |
| `status.skip`                | `scripts/workflow.pda.R`                           |


