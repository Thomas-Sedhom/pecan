---
title: "PEcAn Modular Input Conversion Workflow Migration"
---

## Overview

This document describes the migration of `do_conversions` and its internal
conversion functions from hidden DB opens and implicit settings dependence to
explicit connection and input passing.

## Old Flow

1. `do_conversions(settings)` loops through `settings$run$inputs`.
2. If `input$path` exists and `input$force` is not set, the conversion is
   skipped for that input.
3. `ic_process()`, `fia.to.psscss()`, `soil_process()`, and `met.process()`
   open DB connections internally.
4. Phenology extraction calls `PEcAn.DB::query.site(..., con = NULL)` when
   lat/lon are missing, which opens DB access implicitly.
5. `do_conversions()` writes `pecan.METProcess.xml` when conversions run.
6. If no conversions run and `pecan.METProcess.xml` exists, it is loaded and
   returned, overriding in-memory settings.

## New Flow

1. Caller optionally opens explicit `dbCon` (BETY) and
   passes it into `do_conversions(...)`.
2. `do_conversions(...)` forwards `dbCon` to downstream functions.
3. Wrapper compatibility path may open DB connections if missing, but emits
   deprecation warnings.
4. `soil_process()` accepts only required settings-derived inputs (run, model,
   host, database, site, input, dbfiles) and does not require the full settings
   object in the strict path.

## Function-by-Function Legacy vs New

### `do_conversions` (`base/workflow/R/do_conversions.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | `settings` only | `settings` + optional `dbCon` |
| DB behavior | Downstream functions open DB internally | `dbCon` passed explicitly |
| Settings usage | Full settings passed through | Orchestration only; explicit inputs passed down |
| Hidden file load | Loads `pecan.METProcess.xml` if no conversions | Same behavior, documented explicitly |

Required explicit inputs:
- `settings`
- optional `dbCon`

---

### `ic_process` (`modules/data.land/R/ic_process.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | `settings, input, dir` | `settings, input, dir, dbCon = NULL` |
| DB behavior | Opens/closes BETY internally | Uses explicit `dbCon` in strict path |
| Site lookup | Queries DB for site info when lat/lon missing | Same behavior, but via explicit `dbCon` |

Required explicit inputs:
- `settings`
- `input`
- `dir`
- optional `dbCon`

---

### `fia.to.psscss` (`modules/data.land/R/fia2ED.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | `settings` only | `settings, dbCon = NULL |
| DB behavior | Opens BETY and FIA internally | Uses explicit `dbCon`  |
| File registration | Inserts generated files into BETY | Same, but via explicit BETY connection |

Required explicit inputs:
- `settings`
- optional `dbCon`

---

### `soil_process` (`modules/data.land/R/soil_process.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | `settings, input, dbfiles` | Explicit settings-derived inputs + `dbCon = NULL` |
| DB behavior | Opens/closes BETY internally | Uses explicit `dbCon` in strict path |
| Settings usage | Full settings used | Only required settings-derived inputs |

Required explicit inputs:
- `run`
- `model`
- `host`
- `database`
- `site`
- `input`
- `dbfiles`
- optional `dbCon`



### `met.process` (`modules/data.atmosphere/R/met.process.R`)

| Aspect | Legacy Pattern | New Pattern |
|---|---|---|
| Input style | `site, input_met, start_date, end_date, model, host, dbparms, dir` | Same + `dbCon = NULL` |
| DB behavior | Opens/closes BETY internally | Uses explicit `dbCon` in strict path |
| Settings usage | Depends on implicit DB access | Explicit DB connection required for queries |

Required explicit inputs:
- `site`
- `input_met`
- `start_date`
- `end_date`
- `model`
- `host`
- `dbparms`
- `dir`
- optional `dbCon`

## `do_conversions` Flow Diagrams

### Old Flow Diagram

```text
do_conversions(settings)
  -> loop inputs
      -> skip if input$path exists and input$force is NULL
      -> ic_process() opens DB internally
      -> fia.to.psscss() opens BETY + FIA internally
      -> soil_process() opens DB internally
      -> extract_phenology_MODIS() calls query.site with con = NULL if needed
      -> met.process() opens DB internally
  -> write pecan.METProcess.xml if conversions ran
  -> else load pecan.METProcess.xml if it exists
```

### New Flow Diagram

```text
Caller
  -> optionally open dbCon (BETY)
  -> do_conversions(settings, dbCon = dbCon)
      -> loop inputs
          -> skip if input$path exists and input$force is NULL
          -> ic_process(..., dbCon)
          -> fia.to.psscss(..., dbCon)
          -> soil_process(..., dbCon)
          -> extract_phenology_MODIS(site_info = explicit)
          -> met.process(..., dbCon)
      -> write pecan.METProcess.xml if conversions ran
      -> else load pecan.METProcess.xml if it exists
  -> close dbCon if opened by caller
```

## Compatibility and Deprecation

1. Stage 1: if `dbCon` is missing, compatibility paths open
   connections internally and emit deprecation warnings.
2. Stage 2: remove compatibility paths and require explicit connections.

## Testing Plan

### Existing coverage to refactor

- `base/workflow/tests/testthat` conversion workflow tests that assume internal
  DB opens or implicit file behavior.

### New tests to add

1. Verify `do_conversions` passes `dbCon` to downstream functions.
2. Verify `ic_process`, `fia.to.psscss`, `soil_process`, and `met.process` do
   not open DB connections internally in the strict path.
3. Verify deprecation warnings when `dbCon` is missing.
4. Verify conversion skip behavior when `input$path` exists.
5. Verify `pecan.METProcess.xml` write on conversion and load on no-op.

