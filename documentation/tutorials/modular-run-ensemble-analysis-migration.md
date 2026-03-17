---
title: "PEcAn Modular Ensemble Analysis Workflow Migration"
---

## Overview

This document describes the migration from implicit file-based state handoff in
ensemble analysis to explicit object passing.

## Old Flow

1. `runModule.run.ensemble.analysis(settings, ...)` delegated to `run.ensemble.analysis(settings, ...)`.
2. `run.ensemble.analysis()` resolved filenames through `ensemble.filename(settings, ...)`.
3. `run.ensemble.analysis()` loaded `ensemble.output.*.Rdata` from `settings$outdir`.
4. `run.ensemble.analysis()` generated and saved histogram/boxplot PDFs.
5. If `plot.timeseries` was requested, `run.ensemble.analysis()` called `read.ensemble.ts(settings, variable=...)`.
6. `read.ensemble.ts()` loaded ensemble sample metadata (`ensemble.samples.*.Rdata` or `samples.Rdata`) internally.
7. `read.ensemble.ts()` read model outputs from run directories and saved `ensemble.ts.*.Rdata` internally.
8. `run.ensemble.analysis()` ran `ensemble.ts(...)` and saved `ensemble.ts.analysis.*.Rdata` internally.

This created hidden dependencies between stages and reduced testability.

## New Flow

1. Preferred path: upstream code prepares and passes required settings attributes and required objects:
   - required settings attributes: `ensemble`, `run`, `outdir`, `modeloutdir`
   - required objects: `ensemble.output`
   - optional required objects for timeseries path: `ensemble.ts`, `ensemble.samples`
2. `runModule.run.ensemble.analysis(settings, ensemble.output, ensemble.ts = NULL, ensemble.samples = NULL, write = TRUE, ...)` handles Settings/MultiSettings orchestration and forwards explicit inputs.
3. `run.ensemble.analysis(ensemble, run, outdir, modeloutdir, ensemble.output, ensemble.ts = NULL, write = FALSE, ...)` performs core computation without internal `load()`.
4. Timeseries path uses explicit `ensemble.ts`; optional compatibility path can call a wrapper that constructs it.
5. Core computation returns structured outputs and file targets.
6. Wrapper level performs optional file writing when `write = TRUE` and returns written paths.
7. `ensemble.filename(outdir, ...)` generates paths without receiving full `settings`.
8. Backward-compatible wrapper path: if required objects are not passed, `runModule.run.ensemble.analysis` emits deprecation warnings and temporarily loads/builds them internally.

## Function-by-Function Legacy vs New

### `runModule.run.ensemble.analysis` (`modules/uncertainty/R/run.ensemble.analysis.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | Full `settings` + `...` | `settings` for orchestration + explicit required attrs/objects |
| Primary data path | Core loads `ensemble.output` internally | Caller provides `ensemble.output` |
| Timeseries path | Core calls internal loader (`read.ensemble.ts`) | Caller passes `ensemble.ts` (or compatibility wrapper builds it with warning) |
| Settings usage | Passed through to core | Used for dispatch and extraction only |
| MultiSettings behavior | `papply` over settings with implicit file coupling | `papply` over sites with per-site explicit inputs |
| Output | Mostly side effects | Structured return object + optional file path list |

Required extracted/passed inputs per site:
- `ensemble`
- `run`
- `outdir`
- `modeloutdir`
- `ensemble.output`
- optional `ensemble.ts`
- optional `ensemble.samples` (only if wrapper builds timeseries data)

---

### `run.ensemble.analysis` (`modules/uncertainty/R/run.ensemble.analysis.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `run.ensemble.analysis(settings, ...)` | `run.ensemble.analysis(ensemble, run, outdir, modeloutdir, ensemble.output, ensemble.ts = NULL, write = FALSE, ...)` |
| File dependencies | Internal `load()` for `ensemble.output.*.Rdata`; internal `save()` | No internal loads in primary path; return payload + file targets |
| Timeseries source | Calls `read.ensemble.ts(settings, ...)` | Uses explicit `ensemble.ts` object for primary path |
| Side effects | Saves PDFs and `ensemble.ts.analysis.*.Rdata` | Returns analysis payload; writes only when `write = TRUE` |
| Input minimization | Full settings object | Minimal required attrs + required objects |

Required public inputs:
- `ensemble`
- `run`
- `outdir`
- `modeloutdir`
- `ensemble.output`
- optional `ensemble.ts`

Derived internally (not required as public API inputs):
- `ensemble.id`
- `variable`, `start.year`, `end.year`
- output file targets via `ensemble.filename(outdir, ...)`

Expected core return keys:
- `ensemble_results_by_variable`
- `timeseries_results_by_variable`
- `plot_payload_by_variable`
- `file_targets`
- `metadata`

---

### `ensemble.filename` (`modules/uncertainty/R/get.analysis.filenames.r`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `ensemble.filename(settings, ...)` | `ensemble.filename(outdir, ...)` |
| Dependency style | Reads `settings$outdir` internally | Receives required values directly |
| Directory handling | Creates output directory | Same behavior retained |
| Output | Filename path | Filename path |

Required public inputs:
- `outdir`

Derived internally (or via defaults):
- `ensemble.id`
- `variable`
- `start.year`
- `end.year`
- `prefix`, `suffix`, `all.var.yr`

---

### `read.ensemble.ts` (`modules/uncertainty/R/run.ensemble.analysis.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `read.ensemble.ts(settings, ensemble.id, variable, ...)` | `read.ensemble.ts(ensemble, run, modeloutdir, outdir, ensemble.samples, ensemble.id, variable, write = FALSE, ...)` |
| File dependencies | Internal `load()` for ensemble samples; internal `save(ensemble.ts, ...)` | No internal loads in primary path; writes only when `write = TRUE` |
| Output contract | Returns `ensemble.ts` plus side-effect save | Returns `ensemble.ts` + file targets; wrapper writes if requested |
| Settings usage | Full settings object | Required attrs only |

Required public inputs:
- `ensemble`
- `run`
- `modeloutdir`
- `outdir`
- `ensemble.samples`
- `variable`

## Helper Functions (New/Internal)

Recommended internal helpers in `modules/uncertainty/R/run.ensemble.analysis.R`:

- `.resolve_ensemble_context(...)`
  - Resolves `ensemble.id`, variables, and year window defaults.
- `.normalize_ensemble_output(...)`
  - Validates and standardizes `ensemble.output` object shape.
- `.compute_ensemble_distribution(...)`
  - Computes histogram/boxplot payload for one variable.
- `.compute_ensemble_ts_analysis(...)`
  - Runs `ensemble.ts(...)` from explicit `ensemble.ts` input.
- `.build_ensemble_file_targets(...)`
  - Uses `ensemble.filename(outdir, ...)` to assemble all output paths.
- `.write_ensemble_outputs(...)` (wrapper-only)
  - Writes PDFs/Rdata and returns `files_written`.
- `.deprecated_load_ensemble_inputs_from_settings(...)` (wrapper-only)
  - Temporary compatibility loader for missing explicit objects.

## `runModule.run.ensemble.analysis` Flow Diagrams

### Old Flow Diagram

```text
runModule.run.ensemble.analysis(settings)
  -> run.ensemble.analysis(settings)
      -> ensemble.filename(settings, ...)
      -> load ensemble.output.*.Rdata
      -> compute distribution summaries
      -> save ensemble.analysis.*.pdf
      -> if plot.timeseries:
          -> read.ensemble.ts(settings, ...)
              -> ensemble.filename(settings, ...)
              -> load ensemble.samples.*.Rdata (or samples.Rdata)
              -> read model outputs from modeloutdir
              -> save ensemble.ts.*.Rdata
          -> ensemble.ts(...)
          -> ensemble.filename(settings, ...)
          -> save ensemble.ts.analysis.*.Rdata
```

### New Flow Diagram

```text
Caller
  -> prepare explicit inputs:
      -> required attrs: ensemble, run, outdir, modeloutdir
      -> required object: ensemble.output
      -> optional timeseries objects: ensemble.ts, ensemble.samples
  -> runModule.run.ensemble.analysis(settings, ensemble.output, ensemble.ts, ensemble.samples, write = TRUE, ...)
      -> if objects missing: deprecated fallback loader builds/loads them from settings
      -> extract/pass required attrs per site
      -> run.ensemble.analysis(ensemble, run, outdir, modeloutdir, ensemble.output, ensemble.ts, write = FALSE, ...)
          -> resolve context (ensemble.id/variable/years)
          -> compute ensemble distribution analysis
          -> optional timeseries analysis using explicit ensemble.ts
          -> ensemble.filename(outdir, ...) for output targets
          -> return structured results + metadata + target paths
      -> optionally write files (pdf/rdata) when `write = TRUE`
      -> return list(results=..., files_written=..., metadata=...)
```

## Compatibility and Deprecation

Backward-compatible wrappers are provided in `runModule.run.ensemble.analysis` to avoid breaking existing workflows immediately.

- If `ensemble.output` (or `ensemble.ts` when requested) is missing:
  - Use deprecated compatibility path to create/load them from `settings`.
  - Emit deprecation warning indicating explicit-object API is required going forward.
- If all required objects are passed:
  - Use strict modular path with no hidden loading in core functions.

Planned deprecation stages:
1. Stage 1: compatibility path enabled with warnings.
2. Stage 2: compatibility path disabled; explicit objects required.

## Testing Plan

### Existing coverage to refactor

Current ensemble workflow coverage in `modules/uncertainty/tests` focuses mostly on config-writing/sampling and has limited coverage for modular ensemble analysis contracts.

### New tests to add

1. `modules/uncertainty/tests/testthat/test-ensemble-filename.R`
- `test_ensemble_filename_uses_outdir_only_required_input()`
- `test_ensemble_filename_all_var_year_vs_specific_window()`
- `test_ensemble_filename_noensembleid_fallback()`

2. `modules/uncertainty/tests/testthat/test-run-ensemble-analysis.R`
- `test_run_ensemble_analysis_requires_explicit_ensemble_output()`
- `test_run_ensemble_analysis_minimal_inputs_compute_results()`
- `test_run_ensemble_analysis_returns_expected_structure()`
- `test_run_ensemble_analysis_has_no_internal_load_dependency()`

3. `modules/uncertainty/tests/testthat/test-runmodule-ensemble-analysis.R`
- `test_runmodule_uses_explicit_object_path_when_objects_passed()`
- `test_runmodule_deprecated_fallback_when_objects_missing()`
- `test_runmodule_emits_deprecation_warning_for_fallback()`
- `test_runmodule_multisettings_dispatch_per_site()`
- `test_runmodule_returns_results_and_files_written()`

4. `modules/uncertainty/tests/testthat/test-read-ensemble-ts.R`
- `test_read_ensemble_ts_requires_explicit_ensemble_samples()`
- `test_read_ensemble_ts_returns_timeseries_without_internal_save()`
- `test_read_ensemble_ts_handles_failed_runs_and_sparse_output()`

### Acceptance criteria for tests

- Explicit-object path does not depend on internal `load()` in core analysis functions.
- Missing required objects trigger deprecated compatibility path with warning.
- `runModule.run.ensemble.analysis` supports both paths during migration window.
- `ensemble.filename` receives `outdir` directly in primary path.
- Result object and file-target return contracts are asserted.

## Recommended Usage

```r
# Preferred explicit-object API
ens_stage <- runModule.run.ensemble.analysis(
  settings = settings,
  ensemble.output = ensemble.output,
  ensemble.ts = ensemble.ts
)

results <- ens_stage$results
files_written <- ens_stage$files_written
```

## Migration Notes

- `runModule.run.ensemble.analysis()` remains orchestration-focused.
- `run.ensemble.analysis()` must not load `ensemble.output` internally in the primary path.
- `read.ensemble.ts()` must not load/save internally in the primary path.
- `ensemble.filename()` should receive only `outdir` as required input.
- Compatibility wrapper is temporary and should be removed after deprecation window.
- This design matches the modular style used in `modular-run-sensitivity-analysis-migration.md`.
