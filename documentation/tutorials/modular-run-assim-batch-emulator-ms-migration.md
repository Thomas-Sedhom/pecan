---
title: "PEcAn Modular Assim.Batch Emulator-MS Workflow Migration"
---

## Overview

This document describes the migration from implicit side-effect orchestration in
`runModule.assim.batch -> pda.emulator.ms` to explicit phase-based object
passing with clear I/O boundaries.

## Old Flow

1. `runModule.assim.batch(settings)` dispatches based on `Settings` vs `MultiSettings`.
2. For MultiSettings with `assim.batch$method == "emulator.ms"`, it directly calls `pda.emulator.ms(settings)`.
3. `pda.emulator.ms()` derives `pda.mode` and toggles boolean branches for `individual`, `joint`, `hierarchical`.
4. The same function performs orchestration and core compute together:
   - opens/closes tunnel internally
   - creates DB connection internally
   - prepares and syncs remote jobs internally
   - loads history and emulator/SS objects from files internally
   - saves restart history/checkpoints internally.
5. Joint and hierarchical paths are large monolithic blocks with shared mutable state.
6. Return contract is implicit/inconsistent for MultiSettings stage outputs.

This created hidden dependencies, made testing difficult, and coupled orchestration
with compute and persistence.

## New Flow

1. Preferred path: caller provides explicit optional inputs:
   - `objects` (history payloads, preloaded GP/SS, shared multi-site objects)
   - `connections` (DB connection)
   - `io` (remote/tunnel/read/write handlers)
2. `runModule.assim.batch(...)` remains orchestration entrypoint and dispatches method-specific wrappers.
3. `pda.emulator.ms(...)` resolves mode and executes phase functions:
   - `.pda_ms_run_individual(...)`
   - `.pda_ms_run_joint(...)`
   - `.pda_ms_run_hierarchical(...)`
4. Phase functions perform core computation from explicit inputs and return structured outputs.
5. Wrapper-level I/O writes checkpoint/history/artifact files and records `files_written`.
6. Default return remains `multi.settings` for compatibility, with attached artifacts.
7. Optional stage return (`return_stage = TRUE`) provides full structured payload.

## Function-by-Function Legacy vs New

### `runModule.assim.batch` (`modules/assim.batch/R/pda.utils.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | `runModule.assim.batch(settings)` | `runModule.assim.batch(settings, objects, connections, io, return_stage, ...)` |
| MultiSettings dispatch | Direct `pda.emulator.ms(settings)` | Dispatch with explicit injectable dependencies |
| Compatibility | Implicit side effects | Compatibility wrapper with deprecation warnings for missing objects |
| Return | `settings` only | `settings` + artifacts attribute (or stage list when requested) |

Required extracted/passed inputs:
- `settings$assim.batch$method`
- per-site `assim.batch` and `host` metadata
- optional `objects`, `connections`, `io`

---

### `pda.emulator.ms` (`modules/assim.batch/R/pda.emulator.ms.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Mode logic | Inline booleans in one large function | Dedicated mode resolver + explicit phase list |
| Core structure | Monolithic mixed orchestration/compute | 3 phase functions with shared state object |
| File dependencies | Internal `load()` for history/emulator/SS | Required objects injected in strict path |
| DB handling | Internal open/close | Connection passed in from wrapper |
| Tunnel/remote | Internal open/execute/sync/close | I/O boundary via wrapper/io callbacks |
| Saved outputs | Internal `save(...)` side effects | Return payload + output targets; wrapper writes |

Primary shared state (`ms_state`) keys:
- `multi.settings`
- `mode`, `phases`, `nsites`
- `shared` (history objects, stacks, IDs, priors/formats)
- `resources` (DB/tunnel handles)
- `artifacts` (`files_written`, `remote_jobs`, `warnings`, metadata)

---

### New Internal Phase Functions (`modules/assim.batch/R/pda.emulator.ms.R`)

| Function | Responsibility | Inputs | Returns |
|---|---|---|---|
| `.pda_ms_run_individual` | Per-site emulator rounds and remote orchestration payload assembly | `ms_state`, precomputed multi-site objects, io hooks | updated `ms_state`, remote artifacts, updated per-site settings |
| `.pda_ms_run_joint` | Joint MCMC calibration and postprocess payload | `tmp.settings`, `need_obj`, `gp_stack`, `db_con`, `workflow.id`, checkpoint target | updated `tmp.settings`, `mcmc.out`, `resume.list`, checkpoint payload/target |
| `.pda_ms_run_hierarchical` | Hierarchical MCMC + hierarchical postprocess payload | `tmp.settings`, `need_obj`, `gp_stack`, `ss_stack`, `db_con`, `workflow.id`, checkpoint target | updated `tmp.settings`, hierarchical outputs, checkpoint payload/target |

## Helper Functions (New/Internal)

Recommended internal helpers in `modules/assim.batch/R/pda.emulator.ms.R`:

- `.pda_ms_resolve_mode(...)`
  - Validates mode and returns normalized phase sequence.
- `.pda_ms_init_state(...)`
  - Builds canonical `ms_state`.
- `.pda_ms_validate_inputs(...)`
  - Ensures required attributes/objects exist.
- `.pda_ms_prepare_shared_objects(...)`
  - Compatibility loader for missing explicit objects (with deprecation warning).
- `.pda_ms_attach_artifacts(...)`
  - Normalizes and attaches artifact metadata to return object.
- `.pda_ms_write_outputs(...)` (wrapper-only)
  - Writes checkpoints/history and records `files_written`.
- `.pda_ms_remote_lifecycle(...)` (wrapper-only)
  - Encapsulates tunnel open/close and remote sync calls.

## `runModule.assim.batch -> pda.emulator.ms` Flow Diagrams

### Old Flow Diagram

```text
runModule.assim.batch(settings)
  -> detect MultiSettings + method emulator.ms
  -> pda.emulator.ms(multi.settings)
      -> mode booleans inline
      -> open_tunnel()
      -> return_multi_site_objects()
      -> prepare_pda_remote() + submit jobs
      -> sync_pda_remote()
      -> kill.tunnel()
      -> load_pda_history(...)
      -> load emulator/SS files from each site
      -> open DB connection
      -> joint block (compute + save checkpoints)
      -> hierarchical block (compute + save checkpoints)
      -> implicit/partial return
```

### New Flow Diagram

```text
Caller
  -> optional explicit dependencies: objects, connections, io
  -> runModule.assim.batch(settings, objects, connections, io, ...)
      -> dispatch emulator.ms path
      -> pda.emulator.ms(multi.settings, objects, connections, io, ...)
          -> resolve mode to phase list
          -> init ms_state
          -> run selected phases in order:
              -> individual
              -> joint
              -> hierarchical
          -> each phase returns compute outputs + artifact targets
          -> wrapper writes optional outputs via io
          -> return updated multi.settings (+ artifacts)
```

## Compatibility and Deprecation

Backward-compatible wrappers are retained initially.

- If required explicit objects are missing:
  - use deprecated compatibility loader path
  - emit deprecation warning.
- If all explicit objects are provided:
  - use strict modular path with no hidden loading in phase compute functions.

Planned stages:
1. Stage 1: compatibility path enabled with warnings.
2. Stage 2: strict explicit-object path required.

## Testing Plan

### Existing coverage to improve

Current `assim.batch` tests are sparse for `emulator.ms` orchestration and modular contracts.

### New tests to add

1. `modules/assim.batch/tests/testthat/test-runmodule-assim-batch-ms.R`
- `test_runmodule_assim_batch_dispatches_emulator_ms()`
- `test_runmodule_assim_batch_multisettings_legacy_fallback_warning()`
- `test_runmodule_assim_batch_returns_multisettings_with_artifacts()`

2. `modules/assim.batch/tests/testthat/test-pda-emulator-ms-mode.R`
- `test_pda_ms_mode_individual_only()`
- `test_pda_ms_mode_joint_only()`
- `test_pda_ms_mode_hierarchical_only()`
- `test_pda_ms_unknown_mode_runs_all_with_warning()`

3. `modules/assim.batch/tests/testthat/test-pda-emulator-ms-contracts.R`
- `test_joint_phase_requires_explicit_inputs_in_strict_path()`
- `test_joint_phase_returns_checkpoint_payload_and_target()`
- `test_hierarchical_phase_returns_structured_outputs()`
- `test_no_internal_load_in_strict_phase_compute_path()`

4. `modules/assim.batch/tests/testthat/test-pda-emulator-ms-io-boundary.R`
- `test_tunnel_lifecycle_closes_on_error()`
- `test_remote_sync_called_only_from_wrapper_io_layer()`
- `test_db_connection_injected_and_not_opened_in_core_phase()`

### Acceptance criteria for tests

- Mode dispatch is deterministic and tested for all modes.
- Unknown mode fallback warns and executes all three phases.
- Joint/hierarchical phase contracts are explicit and asserted.
- Wrapper preserves backward-compatible return while exposing artifacts.
- Strict path removes hidden file loads from phase compute code.
- Tunnel and remote lifecycle are isolated from core compute functions.

## Recommended Usage

```r
# preferred modular call
ms_stage <- PEcAn.assim.batch::runModule.assim.batch(
  settings = multi.settings,
  objects = explicit_objects,
  connections = list(db_con = con),
  io = io_handlers,
  return_stage = TRUE
)

updated_settings <- ms_stage$settings
files_written <- ms_stage$artifacts$files_written
```

## Migration Notes

- `runModule.assim.batch()` remains the orchestration entrypoint.
- `pda.emulator.ms()` becomes phase-oriented and contract-driven.
- `mcmc.out` is produced by joint phase and returned, not required as input.
- Checkpoint behavior is represented as payload + target; writing is wrapper-level.
- Initial bug fixes included in migration scope:
  - `hierarchical` mode typo correction
  - undefined `settings` use in tunnel close path
  - explicit return contract from `pda.emulator.ms`.
