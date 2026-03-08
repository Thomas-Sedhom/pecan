---
title: "PEcAn Modular Start Model Runs Workflow Migration"
---

## Overview

This document describes a refactor of the start model runs workflow to improve
modularity and reduce hidden dependencies.

## Old Flow

1. `runModule_start_model_runs(settings)` derived `write` from
   `settings$database$bety$write`.
2. `runModule_start_model_runs()` delegated directly to
   `start_model_runs(settings, write, ...)`.
3. `start_model_runs()` loaded `runs.txt` from `settings$rundir`.
4. `start_model_runs()` opened its own BETY DB connection when `write = TRUE`.
5. `start_model_runs()` mutated submission strings inside `settings$host`
   (`@NJOBS@` replacement).
6. `start_model_runs()` copied run/output directories to remote storage when
   `host` was not local.
7. `start_model_runs()` submitted runs through serial, qsub, rabbitmq, or
   modellauncher paths.
8. `start_model_runs()` polled job completion, copied logs/output back, stamped
   DB timestamps, and returned primarily through side effects.

This created hidden dependencies on:

- `settings$rundir`
- `settings$model$type`
- `settings$modeloutdir`
- `settings$host` and multiple nested host fields
- `settings$database$bety`
- `runs.txt`
- local/remote shell tools (`rsync`, `ssh`, `qsub`, `qstat`)
- environment variables in the rabbitmq path

## New Flow

1. Preferred path: caller prepares and passes required run inputs explicitly:
   - required settings-derived attrs: `rundir`, `modeloutdir`, `host`,
     `model_type`
   - required object: `runs`
   - optional explicit dependency: `dbCon`
2. `runModule_start_model_runs(settings, runs, dbCon = NULL, ...)` keeps
   `settings` as a required input for orchestration and Settings vs
   MultiSettings dispatch.
3. `start_model_runs(runs, rundir, modeloutdir, host, model_type, dbCon = NULL, ...)`
   performs launch orchestration without opening a DB connection or loading
   `runs.txt` in the primary path.
4. Modellauncher artifact creation is split so file-writing helpers return the
   written paths (`launcher.sh`, `joblist.txt`) instead of hiding them.
5. Wrapper level handles deprecated fallback behavior:
   - load `runs.txt` when `runs` is missing
   - open/close `dbCon` when `dbCon` is missing and legacy DB writing is enabled
6. Wrapper/core return structured execution metadata, including written/synced
   paths and submission records.
7. MultiSettings behavior is made explicit rather than relying on the current
   pass-through behavior.

## Function-by-Function Legacy vs New

### `runModule_start_model_runs` (`base/workflow/R/start_model_runs.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | Full `settings` only | Required `settings` for orchestration + explicit optional inputs |
| Hidden file input | Wrapper always relies on `runs.txt` indirectly | `runs` accepted explicitly; wrapper fallback loads file only when missing |
| DB connection | Derived/opened in downstream core | Accepts explicit `dbCon`; deprecated fallback opens/closes internally |
| Settings usage | Passed through wholesale | Used for compatibility extraction and MultiSettings dispatch only |
| MultiSettings behavior | Claims support but just forwards object unchanged | Explicit dispatch strategy (`papply` or equivalent) with per-site inputs |
| Output | Mostly side effects | Structured result object with execution metadata and file path lists |

Recommended public wrapper signature:

```r
runModule_start_model_runs <- function(
  settings,
  runs = NULL,
  dbCon = NULL,
  rundir = NULL,
  modeloutdir = NULL,
  host = NULL,
  model_type = NULL,
  stop.on.error = TRUE,
  write = NULL
)
```

Required extracted/passed inputs per site:

- `runs`
- `rundir`
- `modeloutdir`
- `host`
- `model_type`
- optional `dbCon`
- required `settings` for wrapper dispatch/compatibility

Compatibility-only wrapper extraction:

- `settings$database$bety`
- `settings$database$bety$write`

---

### `start_model_runs` (`base/workflow/R/start_model_runs.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `start_model_runs(settings, write = TRUE, ...)` | `start_model_runs(runs, rundir, modeloutdir, host, model_type = NULL, dbCon = NULL, ...)` |
| DB behavior | Opens/closes DB connection internally | Requires explicit `dbCon` for timestamp writing; no hidden DB open |
| File input | Reads `runs.txt` internally | Requires explicit `runs` in primary path |
| Settings dependency | Full settings object | Minimal extracted attrs only |
| Side effects | Submission, remote sync, DB stamping, progress bar, file writes | Same orchestration role, but with explicit inputs and structured return |
| Output | `NULL` / side effects | `list(results = ..., files_written = ..., files_synced = ..., metadata = ...)` |

Required public inputs:

- `runs`
- `rundir`
- `modeloutdir`
- `host`
- `model_type` (logging only; optional but recommended)
- `dbCon` (optional)

Derived internally:

- `is_local`
- submission mode (`serial`, `qsub`, `rabbitmq`, `modellauncher`)
- `Njobmax`
- normalized qsub/modellauncher strings

Expected core return keys:

- `files_written`
- `metadata`

---

### `setup_modellauncher` (`base/remote/R/setup_modellauncher.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Behavior | Deletes/recreates `joblist.txt`, writes `launcher.sh`, opens a writable connection | Split into build + write phases |
| Hidden file writes | Yes | Wrapper-only writer returns file paths and connection metadata |
| API | `setup_modellauncher(run, rundir, host_rundir, mpirun, binary)` | `.build_modellauncher_artifacts(...)` + `.write_modellauncher_artifacts(...)` |
| Return | Open file connection | Structured artifact object + written paths |

Recommended outputs from the new writer:

- `joblist_entries`

---

### `start_rabbitmq` (`base/remote/R/start_rabbitmq.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Hidden runtime input | Reads `RABBITMQ_PREFIX` and `RABBITMQ_PORT` from environment | Prefix/port passed explicitly  |
| API | `start_rabbitmq(folder, rabbitmq_uri, rabbitmq_queue)` | `start_rabbitmq(folder, rabbitmq_uri, rabbitmq_queue, prefix = "", port = 15672)` |
| Output | Submission response only | Same, but with explicit runtime config |

## Hidden Logic Audit

### Hidden inputs currently happening inside `start_model_runs`

- `runs.txt` is read internally from `settings$rundir`.
- `@NJOBS@` replacement mutates `settings$host$qsub` and
  `settings$host$modellauncher$qsub.extra`.
- `settings$modeloutdir` is required for remote copy/sync behavior.
- `settings$database$bety` is required only because core opens the DB itself.

### Hidden file reads/writes currently happening in this stage

- Reads `runs.txt`.
- Writes `launcher.sh`.
- Deletes/recreates `joblist.txt`.
- Reads `rabbitmq.out` when polling rabbitmq completion.
- Copies run directories to remote storage.
- Copies output directories back from remote storage during polling and at
  the end.

### Hidden runtime/environment dependencies in called helpers

- `start_rabbitmq()` reads `RABBITMQ_PREFIX` and `RABBITMQ_PORT`.
- `remote.copy.to()` and `remote.copy.from()` require `rsync` and may depend on
  tunnel/data host fields inside `host`.
- `remote.execute.cmd()` and remote submission paths require `ssh`.
- `start_qsub()` requires a valid `qsub` template and remote/local command
  availability.
- `start_serial()` depends on `job.sh` / `launcher.sh` already existing in run
  directories.

## Helper Functions (New/Internal)

Recommended internal helpers in `base/workflow/R/start_model_runs.R`:

- `.resolve_start_run_inputs(...)`
  - Normalizes explicit inputs and compatibility-derived values.
- `.normalize_submission_context(host, nruns)`
  - Returns normalized submission config without mutating the caller's host
    object.
- `.submit_run(...)`
  - Dispatches one run to serial/qsub/rabbitmq/modellauncher mode.
- `.poll_run_completion(...)`
  - Polls job status and returns completion events.
- `.deprecated_open_start_runs_dbcon(settings, write)`
  - Temporary wrapper-only fallback for legacy settings-driven DB behavior.

Recommended helper extraction in `base/remote/R/setup_modellauncher.R`:

- `.write_modellauncher_artifacts(artifacts)`
  - Writes launcher/joblist files and returns `files_written`.

## `runModule_start_model_runs` Flow Diagrams

### Old Flow Diagram

```text
runModule_start_model_runs(settings)
  -> derive write from settings$database$bety$write
  -> start_model_runs(settings, write, ...)
      -> read runs.txt
      -> open db connection
      -> mutate qsub/modellauncher strings in settings$host
      -> remote.copy.to(rundir)
      -> remote.copy.to(modeloutdir dirs only)
      -> submit runs (serial/qsub/rabbitmq/modellauncher)
      -> setup_modellauncher() writes launcher.sh + joblist.txt
      -> poll completion
      -> read rabbitmq.out when applicable
      -> stamp BETY timestamps
      -> remote.copy.from(logs/output)
```

### New Flow Diagram

```text
Caller
  -> prepare explicit inputs:
      -> runs
      -> rundir, modeloutdir, host
      -> model_type
      -> optional dbCon
  -> runModule_start_model_runs(settings, runs, dbCon, ...)
      -> if runs missing: deprecated fallback loads runs.txt
      -> if dbCon missing and write enabled: deprecated fallback opens dbCon
      -> if MultiSettings: dispatch per site explicitly
      -> start_model_runs(runs, rundir, modeloutdir, host, model_type, dbCon, ...)
          -> normalize submission context (no caller mutation)
          -> sync remote inputs if needed
          -> submit runs / prepare modellauncher artifacts
          -> poll completion
          -> sync remote outputs/logs
          -> return execution metadata + files_written + files_synced + db_events
      -> close deprecated fallback dbCon if wrapper opened it
      -> return list(results, files_written, files_synced, metadata)
```

## Compatibility and Deprecation

Backward-compatible wrappers should be provided in `runModule_start_model_runs`
to avoid breaking existing workflows immediately.

- If `runs` is missing:
  - Use deprecated compatibility path to load `runs.txt` from `settings$rundir`.
  - Emit a deprecation warning indicating that explicit `runs` will be required.
- If `dbCon` is missing and DB writing is enabled:
  - Use deprecated compatibility path to open/close a DB connection from
    `settings$database$bety`.
  - Emit a deprecation warning indicating that explicit `dbCon` will be
    required.
- If explicit inputs are provided:
  - Use strict modular path with no hidden file load and no hidden DB open.

Planned deprecation stages:

1. Stage 1: compatibility path enabled with warnings.
2. Stage 2: compatibility path disabled; explicit `runs` required.
3. Stage 3: explicit `dbCon` required for DB timestamp writes.

## Testing Plan

### Existing coverage to refactor

Current coverage is minimal in:

- `base/workflow/tests/testthat/test.start_model_runs.R`
  - Existing tests only cover missing/empty `runs.txt`.

### New tests to add

1. `base/workflow/tests/testthat/test-start-model-runs-core.R`
- `test_start_model_runs_requires_explicit_runs_in_strict_path()`
- `test_start_model_runs_does_not_open_db_internally_when_dbcon_provided()`
- `test_start_model_runs_returns_execution_metadata_and_written_paths()`

2. `base/workflow/tests/testthat/test-runModule-start-model-runs.R`
- `test_runmodule_start_model_runs_uses_explicit_inputs_when_passed()`
- `test_runmodule_start_model_runs_deprecated_runs_txt_fallback_warns()`
- `test_runmodule_start_model_runs_deprecated_db_open_fallback_warns()`
- `test_runmodule_start_model_runs_supports_multisettings_dispatch()`

## Recommended Usage

```r
dbCon <- PEcAn.DB::db.open(settings$database$bety)
on.exit(try(PEcAn.DB::db.close(dbCon), silent = TRUE), add = TRUE)

run_ids <- readLines(file.path(settings$rundir, "runs.txt"))

start_stage <- PEcAn.workflow::runModule_start_model_runs(
  settings = settings,
  runs = run_ids,
  dbCon = dbCon,
  rundir = settings$rundir,
  modeloutdir = settings$modeloutdir,
  host = settings$host,
  model_type = settings$model$type
)

files_written <- start_stage$files_written
files_synced <- start_stage$files_synced
```

## Migration Notes

- `runModule_start_model_runs()` should remain orchestration-focused.
- `start_model_runs()` should not open DB connections internally in the primary
  path.
- `start_model_runs()` should not read `runs.txt` internally in the primary
  path.
- The current stage has no hidden `.Rdata` load/save, but it does have hidden
  file reads/writes/transfers that should be surfaced.
- `settings$modeloutdir` must remain part of the required explicit input set.
- `start_rabbitmq()` should stop depending on hidden environment variables in
  the strict path.
- The modellauncher completion stamping logic should be fixed during the
  refactor, not carried forward.
