---
title: "PEcAn Modular get.results Workflow Migration"
---

## Overview

This document describes the migration of `runModule.get.results` / `get.results`
from implicit file-based state handoff to explicit object passing, while keeping
a temporary backward-compatible wrapper path.

## Scope and Dependency Graph

Target chain for this migration:

```text
runModule.get.results
  -> get.results
      -> sensitivity.filename
      -> read.sa.output
```

Notes:
- `sensitivity.filename` refactor is already defined in
  `modular-run-sensitivity-analysis-migration.md`.
- This migration reuses that contract and does not introduce new
  `sensitivity.filename` feature changes.

## Old Flow

1. `runModule.get.results(settings)` calls `get.results(settings)`.
2. `get.results()` uses full `settings` object directly for all logic.
3. `get.results()` loads sensitivity samples internally from
   `sensitivity.samples.*.Rdata` (or `samples.Rdata`).
4. `get.results()` calls `read.sa.output(...)`.
5. `read.sa.output()` loads `runs_manifest.csv` internally from disk.
6. `get.results()` saves `sensitivity.output.*.Rdata` internally.
7. `get.results()` also runs ensemble output loading/saving in the same large function.

This creates hidden dependencies, large function scope, and lower testability.

## New Flow

1. Preferred path: caller prepares and passes required settings attributes and required objects:
   - required settings attributes: `ensemble`, `modeloutdir`, `sensitivity`, `outdir`, `pfts`
   - required objects: `sensitivity.samples`, `ensemble.samples`, `manifest`
2. `runModule.get.results(settings, sensitivity.samples = NULL, ensemble.samples = NULL, manifest = NULL, ...)`
   orchestrates Settings/MultiSettings and forwards explicit inputs.
3. `get.results(ensemble, modeloutdir, sensitivity, outdir, pfts, sensitivity.samples, ensemble.samples, manifest, ...)`
   performs core sensitivity-output computation without internal `load()` / `read.csv()`.
4. `read.sa.output(..., manifest, ...)` uses provided manifest object; no internal file read.
5. Core path returns `sensitivity.output` (and optional metadata/file-targets payload).
6. Wrapper-only compatibility path may load missing objects from disk temporarily and emits deprecation warnings.
7. If wrapper writes files, it returns written paths explicitly.

## Function-by-Function Legacy vs New

### `runModule.get.results` (`modules/uncertainty/R/get.results.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | `settings` only | `settings` + explicit objects (`sensitivity.samples`, `ensemble.samples`, `manifest`) |
| Settings usage | Passed wholesale to core | Used for orchestration and extracting required attrs only |
| MultiSettings behavior | `papply` with implicit file coupling | `papply` with per-site explicit objects |
| Compatibility path | N/A | Missing objects trigger deprecated internal loaders with warning |
| Return | Implicit side effects | Structured return including `sensitivity.output`; wrapper also returns `files_written` if writing |

Required extracted/passed attrs per site:
- `ensemble`
- `modeloutdir`
- `sensitivity`
- `outdir`
- `pfts`

Required objects per site:
- `sensitivity.samples`
- `ensemble.samples`
- `manifest`

---

### `get.results` (`modules/uncertainty/R/get.results.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `get.results(settings, ...)` | `get.results(ensemble, modeloutdir, sensitivity, outdir, pfts, sensitivity.samples, ensemble.samples, manifest, ...)` |
| File dependencies | Internal `load()` and implicit object reconstruction | No internal loading in primary path |
| Manifest dependency | Delegated to `read.sa.output()` internal disk read | Manifest passed explicitly to lower layer |
| Side effects | Saves `sensitivity.output.*.Rdata` internally | Core returns `sensitivity.output`; writing handled by wrapper helper |
| Function size | Mixed sensitivity + ensemble + IO logic | Split into focused helpers (context resolution, compute, optional write) |

Required public inputs:
- `ensemble`
- `modeloutdir`
- `sensitivity`
- `outdir`
- `pfts`
- `sensitivity.samples`
- `ensemble.samples`
- `manifest`

Primary core return:
- `sensitivity.output`

Optional wrapper return keys:
- `sensitivity.output`
- `files_written`
- `metadata`

---

### `read.sa.output` (`modules/uncertainty/R/sensitivity.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `read.sa.output(..., pecandir, ..., sa.run.ids = NULL, ...)` | `read.sa.output(..., manifest, outdir, ..., per.pft = FALSE)` |
| Manifest source | Reads `runs_manifest.csv` internally | Uses provided `manifest` object |
| IO behavior | Performs internal file read | No internal manifest load in primary path |
| Run lookup | Derived from disk manifest | Derived from passed manifest rows |

Required public inputs:
- `traits`
- `quantiles`
- `manifest`
- `outdir`
- `pft.name`
- `start.year`
- `end.year`
- `variable`
- `per.pft`

## `sensitivity.filename` Status

No new refactor scope is introduced here.

Use the previously-defined modular contract from:
- `documentation/tutorials/modular-run-sensitivity-analysis-migration.md`

That means:
- pass only required inputs (not full settings object)
- reuse existing migration decisions and tests

## Helper Functions (New/Internal)

Recommended internal helpers in `modules/uncertainty/R/get.results.R`:

- `.extract_get_results_inputs(settings)`
  - Extracts `ensemble`, `modeloutdir`, `sensitivity`, `outdir`, `pfts`.
- `.resolve_get_results_context(sensitivity, ensemble, variable, start.year, end.year, sa.ensemble.id, ens.ensemble.id)`
  - Resolves variable/year/ensemble defaults deterministically.
- `.normalize_legacy_samples_payload(sensitivity.samples, ensemble.samples)`
  - Fills compatibility fields (`pft.names`, `trait.names`, `sa.run.ids`, `ens.run.ids`) when missing.
- `.compute_sensitivity_output_for_variable(...)`
  - Runs per-variable/per-PFT read pipeline using explicit inputs.
- `.write_sensitivity_output(...)` (wrapper-only)
  - Saves output and returns `files_written`.
- `.deprecated_load_get_results_inputs_from_settings(settings, ...)` (wrapper-only)
  - Temporary fallback loader for missing explicit objects/manifest.

## `runModule.get.results` Flow Diagrams

### Old Flow Diagram

```text
runModule.get.results(settings)
  -> get.results(settings)
      -> sensitivity.filename(settings, ...)
      -> load sensitivity.samples.*.Rdata OR samples.Rdata
      -> read.sa.output(...)
          -> load runs_manifest.csv internally
      -> sensitivity.filename(settings, ...)
      -> save sensitivity.output.*.Rdata
```

### New Flow Diagram

```text
Caller
  -> prepare explicit inputs:
      -> attrs: ensemble, modeloutdir, sensitivity, outdir, pfts
      -> objects: sensitivity.samples, ensemble.samples, manifest
  -> runModule.get.results(settings, sensitivity.samples, ensemble.samples, manifest, ...)
      -> if missing objects: deprecated fallback loader from settings/files with warning
      -> extract attrs per site
      -> get.results(ensemble, modeloutdir, sensitivity, outdir, pfts, sensitivity.samples, ensemble.samples, manifest, ...)
          -> resolve context
          -> read.sa.output(..., manifest = manifest, ...)
          -> return sensitivity.output (no internal load/save)
      -> optionally write files in wrapper
      -> return list(sensitivity.output=..., files_written=..., metadata=...)
```

## Compatibility and Deprecation

Backward-compatible wrapper behavior is retained temporarily in `runModule.get.results`.

- If `sensitivity.samples`, `ensemble.samples`, or `manifest` are missing:
  - Use deprecated compatibility loading path from `settings$outdir`.
  - Emit deprecation warning requiring explicit-object API.
- If all required objects are passed:
  - Use strict modular path with no hidden loading in core functions.

Planned deprecation stages:
1. Stage 1: fallback path enabled with warnings.
2. Stage 2: fallback removed; explicit inputs required.

## Testing Plan

### Existing coverage to refactor

Current `get.results` behavior is mostly exercised through workflow/integration paths.
This migration needs direct unit tests for explicit-input contracts.

### New tests to add

1. `modules/uncertainty/tests/testthat/test-get-results.R`
- `test_get_results_requires_explicit_required_attrs_and_objects()`
- `test_get_results_returns_sensitivity_output()`
- `test_get_results_has_no_internal_file_load_in_primary_path()`
- `test_get_results_resolves_variable_and_year_precedence()`

2. `modules/uncertainty/tests/testthat/test-runmodule-get-results.R`
- `test_runmodule_get_results_uses_explicit_path_when_objects_passed()`
- `test_runmodule_get_results_deprecated_fallback_when_objects_missing()`
- `test_runmodule_get_results_emits_deprecation_warning_for_fallback()`
- `test_runmodule_get_results_multisettings_dispatch_per_site()`
- `test_runmodule_get_results_returns_sensitivity_output_and_files_written()`

3. `modules/uncertainty/tests/testthat/test-read-sa-output.R`
- `test_read_sa_output_uses_passed_manifest_object()`
- `test_read_sa_output_no_internal_manifest_file_dependency()`
- `test_read_sa_output_manifest_duplicate_and_missing_run_handling()`

### Acceptance criteria for tests

- Primary `get.results` path performs no internal `load()` or manifest file read.
- `read.sa.output` relies on provided `manifest` object.
- `runModule.get.results` supports explicit path plus temporary fallback warning path.
- Core return includes `sensitivity.output`.
- Wrapper file writes (if enabled) are returned as explicit paths.

## Recommended Usage

```r
# Preferred explicit-object API
res <- runModule.get.results(
  settings = settings,
  sensitivity.samples = sensitivity.samples,
  ensemble.samples = ensemble.samples,
  manifest = manifest
)

sensitivity.output <- res$sensitivity.output
files_written <- res$files_written
```

## Migration Notes

- `runModule.get.results()` stays orchestration-focused.
- `get.results()` should not load files in primary modular path.
- `read.sa.output()` should not load manifest internally in primary path.
- `sensitivity.filename()` changes are reused from existing modular SA migration doc.
- No DB connection logic is introduced in this chain; maintain explicit data-only inputs.
- Compatibility fallback is temporary and should be removed after deprecation window.
