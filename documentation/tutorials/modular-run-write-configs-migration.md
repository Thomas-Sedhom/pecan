---
title: "PEcAn Modular Config Workflow Migration"
---

## Overview

This document describes the migration from implicit `samples.Rdata`-based state
handoff to explicit object passing for config generation. It also clarifies the
artifact persistence policy: core functions **return objects** and do **not**
save to disk by default, except for explicit config-writing steps that produce
run artifacts (e.g., configs and `runs_manifest.csv`).

## Old Flow

1. `runModule.run.write.configs(settings)` generated input designs.
2. `generate_joint_ensemble_design(settings, ...)` could call `get.parameter.samples(settings, ...)`.
3. `get.parameter.samples()` wrote `samples.Rdata`.
4. `run.write.configs()` loaded `samples.Rdata` from disk.

This created hidden dependencies between steps and reduced testability.

## New Flow

1. (Optional) Open a DB connection (`dbCon`) before config generation only if BETY
   lookups or writes are explicitly requested.
2. `generate_input_design(settings, input_design = NULL, samples = NULL, design_type = "ensemble" | "sensitivity")`
   prepares `samples` internally when missing (via `get.parameter.samples(..., write = FALSE)`), then builds
   **one** design based on `design_type`.
3. (Optional) Persist user-facing artifacts (e.g., `trait.mcmc`, `distns`, `samples`)
   using an explicit wrapper step if desired for inspection or reuse.
4. If both designs are required, call `generate_input_design(...)` twice with different `design_type` values.
5. `runModule.run.write.configs(settings, input_design = design, samples = samples, dbCon = NULL, write = TRUE)`
   requires a **single** design at a time; call it once per design and it delegates to
   `run.write.configs(..., samples = samples)`.
6. For `MultiSettings`, the same shared `samples` and per-design `input_design` objects are reused across all sites
   to keep sampling/design consistent.

## Function-by-Function Legacy vs New

### `.prepare_samples` (`base/workflow/R/runModule.run.write.configs.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | Implicit full `settings` with hidden file coupling | Deprecated helper; primary modular path uses `generate_input_design` to build `samples` |
| File/DB side effects | Could be hidden in downstream calls | No default file writes; DB access only if an explicit `dbCon` is provided |
| Parameters | `settings` | `settings, dbCon = NULL` |
| Output | Implicit downstream state | Structured `samples` object (legacy/compatibility use only) |
| MultiSettings behavior | Inherited from callers | Internally uses `settings[1]` as base settings |

Settings attributes extracted internally:
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
| Side effects | Wrote `samples.Rdata` by default | Returns `samples` list; writes artifacts only when `write = TRUE` |
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
- `write` (optional; when `TRUE` writes sample artifacts)

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
| Parameters | `settings, input_design` | `run, ensemble, sensitivity, samples, input_design, design_type` |
| Output | Normalized/generate designs | Single design object for the requested `design_type` |

Required settings attributes passed in by caller:
- `settings$run`
- `settings$ensemble`
- `settings$sensitivity.analysis`
- explicit `samples`

---

### `generate_input_design` (`base/workflow/R/runModule.run.write.configs.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Config orchestration | `runModule.run.write.configs` built designs internally | Design generation is separated and called before config writing |
| Parameters | N/A | `settings, input_design = NULL, samples = NULL, design_type = "ensemble" | "sensitivity"` |
| Output contract | N/A | `list(design = ..., samples = ...)` |
| Validation | N/A | Builds `samples` if missing; validates `Settings`/`MultiSettings` and `design_type` |
| MultiSettings behavior | Internal branching in writer | Uses `settings[1]` internally when sampling and generating the requested design |

Required inputs passed in by caller:
- `settings` (`Settings` or `MultiSettings`)
- `design_type` (`"ensemble"` or `"sensitivity"`)
- optional pre-built `samples` object
- optional `input_design` override (data.frame or normalized list)

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

- `.resolve_pft_outdirs(pfts, outdir, dbCon = NULL)`
  - Resolves PFT output directories from explicit PFT/outdir/db inputs.

- `get.distns(pfts, outdir, dbCon = NULL, host, posterior.files)`
  - Loads prior/posterior distribution objects for each PFT.

- `get.trait.mcmc(pfts, outdir, dbCon = NULL, host, outdirs)`
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
Caller
  -> dbCon <- NULL (optional)
  -> design_stage <- generate_input_design(
       settings,
       input_design = NULL,
       samples = NULL,
       design_type = "ensemble" | "sensitivity"
     )
  -> if both designs needed: repeat for each design_type
      -> (if samples missing) get.parameter.samples(..., write = FALSE)
      -> .prepare_input_designs(run, ensemble, sensitivity, samples, input_design, design_type)
          -> if design_type == "ensemble": generate_joint_ensemble_design(...)
          -> if design_type == "sensitivity": generate_OAT_SA_design(...)
      -> return list(design = ..., samples = ...)
  -> (optional) persist artifacts (e.g., trait.mcmc, distns, samples)
  -> runModule.run.write.configs(settings, input_design = design_stage$design, samples = design_stage$samples, dbCon = dbCon, write = TRUE)
      -> validate required input_design contract
      -> if MultiSettings: papply over sites with same shared design/samples
      -> if Settings: call run.write.configs for the requested design
          -> run.write.configs(settings, ..., input_design, samples)
              -> write configs + runs manifest
              -> return list(settings = updated_settings, runs_manifest = run_manifest_df)
      -> return list(settings = settings_final, samples = samples)
  -> if opened, db.close(dbCon)
```

## Deprecations

The following compatibility paths remain temporarily and emit deprecation warnings:

- Passing `settings` to `get.parameter.samples()`
- Calling `run.write.configs()` without `samples`

## Recommended Usage

```r
dbCon <- NULL
if (!is.null(settings$database$bety) && isTRUE(settings$database$bety$use)) {
  dbCon <- PEcAn.DB::db.open(settings$database$bety)
  on.exit(try(PEcAn.DB::db.close(dbCon), silent = TRUE), add = TRUE)
}

design_stage <- PEcAn.workflow::generate_input_design(
  settings = settings,
  input_design = NULL,
  samples = NULL,
  design_type = "ensemble"
)

config_stage <- PEcAn.workflow::runModule.run.write.configs(
  settings = settings,
  input_design = design_stage$design,
  samples = design_stage$samples,
  dbCon = dbCon,
  write = TRUE
)
settings <- config_stage$settings
samples <- config_stage$samples

# Optional: persist artifacts for inspection/reuse (explicit caller decision).
# saveRDS(samples, file.path(settings$outdir, "samples.rds"))
```

If both ensemble and sensitivity designs are needed, call `generate_input_design`
twice with different `design_type` values and run `runModule.run.write.configs`
for each design.

## Migration Notes

- `runModule.run.write.configs()` now requires a single pre-generated `input_design` plus explicit `samples`.
- New development should pass explicit objects and avoid relying on `samples.Rdata`.
