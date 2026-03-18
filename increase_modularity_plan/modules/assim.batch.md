# assim.batch Refactor Plan

Package path: `modules/assim.batch`

## Package Summary


| Item               | Value                 |
| ------------------ | --------------------- |
| Package            | `assim.batch`         |
| Layer              | `modules`             |
| Source path        | `modules/assim.batch` |
| Functions detected | `18`                  |


## Function Inventory

- [hier.mcmc](#function-hiermcmc)
- [load_pda_history](#function-load_pda_history)
- [mcmc.GP](#function-mcmcgp)
- [pda.adjust.jumps.bs](#function-pdaadjustjumpsbs)
- [pda.bayesian.tools](#function-pdabayesiantools)
- [pda.calc.error](#function-pdacalcerror)
- [pda.calc.llik.par](#function-pdacalcllikpar)
- [pda.create.ensemble](#function-pdacreateensemble)
- [pda.emulator](#function-pdaemulator)
- [pda.emulator.ms](#function-pdaemulatorms)
- [pda.get.model.output](#function-pdagetmodeloutput)
- [pda.init.run](#function-pdainitrun)
- [pda.plot.params](#function-pdaplotparams)
- [pda.postprocess](#function-pdapostprocess)
- [pda.settings.bt](#function-pdasettingsbt)
- [return.bias](#function-returnbias)
- [return_multi_site_objects](#function-return_multi_site_objects)
- [runModule.assim.batch](#function-runmoduleassimbatch)

## Function: hier.mcmc

### Refactor Summary


| Aspect                  | Old                                                        | New                                                                                                   |
| ----------------------- | ---------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| Parameters              | `hier.mcmc(settings, ...)`                                 | `hier.mcmc(assim.batch = NULL, inputs = NULL, jump = NULL, pos.check = NULL, hyper.pars = NULL, ...)` |
| Load files              | None                                                       | None                                                                                                  |
| Save files              | None                                                       | None                                                                                                  |
| Settings-derived inputs | Reads `settings$assim.batch$jump` and `inputs$ss.positive` | Uses explicit `jump` and `pos.check`; no full settings                                                |
| Flow                    | Derives jump and likelihood params from settings           | Uses explicit inputs; calls `pda.calc.llik.par` with explicit args                                    |
| Return                  | Hierarchical MCMC samples                                  | Same                                                                                                  |


### Test Refactor


| Test area                         | Legacy coverage             | Required update                                 |
| --------------------------------- | --------------------------- | ----------------------------------------------- |
| Happy path                        | Minimal                     | Add tests for explicit inputs and jump settings |
| Edge cases                        | Hidden pos.check derivation | Add tests for explicit pos.check override       |
| Side effects / integration points | None                        | No change                                       |


### Call Flow Comparison

Old flow:

```text
hier.mcmc(settings, ...)
  -> derive pos.check from inputs
  -> pda.calc.llik.par(settings, ...)
  -> pda.adjust.jumps.bs(settings, ...)
```

New flow:

```text
hier.mcmc(inputs, jump, pos.check, hyper.pars, ...)
  -> pda.calc.llik.par(inputs, hyper.pars)
  -> pda.adjust.jumps.bs(jump)
```

### Refactored Dependency References


| Called function       | Source of truth                                                              | Caller update after dependency refactor            |
| --------------------- | ---------------------------------------------------------------------------- | -------------------------------------------------- |
| `pda.calc.llik.par`   | [assim.batch.md - Function: pda.calc.llik.par](#function-pdacalcllikpar)     | Pass explicit inputs/hyper.pars; no full settings. |
| `pda.adjust.jumps.bs` | [assim.batch.md - Function: pda.adjust.jumps.bs](#function-pdaadjustjumpsbs) | Pass explicit jump settings.                       |


### Caller References


| Caller function   | Location                                  |
| ----------------- | ----------------------------------------- |
| `pda.emulator.ms` | `modules/assim.batch/R/pda.emulator.ms.R` |


## Function: load_pda_history

### Refactor Summary


| Aspect                  | Old                                               | New                                                                                    |
| ----------------------- | ------------------------------------------------- | -------------------------------------------------------------------------------------- |
| Parameters              | `load_pda_history(workdir, ensemble.id, objects)` | `load_pda_history(workdir, ensemble.id, objects, history = NULL, history_path = NULL)` |
| Load files              | Loads history from implicit path                  | Uses provided `history` or `history_path` when supplied                                |
| Save files              | None                                              | None                                                                                   |
| Settings-derived inputs | None                                              | None                                                                                   |
| Flow                    | Build path and `load()` history                   | Use explicit object or explicit path; fallback to legacy path                          |
| Return                  | Requested history objects                         | Same                                                                                   |


### Test Refactor


| Test area                         | Legacy coverage       | Required update                                |
| --------------------------------- | --------------------- | ---------------------------------------------- |
| Happy path                        | Minimal               | Add tests for explicit history object and path |
| Edge cases                        | Missing history files | Add tests for graceful fallback behavior       |
| Side effects / integration points | File reads implicit   | Verify no disk reads when history is provided  |


### Call Flow Comparison

Old flow:

```text
load_pda_history(workdir, ensemble.id, objects)
  -> build history path
  -> load() objects
```

New flow:

```text
load_pda_history(workdir, ensemble.id, objects, history, history_path)
  -> use history if provided
  -> else load from history_path or legacy path
```

### Refactored Dependency References


| Called function | Source of truth | Caller update after dependency refactor          |
| --------------- | --------------- | ------------------------------------------------ |
| None            | --              | Pure file load helper; no internal dependencies. |


### Caller References


| Caller function             | Location                                  |
| --------------------------- | ----------------------------------------- |
| `pda.emulator.ms`           | `modules/assim.batch/R/pda.emulator.ms.R` |
| `return_multi_site_objects` | `modules/assim.batch/R/pda.utils.R`       |


## Function: mcmc.GP

### Refactor Summary


| Aspect                  | Old                                                        | New                                                                                                 |
| ----------------------- | ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Parameters              | `mcmc.GP(settings, ...)`                                   | `mcmc.GP(assim.batch = NULL, inputs = NULL, jump = NULL, pos.check = NULL, hyper.pars = NULL, ...)` |
| Load files              | None                                                       | None                                                                                                |
| Save files              | None                                                       | None                                                                                                |
| Settings-derived inputs | Reads `settings$assim.batch$jump` and `inputs$ss.positive` | Uses explicit `jump` and `pos.check`; no full settings                                              |
| Flow                    | Derives jump and likelihood params from settings           | Uses explicit inputs; calls `pda.calc.llik.par` and `pda.adjust.jumps.bs` with explicit args        |
| Return                  | MCMC samples and chain state                               | Same                                                                                                |


### Test Refactor


| Test area                         | Legacy coverage             | Required update                                 |
| --------------------------------- | --------------------------- | ----------------------------------------------- |
| Happy path                        | Minimal                     | Add tests for explicit inputs and jump settings |
| Edge cases                        | Hidden pos.check derivation | Add tests for explicit pos.check override       |
| Side effects / integration points | None                        | No change                                       |


### Call Flow Comparison

Old flow:

```text
mcmc.GP(settings, ...)
  -> derive pos.check from inputs
  -> pda.calc.llik.par(settings, ...)
  -> pda.adjust.jumps.bs(settings, ...)
```

New flow:

```text
mcmc.GP(inputs, jump, pos.check, hyper.pars, ...)
  -> pda.calc.llik.par(inputs, hyper.pars)
  -> pda.adjust.jumps.bs(jump)
```

### Refactored Dependency References


| Called function       | Source of truth                                                              | Caller update after dependency refactor            |
| --------------------- | ---------------------------------------------------------------------------- | -------------------------------------------------- |
| `pda.calc.llik.par`   | [assim.batch.md - Function: pda.calc.llik.par](#function-pdacalcllikpar)     | Pass explicit inputs/hyper.pars; no full settings. |
| `pda.adjust.jumps.bs` | [assim.batch.md - Function: pda.adjust.jumps.bs](#function-pdaadjustjumpsbs) | Pass explicit jump settings.                       |


### Caller References


| Caller function   | Location                                  |
| ----------------- | ----------------------------------------- |
| `pda.emulator`    | `modules/assim.batch/R/pda.emulator.R`    |
| `pda.emulator.ms` | `modules/assim.batch/R/pda.emulator.ms.R` |


## Function: pda.adjust.jumps.bs

### Refactor Summary


| Aspect                  | Old                                  | New                                                                             |
| ----------------------- | ------------------------------------ | ------------------------------------------------------------------------------- |
| Parameters              | `pda.adjust.jumps.bs(settings, ...)` | `pda.adjust.jumps.bs(jump)` or `pda.adjust.jumps.bs(adapt, adj.min, ar.target)` |
| Load files              | Reads `settings$assim.batch$jump`    | Uses explicit jump settings                                                     |
| Save files              | None                                 | None                                                                            |
| Settings-derived inputs | Full `settings` required             | Explicit `jump` only                                                            |
| Flow                    | Adjusts covariance using settings    | Adjusts covariance using explicit jump inputs                                   |
| Return                  | Updated covariance matrix            | Same                                                                            |


### Test Refactor


| Test area                         | Legacy coverage                | Required update                      |
| --------------------------------- | ------------------------------ | ------------------------------------ |
| Happy path                        | Minimal                        | Add tests for explicit jump settings |
| Edge cases                        | Implicit settings dependencies | Add tests for missing jump fields    |
| Side effects / integration points | None                           | No change                            |


### Call Flow Comparison

Old flow:

```text
pda.adjust.jumps.bs(settings, ...)
  -> read settings$assim.batch$jump
  -> adjust covariance
```

New flow:

```text
pda.adjust.jumps.bs(jump)
  -> adjust covariance
```

### Refactored Dependency References


| Called function | Source of truth | Caller update after dependency refactor         |
| --------------- | --------------- | ----------------------------------------------- |
| None            | --              | Pure jump adjustment; no internal dependencies. |


### Caller References


| Caller function | Location                              |
| --------------- | ------------------------------------- |
| `hier.mcmc`     | `modules/assim.batch/R/hier.mcmc.R`   |
| `mcmc.GP`       | `modules/assim.batch/R/minimize.GP.R` |
| `pda.mcmc.bs`   | `modules/assim.batch/R/pda.mcmc.bs.R` |


## Function: pda.bayesian.tools

### Refactor Summary


| Aspect                  | Old                                                                    | New                                                                                                                                                                                                                                                                                                                 |
| ----------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `pda.bayesian.tools(settings, ...)`                                    | `pda.bayesian.tools(settings, dbCon = NULL, inputs = NULL, external.formats = NULL, external.data = NULL, external.priors = NULL, prior.sel = NULL, bt.prior = NULL, llik.fn = NULL, hyper.pars = NULL, ensemble.id = NULL, workflow.id = NULL, out = NULL, write = TRUE, return = c("settings","results","both"))` |
| Load files              | Loads `external.<ensemble>.Rdata` and `out.path` internally            | Uses explicit `inputs`, `external.formats`, `external.data`, and `out` when provided                                                                                                                                                                                                                                |
| Save files              | Writes BayesianTools `out`, `external.data`, and DB inserts internally | `write` controls file and DB writes; artifacts returned in `results`                                                                                                                                                                                                                                                |
| Settings-derived inputs | Builds priors, likelihood, and hyperparameters from full settings      | Accepts explicit `prior.list`, `prior.sel`, `bt.prior`, `llik.fn`, and `hyper.pars`                                                                                                                                                                                                                                 |
| Flow                    | Monolithic setup -> run BayesianTools -> write outputs                 | Explicit inputs -> run BayesianTools -> optional write -> return results                                                                                                                                                                                                                                            |
| Return                  | `settings` only                                                        | `list(settings = ..., results = ...)` with `out`, `external.data`, and filenames when written                                                                                                                                                                                                                       |


### Test Refactor


| Test area                         | Legacy coverage                       | Required update                                                     |
| --------------------------------- | ------------------------------------- | ------------------------------------------------------------------- |
| Happy path                        | Limited                               | Add tests for explicit inputs and return shape                      |
| Edge cases                        | Extension runs depended on file loads | Add tests for explicit `out` and `external.data` without file reads |
| Side effects / integration points | DB and file writes implicit           | Verify `write = FALSE` blocks writes and still returns results      |


### Call Flow Comparison

Old flow:

```text
pda.bayesian.tools(settings)
  -> pda.settings + pda.load.priors + load.pda.data
  -> build prior.sel/bt.prior/llik.fn/hyper.pars
  -> optional load external.<ensemble>.Rdata
  -> run BayesianTools
  -> write out + external.data + DB inserts
```

New flow:

```text
pda.bayesian.tools(settings, inputs, external.formats, external.data, prior.list, prior.sel, bt.prior, llik.fn, hyper.pars, ensemble.id, workflow.id, out, write)
  -> use explicit objects if present
  -> run BayesianTools
  -> if write = TRUE: file writes and DB inserts
  -> return list(settings, results)
```

### Refactored Dependency References


| Called function        | Source of truth                                                                | Caller update after dependency refactor                    |
| ---------------------- | ------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| `pda.settings.bt`      | [assim.batch.md - Function: pda.settings.bt](#function-pdasettingsbt)          | Use explicit BayesianTools settings.                       |
| `pda.create.ensemble`  | [assim.batch.md - Function: pda.create.ensemble](#function-pdacreateensemble)  | Create or inject ensemble id/workflow id.                  |
| `pda.init.run`         | [assim.batch.md - Function: pda.init.run](#function-pdainitrun)                | Create runs/configs using explicit run/model/host attrs.   |
| `pda.get.model.output` | [assim.batch.md - Function: pda.get.model.output](#function-pdagetmodeloutput) | Read model outputs with explicit run metadata and formats. |
| `return.bias`          | [assim.batch.md - Function: return.bias](#function-returnbias)                 | Compute bias terms from explicit bias config.              |
| `pda.calc.error`       | [assim.batch.md - Function: pda.calc.error](#function-pdacalcerror)            | Compute likelihood errors without full settings.           |
| `pda.calc.llik.par`    | [assim.batch.md - Function: pda.calc.llik.par](#function-pdacalcllikpar)       | Compute likelihood parameters from explicit inputs.        |
| `pda.postprocess`      | [assim.batch.md - Function: pda.postprocess](#function-pdapostprocess)         | Use minimal attributes; handle writes via `write`.         |


### Caller References


| Caller function | Location                            |
| --------------- | ----------------------------------- |
| `assim.batch`   | `modules/assim.batch/R/pda.utils.R` |


## Function: pda.calc.error

### Refactor Summary


| Aspect                  | Old                                                          | New                                                                                                     |
| ----------------------- | ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| Parameters              | `pda.calc.error(settings, ...)`                              | `pda.calc.error(inputs, likelihoods, model.out, run.id, bias.terms = NULL, dbCon = NULL, write = TRUE)` |
| Load files              | Reads likelihood config from `settings`                      | Uses explicit `inputs` and likelihood config                                                            |
| Save files              | DB inserts implicit when `con` present                       | DB inserts only when `dbCon` provided and `write = TRUE`                                                |
| Settings-derived inputs | Full `settings` required                                     | Explicit inputs only                                                                                    |
| Flow                    | Pulls inputs from settings, computes errors, may write to DB | Compute errors from explicit inputs; optional DB insert                                                 |
| Return                  | `pda.errors`                                                 | Same                                                                                                    |


### Test Refactor


| Test area                         | Legacy coverage                | Required update                                                  |
| --------------------------------- | ------------------------------ | ---------------------------------------------------------------- |
| Happy path                        | Limited                        | Add tests with explicit inputs and likelihood config             |
| Edge cases                        | Implicit settings dependencies | Add tests for missing likelihood entries and bias.terms handling |
| Side effects / integration points | DB writes implicit             | Verify DB inserts only when `write = TRUE` and `dbCon` provided  |


### Call Flow Comparison

Old flow:

```text
pda.calc.error(settings, model.out, run.id)
  -> read settings$assim.batch$inputs
  -> compute errors
  -> optional DB insert
```

New flow:

```text
pda.calc.error(inputs, likelihoods, model.out, run.id, bias.terms, dbCon, write)
  -> compute errors from explicit inputs
  -> optional DB insert when write = TRUE
```

### Refactored Dependency References


| Called function | Source of truth | Caller update after dependency refactor                         |
| --------------- | --------------- | --------------------------------------------------------------- |
| None            | --              | Pure error computation; DB insert only when explicitly enabled. |


### Caller References


| Caller function      | Location                                     |
| -------------------- | -------------------------------------------- |
| `pda.bayesian.tools` | `modules/assim.batch/R/pda.bayesian.tools.R` |
| `pda.emulator`       | `modules/assim.batch/R/pda.emulator.R`       |
| `pda.mcmc`           | `modules/assim.batch/R/pda.mcmc.R`           |
| `pda.mcmc.bs`        | `modules/assim.batch/R/pda.mcmc.bs.R`        |


## Function: pda.calc.llik.par

### Refactor Summary


| Aspect                  | Old                                       | New                                                     |
| ----------------------- | ----------------------------------------- | ------------------------------------------------------- |
| Parameters              | `pda.calc.llik.par(settings, ...)`        | `pda.calc.llik.par(inputs, n, error.stats, hyper.pars)` |
| Load files              | Reads `settings$assim.batch$inputs`       | Uses explicit `inputs`                                  |
| Save files              | None                                      | None                                                    |
| Settings-derived inputs | Full `settings` required                  | Explicit inputs only                                    |
| Flow                    | Build likelihood parameters from settings | Build likelihood parameters from explicit inputs        |
| Return                  | Likelihood parameter list                 | Same                                                    |


### Test Refactor


| Test area                         | Legacy coverage | Required update                              |
| --------------------------------- | --------------- | -------------------------------------------- |
| Happy path                        | Minimal         | Add tests for explicit inputs and hyper.pars |
| Edge cases                        | Implicit inputs | Add tests for missing error.stats entries    |
| Side effects / integration points | None            | No change                                    |


### Call Flow Comparison

Old flow:

```text
pda.calc.llik.par(settings, ...)
  -> read settings$assim.batch$inputs
  -> compute likelihood params
```

New flow:

```text
pda.calc.llik.par(inputs, n, error.stats, hyper.pars)
  -> compute likelihood params
```

### Refactored Dependency References


| Called function | Source of truth | Caller update after dependency refactor                          |
| --------------- | --------------- | ---------------------------------------------------------------- |
| None            | --              | Pure likelihood parameter calculation; no internal dependencies. |


### Caller References


| Caller function      | Location                                     |
| -------------------- | -------------------------------------------- |
| `hier.mcmc`          | `modules/assim.batch/R/hier.mcmc.R`          |
| `mcmc.GP`            | `modules/assim.batch/R/minimize.GP.R`        |
| `pda.bayesian.tools` | `modules/assim.batch/R/pda.bayesian.tools.R` |
| `pda.mcmc`           | `modules/assim.batch/R/pda.mcmc.R`           |
| `pda.mcmc.bs`        | `modules/assim.batch/R/pda.mcmc.bs.R`        |


## Function: pda.create.ensemble

### Refactor Summary


| Aspect                  | Old                                          | New                                                                         |
| ----------------------- | -------------------------------------------- | --------------------------------------------------------------------------- |
| Parameters              | `pda.create.ensemble(settings, con)`         | `pda.create.ensemble(assim.batch, workflow.id, dbCon = NULL, write = TRUE)` |
| Load files              | None                                         | None                                                                        |
| Save files              | Always inserts DB row when `con` present     | Inserts only when `write = TRUE` and `dbCon` provided                       |
| Settings-derived inputs | Full `settings` required                     | Explicit `assim.batch$method` and `workflow.id`                             |
| Flow                    | Build ensemble type from settings and insert | Build ensemble type from explicit inputs, optional DB insert                |
| Return                  | `ensemble.id` or `NA`                        | Same                                                                        |


### Test Refactor


| Test area                         | Legacy coverage    | Required update                                            |
| --------------------------------- | ------------------ | ---------------------------------------------------------- |
| Happy path                        | Minimal            | Add tests for explicit workflow.id and method              |
| Edge cases                        | DB optionality     | Add tests for write = FALSE returning NA without DB insert |
| Side effects / integration points | DB insert implicit | Verify DB insert only when write = TRUE                    |


### Call Flow Comparison

Old flow:

```text
pda.create.ensemble(settings, con)
  -> derive method from settings
  -> insert ensemble row
```

New flow:

```text
pda.create.ensemble(assim.batch, workflow.id, dbCon, write)
  -> derive method from assim.batch
  -> optional DB insert
```

### Refactored Dependency References


| Called function | Source of truth | Caller update after dependency refactor          |
| --------------- | --------------- | ------------------------------------------------ |
| None            | --              | Pure DB insert helper; no internal dependencies. |


### Caller References


| Caller function             | Location                                     |
| --------------------------- | -------------------------------------------- |
| `pda.bayesian.tools`        | `modules/assim.batch/R/pda.bayesian.tools.R` |
| `pda.emulator`              | `modules/assim.batch/R/pda.emulator.R`       |
| `pda.emulator.ms`           | `modules/assim.batch/R/pda.emulator.ms.R`    |
| `pda.mcmc`                  | `modules/assim.batch/R/pda.mcmc.R`           |
| `pda.mcmc.bs`               | `modules/assim.batch/R/pda.mcmc.bs.R`        |
| `return_multi_site_objects` | `modules/assim.batch/R/pda.utils.R`          |


## Function: pda.emulator

### Overview

Refactor `pda.emulator` to consume explicit prepared inputs and optional emulator state for extension runs. DB access and file writes are controlled by `write`, and all artifacts are surfaced in `results` instead of being saved silently.

### Refactor Summary


| Aspect                  | Old                                                                                                                                                                                                                 | New                                                                                                                                                                                                                                         |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `pda.emulator(settings, external.data, external.priors, external.knots, external.formats, ensemble.id, params.id, param.names, prior.id, chain, iter, adapt, adj.min, ar.target, jvar, n.knot, individual, remote)` | `pda.emulator(settings, dbCon = NULL, inputs = NULL, external.formats = NULL, external.priors = NULL, external.knots = NULL, ensemble.id = NULL, gp = NULL, SS = NULL, resume.list = NULL, bias.prior = NULL, sf.samp = NULL, write = TRUE` |
| Load files              | Loads `external.*` and emulator/SS/resume/bias/sf artifacts internally                                                                                                                                              | Uses explicit objects when provided; compatibility loads only when needed                                                                                                                                                                   |
| Save files              | Writes history/emulator/SS/mcmc/resume/external/bias/sf artifacts internally                                                                                                                                        | Returns artifacts in `results`; `write` controls file and DB writes                                                                                                                                                                         |
| Settings-derived inputs | Derives ensemble/run IDs, output paths, and DB connection internally                                                                                                                                                | Uses minimal required settings attributes and explicit `dbCon`/`ensemble.id`                                                                                                                                                                |
| Flow                    | Monolithic setup, IO, DB access, model runs, emulator, and writes                                                                                                                                                   | Explicit inputs -> compute -> optional write -> postprocess                                                                                                                                                                                 |
| Return                  | Updated `settings` only                                                                                                                                                                                             | `list(settings = ..., results = ...)`                                                                                                                                                                                                       |


### Test Refactor


| Test area                         | Legacy coverage   | Required update                                                                  |
| --------------------------------- | ----------------- | -------------------------------------------------------------------------------- |
| Happy path                        | Minimal           | Add tests for explicit inputs and `list(settings, results)` return shape         |
| Edge cases                        | Unspecified       | Extension modes (`round`, `longer`) with injected emulator state; write disabled |
| Side effects / integration points | Heavy internal IO | Assert no implicit DB open/close or file writes when `write = FALSE`             |


### Call Flow Comparison

Old flow:

```text
assim.batch(settings)
  -> pda.emulator(settings)
      -> pda.settings
      -> db.open + pda.load.priors + load.pda.data
      -> pda.create.ensemble + pda.init.run
      -> pda.get.model.output + pda.calc.error
      -> fit GP + mcmc
      -> write history/emulator/ss/mcmc/resume/external/bias/sf
      -> pda.postprocess
```

New flow:

```text
pda.emulator(settings, dbCon, inputs, external.priors, external.knots, external.formats, ensemble.id, gp, SS, resume.list, bias.prior, sf.samp, write)
  -> use explicit objects if present
  -> compute emulator + MCMC
  -> if write = TRUE: file writes and DB inserts
  -> pda.postprocess(...)
  -> return list(settings, results)
```

### Refactored Dependency References


| Called function        | Source of truth                                                                | Caller update after dependency refactor                    |
| ---------------------- | ------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| `pda.create.ensemble`  | [assim.batch.md - Function: pda.create.ensemble](#function-pdacreateensemble)  | Create or inject ensemble id.                              |
| `pda.init.run`         | [assim.batch.md - Function: pda.init.run](#function-pdainitrun)                | Create runs/configs using explicit run/model/host attrs.   |
| `pda.get.model.output` | [assim.batch.md - Function: pda.get.model.output](#function-pdagetmodeloutput) | Read model outputs with explicit run metadata and formats. |
| `return.bias`          | [assim.batch.md - Function: return.bias](#function-returnbias)                 | Compute bias terms from explicit bias config.              |
| `pda.calc.error`       | [assim.batch.md - Function: pda.calc.error](#function-pdacalcerror)            | Compute likelihood errors without full settings.           |
| `mcmc.GP`              | [assim.batch.md - Function: mcmc.GP](#function-mcmcgp)                         | Run emulator MCMC with explicit inputs/jump.               |
| `pda.postprocess`      | [assim.batch.md - Function: pda.postprocess](#function-pdapostprocess)         | Use minimal attributes; handle writes via `write`.         |


### Caller References


| Caller function      | Location                            |
| -------------------- | ----------------------------------- |
| `assim.batch`        | `modules/assim.batch/R/pda.utils.R` |
| `prepare_pda_remote` | `modules/assim.batch/R/pda.utils.R` |


## Function: pda.emulator.ms

### Refactor Summary


| Aspect                  | Old                                                                                                          | New                                                                                                                                                                                 |
| ----------------------- | ------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `pda.emulator.ms(settings)`                                                                                  | `pda.emulator.ms(multi.settings, history = NULL, gp.stack = NULL, SS.stack = NULL, dbCon = NULL, multi_site_objects = NULL, write = TRUE, return = c("settings","results","both"))` |
| Load files              | Loaded history, emulator objects, and SS objects internally from files                                       | Uses explicit `history`, `gp.stack`, `SS.stack`, and `multi_site_objects` when provided; compatibility loads only when needed                                                       |
| Save files              | Saved restart history/checkpoints internally as side effects                                                 | Returns artifacts in `results`; `write` controls file and DB writes                                                                                                                 |
| Settings-derived inputs | Derived mode and resource context from full `multi.settings`                                                 | Uses required method/mode/site metadata and explicit objects/connections                                                                                                            |
| Flow                    | Inline mode resolution, remote sync, DB open/close, file loads, joint/hierarchical blocks, checkpoint writes | Explicit objects drive phases; remote and DB lifecycle moved behind `write` and wrapper boundaries                                                                                  |
| Return                  | `settings` only                                                                                              | `list(settings = ..., results = ...)` with history, gp/SS stacks, MCMC outputs, postprocess artifacts, and filenames when written                                                   |


### Test Refactor


| Test area                         | Legacy coverage                          | Required update                                                       |
| --------------------------------- | ---------------------------------------- | --------------------------------------------------------------------- |
| Happy path                        | Sparse orchestration coverage            | Add tests for explicit inputs and return shape per mode               |
| Edge cases                        | Mode-specific hidden paths               | Add tests for missing explicit objects with compatibility fallback    |
| Side effects / integration points | Remote/DB/file writes coupled to compute | Verify `write = FALSE` blocks side effects while results are returned |


### Call Flow Comparison

Old flow:

```text
runModule.assim.batch(settings)
  -> pda.emulator.ms(multi.settings)
      -> open tunnel + remote prep/sync
      -> load history/emulator/SS from disk
      -> open DB connection
      -> joint + hierarchical blocks
      -> checkpoint writes
```

New flow:

```text
pda.emulator.ms(multi.settings, history, gp.stack, SS.stack, dbCon, multi_site_objects, write)
  -> use explicit objects if present
  -> run selected phases (individual, joint, hierarchical)
  -> if write = TRUE: file writes and DB inserts
  -> return list(settings, results)
```

### Refactored Dependency References


| Called function             | Source of truth                                                                             | Caller update after dependency refactor                                 |
| --------------------------- | ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `return_multi_site_objects` | [assim.batch.md - Function: return_multi_site_objects](#function-return_multi_site_objects) | Provide shared priors/knots/formats and ensemble IDs explicitly.        |
| `load_pda_history`          | [assim.batch.md - Function: load_pda_history](#function-load_pda_history)                   | Inject preloaded history or explicit history path.                      |
| `pda.create.ensemble`       | [assim.batch.md - Function: pda.create.ensemble](#function-pdacreateensemble)               | Pass explicit assim.batch method + workflow id; avoid internal DB open. |
| `mcmc.GP`                   | [assim.batch.md - Function: mcmc.GP](#function-mcmcgp)                                      | Pass explicit inputs/jump/pos.check as needed.                          |
| `hier.mcmc`                 | [assim.batch.md - Function: hier.mcmc](#function-hiermcmc)                                  | Pass explicit inputs/jump/hyper.pars; no full settings.                 |
| `pda.postprocess`           | [assim.batch.md - Function: pda.postprocess](#function-pdapostprocess)                      | Pass minimal attributes and optional params.subset.                     |


### Caller References


| Caller function         | Location                            |
| ----------------------- | ----------------------------------- |
| `runModule.assim.batch` | `modules/assim.batch/R/pda.utils.R` |


## Function: pda.get.model.output

### Refactor Summary


| Aspect                  | Old                                                        | New                                                                        |
| ----------------------- | ---------------------------------------------------------- | -------------------------------------------------------------------------- |
| Parameters              | `pda.get.model.output(settings, ...)`                      | `pda.get.model.output(run.id, run, modeloutdir, inputs, external.formats)` |
| Load files              | Queries BETY for formats and reads model output internally | Uses explicit `external.formats` when provided; otherwise fallback         |
| Save files              | None                                                       | None                                                                       |
| Settings-derived inputs | Full `settings` required                                   | Explicit run metadata and inputs                                           |
| Flow                    | Fetch formats, read outputs, align timestamps              | Same, but driven by explicit inputs                                        |
| Return                  | `list(model.out, inputs)`                                  | Same                                                                       |


### Test Refactor


| Test area                         | Legacy coverage     | Required update                             |
| --------------------------------- | ------------------- | ------------------------------------------- |
| Happy path                        | Minimal             | Add tests for explicit external.formats     |
| Edge cases                        | Hidden BETY queries | Add tests for fallback when formats missing |
| Side effects / integration points | None                | No change                                   |


### Call Flow Comparison

Old flow:

```text
pda.get.model.output(settings)
  -> lookup formats via BETY
  -> read.output + align timestamps
```

New flow:

```text
pda.get.model.output(run.id, run, modeloutdir, inputs, external.formats)
  -> read.output + align timestamps
```

### Refactored Dependency References


| Called function | Source of truth | Caller update after dependency refactor              |
| --------------- | --------------- | ---------------------------------------------------- |
| None            | --              | Uses model read utilities; no internal dependencies. |


### Caller References


| Caller function      | Location                                     |
| -------------------- | -------------------------------------------- |
| `pda.bayesian.tools` | `modules/assim.batch/R/pda.bayesian.tools.R` |
| `pda.emulator`       | `modules/assim.batch/R/pda.emulator.R`       |
| `pda.mcmc`           | `modules/assim.batch/R/pda.mcmc.R`           |
| `pda.mcmc.bs`        | `modules/assim.batch/R/pda.mcmc.bs.R`        |


## Function: pda.init.run

### Refactor Summary


| Aspect                  | Old                                                           | New                                                                                    |
| ----------------------- | ------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| Parameters              | `pda.init.run(settings)`                                      | `pda.init.run(run, model, host, pfts, rundir, modeloutdir, ensemble.id, write = TRUE)` |
| Load files              | None                                                          | None                                                                                   |
| Save files              | Creates dirs, writes README, runs.txt, and configs implicitly | Controlled by `write`                                                                  |
| Settings-derived inputs | Full `settings` required                                      | Explicit run/model/host/pfts attributes                                                |
| Flow                    | Derive rundir/outdir from settings, write configs             | Same operations with explicit inputs                                                   |
| Return                  | Run IDs and config paths                                      | Same                                                                                   |


### Test Refactor


| Test area                         | Legacy coverage      | Required update                              |
| --------------------------------- | -------------------- | -------------------------------------------- |
| Happy path                        | Minimal              | Add tests for explicit run/model/host inputs |
| Edge cases                        | Implicit paths       | Add tests for missing rundir/modeloutdir     |
| Side effects / integration points | File writes implicit | Verify `write = FALSE` does not create files |


### Call Flow Comparison

Old flow:

```text
pda.init.run(settings)
  -> derive run/model/host/rundir
  -> write configs and run metadata
```

New flow:

```text
pda.init.run(run, model, host, pfts, rundir, modeloutdir, ensemble.id, write)
  -> write configs only when write = TRUE
```

### Caller References


| Caller function      | Location                                     |
| -------------------- | -------------------------------------------- |
| `pda.bayesian.tools` | `modules/assim.batch/R/pda.bayesian.tools.R` |
| `pda.emulator`       | `modules/assim.batch/R/pda.emulator.R`       |
| `pda.mcmc`           | `modules/assim.batch/R/pda.mcmc.R`           |
| `pda.mcmc.bs`        | `modules/assim.batch/R/pda.mcmc.bs.R`        |


## Function: pda.plot.params

### Refactor Summary


| Aspect                  | Old                                           | New                                                        |
| ----------------------- | --------------------------------------------- | ---------------------------------------------------------- |
| Parameters              | `pda.plot.params(settings)`                   | `pda.plot.params(pfts, outdir, ensemble.id, write = TRUE)` |
| Load files              | Uses settings to find param folders           | Uses explicit attributes                                   |
| Save files              | Always writes diagnostics files               | Writes only when `write = TRUE`                            |
| Settings-derived inputs | Full `settings` required                      | Explicit `pfts`, `outdir`, and `ensemble.id`               |
| Flow                    | Computes params.subset and writes diagnostics | Computes params.subset; optional writes                    |
| Return                  | `params.subset`                               | Same                                                       |


### Test Refactor


| Test area                         | Legacy coverage     | Required update                              |
| --------------------------------- | ------------------- | -------------------------------------------- |
| Happy path                        | Minimal             | Add tests for explicit inputs and write flag |
| Edge cases                        | Missing outdir/pfts | Add tests for fallback paths                 |
| Side effects / integration points | Writes implicit     | Verify write = FALSE skips files             |


### Call Flow Comparison

Old flow:

```text
pda.plot.params(settings)
  -> compute params.subset
  -> write diagnostics
```

New flow:

```text
pda.plot.params(pfts, outdir, ensemble.id, write)
  -> compute params.subset
  -> optional writes
```

### Refactored Dependency References

- No documented refactored-function dependencies in the strict path.

### Caller References


| Caller function   | Location                                  |
| ----------------- | ----------------------------------------- |
| `pda.postprocess` | `modules/assim.batch/R/pda.postprocess.R` |


## Function: pda.postprocess

### Refactor Summary


| Aspect                  | Old                                                    | New                                                                                                                                                              |
| ----------------------- | ------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `pda.postprocess(settings, ...)`                       | `pda.postprocess(pfts, outdir, model_type, modeloutdir, ensemble.id, params.subset = NULL, dbCon = NULL, write = TRUE, return = c("settings","results","both"))` |
| Load files              | Reads multiple values from `settings`                  | Uses explicit inputs; minimal required attributes only                                                                                                           |
| Save files              | Always writes post.distns, trait.mcmc, and XML         | Controlled by `write`                                                                                                                                            |
| Settings-derived inputs | Full `settings` required                               | Explicit `pfts`, `outdir`, `model_type`, `modeloutdir`, `ensemble.id`                                                                                            |
| Flow                    | Calls `pda.plot.params`, writes outputs and DB inserts | Accepts optional `params.subset`; optional writes and DB inserts                                                                                                 |
| Return                  | `settings` only                                        | `list(settings = ..., results = ...)` with postprocess artifacts and filenames                                                                                   |


### Test Refactor


| Test area                         | Legacy coverage                | Required update                                |
| --------------------------------- | ------------------------------ | ---------------------------------------------- |
| Happy path                        | Minimal                        | Add tests for explicit inputs and return shape |
| Edge cases                        | Implicit params.subset         | Add tests for passing params.subset directly   |
| Side effects / integration points | Writes and DB inserts implicit | Verify `write = FALSE` blocks writes/inserts   |


### Call Flow Comparison

Old flow:

```text
pda.postprocess(settings)
  -> pda.plot.params(settings)
  -> write post.distns/trait.mcmc/XML
  -> DB inserts
```

New flow:

```text
pda.postprocess(pfts, outdir, model_type, modeloutdir, ensemble.id, params.subset, dbCon, write)
  -> optional pda.plot.params(...) if params.subset missing
  -> optional writes/inserts when write = TRUE
  -> return list(settings, results)
```

### Refactored Dependency References


| Called function   | Source of truth                                                       | Caller update after dependency refactor                   |
| ----------------- | --------------------------------------------------------------------- | --------------------------------------------------------- |
| `pda.plot.params` | [assim.batch.md - Function: pda.plot.params](#function-pdaplotparams) | Pass optional `params.subset` to avoid internal plotting. |


### Caller References


| Caller function      | Location                                     |
| -------------------- | -------------------------------------------- |
| `pda.bayesian.tools` | `modules/assim.batch/R/pda.bayesian.tools.R` |
| `pda.emulator`       | `modules/assim.batch/R/pda.emulator.R`       |
| `pda.emulator.ms`    | `modules/assim.batch/R/pda.emulator.ms.R`    |
| `pda.mcmc`           | `modules/assim.batch/R/pda.mcmc.R`           |
| `pda.mcmc.bs`        | `modules/assim.batch/R/pda.mcmc.bs.R`        |
| `pda.mcmc.recover`   | `modules/assim.batch/R/pda.mcmc.recover.R`   |


## Function: pda.settings.bt

### Refactor Summary


| Aspect                  | Old                                        | New                                               |
| ----------------------- | ------------------------------------------ | ------------------------------------------------- |
| Parameters              | `pda.settings.bt(settings)`                | `pda.settings.bt(bt.settings)` or explicit fields |
| Load files              | None                                       | None                                              |
| Save files              | None                                       | None                                              |
| Settings-derived inputs | Reads `settings$assim.batch$bt.settings`   | Uses explicit `bt.settings` input                 |
| Flow                    | Build BayesianTools settings from settings | Build from explicit inputs                        |
| Return                  | BayesianTools settings list                | Same                                              |


### Test Refactor


| Test area                         | Legacy coverage         | Required update                      |
| --------------------------------- | ----------------------- | ------------------------------------ |
| Happy path                        | Minimal                 | Add tests for explicit bt.settings   |
| Edge cases                        | Missing settings fields | Add tests for defaults and overrides |
| Side effects / integration points | None                    | No change                            |


### Call Flow Comparison

Old flow:

```text
pda.settings.bt(settings)
  -> read settings$assim.batch$bt.settings
```

New flow:

```text
pda.settings.bt(bt.settings)
  -> return settings list
```

### Refactored Dependency References


| Called function | Source of truth | Caller update after dependency refactor         |
| --------------- | --------------- | ----------------------------------------------- |
| None            | --              | Pure settings helper; no internal dependencies. |


### Caller References


| Caller function      | Location                                     |
| -------------------- | -------------------------------------------- |
| `pda.bayesian.tools` | `modules/assim.batch/R/pda.bayesian.tools.R` |


## Function: return.bias

### Refactor Summary


| Aspect                  | Old                                           | New                                                                                                       |
| ----------------------- | --------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| Parameters              | `return.bias(settings, ...)`                  | `return.bias(inputs, model.out, bias.prior = NULL, run.round = NULL, pass2bias = NULL, bias.path = NULL)` |
| Load files              | Reads bias config from settings and bias path | Uses explicit bias config or bias.prior when provided                                                     |
| Save files              | None                                          | None                                                                                                      |
| Settings-derived inputs | Full `settings` required                      | Explicit inputs and bias config only                                                                      |
| Flow                    | Derives bias priors and terms from settings   | Computes bias terms from explicit inputs                                                                  |
| Return                  | Bias terms and updated prior list             | Same                                                                                                      |


### Test Refactor


| Test area                         | Legacy coverage | Required update                               |
| --------------------------------- | --------------- | --------------------------------------------- |
| Happy path                        | Minimal         | Add tests for explicit inputs and bias priors |
| Edge cases                        | Hidden defaults | Add tests for missing bias prior defaults     |
| Side effects / integration points | None            | No change                                     |


### Call Flow Comparison

Old flow:

```text
return.bias(settings, ...)
  -> read bias config from settings
  -> compute bias terms
```

New flow:

```text
return.bias(inputs, model.out, bias.prior, run.round, pass2bias, bias.path)
  -> compute bias terms
```

### Refactored Dependency References


| Called function | Source of truth | Caller update after dependency refactor               |
| --------------- | --------------- | ----------------------------------------------------- |
| None            | --              | Pure bias term computation; no internal dependencies. |


### Caller References


| Caller function      | Location                                     |
| -------------------- | -------------------------------------------- |
| `pda.bayesian.tools` | `modules/assim.batch/R/pda.bayesian.tools.R` |
| `pda.emulator`       | `modules/assim.batch/R/pda.emulator.R`       |
| `pda.mcmc`           | `modules/assim.batch/R/pda.mcmc.R`           |
| `pda.mcmc.bs`        | `modules/assim.batch/R/pda.mcmc.bs.R`        |


## Function: return_multi_site_objects

### Refactor Summary


| Aspect                  | Old                                                          | New                                                                                         |
| ----------------------- | ------------------------------------------------------------ | ------------------------------------------------------------------------------------------- |
| Parameters              | `return_multi_site_objects(settings, ...)`                   | `return_multi_site_objects(method, dbCon = NULL, write = TRUE, ensembleidlist = NULL, ...)` |
| Load files              | Loads priors/knots/formats as needed                         | Uses explicit objects when provided; compatibility loads only when needed                   |
| Save files              | Creates ensemble IDs via DB insert                           | If `write = FALSE`, allow `ensembleidlist` or return `NA`                                   |
| Settings-derived inputs | Full `settings` required                                     | Explicit `method` and optional `dbCon`                                                      |
| Flow                    | Open DB, load priors/knots/formats, create ensemble ids      | Same operations with explicit inputs and optional DB use                                    |
| Return                  | `priorlist`, `formatlist`, `externalknots`, `ensembleidlist` | Same                                                                                        |


### Test Refactor


| Test area                         | Legacy coverage     | Required update                                 |
| --------------------------------- | ------------------- | ----------------------------------------------- |
| Happy path                        | Minimal             | Add tests for explicit dbCon and ensembleidlist |
| Edge cases                        | DB optionality      | Add tests for write = FALSE without DB          |
| Side effects / integration points | DB inserts implicit | Verify DB inserts only when write = TRUE        |


### Call Flow Comparison

Old flow:

```text
return_multi_site_objects(settings)
  -> open DB
  -> load priors/knots/formats
  -> create ensemble IDs
```

New flow:

```text
return_multi_site_objects(method, dbCon, write, ensembleidlist)
  -> load priors/knots/formats
  -> optional DB insert for ensemble IDs
```

### Refactored Dependency References


| Called function       | Source of truth                                                               | Caller update after dependency refactor            |
| --------------------- | ----------------------------------------------------------------------------- | -------------------------------------------------- |
| `load_pda_history`    | [assim.batch.md - Function: load_pda_history](#function-load_pda_history)     | Inject preloaded history or explicit history path. |
| `pda.create.ensemble` | [assim.batch.md - Function: pda.create.ensemble](#function-pdacreateensemble) | Create or inject ensemble ids explicitly.          |


### Caller References


| Caller function   | Location                                  |
| ----------------- | ----------------------------------------- |
| `pda.emulator.ms` | `modules/assim.batch/R/pda.emulator.ms.R` |


## Function: runModule.assim.batch

### Refactor Summary


| Aspect                  | Old                                                      | New                                                                                                                                      |
| ----------------------- | -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `runModule.assim.batch(settings)`                        | `runModule.assim.batch(settings, history = NULL, gp.stack = NULL, SS.stack = NULL, dbCon = NULL, write = TRUE, multi_site_objects = NULL |
| Load files              | History/emulator objects loaded downstream               | Uses explicit `history`, `gp.stack`, `SS.stack`, and `multi_site_objects` when provided; compatibility loads only when needed            |
| Save files              | Downstream writes happened implicitly                    | `write` controls file and DB writes; returned `results` always expose artifacts                                                          |
| Settings-derived inputs | Full `settings` used to derive dispatch and dependencies | Uses required dispatch fields and passes explicit dependencies                                                                           |
| Flow                    | Direct dispatch into monolithic multi-site emulator      | Dispatches emulator or BayesianTools paths with explicit inputs                                                                          |
| Return                  | `settings` only                                          | `list(settings = ..., results = ...)`                                                                                                    |


### Test Refactor


| Test area                         | Legacy coverage                  | Required update                                                 |
| --------------------------------- | -------------------------------- | --------------------------------------------------------------- |
| Happy path                        | Sparse orchestration coverage    | Add tests for explicit-parameter dispatch and return shape      |
| Edge cases                        | Compatibility paths not isolated | Add tests for missing explicit objects with fallback loading    |
| Side effects / integration points | Downstream writes implicit       | Verify `write = FALSE` blocks writes and results still returned |


### Call Flow Comparison

Old flow:

```text
runModule.assim.batch(settings)
  -> detect method
  -> pda.emulator.ms(settings) or assim.batch(settings)
```

New flow:

```text
runModule.assim.batch(settings, history, gp.stack, SS.stack, dbCon, write, multi_site_objects, return)
  -> detect method
  -> pda.emulator.ms(...) or pda.emulator(...) or pda.bayesian.tools(...)
  -> return list(settings, results)
```

### Refactored Dependency References


| Called function      | Source of truth                                                             | Caller update after dependency refactor                                                                  |
| -------------------- | --------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `pda.emulator.ms`    | [assim.batch.md - Function: pda.emulator.ms](#function-pdaemulatorms)       | Dispatch multi-site emulator.ms with explicit objects and connections.                                   |
| `pda.emulator`       | [assim.batch.md - Function: pda.emulator](#function-pdaemulator)            | Dispatch the single-site emulator path with explicit prepared objects when that method is selected.      |
| `pda.bayesian.tools` | [assim.batch.md - Function: pda.bayesian.tools](#function-pdabayesiantools) | Dispatch the single-site BayesianTools path with explicit prepared objects when that method is selected. |


### Caller References


| Caller function        | Location                                                        |
| ---------------------- | --------------------------------------------------------------- |                                                                                     
| `workflow.R`           | `web/workflow.R`                                                |
| `workflow.wcr.assim.R` | `scripts/workflow.wcr.assim.R`                                  |
| `workflow_2.R`         | `modules/assim.sequential/inst/sda_backup/sserbin/workflow_2.R` |
| `workflow.R`           | `modules/assim.sequential/inst/sda_backup/sserbin/workflow.R`   |


