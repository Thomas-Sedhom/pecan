---
title: "PEcAn Modular Config Workflow Migration"
---

## Overview

This document describes the migration from implicit `samples.Rdata`-based state
handoff to explicit object passing for config generation.

## Old Flow

1. `runModule.run.write.configs(settings)` generated input designs.
2. `generate_joint_ensemble_design(settings, ...)` could call `get.parameter.samples(settings, ...)`.
3. `get.parameter.samples()` wrote `samples.Rdata`.
4. `run.write.configs()` loaded `samples.Rdata` from disk.

This created hidden dependencies between steps and reduced testability.

## New Flow

1. `runModule.run.write.configs(settings, dbCon = dbCon)` orchestrates explicit object assembly.
2. Internal helper loaders resolve:
   - `distns`
   - `trait.mcmc`
   - optional ensemble sample structures
3. `get.parameter.samples(...)` returns a structured `samples` object.
4. `generate_joint_ensemble_design(run, ensemble, ensemble_size, samples, sobol = FALSE)` builds design from explicit inputs.
5. `generate_OAT_SA_design(ensemble, samples)` builds OAT design from explicit inputs.
6. `run.write.configs(..., samples = samples)` consumes explicit samples directly.

## Function-by-Function Legacy vs New

### `.prepare_samples` (`base/workflow/R/runModule.run.write.configs.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | Implicit full `settings` | Explicit required inputs only |
| File/DB side effects | Could be hidden in downstream calls | Requires explicit `dbCon`; no `samples.Rdata` read/write in this function |
| Parameters | `settings` | `pfts, outdir, ensemble, sensitivity, host, dbCon` |
| Output | Implicit downstream state | Structured `samples` object from `get.parameter.samples(...)` |

Required settings attributes passed in by caller:
- `settings$pfts`
- `settings$outdir`
- `settings$ensemble`
- `settings$sensitivity.analysis` (optional)
- `settings$host$name` (optional)

---

### `get.parameter.samples` (`modules/uncertainty/R/get.parameter.samples.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `get.parameter.samples(settings, ...)` | Explicit-object-first inputs |
| Dependency style | Read from settings + DB/file fallback inside function | Receives prepared objects/attributes as parameters |
| Side effects | Wrote `samples.Rdata` by default | Returns `samples` list; legacy file write is optional/deprecated |
| Compatibility | N/A | Legacy `settings` path kept with deprecation warning |

New explicit inputs:
- `pfts`
- `outdir`
- `sensitivity`
- `trait.mcmc`
- `distns`
- `ensemble`
- `ensemble.size`
- `ens.sample.method`

Return object keys:
- `trait.samples`
- `sa.samples`
- `ensemble.samples`
- `runs.samples`
- `env.samples`
- `param.names`

---

### `.prepare_input_designs` (`base/workflow/R/runModule.run.write.configs.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | Full `settings` + optional `input_design` | Explicit pieces + `samples` |
| Internal generation | Could trigger implicit sampling via called functions | Uses explicit objects only |
| Parameters | `settings, input_design` | `run, ensemble, sensitivity, samples, input_design` |
| Output | Normalized/generate designs | `list(ensemble = ..., sensitivity = ...)` |

Required settings attributes passed in by caller:
- `settings$run`
- `settings$ensemble`
- `settings$sensitivity.analysis`
- explicit `samples`

---

### `generate_joint_ensemble_design` (`modules/uncertainty/R/generate_joint_ensemble_design.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | Accepted `settings` and could do internal fallback work | Only explicit required inputs |
| Hidden behavior | Could depend on internal sampling/file logic | No internal sample generation/load |
| Parameters | Mixed (`settings`, optional compatibility args) | `run, ensemble, ensemble_size, samples, sobol = FALSE` |
| Output | Design matrix / Sobol object | Same: `list(X=...)` or Sobol object when `sobol=TRUE` |

Required settings attributes passed in by caller:
- `settings$run`
- `settings$ensemble`
- explicit `samples`
- `ensemble_size`

---

### `generate_OAT_SA_design` (`modules/uncertainty/R/generate_OAT_SA_design.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | Accepted `settings`, `sa_samples` and fallback logic | Strict explicit inputs |
| Hidden behavior | Could call sampling path indirectly | No file/DB fallback in function |
| Parameters | `settings`, `sa_samples` (legacy) | `ensemble, samples` |
| Output | `list(X = design_matrix)` | Same |

Required settings attributes passed in by caller:
- `settings$ensemble`
- explicit `samples$sa.samples`

---

### `input.ens.gen` (`modules/uncertainty/R/ensemble.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | Could accept `settings` + deprecation path | Explicit required args only |
| Parameters | Included `settings` compatibility branch | `ensemble_size, input, method = "sampling", parent_ids = NULL, run` |
| Hidden behavior | Access via `settings$run$inputs` | Explicit `run$inputs` only |

Required settings attributes passed in by caller:
- `settings$run`

## Helper Functions (New/Internal)

New helper functions in `modules/uncertainty/R/samples.helpers.R`:

- `.resolve_pft_outdirs(pfts, outdir, dbCon)`
  - Resolves PFT output directories from explicit PFT/outdir/db inputs.

- `get.distns(pfts, outdir, dbCon, host, posterior.files)`
  - Loads prior/posterior distribution objects for each PFT.

- `get.trait.mcmc(pfts, outdir, dbCon, host, outdirs)`
  - Loads trait MCMC chains for each PFT; retains source-file metadata used for PDA-specific logic.

- `get_ensemble_samples(ensemble.size, trait.samples, env.samples, ens.sample.method, param.names)`
  - Creates ensemble sample draws from explicit sample inputs.

- `.validate_samples_list(samples)`
  - Validates required keys in the explicit samples object.

## New Samples Object Contract

The `samples` object passed through workflow/config layers is a list with:

- `trait.samples`
- `sa.samples`
- `ensemble.samples`
- `runs.samples`
- `env.samples`
- `param.names` (used when preserving correlated sampling behavior)

## `runModule.run.write.configs` Flow Diagrams

### Old Flow Diagram

```text
runModule.run.write.configs(settings)
  -> .prepare_input_designs(settings, input_design)
      -> generate_joint_ensemble_design(settings, ...)
          -> (if needed) get.parameter.samples(settings, ...)
              -> write samples.Rdata
  -> run.write.configs(settings, ...)
      -> load samples.Rdata
      -> write configs
```

### New Flow Diagram

```text
runModule.run.write.configs(settings, dbCon)
  -> .prepare_samples(pfts, outdir, ensemble, sensitivity, host, dbCon)
      -> get.distns(...)
      -> get.trait.mcmc(...)
      -> get.parameter.samples(pfts, outdir, sensitivity, trait.mcmc, distns, ensemble, ...)
      -> return samples (in memory)
  -> .prepare_input_designs(run, ensemble, sensitivity, samples, input_design)
      -> generate_joint_ensemble_design(run, ensemble, ensemble_size, samples, sobol=FALSE)
      -> generate_OAT_SA_design(ensemble, samples)
  -> run.write.configs(settings, ..., input_design, samples)
      -> write configs
```

## Deprecations

The following compatibility paths remain temporarily and emit deprecation warnings:

- Passing `settings` to `get.parameter.samples()`
- Calling `run.write.configs()` without `samples`

## Recommended Usage

```r
dbCon <- PEcAn.DB::db.open(settings$database$bety)
on.exit(try(PEcAn.DB::db.close(dbCon), silent = TRUE), add = TRUE)

settings <- PEcAn.workflow::runModule.run.write.configs(
  settings = settings,
  dbCon = dbCon
)
```

## Migration Notes

- Existing workflows can continue using compatibility paths during the deprecation window.
- New development should pass explicit objects and avoid relying on `samples.Rdata`.
