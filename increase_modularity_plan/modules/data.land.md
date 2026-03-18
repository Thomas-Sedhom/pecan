# data.land Refactor Plan

Package path: `modules/data.land`

## Package Summary


| Item               | Value               |
| ------------------ | ------------------- |
| Package            | `data.land`         |
| Layer              | `modules`           |
| Source path        | `modules/data.land` |
| Functions detected | `3`                 |


## Function Inventory

- [fia.to.psscss](#function-fiatopsscss)
- [ic_process](#function-ic_process)
- [soil_process](#function-soil_process)

## Function: fia.to.psscss

### Refactor Summary


| Aspect                  | Old                                                                      | New                                                                                        |
| ----------------------- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| Parameters              | `fia.to.psscss(settings, ...)`                                           | `fia.to.psscss(settings, dbCon = NULL, ...)`                                               |
| Load files              | Opens BETY and FIA DB connections internally                             | Uses explicit BETY `dbCon` in strict path; compatibility opens DBs with warnings           |
| Save files              | Inserts generated PSS/CSS/SITE files into BETY                           | Same behavior, but via explicit BETY connection                                            |
| Settings-derived inputs | Uses full settings for site, host, database, and run dates               | Extracts only required settings-derived values; still accepts `settings` for compatibility |
| Flow                    | Check existing files, query FIA, generate PSS/CSS/SITE, register in BETY | Same flow; DB access is explicit and forwarded                                             |
| Return                  | Updated `settings` (invisible)                                           | Updated `settings` (invisible)                                                             |


### Test Refactor


| Test area                         | Legacy coverage                                              | Required update                                                                                       |
| --------------------------------- | ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| Happy path                        | Coverage assumed internal DB opens                           | Add tests that explicit `dbCon` is used for BETY queries and registration                             |
| Edge cases                        | Existing-file reuse tests did not cover explicit connections | Add tests for reuse path with explicit `dbCon` and warning on missing `dbCon`                         |
| Side effects / integration points | File registration via BETY not isolated                      | Assert PSS/CSS/SITE registration uses provided `dbCon` and does not open DB internally in strict path |


### Call Flow Comparison

Old flow:

```text
fia.to.psscss(settings, ...)
  -> open BETY + FIA DB connections
  -> check for existing pss/css/site files
  -> query FIA + BETY for inputs
  -> generate pss/css/site
  -> register files in BETY
  -> return settings
```

New flow:

```text
fia.to.psscss(settings, dbCon = NULL, ...)
  -> use explicit BETY dbCon (compat opens if missing)
  -> check for existing pss/css/site files
  -> query FIA + BETY for inputs
  -> generate pss/css/site
  -> register files in BETY via dbCon
  -> return settings
```

### Caller References


| Caller function  | Location                           |
| ---------------- | ---------------------------------- |
| `do_conversions` | `base/workflow/R/do_conversions.R` |
| `kill.tunnel`    | `scripts/workflow.bm.R`            |
| `status.skip`    | `scripts/workflow.pda.R`           |


## Function: ic_process

### Refactor Summary


| Aspect                  | Old                                                                                       | New                                                                                        |
| ----------------------- | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| Parameters              | `ic_process(settings, input, dir)`                                                        | `ic_process(settings, input, dir, dbCon = NULL)`                                           |
| Load files              | Opens BETY DB internally and queries site/input metadata                                  | Uses explicit `dbCon` in strict path; compatibility opens DB with warnings                 |
| Save files              | Writes IC outputs via vegetation modules                                                  | Same behavior; side effects remain in module calls                                         |
| Settings-derived inputs | Uses full settings for site/model/host/database                                           | Extracts only required settings-derived values; still accepts `settings` for compatibility |
| Flow                    | Open DB, resolve site lat/lon, run `get_veg_module` / `ens_veg_module` / `put_veg_module` | Same flow; DB access is explicit and forwarded                                             |
| Return                  | Updated `settings`                                                                        | Updated `settings`                                                                         |


### Test Refactor


| Test area                         | Legacy coverage                                   | Required update                                                                                                                       |
| --------------------------------- | ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| Happy path                        | Internal DB opens were assumed                    | Add tests that explicit `dbCon` is used for site/input queries                                                                        |
| Edge cases                        | Lat/lon fallback and overwrite paths not isolated | Add tests for lat/lon missing path using explicit `dbCon` and for compatibility warnings                                              |
| Side effects / integration points | Downstream module calls not asserted              | Assert `get_veg_module`, `ens_veg_module`, and `put_veg_module` receive explicit inputs and no internal DB open occurs in strict path |


### Call Flow Comparison

Old flow:

```text
ic_process(settings, input, dir)
  -> open BETY DB
  -> if lat/lon missing: query.site
  -> get_veg_module(...)
  -> ens_veg_module(...) (if ensemble)
  -> put_veg_module(...)
  -> return settings
```

New flow:

```text
ic_process(settings, input, dir, dbCon = NULL)
  -> use dbCon (compat opens if missing)
  -> if lat/lon missing: query.site via dbCon
  -> get_veg_module(...)
  -> ens_veg_module(...) (if ensemble)
  -> put_veg_module(...)
  -> return settings
```

### Caller References


| Caller function  | Location                           |
| ---------------- | ---------------------------------- |
| `do_conversions` | `base/workflow/R/do_conversions.R` |


## Function: soil_process

### Refactor Summary


| Aspect                  | Old                                                                                      | New                                                                                                                 |
| ----------------------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `soil_process(settings, input, dbfiles, overwrite = FALSE, run.local = TRUE)`            | `soil_process(run, model, host, database, site, input, dbfiles, dbCon = NULL, overwrite = FALSE, run.local = TRUE)` |
| Load files              | Opens BETY DB internally and queries site/input metadata                                 | Uses explicit `dbCon` in strict path; compatibility opens DB with warnings                                          |
| Save files              | Writes soil NetCDF outputs and registers in BETY                                         | Same behavior, but via explicit BETY connection                                                                     |
| Settings-derived inputs | Used full settings list throughout                                                       | Uses only required settings-derived values (`run`, `model`, `host`, `database`, `site`, `input`, `dbfiles`)         |
| Flow                    | Open DB, resolve site info, branch on source (gSSURGO vs PalEON), write/register outputs | Same flow; DB access is explicit and forwarded                                                                      |
| Return                  | Path(s) to soil file(s)                                                                  | Path(s) to soil file(s)                                                                                             |


### Test Refactor


| Test area                         | Legacy coverage                                    | Required update                                                                               |
| --------------------------------- | -------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| Happy path                        | Internal DB opens were assumed                     | Add tests that explicit `dbCon` is used for site/input queries and registrations              |
| Edge cases                        | Source-specific branches not isolated              | Add tests for gSSURGO vs PalEON branches with explicit `dbCon`, including existing-file reuse |
| Side effects / integration points | File registration and DB interactions not isolated | Assert no internal DB open in strict path and that registrations use provided `dbCon`         |


### Call Flow Comparison

Old flow:

```text
soil_process(settings, input, dbfiles, ...)
  -> open BETY DB
  -> if lat/lon missing: query.site
  -> if source == gSSURGO: extract_soil_gssurgo(...), register files
  -> else: extract_soil_nc(...), register files
  -> return file path(s)
```

New flow:

```text
soil_process(run, model, host, database, site, input, dbfiles, dbCon = NULL, ...)
  -> use dbCon (compat opens if missing)
  -> resolve site info
  -> if source == gSSURGO: extract_soil_gssurgo(...), register files via dbCon
  -> else: extract_soil_nc(...), register files via dbCon
  -> return file path(s)
```

### Caller References


| Caller function  | Location                           |
| ---------------- | ---------------------------------- |
| `do_conversions` | `base/workflow/R/do_conversions.R` |


