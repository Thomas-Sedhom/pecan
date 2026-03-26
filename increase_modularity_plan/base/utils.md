## Function Inventory

- [read.output](#function-readoutput)

## Function: read.output

### Refactor Summary


| Aspect                  | Old                                                                                                  | New                                                                                                                                        |
| ----------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| Parameters              | `read.output(runid, outdir, ..., ncfiles = NULL, ...)`                                               | `read.output(ncfiles, variables = "GPP", start.year = NA, end.year = NA, dataframe = FALSE, pft.name = NULL, verbose = FALSE, ...)`     |
| Load files              | Discovered `*.nc` files internally from `outdir` when `ncfiles` was not supplied                    | No strict-path file discovery; `ncfiles` is passed explicitly                                                                              |
| Save files              | No save behavior                                                                                     | No save behavior                                                                                                                           |
| Settings-derived inputs | No direct settings dependency, but callers had to know the implicit `runid`/`outdir` path contract  | Requires only explicit `ncfiles` plus optional filtering/formatting arguments                                                              |
| Flow                    | Mixed compatibility path discovery, year normalization, NetCDF reading, and dataframe conversion     | Primary path reads output from explicit `ncfiles`; backward-compatible wrapper may derive `ncfiles` from `runid`/`outdir` with a warning |
| Return                  | List of variables or a dataframe with `posix`/`year` columns                                         | Same return contract                                                                                                                       |


### Test Refactor


| Test area                         | Legacy coverage                                                     | Required update                                                                                               |
| --------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Happy path                        | Existing tests mostly exercised the inferred-path calling style      | Add tests that explicit `ncfiles` drive the strict path directly                                              |
| Edge cases                        | Year normalization and no-file behavior were mixed into one path     | Add tests for explicit `ncfiles`, explicit year-window filtering, and deprecated `runid`/`outdir` fallback  |
| Side effects / integration points | Directory scanning was part of the default contract                  | Assert no implicit file discovery occurs in the strict path                                                   |


### Call Flow Comparison

Old flow:

```text
read.output(runid, outdir, ..., ncfiles = NULL)
  -> if ncfiles missing: scan outdir for YYYY.nc files
  -> normalize year window
  -> open/read NetCDF files
  -> optionally convert to dataframe
```

New flow:

```text
read.output(ncfiles, variables, start.year, end.year, ...)
  -> validate explicit ncfiles
  -> normalize year window
  -> open/read NetCDF files
  -> optionally convert to dataframe

Compatibility wrapper
  -> if ncfiles missing: derive from runid/outdir with deprecation warning
```

### Caller References


| Caller function         | Location                                        |
| ----------------------- | ----------------------------------------------- |
| `read.ensemble.output`  | `modules/uncertainty/R/ensemble.R`              |
| `read.sa.output`        | `modules/uncertainty/R/sensitivity.R`           |
| `read.ensemble.ts`      | `modules/uncertainty/R/run.ensemble.analysis.R` |
| `compute_sobol_indices` | `modules/uncertainty/R/compute_sobol_indices.R` |
| `query.run.output`      | `base/db/R/query.dplyr.R`                       |
