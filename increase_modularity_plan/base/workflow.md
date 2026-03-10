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

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: generate_input_design

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | New Function | `settings, samples, input_design = NULL` |
| Load files | New Function | No primary-path file loading; explicit `samples` are passed in |
| Save files | New Function | Returns design objects in memory |
| Settings-derived inputs | New Function | Uses only required settings-derived values for `run`, `ensemble`, and `sensitivity` normalization |
| Flow | New Function | Dedicated pre-write step that validates `Settings` or `MultiSettings`, normalizes optional overrides, and builds ensemble/sensitivity designs from explicit `samples` |
| Return | New Function | `list(ensemble = ..., sensitivity = ...)` |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | New Function | Add direct tests that `generate_input_design()` returns normalized `ensemble` and `sensitivity` designs from explicit `samples` |
| Edge cases | New Function | Add tests for missing `samples`, `Settings` vs `MultiSettings`, and normalized list vs data.frame `input_design` overrides |
| Side effects / integration points | New Function | Assert no implicit sampling or file access occurs in this function and that shared `samples` are reused across sites |

### Call Flow Comparison

New flow:

```text
Caller
  -> samples <- .prepare_samples(settings, dbCon)
  -> generate_input_design(settings, samples, input_design = NULL)
      -> .prepare_input_designs(run, ensemble, sensitivity, samples, input_design)
          -> generate_joint_ensemble_design(run, ensemble, ensemble_size, samples, sobol = FALSE)
          -> generate_OAT_SA_design(ensemble, samples)
      -> return list(ensemble = ..., sensitivity = ...)
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `get.parameter.samples` | [uncertainty.md - Function: get.parameter.samples](../modules/uncertainty.md#function-getparametersamples) | Consume the explicit `samples` contract produced upstream instead of assuming hidden `samples.Rdata` state. |
| `generate_joint_ensemble_design` | [uncertainty.md - Function: generate_joint_ensemble_design](../modules/uncertainty.md#function-generate_joint_ensemble_design) | Pass `run`, `ensemble`, `ensemble_size`, and explicit `samples` instead of full `settings`. |
| `generate_OAT_SA_design` | [uncertainty.md - Function: generate_OAT_SA_design](../modules/uncertainty.md#function-generate_oat_sa_design) | Pass `ensemble` and explicit `samples` only. |

## Function: run.write.configs

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `settings, ...` with implicit dependency on `samples.Rdata` | `settings, input_design, samples, ...` with explicit `samples` requirement |
| Load files | Loaded `samples.Rdata` from disk | No primary-path sample file load; consumes explicit `samples` and `input_design` |
| Save files | Wrote configs only through side effects | Returns updated settings and explicit `samples`; config writing remains the controlled side effect |
| Settings-derived inputs | Used full `settings` together with hidden file-backed sample state | Uses only the settings-derived values needed for config writing plus explicit design/sample objects |
| Flow | Loaded `samples.Rdata` from disk, then wrote configs using implicit shared state | Writes configs from explicit `input_design` and `samples`; no primary-path `samples.Rdata` load |
| Return | Updated settings via side effects | `list(settings = updated_settings, samples = samples)` |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing workflow coverage assumed disk-backed samples | Add tests that `run.write.configs()` succeeds when explicit `samples` are provided |
| Edge cases | Missing explicit-object validation was not covered | Add tests that calling without `samples` follows only the temporary deprecated compatibility path |
| Side effects / integration points | Config writing verified without asserting object contracts | Assert config output writing still occurs while `samples` are returned explicitly and not reloaded from disk |

### Call Flow Comparison

Old flow:

```text
runModule.run.write.configs(settings)
  -> run.write.configs(settings, ...)
      -> load samples.Rdata
      -> write configs
```

New flow:

```text
Caller
  -> samples <- .prepare_samples(settings, dbCon)
  -> designs <- generate_input_design(settings, samples, input_design = NULL)
  -> run.write.configs(settings, input_design = designs, samples = samples, ...)
      -> validate explicit design + samples contract
      -> write configs
      -> return list(settings = updated_settings, samples = samples)
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `generate_input_design` | [workflow.md - Function: generate_input_design](#function-generate_input_design) | Require pre-generated design objects instead of generating them inside the writer. |
| `get.parameter.samples` | [uncertainty.md - Function: get.parameter.samples](../modules/uncertainty.md#function-getparametersamples) | Consume explicit `samples` instead of loading `samples.Rdata`. |

## Function: runModule.get.trait.data

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `settings` only | `settings, trait_inputs_by_pft = NULL, trait_data_flat = NULL, dbcon = NULL, ...` |
| Load files | Wrapper behavior depended on downstream hidden DB/file loading | No strict-path workflow file load; explicit per-PFT inputs are prepared or passed in |
| Save files | Workflow files and DB registration happened implicitly downstream | Returns structured per-PFT results and file metadata; wrapper-controlled persistence remains explicit |
| Settings-derived inputs | Full workflow settings object was passed through implicitly | Extracts only required settings-derived attrs such as `pfts`, `model$type`, `database$dbfiles`, update/write flags, and `trait.names` |
| Flow | Delegated to `get.trait.data()` with hidden DB/file behavior and implicit per-PFT orchestration | Wrapper extracts only required attrs, optionally builds `trait_inputs_by_pft`, owns the per-PFT loop, and calls `get.trait.data.pft()` with explicit objects |
| Return | Updated `settings` only | Updated `settings` plus `results_by_pft`, `files_written_by_pft`, and metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing tests emphasized workflow side effects | Add tests that the explicit-object path is used when `trait_inputs_by_pft` is passed |
| Edge cases | Fallback/loading behavior not isolated | Add tests for deprecated fallback when explicit objects are missing |
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

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `get.trait.data` | [db.md - Function: get.trait.data](db.md#function-gettraitdata) | Use it as the preparation step for explicit per-PFT objects instead of the full orchestration step. |
| `get.trait.data.pft` | [db.md - Function: get.trait.data.pft](db.md#function-gettraitdatapft) | Call it per PFT with explicit `pft_members`, `prior.distns`, and `trait.data` after preparation. |

## Function: runModule.run.write.configs

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `settings, ...` | `settings, input_design = designs, samples = samples, dbCon = dbCon, ...` |
| Load files | Design generation and sample loading could happen implicitly inside the workflow chain | No strict-path file load; shared `samples` and `input_design` are passed explicitly |
| Save files | Configs were written via side effects and sample state persisted in `samples.Rdata` | Returns updated settings and explicit `samples`; config file writes remain wrapper/core side effects |
| Settings-derived inputs | Used full workflow settings object for generation and writing steps | Uses only required settings-derived values for dispatch while shared design/sample objects are injected |
| Flow | Generated designs internally and relied on downstream hidden `samples.Rdata` coupling | Requires explicit shared `samples` and pre-generated `input_design`, reuses them across sites, and delegates to `run.write.configs()` |
| Return | Updated settings through side effects | `list(settings = settings_final, samples = samples)` |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Integration coverage existed through legacy workflow execution | Add tests that explicit `samples` and `input_design` are accepted and reused across `MultiSettings` sites |
| Edge cases | Shared object reuse and validation were not asserted directly | Add tests for missing `samples` or malformed `input_design` contracts |
| Side effects / integration points | Config writing behavior not separated from sample generation | Assert orchestration only: no internal sample generation/load in the strict path |

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
  -> designs <- generate_input_design(settings, samples, input_design = NULL)
  -> runModule.run.write.configs(settings, input_design = designs, samples = samples, dbCon = dbCon)
      -> validate required input_design contract
      -> if MultiSettings: dispatch over sites with same shared designs/samples
      -> call run.write.configs(settings, ..., input_design, samples)
      -> return list(settings = settings_final, samples = samples)
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `generate_input_design` | [workflow.md - Function: generate_input_design](#function-generate_input_design) | Treat design generation as a distinct upstream stage. |
| `run.write.configs` | [workflow.md - Function: run.write.configs](#function-runwriteconfigs) | Delegate only config writing once explicit designs and samples are available. |
| `get.parameter.samples` | [uncertainty.md - Function: get.parameter.samples](../modules/uncertainty.md#function-getparametersamples) | Use the explicit `samples` contract created upstream instead of implicit writer-side loading. |



## Function: runModule_start_model_runs

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `settings` only | `settings, runs = NULL, dbCon = NULL, rundir = NULL, modeloutdir = NULL, host = NULL, model_type = NULL, stop.on.error = TRUE, write = NULL` |
| Load files | Relied on downstream internal `runs.txt` loading and hidden DB open behavior | No strict-path file load; `runs` and optional `dbCon` are passed explicitly, with fallback isolated in the wrapper |
| Save files | Side effects included remote syncs, log/output transfers, and DB timestamp writes | Returns structured execution metadata, `files_written`, and `files_synced`; side effects remain explicit orchestration outputs |
| Settings-derived inputs | Full `settings` object plus `settings$database$bety$write` drove the stage implicitly | Uses `settings` only for orchestration/compatibility and extracts required inputs such as `rundir`, `modeloutdir`, `host`, and `model_type` |
| Flow | Derived `write` from settings, delegated directly to `start_model_runs(settings, ...)`, and relied on hidden `runs.txt` and DB open behavior downstream | Wrapper keeps `settings` for orchestration, accepts explicit run inputs, owns deprecated fallbacks for missing `runs` and `dbCon`, and dispatches `MultiSettings` explicitly |
| Return | Mostly side effects | Structured result with execution metadata, `files_written`, and `files_synced` |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Minimal tests only covered missing or empty `runs.txt` | Add tests that explicit `runs` and `dbCon` drive the strict path |
| Edge cases | Deprecated fallback paths were not isolated | Add tests for `runs.txt` fallback warning and wrapper-opened DB fallback warning |
| Side effects / integration points | MultiSettings behavior and returned metadata were not asserted | Add tests for explicit per-site dispatch and structured return payloads |

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

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `start_model_runs` | [workflow.md - Function: start_model_runs](#function-start_model_runs) | Pass explicit run-launch inputs and keep wrapper-only fallback logic here. |

## Function: start_model_runs

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `start_model_runs(settings, write = TRUE, ...)` | `start_model_runs(runs, rundir, modeloutdir, host, model_type = NULL, dbCon = NULL, ...)` |
| Load files | Read `runs.txt` internally | No strict-path run file load; `runs` are passed explicitly |
| Save files | Produced launcher/job files, remote syncs, logs, and DB stamps as hidden side effects | Returns explicit execution metadata plus `files_written`, `files_synced`, and DB event information |
| Settings-derived inputs | Used the full settings object, including host/model/database state | Uses only required settings-derived inputs supplied explicitly by the wrapper: `rundir`, `modeloutdir`, `host`, `model_type`, and optional `dbCon` |
| Flow | Read `runs.txt`, opened DB internally, mutated submission strings inside `settings$host`, synced remote inputs/outputs, and submitted jobs using the full settings object | Launch orchestration works from explicit inputs, normalizes submission context without mutating the caller, performs optional remote sync/submission/polling, and uses explicit `dbCon` only when timestamp writing is needed |
| Return | `NULL` or side effects | `list(results = ..., files_written = ..., files_synced = ..., metadata = ...)` |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Only limited core coverage existed | Add tests that strict-path calls require explicit `runs` and return execution metadata |
| Edge cases | DB open and run file loading were not isolated | Add tests that no internal DB open occurs when `dbCon` is provided and no internal `runs.txt` read occurs in the primary path |
| Side effects / integration points | Remote sync, modellauncher artifacts, and rabbitmq runtime config were hidden | Add tests around returned `files_written`, `files_synced`, and explicit runtime configuration boundaries |

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

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `setup_modellauncher` | [remote.md - Function: setup_modellauncher](remote.md#function-setup_modellauncher) | Treat modellauncher file creation as explicit artifact build/write work that returns written paths. |
| `start_rabbitmq` | [remote.md - Function: start_rabbitmq](remote.md#function-start_rabbitmq) | Pass rabbitmq prefix and port explicitly instead of depending on hidden environment variables. |

