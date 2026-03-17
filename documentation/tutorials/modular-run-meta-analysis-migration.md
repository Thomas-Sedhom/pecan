---
title: "PEcAn Modular Meta-Analysis Workflow Migration"
---

## Overview

This document describes the migration of `runModule.run.meta.analysis` /
`run.meta.analysis` from hidden file-based and DB-coupled behavior to explicit
object passing and structured returns, while keeping a temporary
backward-compatible wrapper path only at `runModule.run.meta.analysis`.

## Old Flow

1. `runModule.run.meta.analysis(settings)` delegates to `run.meta.analysis(...)`.
2. `run.meta.analysis()` opens a BETY database connection internally.
3. `run.meta.analysis()` loops over PFTs and calls `run.meta.analysis.pft(...)`.
4. `run.meta.analysis.pft()` loads `trait.data.Rdata` and
   `prior.distns.Rdata` from each `pft$outdir`.
5. `run.meta.analysis.pft()` calls `meta_analysis_standalone(...)`.
6. `run.meta.analysis.pft()` saves:
   - `jagged.data.Rdata`
   - `trait.mcmc.Rdata`
   - `post.distns.MA.Rdata`
   - `post.distns.Rdata`
7. `run.meta.analysis.pft()` copies and registers newly-created files into DB
   storage using `dbfiles` and `dbcon`.
8. `meta_analysis_standalone()` itself does not load workflow `.Rdata` files,
   but still triggers lower-level artifact writing via `outdir`, including:
   - `meta-analysis.log`
   - `*.model.bug`
   - MA summary/posterior PDF artifacts

This creates hidden file dependencies, hidden DB lifecycle management, and
mixed compute / persistence responsibilities across the call chain.

## New Flow

1. Preferred path: caller prepares and passes required settings attributes and
   required objects explicitly:
   - required attrs: `pfts`, `iterations`, `random`, `threshold`, `use_ghs`,
     `update`, `dbfiles`
   - required objects: `trait_data_by_pft`, `prior_distns_by_pft`
2. `runModule.run.meta.analysis(settings, trait_data_by_pft = NULL, prior_distns_by_pft = NULL, dbcon = NULL, ...)`
   handles Settings/MultiSettings orchestration, extracts only the required
   settings attrs, and forwards explicit inputs.
3. `run.meta.analysis(pfts, iterations, trait_data_by_pft, prior_distns_by_pft, ..., dbcon = NULL)`
   orchestrates per-PFT execution without internal `load()` or internal
   `db.open()`.
4. `run.meta.analysis.pft(pft, trait_data, priors, ..., dbcon = NULL)` computes
   from explicit objects and optionally writes / registers outputs.
5. `meta_analysis_standalone(trait_data, priors, ...)` remains the core
   analysis function and returns in-memory results.
6. Lower-level artifact writing becomes optional, wrapper-controlled, or
   explicitly enabled.
7. Wrapper layers return structured results plus file / DB metadata rather than
   relying only on side effects.

## Function-by-Function Legacy vs New

### `runModule.run.meta.analysis` (`modules/meta.analysis/R/run.meta.analysis.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | `settings` only | `settings` + explicit object maps (`trait_data_by_pft`, `prior_distns_by_pft`) and optional `dbcon` |
| Settings usage | Passed through as workflow state | Used only for orchestration and extracting required attrs |
| Compatibility path | N/A | Missing objects trigger deprecated fallback loader with warning |
| MultiSettings behavior | Existing dedupe/orchestration | Existing dedupe/orchestration retained |
| Return | Mostly side effects | Structured return with results, files, and metadata |

Required extracted/passed attrs:
- `pfts`
- `meta.analysis$iter`
- `meta.analysis$random.effects$on`
- `meta.analysis$threshold`
- `meta.analysis$random.effects$use_ghs`
- `meta.analysis$update`
- `database$dbfiles`

Required objects:
- `trait_data_by_pft`
- `prior_distns_by_pft`

---

### `run.meta.analysis` (`modules/meta.analysis/R/run.meta.analysis.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | Positional args plus internal DB open/close | Explicit attrs + named object maps + optional `dbcon` |
| File dependencies | No direct `load()`, but depends on downstream implicit loads | No internal loading in primary path |
| DB behavior | Opens/closes DB internally | Accepts `dbcon` explicitly and does not open DB internally |
| Side effects | Indirect side effects through per-PFT wrapper | Structured per-PFT results plus optional file/DB metadata |
| Return | `lapply()` result computed but effectively ignored | Named result list by PFT |

Required public inputs:
- `pfts`
- `iterations`
- `trait_data_by_pft`
- `prior_distns_by_pft`
- `random`
- `threshold`
- `use_ghs`
- `update`
- `write_outputs`
- `register_outputs`
- `dbfiles`
- `dbcon`

---

### `run.meta.analysis.pft` (`modules/meta.analysis/R/run.meta.analysis.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `pft + dbfiles + dbcon` with internal file load | Explicit `pft + trait_data + priors` and optional write/register controls |
| File dependencies | Internal `load()` and output save | No internal load in primary path; wrapper-only optional writing |
| DB behavior | File copy + DB registration in same function body | Optional explicit registration path |
| Side effects | Always writes outputs | Returns results plus optional written paths |
| Return | `NA` or implicit side effects | Structured per-PFT payload |

Required public inputs:
- `pft`
- `trait_data`
- `priors`
- `iterations`
- `random`
- `threshold`
- `use_ghs`

Optional wrapper inputs:
- `write_outputs`
- `register_outputs`
- `dbfiles`
- `dbcon`

Expected return keys:
- `pft`
- `results`
- `files_written`
- `registered_files`
- `metadata`

---

### `meta_analysis_standalone` (`modules/meta.analysis/R/run.meta.analysis.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | Already explicit objects | Remains explicit core API |
| File dependencies | No workflow `load()` / `save()` in function body | Same, but lower-level artifact generation becomes optional |
| Side effects | Writes via `outdir` in lower layers | Optional artifact path only when enabled |
| Return | In-memory result list | Existing result list plus metadata/artifact fields |

Required public inputs:
- `trait_data`
- `priors`
- `iterations`
- `pft_name`
- `random`
- `threshold`
- `use_ghs`
- `gamma_tau`

Optional artifact controls:
- `write_artifacts`
- `artifact_dir`

Expected core return keys:
- `trait.mcmc`
- `post.distns`
- `jagged.data`
- `files_written`
- `metadata`


## `runModule.run.meta.analysis` Flow Diagrams

### Old Flow Diagram

```text
runModule.run.meta.analysis(settings)
  -> run.meta.analysis(...)
      -> db.open(settings$database$bety)
      -> run.meta.analysis.pft(pft, ...)
          -> load trait.data.Rdata
          -> load prior.distns.Rdata
          -> meta_analysis_standalone(...)
              -> lower-level core writes log / model / PDF artifacts via outdir
          -> save jagged.data.Rdata
          -> save trait.mcmc.Rdata
          -> save post.distns.MA.Rdata
          -> create/symlink post.distns.Rdata
          -> copy/register files in DB storage
      -> db.close(...)
```

### New Flow Diagram

```text
Caller
  -> prepare explicit inputs:
      -> attrs: pfts, iterations, random, threshold, use_ghs, update, dbfiles
      -> objects: trait_data_by_pft, prior_distns_by_pft
      -> optional: dbcon
  -> runModule.run.meta.analysis(settings, trait_data_by_pft, prior_distns_by_pft, dbcon, ...)
      -> if object maps missing: deprecated fallback loader from pft outdirs with warning
      -> extract attrs from settings
      -> run.meta.analysis(pfts, iterations, trait_data_by_pft, prior_distns_by_pft, ..., dbcon = dbcon)
          -> validate input maps
          -> run.meta.analysis.pft(pft, trait_data, priors, ..., dbcon = dbcon)
              -> meta_analysis_standalone(trait_data, priors, ...)
              -> optionally write workflow outputs
              -> optionally register outputs in DB storage
              -> return structured per-PFT payload
      -> return list(results_by_pft = ..., files_written_by_pft = ..., metadata = ...)
```

## Compatibility and Deprecation

Backward-compatible wrapper behavior is retained temporarily only in
`runModule.run.meta.analysis`.

- If `trait_data_by_pft` or `prior_distns_by_pft` are missing:
  - Use deprecated compatibility loading path from each `pft$outdir`.
  - Emit deprecation warning requiring the explicit-object API.
- If all required objects are passed:
  - Use strict modular path with no hidden loading in `run.meta.analysis()` or
    `run.meta.analysis.pft()`.

Planned deprecation stages:
1. Stage 1: fallback path enabled with warnings.
2. Stage 2: fallback removed; explicit inputs required.

## Testing Plan

### Existing coverage to refactor

Current meta-analysis coverage is concentrated in
`modules/meta.analysis/tests/testthat/test.run.meta.analysis.R` and broader
workflow usage. This migration needs direct unit tests for explicit-input
contracts and compatibility behavior.

### New tests to add

1. `modules/meta.analysis/tests/testthat/test-meta-analysis-standalone.R`
- `test_meta_analysis_standalone_returns_expected_structure()`
- `test_meta_analysis_standalone_no_persistent_artifact_writes_when_disabled()`
- `test_meta_analysis_standalone_artifact_path_enabled_when_requested()`

2. `modules/meta.analysis/tests/testthat/test-run-meta-analysis-pft.R`
- `test_run_meta_analysis_pft_requires_explicit_trait_data_and_priors()`
- `test_run_meta_analysis_pft_has_no_internal_load_in_primary_path()`
- `test_run_meta_analysis_pft_returns_results_and_optional_files_written()`
- `test_run_meta_analysis_pft_optional_db_registration_uses_passed_dbcon()`

3. `modules/meta.analysis/tests/testthat/test-run-meta-analysis.R`
- `test_run_meta_analysis_uses_explicit_maps_keyed_by_pft_name()`
- `test_run_meta_analysis_calls_per_pft_wrapper_once_per_pft()`
- `test_run_meta_analysis_has_no_internal_db_open_in_primary_path()`
- `test_run_meta_analysis_returns_named_per_pft_results()`

4. `modules/meta.analysis/tests/testthat/test-runmodule-meta-analysis.R`
- `test_runmodule_meta_analysis_uses_explicit_path_when_maps_passed()`
- `test_runmodule_meta_analysis_deprecated_fallback_when_maps_missing()`

### Acceptance criteria for tests

- No internal `load()` in primary `run.meta.analysis.pft()` path.
- No internal `db.open()` in primary `run.meta.analysis()` path.
- Wrapper-level output writing remains available and explicit.
- Downstream workflow compatibility is preserved by default file writing.

## Recommended Usage

```r
# Preferred explicit-object API
ma_stage <- runModule.run.meta.analysis(
  settings = settings,
  trait_data_by_pft = trait_data_by_pft,
  prior_distns_by_pft = prior_distns_by_pft,
  dbcon = dbcon
)

results_by_pft <- ma_stage$results_by_pft
files_written_by_pft <- ma_stage$files_written_by_pft
```
