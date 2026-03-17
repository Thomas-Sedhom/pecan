---

## title: "PEcAn Modular Assim Batch (Emulator MS) Migration"

## Overview

This document describes the migration from implicit file/DB state to explicit
object passing for emulator-based PDA. It clarifies artifact persistence: core
functions **return objects** and **expose internally saved artifacts**, while
file writes and DB inserts happen only when `write = TRUE`.

Key compatibility rule: the default return remains the **settings** object, but
it is returned inside a list as `list(settings = ..., results = ...)` so all
internal artifacts are always surfaced.

## Old Flow

1. `runModule.assim.batch(settings)` detects `method == "emulator.ms"`.
2. `pda.emulator.ms(settings)` loads history and emulator objects from disk, opens
  a DB connection, creates ensembles, and writes MCMC outputs and XML to disk.
3. Individual mode runs submit jobs, sync remote files, then read XML back.

This created hidden dependencies and made it hard to reuse outputs without
reading or writing the filesystem.

## New Flow

Explicit inputs can be prepared up front, then passed through:

- `dbCon`, `inputs`, `external.priors`, `external.knots`, `external.formats`
- Optional BayesianTools inputs: `external.data`, `prior.sel`, `bt.prior`, `llik.fn`, `hyper.pars`, `out`
- Optional longer-run emulator state: `gp`, `SS`, `resume.list`, `bias.prior`, `sf.samp`

Steps:

1. `runModule.assim.batch(settings, ...)` forwards explicit objects to
  `pda.emulator.ms(...)` or `pda.emulator(...)`.
2. `pda.emulator.ms(...)` and `pda.emulator(...)` use explicit inputs when present
  and return `list(settings = ..., results = ...)`.
3. `pda.bayesian.tools(...)` uses explicit inputs when present, supports `out`
  for extension runs, and returns `list(settings = ..., results = ...)`.
4. `pda.get.model.output(...)` uses explicit run metadata, inputs, and formats.
5. `pda.settings.bt(...)` uses explicit BayesianTools settings.
6. `pda.init.run(...)`, `return.bias(...)`, and `pda.calc.error(...)` use explicit
  attributes instead of full settings.
7. `mcmc.GP(...)` and `hier.mcmc(...)` use only `assim.batch` inputs or explicit
  `inputs`/`jump`.
8. `pda.postprocess(...)` accepts minimal attributes and optional `params.subset`.
9. If `write = FALSE`, no file writes or DB inserts occur and results still include
  all objects that would have been written.

## Function-by-Function Legacy vs New

### `runModule.assim.batch` (`modules/assim.batch/R/pda.utils.R`)


| Aspect          | Legacy Pattern  | New Pattern                                                                                                                                    |
| --------------- | --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Input style     | `settings` only | `settings` plus explicit objects                                                                                                               |
| Hidden behavior | None directly   | Forwards explicit objects                                                                                                                      |
| Parameters      | `settings`      | `settings, history=NULL, gp.stack=NULL, SS.stack=NULL, dbCon=NULL, write=TRUE, multi_site_objects=NULL, return=c("settings","results","both")` |
| Output          | `settings`      | `list(settings = ..., results = ...)`; optionally return only `settings` if `return = "settings"`                                              |


### `pda.emulator.ms` (`modules/assim.batch/R/pda.emulator.ms.R`)


| Aspect       | Legacy Pattern                  | New Pattern                                                            |
| ------------ | ------------------------------- | ---------------------------------------------------------------------- |
| History      | `load_pda_history()` from disk  | Use `history` if provided, else load                                   |
| GP/SS        | `load()` from emulator/ss paths | Use `gp.stack`/`SS.stack` if provided                                  |
| DB           | `db.open()` internally          | Use `dbCon` if provided; open only if needed and `write=TRUE`          |
| Side effects | Writes many files + DB inserts  | Controlled by `write`                                                  |
| Return       | `settings`                      | `list(settings = ..., results = ...)` + optional explicit results list |


Results returned in `results` always include:

- `history` (loaded or provided)
- `gp.stack`, `SS.stack`
- `mcmc.out`, `mcmc.param.list`
- `postprocess` results from `pda.postprocess`
- `filenames` for artifacts when `write = TRUE`

### `pda.emulator` (`modules/assim.batch/R/pda.emulator.R`)


| Aspect           | Legacy Pattern                                | New Pattern                                                          |
| ---------------- | --------------------------------------------- | -------------------------------------------------------------------- |
| DB               | Opens `db.open()` internally                  | Accept `dbCon = NULL` and only open if needed and `write=TRUE`       |
| Data             | Calls `load.pda.data(...)` internally         | Accept `inputs` and `external.formats` explicitly                    |
| Priors           | Calls `pda.load.priors(...)` internally       | Accept `prior.list` via `external.priors`                            |
| Knots            | Generates knots internally                    | Accept `knots.params` via `external.knots`                           |
| Ensemble         | Calls `pda.create.ensemble(...)` internally   | Accept `ensemble.id` explicitly                                      |
| Longer-run state | Loads `emulator/SS/resume/bias/sf` from files | Accept `gp`, `SS`, `resume.list`, `bias.prior`, `sf.samp` explicitly |
| Side effects     | Writes many files + DB inserts                | Controlled by `write`                                                |
| Return           | `settings`                                    | `list(settings = ..., results = ...)`                                |


Results returned in `results` include all previously saved artifacts:

- `gp`, `SS`
- `mcmc.samp.list`, `resume.list`
- `external.data` (inputs with neff)
- `bias.prior` and bias path when used
- `sf.post.distns`, `sf.samp.list`
- `history` restart path and logfile path
- `filenames` for artifacts when `write = TRUE`

### `pda.bayesian.tools` (`modules/assim.batch/R/pda.bayesian.tools.R`)


| Aspect          | Legacy Pattern                                                                 | New Pattern                                                         |
| --------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------- |
| DB              | Opens `db.open()` internally                                                   | Accept `dbCon = NULL` and only open if needed and `write=TRUE`      |
| Data            | Calls `load.pda.data(...)` and loads `external.<ensemble>.Rdata` for extension | Accept `inputs`, `external.formats`, and `external.data` explicitly |
| Priors          | Calls `pda.load.priors(...)` internally                                        | Accept `prior.list` via `external.priors`                           |
| Prior objects   | Builds `prior.sel` and `bt.prior` internally                                   | Accept `prior.sel`, `bt.prior` explicitly                           |
| Likelihood      | Builds `llik.fn` and `hyper.pars` internally                                   | Accept `llik.fn` and `hyper.pars` explicitly                        |
| Ensemble        | Calls `pda.create.ensemble(...)` internally                                    | Accept `ensemble.id` and `workflow.id` explicitly                   |
| Extension state | Loads `out` from `settings$assim.batch$out.path`                               | Accept `out` explicitly                                             |
| Side effects    | Writes `out` and `external.data` to disk + DB inserts                          | Controlled by `write`                                               |
| Return          | `settings`                                                                     | `list(settings = ..., results = ...)`                               |


Results returned in `results` include all previously saved artifacts:

- BayesianTools `out`
- `external.data` (inputs with neff)
- `out.path` and filenames when `write = TRUE`
- Optional cached objects used for extension runs

### `pda.init.run` (`modules/assim.batch/R/pda.utils.R`)


| Aspect          | Legacy Pattern                                           | New Pattern                                                                    |
| --------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------ |
| Input style     | Full `settings` list                                     | Minimal `run`, `model`, `host`, `pfts`, `rundir`, `modeloutdir`, `ensemble.id` |
| Hidden behavior | Creates dirs, writes README and runs.txt, writes configs | Make write behavior explicit (e.g., `write = TRUE/FALSE`)                      |
| Output          | Run IDs                                                  | Same                                                                           |


Required attributes passed in by caller:

- `run` (site, dates, inputs)
- `model` (id, type)
- `host` (rundir, outdir, name)
- `rundir`, `modeloutdir`
- `assim.batch$ensemble.id`
- `pfts` (for config writing)

### `return.bias` (`modules/assim.batch/R/pda.utils.R`)


| Aspect          | Legacy Pattern                                | New Pattern                             |
| --------------- | --------------------------------------------- | --------------------------------------- |
| Input style     | Full `settings` list                          | Explicit bias config and priors         |
| Hidden behavior | Default bias priors assumed when not provided | Accept explicit bias priors or defaults |
| Output          | Bias params and updated prior list            | Same                                    |


Required attributes passed in by caller:

- `inputs`
- `model.out`
- `bias.prior` or `bprior` config
- `run.round`, `pass2bias`, `bias.path` (for round extension)

### `pda.calc.error` (`modules/assim.batch/R/pda.define.llik.R`)


| Aspect          | Legacy Pattern                                          | New Pattern                             |
| --------------- | ------------------------------------------------------- | --------------------------------------- |
| Input style     | Full `settings` list                                    | Explicit `inputs` and likelihood config |
| Hidden behavior | Reads `settings$assim.batch$inputs` for likelihood type | Use explicit likelihood inputs          |
| Output          | `pda.errors` and optional DB inserts                    | Same                                    |


Required attributes passed in by caller:

- `inputs` (obs, n, n_eff, par, variable.id, input.id)
- `likelihood` configuration per input
- `dbCon` (optional, for DB inserts)

### `pda.get.model.output` (`modules/assim.batch/R/pda.get.model.output.R`)


| Aspect          | Legacy Pattern                                                                   | New Pattern                                      |
| --------------- | -------------------------------------------------------------------------------- | ------------------------------------------------ |
| Input style     | Full `settings` list                                                             | Explicit run metadata, inputs, and formats       |
| Hidden behavior | Queries format via BETY, reads model output via `read.output`, aligns timestamps | Use explicit `external.formats` and run metadata |
| Output          | `list(model.out, inputs)`                                                        | Same                                             |


Required attributes passed in by caller:

- `assim.batch$inputs` (variable.name, input.id, align.method)
- `run$start.date`, `run$end.date`
- `modeloutdir`
- `run.id`
- `inputs`
- `external.formats` (or `bety` when formats are not supplied)

### `pda.settings.bt` (`modules/assim.batch/R/pda.bayestools.helpers.R`)


| Aspect          | Legacy Pattern                           | New Pattern                        |
| --------------- | ---------------------------------------- | ---------------------------------- |
| Input style     | Full `settings` list                     | `bt.settings` (or explicit fields) |
| Hidden behavior | Reads `settings$assim.batch$bt.settings` | Use explicit `bt.settings` input   |
| Output          | BayesianTools settings list              | Same                               |




### `load_pda_history` (`modules/assim.batch/R/pda.utils.R`)


| Aspect          | Legacy Pattern                      | New Pattern                              |
| --------------- | ----------------------------------- | ---------------------------------------- |
| Input style     | `workdir`, `ensemble.id`, `objects` | Add `history=NULL`, `history_path=NULL`  |
| Hidden behavior | `load()` from implicit path         | Uses explicit history object if provided |
| Output          | List of requested objects           | Same                                     |


### `return_multi_site_objects` (`modules/assim.batch/R/pda.utils.R`)


| Aspect       | Legacy Pattern                                               | New Pattern                                             |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------- |
| DB use       | Always opens DB                                              | Uses `dbCon` if provided; optional                      |
| Ensemble IDs | Always created via DB                                        | If `write=FALSE`, allow `ensembleidlist` or return `NA` |
| Output       | `priorlist`, `formatlist`, `externalknots`, `ensembleidlist` | Same                                                    |


### `pda.create.ensemble` (`modules/assim.batch/R/pda.utils.R`)


| Aspect      | Legacy Pattern        | New Pattern                                             |
| ----------- | --------------------- | ------------------------------------------------------- |
| Input style | Full `settings` list  | `assim.batch` (or explicit `method`) plus `workflow.id` |
| DB insert   | Always if `con`       | Skips when `write=FALSE`                                |
| Output      | `ensemble.id` or `NA` | Same                                                    |


Required attributes passed in by caller:

- `assim.batch$method` (to determine ensemble type)
- `workflow.id`

### `mcmc.GP` (`modules/assim.batch/R/minimize.GP.R`)


| Aspect          | Legacy Pattern                                                                        | New Pattern                                                                             |
| --------------- | ------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| Input style     | Full `settings` list                                                                  | `assim.batch` or explicit `inputs`, `jump`, `pos.check`                                 |
| Hidden behavior | Derives `pos.check` from `inputs$ss.positive`; uses `settings$assim.batch$jump$adapt` | Accept `pos.check` explicitly; use local `jump` copy                                    |
| Internal calls  | `pda.calc.llik.par(settings, ...)`, `pda.adjust.jumps.bs(settings, ...)`              | Pass `inputs`/`hyper.pars` to `pda.calc.llik.par`; pass `jump` to `pda.adjust.jumps.bs` |
| Output          | MCMC samples and chain state                                                          | Same                                                                                    |


Required attributes for likelihood and jumping:

- `inputs` (likelihood, `ss.positive`, count)
- `jump` (`adapt`, `adj.min`, `ar.target`)
- `hyper.pars` (for `pda.calc.llik.par`)
- `n.of.obs`

### `pda.calc.llik.par` (`modules/assim.batch/R/pda.define.llik.R`)


| Aspect          | Legacy Pattern                      | New Pattern                                |
| --------------- | ----------------------------------- | ------------------------------------------ |
| Input style     | Full `settings` list                | `inputs`, `n`, `error.stats`, `hyper.pars` |
| Hidden behavior | Reads `settings$assim.batch$inputs` | Uses explicit `inputs`                     |
| Output          | Likelihood parameter list           | Same                                       |


### `pda.adjust.jumps.bs` (`modules/assim.batch/R/pda.utils.R`)


| Aspect          | Legacy Pattern                    | New Pattern                                          |
| --------------- | --------------------------------- | ---------------------------------------------------- |
| Input style     | Full `settings` list              | `jump` (or explicit `adapt`, `adj.min`, `ar.target`) |
| Hidden behavior | Reads `settings$assim.batch$jump` | Uses explicit jump settings                          |
| Output          | Updated covariance matrix         | Same                                                 |


### `pda.postprocess` (`modules/assim.batch/R/pda.postprocess.R`)


| Aspect                 | Legacy Pattern                 | New Pattern                                                                                                                           |
| ---------------------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------- |
| Input style            | Full `settings` list           | Minimal required attributes + optional `params.subset`                                                                                |
| Internal params.subset | Always calls `pda.plot.params` | Accept `params.subset` to avoid internal call                                                                                         |
| File writes            | Always                         | Controlled by `write`                                                                                                                 |
| DB inserts             | Always if `con`                | Controlled by `write`                                                                                                                 |
| Output                 | `settings`                     | `list(settings = ..., results = ...)` where results includes post.distns, trait.mcmc, diagnostics objects, and filenames when written |


Required settings attributes passed in by caller:

- `settings$pfts` (with `name`, `outdir`, `posteriorid` as needed)
- `settings$outdir`
- `settings$model$type`
- `settings$modeloutdir`
- `settings$assim.batch$ensemble.id`

### `pda.plot.params` (`modules/assim.batch/R/pda.postprocess.R`)


| Aspect               | Legacy Pattern       | New Pattern                 |
| -------------------- | -------------------- | --------------------------- |
| Input style          | Full `settings` list | Minimal required attributes |
| Diagnostics PDFs/TXT | Always written       | Only when `write=TRUE`      |
| Output               | `params.subset`      | Same                        |


Required settings attributes passed in by caller:

- `settings$pfts` (with `name`, `outdir`)
- `settings$assim.batch$ensemble.id`
- `settings$outdir` (for non-model params folder)

### `hier.mcmc` (`modules/assim.batch/R/hier.mcmc.R`)


| Aspect          | Legacy Pattern                                                                                                                     | New Pattern                                                                                                            |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Input style     | Full `settings` list                                                                                                               | `assim.batch` or explicit `inputs`, `jump`, `pos.check`, `hyper.pars`                                                  |
| Hidden behavior | Derives `pos.check` from `inputs$ss.positive`; mutates `settings$assim.batch$jump$adapt`; calls `pda.calc.llik.par(settings, ...)` | Accept `pos.check` explicitly; use local `jump` copy; call `pda.calc.llik.par` with explicit `inputs` and `hyper.pars` |
| Output          | Hierarchical MCMC samples                                                                                                          | Same                                                                                                                   |


Required attributes for hierarchical likelihood logic:

- `inputs` (likelihood, `ss.positive`, count)
- `jump` (`adapt`, `adj.min`, `ar.target`)
- `hyper.pars` (for `pda.calc.llik.par`)
- `nstack` (per-site sample sizes)

## Flow Diagrams

### Old Flow

```text
runModule.assim.batch(settings)
  -> pda.emulator.ms(settings)
      -> load_pda_history(...) from disk
      -> load gp / SS from disk
      -> open DB if needed
      -> write history.*.Rdata
      -> write MCMC outputs, post.distns, trait.mcmc, XML
      -> return settings
```

### New Flow

```text
Caller (optional)
  -> dbCon, inputs, prior.list, knots.params
  -> gp, SS, resume.list, bias.prior, sf.samp (longer runs)

runModule.assim.batch(settings, ...)
  -> pda.emulator.ms(settings, history, gp.stack, SS.stack, dbCon, write, ...)
      -> use explicit objects if present
      -> if write=FALSE: no file/DB writes
      -> return list(settings = ..., results = ...)
  -> pda.emulator(settings, dbCon, inputs, external.priors, external.knots, external.formats, gp, SS, resume.list, bias.prior, sf.samp, write)
      -> return list(settings = ..., results = ...)
  -> pda.bayesian.tools(settings, dbCon, inputs, external.priors, external.formats, external.data, prior.sel, bt.prior, llik.fn, hyper.pars, out, write)
      -> return list(settings = ..., results = ...)
  -> pda.settings.bt(bt.settings)
  -> pda.init.run(run, model, host, pfts, rundir, modeloutdir, ensemble.id, write)
  -> pda.get.model.output(run.id, run, modeloutdir, inputs, external.formats)
  -> return.bias(inputs, model.out, bias.prior, run.round, pass2bias, bias.path)
  -> pda.calc.error(inputs, likelihoods, model.out, run.id, bias.terms, dbCon)
  -> mcmc.GP(assim, gp, x0, n.of.obs, llik.fn, hyper.pars, jump, inputs, pos.check = NULL)
  -> hier.mcmc(assim, gp.stack, nstack, ..., pos.check = NULL, hyper.pars = ...)
  -> pda.postprocess(pfts, outdir, model_type, modeloutdir, ensemble_id, ..., params.subset = NULL)
      -> if params.subset missing, caller can compute with pda.plot.params(...)
```

## Deprecations

- Legacy implicit loading remains for backward compatibility but should be
avoided in new modular workflows.
- Passing the full settings object into `pda.emulator`, `pda.init.run`,
`return.bias`, `pda.calc.error`, `mcmc.GP`, `pda.calc.llik.par`,
`pda.adjust.jumps.bs`, `pda.create.ensemble`, `pda.postprocess`,
`pda.plot.params`, `hier.mcmc`, `pda.bayesian.tools`, `pda.get.model.output`,
or `pda.settings.bt` is discouraged when explicit attributes are available.
- Relying on implicit DB open/close and implicit loads for `resume/emulator/SS/bias/sf`
or `external.<ensemble>.Rdata` / `out.path` is discouraged when explicit objects are available.

## Recommended Usage

```r
# Optional explicit inputs
history <- NULL
gp.stack <- NULL
SS.stack <- NULL
dbCon <- NULL
inputs <- NULL
prior.list <- NULL
knots.params <- NULL

# Optional longer-run state
resume.list <- NULL
gp <- NULL
SS <- NULL
bias.prior <- NULL
sf.samp <- NULL

if (isTRUE(settings$database$bety$write)) {
  dbCon <- PEcAn.DB::db.open(settings$database$bety)
  on.exit(try(PEcAn.DB::db.close(dbCon), silent = TRUE), add = TRUE)
}

out <- runModule.assim.batch(
  settings,
  history = history,
  gp.stack = gp.stack,
  SS.stack = SS.stack,
  dbCon = dbCon,
  write = FALSE
)

settings <- out$settings
results <- out$results
```

Notes:

- If `write = FALSE`, individual/remote mode is disabled.
- All artifacts are exposed in `results` regardless of write.

