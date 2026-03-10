---
title: "PEcAn Modular get.trait.data Workflow Migration"
---

## Overview

This document describes the migration of `runModule.get.trait.data` /
`get.trait.data` from hidden DB/file behavior to explicit object passing and
structured returns.

The explicit inputs should be the in-memory objects represented by the saved
workflow files, not the file artifacts themselves. The modular API should
accept objects such as `pft_members`, `prior.distns`, and `trait.data`, while
`.Rdata` and `.csv` files remain wrapper-level persistence artifacts.

## Old Flow

1. `runModule.get.trait.data(settings)` extracts values from `settings` and
   calls `get.trait.data(...)`.
2. `get.trait.data()` opens a BETY database connection internally unless
   `input_file` / `pfts$file_path` is used.
3. `get.trait.data()` optionally reads flat trait/prior data from CSV via
   `input_file`.
4. `get.trait.data()` loops over PFTs and calls `get.trait.data.pft(...)`.
5. `get.trait.data.pft()` queries:
   - `query_pfts`
   - `query.pft_species` / `query.pft_cultivars`
   - `query.priors`
   - `query.traits`
6. `get.trait.data.pft()` also loads previous files during the reuse/update
   check:
   - `prior.distns.Rdata`
   - `trait.data.Rdata`
   - membership CSVs (`species.csv` / `cultivars.csv`)
7. If reuse is not possible, `get.trait.data.pft()` writes:
   - `species.csv` or `cultivars.csv`
   - `prior.distns.Rdata`
   - `prior.distns.csv`
   - `trait.data.Rdata`
   - `trait.data.csv`
8. `get.trait.data.pft()` may create a posterior DB record and register the
   written files in DB storage.

This mixes DB access, reuse checks, file loading, file writing, and per-PFT
workflow orchestration in the same chain.

## New Flow

1. Preferred path: caller prepares and passes required settings attributes and
   required objects explicitly:
   - required attrs: `pfts`, `modeltype`, `dbfiles`, `forceupdate`, `write`,
     `trait.names`
   - required objects: `trait_inputs_by_pft`
   - optional flat-file object: `trait_data_flat`
2. `runModule.get.trait.data(settings, trait_inputs_by_pft = NULL, trait_data_flat = NULL, dbcon = NULL, ...)`
   handles Settings/MultiSettings orchestration and owns the per-PFT workflow
   loop.
3. If explicit inputs are not passed, `runModule.get.trait.data(...)` calls
   `get.trait.data(...)` to prepare and return `trait_inputs_by_pft`.
4. `get.trait.data(...)` becomes the preparation step: it builds explicit
   per-PFT inputs and does not call `get.trait.data.pft()` in the primary
   modular path.
5. `runModule.get.trait.data(...)` then calls
   `get.trait.data.pft(pft, pft_members, prior.distns, trait.data, ...)` once
   per PFT.
6. Wrapper-level code optionally writes workflow files and optionally registers
   them in DB storage.
7. Temporary compatibility paths may still query DB or load legacy files when
   explicit objects are missing, but those paths emit deprecation warnings.

## Function-by-Function Legacy vs New

### `runModule.get.trait.data` (`base/workflow/R/runModule.get.trait.data.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | `settings` only | `settings` + explicit inputs (`trait_inputs_by_pft`, optional `trait_data_flat`, optional `dbcon`) |
| Settings usage | Full workflow container | Orchestration and attr extraction only |
| Workflow role | Delegates to `get.trait.data()` | Calls `get.trait.data()` to prepare inputs, then calls `get.trait.data.pft()` per PFT |
| Compatibility path | N/A | Missing objects trigger deprecated wrapper-side fallback |
| Return | Updated `settings` only | Updated `settings` plus structured results/files/metadata |

Required extracted inputs per site:
- `pfts`
- `model$type`
- `database$dbfiles`
- `meta.analysis$update`
- `database$bety$write`

Required objects:
- `trait_inputs_by_pft`
- optional `trait_data_flat`

---

### `get.trait.data` (`base/db/R/get.trait.data.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `get.trait.data(pfts, modeltype, dbfiles, database, forceupdate, ..., input_file = NULL)` | `get.trait.data(pfts, modeltype, trait.names, trait_data_flat = NULL, dbcon = NULL, ...)` |
| DB behavior | Opens/closes DB internally in the main path | Prepares inputs only; no per-PFT workflow calls in the primary path |
| Flat-file behavior | Reads CSV from `input_file` internally | Accepts `trait_data_flat` object explicitly |
| Side effects | Delegates to per-PFT save/register logic | No file writing in the primary path |
| Return | List of updated PFTs | `trait_inputs_by_pft` plus metadata |

Required public inputs:
- `pfts`
- `modeltype`
- `trait.names`
- optional `trait_data_flat`
- optional `dbcon`

Expected core return keys:
- `trait_inputs_by_pft`
- `metadata`

---

### `get.trait.data.pft` (`base/db/R/get.trait.data.pft.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Main API | `pft + modeltype + dbfiles + dbcon + trait.names` with internal DB queries and legacy file checks | Explicit `pft + pft_members + prior.distns + trait.data` and optional write/register controls |
| File dependencies | Reads/writes workflow files internally | No legacy file load in the primary path; optional writing only |
| DB behavior | Queries DB, creates posterior ID, copies/registers files | Primary path is object-driven; optional DB work is explicit |
| Side effects | Clears outdir, writes outputs, may register in DB | Returns structured per-PFT payload plus optional written paths |
| Return | Updated `pft` only | `pft`, results, files, registration metadata |

Required public inputs:
- `pft`
- `pft_members`
- `prior.distns`
- `trait.data`
- `forceupdate`

Optional wrapper inputs:
- `write_outputs`
- `register_outputs`
- `dbfiles`
- `posteriorid`
- `dbcon`

Expected return keys:
- `pft`
- `results`
- `files_written`
- `registered_files`
- `metadata`

---

### Query layer (`base/db/R/get.trait.data.pft.R`, `base/db/R/query.traits.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Query ownership | Queries mixed into `get.trait.data.pft()` | Query logic moved into the preparation step or compatibility wrapper |
| Reuse checks | Same function also loads old files and compares them | Compatibility path owns legacy reuse/load logic |
| Core dependency | Core needs DB connection object | Core receives explicit objects and does not require DB connection |

Required explicit query outputs per PFT:
- `pft_info`
- `pft_members`
- `prior.distns`
- `trait.data`
- optional compatibility-only `trait.data.check`

## `runModule.get.trait.data` Flow Diagrams

### Old Flow Diagram

```text
runModule.get.trait.data(settings)
  -> get.trait.data(pfts, modeltype, dbfiles, database, forceupdate, ...)
      -> db.open(database) OR read input_file CSV
      -> loop over pfts
          -> get.trait.data.pft(pft, ...)
              -> query_pfts
              -> query.pft_species / query.pft_cultivars
              -> query.priors
              -> query.traits(update.check.only = TRUE)
              -> load/read prior.distns.Rdata, trait.data.Rdata, membership CSV
              -> if reusing: copy old files into pft$outdir
              -> else query.traits(update.check.only = FALSE)
              -> create posterior record
              -> write prior/trait/member files
              -> optionally register files in DB storage
      -> db.close(...)
```

### New Flow Diagram

```text
Caller
  -> prepare explicit inputs:
      -> attrs: pfts, modeltype, dbfiles, forceupdate, write, trait.names
      -> objects: trait_inputs_by_pft
      -> optional: trait_data_flat, dbcon
  -> runModule.get.trait.data(settings, trait_inputs_by_pft, trait_data_flat, dbcon, ...)
      -> if explicit objects missing: deprecated wrapper-side fallback with warning
      -> extract attrs from settings
      -> get.trait.data(pfts, modeltype, trait.names, trait_data_flat, dbcon, ...)
          -> build or normalize trait_inputs_by_pft
          -> return trait_inputs_by_pft
      -> loop over pfts
          -> get.trait.data.pft(pft, pft_members, prior.distns, trait.data, ...)
              -> optionally write workflow files
              -> optionally register files in DB storage
              -> return per-PFT payload
      -> return updated settings plus structured results/files/metadata
```

## Compatibility and Deprecation

Backward-compatible behavior is retained temporarily during this migration.

- If `trait_inputs_by_pft` is missing:
  - wrapper code may call `get.trait.data()` to query DB or normalize
    `trait_data_flat`
  - wrapper emits a deprecation warning
- If only legacy DB/file parameters are supplied to `get.trait.data()`:
  - keep a temporary deprecated compatibility path because there are direct
    callers of `get.trait.data()` in the repository
- If all required explicit objects are passed:
  - use the strict modular path with no hidden file loading in
    `get.trait.data.pft()`

Planned deprecation stages:
1. Stage 1: fallback path enabled with warnings.
2. Stage 2: fallback removed; explicit inputs required.

## Testing Plan

### Existing coverage to refactor

Current get-trait coverage is mainly in:
- `base/db/tests/testthat/test-get.trait.data.pft.R`
- `base/db/tests/testthat/test-get.trait.data.R`
- `base/workflow/tests/testthat/test-runModule.get.trait.data.R`

These tests currently emphasize workflow side effects and need direct coverage
for the new boundaries.

### New tests to add

1. `base/db/tests/testthat/test-get.trait.data.R`
- `test_get_trait_data_returns_trait_inputs_by_pft()`
- `test_get_trait_data_does_not_call_get_trait_data_pft_in_primary_path()`

2. `base/db/tests/testthat/test-get.trait.data.pft.R`
- `test_get_trait_data_pft_requires_explicit_objects_in_primary_path()`
- `test_get_trait_data_pft_has_no_internal_legacy_file_load_in_primary_path()`

3. `base/workflow/tests/testthat/test-runModule.get.trait.data.R`
- `test_runmodule_get_trait_data_uses_explicit_path_when_objects_passed()`
- `test_runmodule_get_trait_data_deprecated_fallback_when_objects_missing()`
- `test_runmodule_get_trait_data_calls_get_trait_data_pft_per_pft()`

### Acceptance criteria for tests

- `get.trait.data()` does not call `get.trait.data.pft()` in the primary path.
- `get.trait.data.pft()` does not load legacy workflow files in the primary
  path.
- `runModule.get.trait.data()` owns the per-PFT loop.
- `trait_data_flat` replaces `input_file` in the primary modular API.
- Wrapper file writes and DB registration remain available and are returned
  explicitly.

## Recommended Usage

```r
# Preferred explicit-object API
trait_stage <- runModule.get.trait.data(
  settings = settings,
  trait_inputs_by_pft = trait_inputs_by_pft,
  dbcon = dbcon
)

updated_settings <- trait_stage$settings
results_by_pft <- trait_stage$results_by_pft
files_written_by_pft <- trait_stage$files_written_by_pft
```
