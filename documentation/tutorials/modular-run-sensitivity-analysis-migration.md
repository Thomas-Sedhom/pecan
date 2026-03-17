---
title: "PEcAn Modular Sensitivity Analysis Workflow Migration"
---

## Overview

This document describes the migration from implicit file-based state handoff in
sensitivity analysis to explicit object passing.

## Old Flow

1. `runModule.run.sensitivity.analysis(settings)` delegated to `run.sensitivity.analysis(settings, ...)`.
2. `run.sensitivity.analysis()` resolved filenames through `sensitivity.filename(settings, ...)`.
3. `run.sensitivity.analysis()` loaded `samples.Rdata` from `settings$outdir`.
4. `run.sensitivity.analysis()` optionally loaded `sensitivity.samples.*.Rdata` and overlaid sample metadata.
5. `run.sensitivity.analysis()` loaded `sensitivity.output.*.Rdata` for each variable/year window.
6. The same function computed sensitivity/variance decomposition and saved:
   - `sensitivity.results.*.Rdata`
   - optional PDF plots (`sensitivity.analysis.*.pdf`, `variance.decomposition.*.pdf`)

This created hidden dependencies between steps and reduced testability.

## New Flow

1. Preferred path: upstream code prepares and passes required settings attributes and required objects:
   - required settings attributes: `sensitivity`, `pfts`, `run`, `outdir`
   - required objects: `samples`, `sensitivity.samples`, `sensitivity.output`
2. `runModule.run.sensitivity.analysis(settings, samples, sensitivity.samples, sensitivity.output, write = TRUE, ...)` handles Settings/MultiSettings orchestration and forwards explicit inputs.
3. `run.sensitivity.analysis(sensitivity, pfts, run, outdir, samples, sensitivity.samples, sensitivity.output, write = FALSE, ...)` performs core computation without loading any files.
4. Core computation returns structured outputs (results + metadata).
5. Wrapper level performs optional file writing/plotting when `write = TRUE` and returns written paths.
6. `sensitivity.filename(outdir, pfts, ...)` generates sensitivity paths without receiving full `settings`.
7. Backward-compatible wrapper path: if required objects are not passed, `runModule.run.sensitivity.analysis` emits deprecation warnings and temporarily creates/loads them internally.

## Function-by-Function Legacy vs New

### `runModule.run.sensitivity.analysis` (`modules/uncertainty/R/run.sensitivity.analysis.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | Full `settings` + `...` | `settings` for orchestration + explicit required attributes/objects |
| Primary data path | Core loads internal files | Caller provides explicit objects (`samples`, `sensitivity.samples`, `sensitivity.output`) |
| Compatibility path | N/A | If objects missing, wrapper emits deprecation warning and builds/loads internally |
| Settings usage | Passed through to core | Used for dispatch and extraction only |
| MultiSettings behavior | `papply` over settings with implicit file coupling | `papply` over sites with per-site explicit inputs |
| Output | Mostly side effects | Structured return object + optional file path list |

Required extracted/passed inputs per site:
- `sensitivity`
- `pfts`
- `run`
- `outdir`
- `samples`
- `sensitivity.samples`
- `sensitivity.output`

---

### `run.sensitivity.analysis` (`modules/uncertainty/R/run.sensitivity.analysis.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `run.sensitivity.analysis(settings, ...)` | `run.sensitivity.analysis(sensitivity, pfts, run, outdir, samples, sensitivity.samples, sensitivity.output, write = FALSE, ...)` |
| File dependencies | Loads multiple `.Rdata` files internally with full settings | No internal loads in primary path; all required objects passed explicitly |
| Compatibility path | N/A | Optional deprecated wrapper may call this with internally created objects |
| Side effects | Saves `sensitivity.results` and plots | Returns results payload; writes only when `write = TRUE` |
| Input minimization | Full settings object | Minimal required settings attrs + required objects |

Required public inputs:
- `sensitivity`
- `pfts`
- `run`
- `outdir`
- `samples`
- `sensitivity.samples`
- `sensitivity.output`

Derived internally (not required as public API inputs):
- `variable`, `start.year`, `end.year`, `ensemble.id`
- output file targets via `sensitivity.filename(outdir, pfts, ...)`

Expected core return keys:
- `sensitivity_results_by_variable`
- `plot_payload_by_variable`
- `metadata`

---

### `sensitivity.filename` (`modules/uncertainty/R/get.analysis.filenames.r`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `sensitivity.filename(settings, ...)` | `sensitivity.filename(outdir, pfts, ...)` |
| Dependency style | Reads `settings$outdir` and `settings$pfts` internally | Receives required values directly |
| Directory handling | Creates output directory | Same behavior retained |
| Output | Filename path | Filename path |

Required public inputs:
- `outdir`
- `pfts`

Derived internally (or via defaults):
- `ensemble.id`
- `variable`
- `start.year`
- `end.year`
- `prefix`, `suffix`, `all.var.yr`, `pft`

## Helper Functions (New/Internal)

Recommended internal helpers in `modules/uncertainty/R/run.sensitivity.analysis.R`:

- `.resolve_sa_context(...)`
  - Resolves variable/year/ensemble defaults from required inputs.
- `.merge_sa_samples(...)`
  - Normalizes legacy compatibility fields (`pft.names`, `trait.names`, `sa.run.ids`).
- `.compute_sa_for_variable(...)`
  - Computes all PFT results for one variable.
- `.compute_sa_for_pft(...)`
  - Computes one PFT result via `sensitivity.analysis(...)`.
- `.build_sa_file_targets(...)`
  - Uses `sensitivity.filename(outdir, pfts, ...)` to create all required output paths.
- `.write_sa_outputs(...)` (wrapper-only)
  - Saves results/plots and returns `files_written`.
- `.deprecated_load_sa_inputs_from_settings(...)` (wrapper-only)
  - Temporary compatibility loader used when explicit objects are missing.

## `runModule.run.sensitivity.analysis` Flow Diagrams

### Old Flow Diagram

```text
runModule.run.sensitivity.analysis(settings)
  -> run.sensitivity.analysis(settings)
      -> sensitivity.filename(settings, ...)
      -> load samples.Rdata
      -> sensitivity.filename(settings, ...)
      -> load sensitivity.samples.*.Rdata (optional)
      -> sensitivity.filename(settings, ...)
      -> load sensitivity.output.*.Rdata
      -> compute sensitivity/VD
      -> sensitivity.filename(settings, ...)
      -> save sensitivity.results.*.Rdata
      -> optionally save PDFs via sensitivity.filename(settings, ...)
```

### New Flow Diagram

```text
Caller
  -> prepare explicit inputs:
      -> required attrs: sensitivity, pfts, run, outdir
      -> required objects: samples, sensitivity.samples, sensitivity.output
  -> runModule.run.sensitivity.analysis(settings, samples, sensitivity.samples, sensitivity.output, write = TRUE, ...)
      -> if objects missing: deprecated fallback loader builds them from settings
      -> extract/pass required attrs per site
      -> run.sensitivity.analysis(sensitivity, pfts, run, outdir, samples, sensitivity.samples, sensitivity.output, write = FALSE, ...)
          -> resolve context (variable/year/ensemble)
          -> compute sensitivity/VD (no internal load in core)
          -> sensitivity.filename(outdir, pfts, ...) for output targets
          -> return structured results + metadata + target paths
      -> optionally write files (results + plots) when `write = TRUE`
      -> return list(results=..., files_written=..., metadata=...)
```

## Compatibility and Deprecation

Backward-compatible wrappers are provided in `runModule.run.sensitivity.analysis` to avoid breaking existing workflows immediately.

- If `samples`, `sensitivity.samples`, or `sensitivity.output` are missing:
  - Use deprecated compatibility path to create/load them from `settings`.
  - Emit deprecation warning indicating explicit-object API is required going forward.
- If all required objects are passed:
  - Use strict modular path with no hidden loading.

Planned deprecation stages:
1. Stage 1: compatibility path enabled with warnings.
2. Stage 2: compatibility path disabled; explicit objects required.

## Testing Plan

### Existing coverage to refactor

Current sensitivity workflow coverage is mainly in:
- `tests/interactive-workflow.R`
  - Existing `run.sensitivity.analysis(settings)` call should move to explicit-object path.
  - Add temporary coverage that deprecated wrapper path still works.

### New tests to add

1. `tests/testthat/test-sensitivity-filename.R`
- `test_sensitivity_filename_uses_outdir_and_pfts_only()`
- `test_sensitivity_filename_handles_pft_null_and_per_pft_paths()`
- `test_sensitivity_filename_unmatched_pft_fallback_path()`

2. `tests/testthat/test-run-sensitivity-analysis.R`
- `test_run_sensitivity_analysis_requires_explicit_objects()`
- `test_run_sensitivity_analysis_minimal_inputs_compute_results()`
- `test_run_sensitivity_analysis_returns_expected_structure()`
- `test_run_sensitivity_analysis_has_no_internal_load_dependency()`

3. `tests/testthat/test-runmodule-sensitivity-analysis.R`
- `test_runmodule_uses_explicit_object_path_when_all_objects_passed()`
- `test_runmodule_deprecated_fallback_when_objects_missing()`
- `test_runmodule_emits_deprecation_warning_for_fallback()`
- `test_runmodule_multisettings_dispatch_per_site()`
- `test_runmodule_returns_results_and_files_written()`

### Acceptance criteria for tests

- Explicit-object path does not depend on internal `load()` in core function.
- Missing objects trigger deprecated compatibility path with warning.
- `runModule.run.sensitivity.analysis` supports both paths during migration window.
- `interactive-workflow` sensitivity path is updated to explicit-object API.
- Result object and file-target return contracts are asserted.

## Recommended Usage

```r
# Preferred explicit-object API
sa_stage <- runModule.run.sensitivity.analysis(
  settings = settings,
  samples = samples,
  sensitivity.samples = sensitivity.samples,
  sensitivity.output = sensitivity.output
)

results <- sa_stage$results
files_written <- sa_stage$files_written
```

## Migration Notes

- `runModule.run.sensitivity.analysis()` remains orchestration-focused.
- `run.sensitivity.analysis()` must not load `samples`, `sensitivity.samples`, or `sensitivity.output` internally in the primary path.
- `sensitivity.filename()` should receive only `outdir` and `pfts` as required inputs.
- Compatibility wrapper is temporary and should be removed after deprecation window.
- This design matches the modular style used in `modular-run-write-configs-migration.md`.
