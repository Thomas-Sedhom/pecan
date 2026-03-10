# uncertainty Refactor Plan

Package path: `modules/uncertainty`

## Package Summary

| Item | Value |
|---|---|
| Package | `uncertainty` |
| Layer | `modules` |
| Source path | `modules/uncertainty` |
| Functions detected | `45` |

## Function Inventory

- [compute_sobol_indices](#function-compute_sobol_indices)
- [ensemble.filename](#function-ensemblefilename)
- [ensemble.ts](#function-ensemblets)
- [filterNA](#function-filterna)
- [flux.uncertainty](#function-fluxuncertainty)
- [generate_joint_ensemble_design](#function-generate_joint_ensemble_design)
- [generate_OAT_SA_design](#function-generate_oat_sa_design)
- [get.change](#function-getchange)
- [get.distns](#function-getdistns)
- [get.ensemble.samples](#function-getensemblesamples)
- [get.gi.phii](#function-getgiphii)
- [get.parameter.samples](#function-getparametersamples)
- [get.results](#function-getresults)
- [get.sensitivity](#function-getsensitivity)
- [get.trait.mcmc](#function-gettraitmcmc)
- [get_ensemble_samples](#function-get_ensemble_samples)
- [input.ens.gen](#function-inputensgen)
- [plot_flux_uncertainty](#function-plot_flux_uncertainty)
- [plot_oechel_flux](#function-plot_oechel_flux)
- [read.ameriflux.L2](#function-readamerifluxl2)
- [read.ensemble.output](#function-readensembleoutput)
- [read.ensemble.ts](#function-readensemblets)
- [read.sa.output](#function-readsaoutput)
- [run.ensemble.analysis](#function-runensembleanalysis)
- [run.sensitivity.analysis](#function-runsensitivityanalysis)
- [runModule.get.results](#function-runmodulegetresults)
- [runModule.run.ensemble.analysis](#function-runmodulerunensembleanalysis)
- [runModule.run.sensitivity.analysis](#function-runmodulerunsensitivityanalysis)
- [sensitivity.filename](#function-sensitivityfilename)
- [spline.ensemble](#function-splineensemble)
- [tundra.flux.uncertainty](#function-tundrafluxuncertainty)
- [variance.stats](#function-variancestats)
- [vd.variance](#function-vdvariance)
- [write.ensemble.configs](#function-writeensembleconfigs)
- [write.sa.configs](#function-writesaconfigs)

## Function: compute_sobol_indices

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: ensemble.filename

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `ensemble.filename(settings, ...)` | `ensemble.filename(outdir, ...)` |
| Load files | No file load, but read `settings$outdir` internally | No file load; uses explicit `outdir` |
| Save files | No save behavior | No save behavior |
| Settings-derived inputs | Took the full `settings` object to get `outdir` | Requires only `outdir` and optional context args |
| Flow | Read `settings$outdir` internally and generated ensemble-analysis filenames from full settings | Receives required path inputs directly and remains a path-construction helper |
| Return | Filename path | Filename path |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Limited direct filename coverage | Add tests that `outdir` is the only required input in the strict path |
| Edge cases | Variable/year-window fallback behavior was not isolated | Add tests for all-variable/all-year vs specific window behavior and missing ensemble ID fallback |
| Side effects / integration points | Helper depended on full settings object | Assert no settings-object dependency in the strict path |

### Call Flow Comparison

Old flow:

```text
ensemble.filename(settings, ...)
  -> read settings$outdir
  -> build output path
```

New flow:

```text
ensemble.filename(outdir, ...)
  -> build output path from explicit outdir and optional context args
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `run.ensemble.analysis` | [uncertainty.md - Function: run.ensemble.analysis](#function-runensembleanalysis) | Pass `outdir` directly when assembling file targets. |
| `read.ensemble.ts` | [uncertainty.md - Function: read.ensemble.ts](#function-readensemblets) | Use explicit `outdir` when returning timeseries file targets. |

## Function: ensemble.ts

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: filterNA

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: flux.uncertainty

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: generate_joint_ensemble_design

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | Mixed input style that could accept `settings` and optional compatibility args | `run, ensemble, ensemble_size, samples, sobol = FALSE` |
| Load files | Could rely on hidden sampling/file logic through settings-driven fallback | No file loading; consumes explicit `samples` |
| Save files | No explicit save contract | Returns the design object in memory |
| Settings-derived inputs | Could reach into full `settings` for run and ensemble state | Requires only explicit `run`, `ensemble`, and `ensemble_size` inputs |
| Flow | Could rely on hidden sampling/file logic through settings-driven fallback | Builds the ensemble design strictly from explicit inputs and explicit `samples` |
| Return | Design matrix / Sobol object | Same contract: `list(X = ...)` or Sobol object when `sobol = TRUE` |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Covered only indirectly through config-writing workflow tests | Add tests that explicit `run`, `ensemble`, `ensemble_size`, and `samples` produce deterministic designs |
| Edge cases | Settings fallback and Sobol branching were not isolated | Add tests for strict-path validation and Sobol path behavior |
| Side effects / integration points | Could inherit hidden sampling dependencies | Assert no internal sample generation or file loading in the strict path |

### Call Flow Comparison

Old flow:

```text
generate_joint_ensemble_design(settings, ...)
  -> may trigger implicit sample generation/load
```

New flow:

```text
generate_joint_ensemble_design(run, ensemble, ensemble_size, samples, sobol = FALSE)
  -> build ensemble design from explicit sample inputs
  -> return design object
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `get.parameter.samples` | [uncertainty.md - Function: get.parameter.samples](#function-getparametersamples) | Consume the explicit `samples` contract returned upstream instead of generating/loading samples internally. |
| `input.ens.gen` | [uncertainty.md - Function: input.ens.gen](#function-inputensgen) | Pass explicit `run` data instead of full `settings`. |

## Function: generate_OAT_SA_design

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `settings, sa_samples` via legacy path | `ensemble, samples` |
| Load files | Could indirectly depend on file-backed sampling behavior | No file loading; consumes explicit `samples$sa.samples` |
| Save files | No explicit save contract | Returns the design object in memory |
| Settings-derived inputs | Could reach into full `settings` for ensemble state | Requires only explicit `ensemble` and `samples` |
| Flow | Accepted settings-driven fallback behavior and could indirectly depend on sampling work | Strict explicit-input design builder for OAT sensitivity design |
| Return | `list(X = design_matrix)` | Same contract |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Covered only through config-writing integration paths | Add tests that explicit `ensemble` and `samples` generate the expected OAT design |
| Edge cases | Compatibility fallback was not isolated | Add tests for missing `samples$sa.samples` and strict-path validation |
| Side effects / integration points | Could rely on hidden sampling behavior | Assert no file or DB fallback in this function |

### Call Flow Comparison

Old flow:

```text
generate_OAT_SA_design(settings, sa_samples)
  -> may depend on implicit sampling path
```

New flow:

```text
generate_OAT_SA_design(ensemble, samples)
  -> build OAT design from explicit ensemble + samples
  -> return list(X = design_matrix)
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `get.parameter.samples` | [uncertainty.md - Function: get.parameter.samples](#function-getparametersamples) | Use explicit `samples$sa.samples` from upstream preparation. |

## Function: get.change

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: get.distns

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: get.ensemble.samples

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: get.gi.phii

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: get.parameter.samples

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `get.parameter.samples(settings, ...)` | Explicit-object-first inputs: `pfts, outdir, sensitivity, trait.mcmc, distns, ensemble, ensemble.size, ens.sample.method, ...` |
| Load files | Read from settings plus DB/file fallback inside the function | No strict-path file load; explicit objects are prepared upstream |
| Save files | Wrote `samples.Rdata` by default | Returns the `samples` object; legacy file write is optional/deprecated |
| Settings-derived inputs | Used the full `settings` object to resolve workflow state | Requires only the needed values already extracted from settings by the caller |
| Flow | Read from settings plus DB/file fallback and wrote `samples.Rdata` by default | Receives prepared objects/attrs as parameters and returns the canonical `samples` object; legacy file write becomes optional/deprecated |
| Return | Implicit file-backed workflow state | `samples` list with `trait.samples`, `sa.samples`, `ensemble.samples`, `runs.samples`, `env.samples`, and `param.names` |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing workflow coverage assumed settings-driven and file-backed sampling | Add tests that explicit inputs produce the canonical `samples` object |
| Edge cases | Legacy compatibility branch was not isolated | Add tests for deprecated `settings` path warning and missing required explicit inputs |
| Side effects / integration points | `samples.Rdata` writing was part of the default contract | Assert strict-path no-write behavior and explicit returned object keys |

### Call Flow Comparison

Old flow:

```text
get.parameter.samples(settings, ...)
  -> resolve inputs from settings/DB/files
  -> write samples.Rdata
  -> return implicitly through saved state
```

New flow:

```text
get.parameter.samples(pfts, outdir, sensitivity, trait.mcmc, distns, ensemble, ensemble.size, ens.sample.method, ...)
  -> validate explicit inputs
  -> build canonical samples object
  -> return samples in memory
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `generate_joint_ensemble_design` | [uncertainty.md - Function: generate_joint_ensemble_design](#function-generate_joint_ensemble_design) | Provide the canonical `samples` object to downstream design generation. |
| `generate_OAT_SA_design` | [uncertainty.md - Function: generate_OAT_SA_design](#function-generate_oat_sa_design) | Provide the canonical `samples` object to downstream sensitivity design generation. |

## Function: get.results

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `get.results(settings, ...)` | `get.results(ensemble, modeloutdir, sensitivity, outdir, pfts, sensitivity.samples, ensemble.samples, manifest, ...)` |
| Load files | Loaded sensitivity samples from disk and relied on `read.sa.output()` to load the manifest internally | No strict-path file load; `sensitivity.samples`, `ensemble.samples`, and `manifest` are passed explicitly |
| Save files | Saved `sensitivity.output.*.Rdata` internally | Returns `sensitivity.output`; wrapper may add `files_written` and metadata |
| Settings-derived inputs | Used the full `settings` object directly | Requires only explicit `ensemble`, `modeloutdir`, `sensitivity`, `outdir`, and `pfts` extracted upstream |
| Flow | Used the full settings object, loaded sensitivity samples from disk, delegated manifest loading to `read.sa.output()`, and saved `sensitivity.output.*.Rdata` internally | Performs sensitivity-output computation from explicit attrs and objects with no internal `load()` in the strict path |
| Return | Implicit side effects plus in-memory output | Primary core return is `sensitivity.output`; wrapper may add `files_written` and metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Coverage mostly came through larger workflow/integration paths | Add direct unit tests for explicit required attrs and objects |
| Edge cases | Context resolution and compatibility payload normalization were not isolated | Add tests for variable/year precedence and deprecated fallback loading |
| Side effects / integration points | Internal file loads and manifest dependency were hidden | Assert no internal file load in the strict path and explicit returned `sensitivity.output` contract |

### Call Flow Comparison

Old flow:

```text
get.results(settings)
  -> sensitivity.filename(settings, ...)
  -> load sensitivity.samples.*.Rdata or samples.Rdata
  -> read.sa.output(...)
      -> load runs_manifest.csv internally
  -> sensitivity.filename(settings, ...)
  -> save sensitivity.output.*.Rdata
```

New flow:

```text
get.results(ensemble, modeloutdir, sensitivity, outdir, pfts, sensitivity.samples, ensemble.samples, manifest, ...)
  -> resolve context
  -> read.sa.output(..., manifest = manifest, outdir = outdir, ...)
  -> return sensitivity.output
  -> wrapper-only file writing if enabled
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `read.sa.output` | [uncertainty.md - Function: read.sa.output](#function-readsaoutput) | Pass the explicit `manifest` object instead of relying on disk reads. |
| `sensitivity.filename` | [uncertainty.md - Function: sensitivity.filename](#function-sensitivityfilename) | Reuse the explicit filename contract already defined for sensitivity analysis. |

## Function: get.sensitivity

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: get.trait.mcmc

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: get_ensemble_samples

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: input.ens.gen

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | Included `settings` compatibility branch | `ensemble_size, input, method = "sampling", parent_ids = NULL, run` |
| Load files | No file load, but could access full `settings` implicitly | No file load; uses explicit `run` data only |
| Save files | No save behavior | No save behavior |
| Settings-derived inputs | Could read `settings$run$inputs` internally | Requires only the explicit `run` object |
| Flow | Could reach into `settings$run$inputs` through compatibility logic | Consumes explicit `run` data only |
| Return | Existing design helper return | Same return contract |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Covered indirectly through ensemble design generation | Add tests that explicit `run` inputs are used correctly |
| Edge cases | Compatibility branch for full settings was not isolated | Add tests for removal/deprecation of settings-driven access in the strict path |
| Side effects / integration points | Hidden dependency on `settings$run$inputs` reduced testability | Assert no full-settings access in the strict path |

### Call Flow Comparison

Old flow:

```text
input.ens.gen(..., settings = settings)
  -> read settings$run$inputs internally
```

New flow:

```text
input.ens.gen(ensemble_size, input, method = "sampling", parent_ids = NULL, run)
  -> use explicit run inputs only
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `generate_joint_ensemble_design` | [uncertainty.md - Function: generate_joint_ensemble_design](#function-generate_joint_ensemble_design) | Provide `run` explicitly when generating input ensembles. |

## Function: plot_flux_uncertainty

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: plot_oechel_flux

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: read.ameriflux.L2

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: read.ensemble.output

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: read.ensemble.ts

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `read.ensemble.ts(settings, ensemble.id, variable, ...)` | `read.ensemble.ts(ensemble, run, modeloutdir, outdir, ensemble.samples, ensemble.id, variable, ...)` |
| Load files | Loaded ensemble sample metadata internally from `ensemble.samples.*.Rdata` or `samples.Rdata` | No strict-path file load; `ensemble.samples` is passed explicitly |
| Save files | Saved `ensemble.ts.*.Rdata` internally | Returns `ensemble.ts` plus file targets / metadata; wrapper writes if needed |
| Settings-derived inputs | Used the full `settings` object | Requires only explicit `ensemble`, `run`, `modeloutdir`, and `outdir` extracted upstream |
| Flow | Loaded ensemble sample metadata internally, read model outputs, and saved `ensemble.ts.*.Rdata` internally | Builds and returns `ensemble.ts` from explicit attrs and explicit `ensemble.samples`; wrapper owns optional file writing |
| Return | `ensemble.ts` plus side-effect save | `ensemble.ts` plus file targets / metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Covered indirectly through ensemble-analysis workflow behavior | Add tests that explicit `ensemble.samples` produce timeseries output without internal save |
| Edge cases | Failed-run and sparse-output behavior were not isolated from internal file loading | Add tests for failed runs, sparse outputs, and strict-path validation |
| Side effects / integration points | Internal load/save reduced testability | Assert no internal loads or saves in the strict path |

### Call Flow Comparison

Old flow:

```text
read.ensemble.ts(settings, ...)
  -> ensemble.filename(settings, ...)
  -> load ensemble.samples.*.Rdata or samples.Rdata
  -> read model outputs
  -> save ensemble.ts.*.Rdata
```

New flow:

```text
read.ensemble.ts(ensemble, run, modeloutdir, outdir, ensemble.samples, ensemble.id, variable, ...)
  -> read model outputs using explicit attrs
  -> return ensemble.ts + file targets
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `ensemble.filename` | [uncertainty.md - Function: ensemble.filename](#function-ensemblefilename) | Use explicit `outdir` when assembling timeseries file targets. |

## Function: read.sa.output

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `read.sa.output(..., pecandir, ..., sa.run.ids = NULL, ...)` | `read.sa.output(..., manifest, outdir, ..., per.pft = FALSE)` |
| Load files | Read `runs_manifest.csv` internally from disk | No strict-path file load; `manifest` is passed explicitly |
| Save files | No save behavior in this function | No save behavior in the core path |
| Settings-derived inputs | Depended on file paths derived from higher-level settings | Requires only explicit `manifest`, `outdir`, and other needed analysis args |
| Flow | Loaded `runs_manifest.csv` internally from disk and derived run lookup from that file | Uses provided `manifest` object and explicit `outdir`; no internal manifest load in the strict path |
| Return | Existing sensitivity-output payload | Same payload, but run lookup is derived from explicit manifest rows |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Covered indirectly through get-results workflow behavior | Add tests that passed `manifest` objects are used directly |
| Edge cases | Duplicate or missing manifest rows were not isolated | Add tests for duplicate and missing run handling from explicit manifest input |
| Side effects / integration points | Internal file read hid the manifest dependency | Assert no internal manifest file dependency in the strict path |

### Call Flow Comparison

Old flow:

```text
read.sa.output(..., pecandir, ...)
  -> load runs_manifest.csv internally
  -> derive run lookup from file contents
```

New flow:

```text
read.sa.output(..., manifest, outdir, ..., per.pft = FALSE)
  -> derive run lookup from provided manifest rows
  -> return sensitivity-output payload
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `get.results` | [uncertainty.md - Function: get.results](#function-getresults) | Require `manifest` to be passed explicitly from the caller or compatibility wrapper. |

## Function: run.ensemble.analysis

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `run.ensemble.analysis(settings, ...)` | `run.ensemble.analysis(ensemble, run, outdir, modeloutdir, ensemble.output, ensemble.ts = NULL, ...)` |
| Load files | Loaded `ensemble.output.*.Rdata` internally and could call `read.ensemble.ts(settings, ...)` | No strict-path file load; `ensemble.output` and optional `ensemble.ts` are passed explicitly |
| Save files | Saved PDFs and `ensemble.ts.analysis.*.Rdata` internally | Returns analysis payloads and file targets; wrapper owns optional writing |
| Settings-derived inputs | Used the full `settings` object | Requires only explicit `ensemble`, `run`, `outdir`, and `modeloutdir` extracted upstream |
| Flow | Resolved filenames, loaded `ensemble.output.*.Rdata`, optionally called `read.ensemble.ts(settings, ...)`, generated plots, and saved analysis artifacts internally | Performs ensemble-analysis computation from explicit attrs and objects; timeseries analysis uses explicit `ensemble.ts`; wrapper owns optional file writing |
| Return | Mostly side effects | `ensemble_results_by_variable`, `timeseries_results_by_variable`, `plot_payload_by_variable`, `file_targets`, and metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing coverage for ensemble-analysis contracts was limited | Add tests that minimal explicit inputs compute results |
| Edge cases | Hidden load behavior and timeseries branching were not isolated | Add tests for explicit `ensemble.output` requirement and optional timeseries behavior |
| Side effects / integration points | Internal save behavior obscured result contracts | Assert structured return shape and no internal load dependency in the strict path |

### Call Flow Comparison

Old flow:

```text
run.ensemble.analysis(settings, ...)
  -> ensemble.filename(settings, ...)
  -> load ensemble.output.*.Rdata
  -> compute summaries
  -> if plot.timeseries:
      -> read.ensemble.ts(settings, ...)
      -> save ensemble.ts.analysis.*.Rdata
```

New flow:

```text
run.ensemble.analysis(ensemble, run, outdir, modeloutdir, ensemble.output, ensemble.ts = NULL, ...)
  -> resolve context
  -> compute ensemble distributions from explicit ensemble.output
  -> optionally compute timeseries analysis from explicit ensemble.ts
  -> assemble file targets with ensemble.filename(outdir, ...)
  -> return structured results + metadata
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `ensemble.filename` | [uncertainty.md - Function: ensemble.filename](#function-ensemblefilename) | Pass explicit `outdir` when building file targets. |
| `read.ensemble.ts` | [uncertainty.md - Function: read.ensemble.ts](#function-readensemblets) | Use explicit `ensemble.ts` in the strict path; wrapper may call `read.ensemble.ts()` only for compatibility. |

## Function: run.sensitivity.analysis

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `run.sensitivity.analysis(settings, ...)` | `run.sensitivity.analysis(sensitivity, pfts, run, outdir, samples, sensitivity.samples, sensitivity.output, ...)` |
| Load files | Loaded `samples.Rdata`, optional `sensitivity.samples.*.Rdata`, and `sensitivity.output.*.Rdata` internally | No strict-path file load; required objects are passed explicitly |
| Save files | Saved `sensitivity.results.*.Rdata` and plot PDFs internally | Returns results payloads and metadata; wrapper owns optional writing and plotting |
| Settings-derived inputs | Used the full `settings` object | Requires only explicit `sensitivity`, `pfts`, `run`, and `outdir` extracted upstream |
| Flow | Loaded `samples.Rdata`, optional `sensitivity.samples.*.Rdata`, and `sensitivity.output.*.Rdata` internally, then computed and saved results/plots | Computes sensitivity analysis from explicit attrs and objects with no internal file load in the strict path; wrapper owns optional writing and plotting |
| Return | Side effects plus internal objects | `sensitivity_results_by_variable`, `plot_payload_by_variable`, and metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing sensitivity workflow coverage was mostly indirect | Add tests that explicit required objects compute results directly |
| Edge cases | Variable/year resolution and compatibility object loading were not isolated | Add tests for strict-path validation and deprecated fallback behavior |
| Side effects / integration points | Internal load/save behavior obscured the modular contract | Assert no internal load dependency and explicit returned result/file-target structure |

### Call Flow Comparison

Old flow:

```text
run.sensitivity.analysis(settings, ...)
  -> sensitivity.filename(settings, ...)
  -> load samples.Rdata
  -> load sensitivity.samples.*.Rdata
  -> load sensitivity.output.*.Rdata
  -> compute sensitivity/VD
  -> save results and plots
```

New flow:

```text
run.sensitivity.analysis(sensitivity, pfts, run, outdir, samples, sensitivity.samples, sensitivity.output, ...)
  -> resolve context
  -> compute sensitivity/VD from explicit objects
  -> assemble output targets with sensitivity.filename(outdir, pfts, ...)
  -> return structured results + metadata
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `sensitivity.filename` | [uncertainty.md - Function: sensitivity.filename](#function-sensitivityfilename) | Pass `outdir` and `pfts` explicitly when building file targets. |

## Function: runModule.get.results

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `settings` only | `settings, sensitivity.samples = NULL, ensemble.samples = NULL, manifest = NULL, ...` |
| Load files | Relied on hidden file coupling for samples and manifest state | No strict-path file load; explicit objects are forwarded per site and fallback loading is isolated in the wrapper |
| Save files | Wrapper/core saved `sensitivity.output.*.Rdata` through side effects | Returns structured `sensitivity.output`, optional `files_written`, and metadata |
| Settings-derived inputs | Passed the full `settings` object into the core stage | Extracts only required settings-derived attrs such as `ensemble`, `modeloutdir`, `sensitivity`, `outdir`, and `pfts` |
| Flow | Delegated to `get.results(settings)` and relied on hidden file coupling for samples and manifest state | Wrapper extracts only required attrs, forwards explicit objects per site, and owns the deprecated fallback loader when objects are missing |
| Return | Implicit side effects | Structured return including `sensitivity.output`, optional `files_written`, and metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing behavior was exercised mostly through workflow-level paths | Add tests that the explicit object path is used when all objects are passed |
| Edge cases | Compatibility fallback behavior and warnings were not isolated | Add tests for missing objects triggering fallback and deprecation warnings |
| Side effects / integration points | MultiSettings dispatch and returned payloads were not asserted | Add tests for per-site dispatch and structured return contracts |

### Call Flow Comparison

Old flow:

```text
runModule.get.results(settings)
  -> get.results(settings)
      -> hidden sample and manifest loading
```

New flow:

```text
Caller
  -> prepare explicit attrs and objects: sensitivity.samples, ensemble.samples, manifest
  -> runModule.get.results(settings, sensitivity.samples, ensemble.samples, manifest, ...)
      -> if objects missing: deprecated fallback loader from settings/files with warning
      -> extract attrs per site
      -> get.results(ensemble, modeloutdir, sensitivity, outdir, pfts, sensitivity.samples, ensemble.samples, manifest, ...)
      -> optionally write files in wrapper
      -> return list(sensitivity.output = ..., files_written = ..., metadata = ...)
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `get.results` | [uncertainty.md - Function: get.results](#function-getresults) | Pass explicit samples and manifest objects into the core results stage. |

## Function: runModule.run.ensemble.analysis

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | Full `settings` plus `...` | `settings, ensemble.output, ensemble.ts = NULL, ensemble.samples = NULL, ...` |
| Load files | Relied on hidden file loading in the core path when required objects were not passed | No strict-path file load; explicit analysis objects are passed and compatibility loading stays in the wrapper |
| Save files | Output PDFs and `.Rdata` analysis files were written via side effects | Returns results, optional written paths, and metadata |
| Settings-derived inputs | Passed the full `settings` object into the core stage | Extracts only required settings-derived attrs such as `ensemble`, `run`, `outdir`, and `modeloutdir` |
| Flow | Delegated to `run.ensemble.analysis(settings, ...)` and relied on hidden file loading in the core path | Wrapper extracts required attrs, forwards explicit analysis objects, and keeps a deprecated compatibility loader only when required objects are missing |
| Return | Mostly side effects | Structured return object with results, optional written paths, and metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing ensemble workflow tests had limited coverage of modular contracts | Add tests that the explicit object path is used when `ensemble.output` is passed |
| Edge cases | Timeseries compatibility loading was not isolated | Add tests for deprecated fallback behavior when `ensemble.output` or `ensemble.ts` is missing |
| Side effects / integration points | MultiSettings dispatch and returned file paths were not asserted | Add tests for per-site explicit dispatch and structured returned payloads |

### Call Flow Comparison

Old flow:

```text
runModule.run.ensemble.analysis(settings)
  -> run.ensemble.analysis(settings)
      -> hidden ensemble output/timeseries loads
```

New flow:

```text
Caller
  -> prepare explicit attrs and objects: ensemble.output, optional ensemble.ts, optional ensemble.samples
  -> runModule.run.ensemble.analysis(settings, ensemble.output, ensemble.ts, ensemble.samples, ...)
      -> if objects missing: deprecated fallback loader with warning
      -> extract/pass required attrs per site
      -> run.ensemble.analysis(ensemble, run, outdir, modeloutdir, ensemble.output, ensemble.ts, ...)
      -> optionally write files
      -> return list(results = ..., files_written = ..., metadata = ...)
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `run.ensemble.analysis` | [uncertainty.md - Function: run.ensemble.analysis](#function-runensembleanalysis) | Supply explicit ensemble analysis inputs from the wrapper and keep compatibility loading outside the core. |

## Function: runModule.run.sensitivity.analysis

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | Full `settings` plus `...` | `settings, samples, sensitivity.samples, sensitivity.output, ...` |
| Load files | Relied on hidden file-based state handoff in the core path when objects were missing | No strict-path file load; explicit objects are passed and compatibility loading stays in the wrapper |
| Save files | Sensitivity results and plots were written via side effects | Returns results, optional file path list, and metadata |
| Settings-derived inputs | Passed the full `settings` object into the core stage | Extracts only required settings-derived attrs such as `sensitivity`, `pfts`, `run`, and `outdir` |
| Flow | Delegated to `run.sensitivity.analysis(settings, ...)` and relied on hidden file-based state handoff | Wrapper extracts required attrs, forwards explicit objects per site, and retains only a deprecated compatibility loader when objects are missing |
| Return | Mostly side effects | Structured return object plus optional file path list |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing workflow coverage was indirect | Add tests that the explicit object path is used when all required objects are passed |
| Edge cases | Missing-object fallback and warnings were not isolated | Add tests for deprecated fallback behavior and deprecation warnings |
| Side effects / integration points | MultiSettings dispatch and returned payloads were not asserted | Add tests for per-site explicit dispatch and structured result/file metadata |

### Call Flow Comparison

Old flow:

```text
runModule.run.sensitivity.analysis(settings)
  -> run.sensitivity.analysis(settings)
      -> hidden samples / sensitivity.samples / sensitivity.output loads
```

New flow:

```text
Caller
  -> prepare explicit attrs and objects: samples, sensitivity.samples, sensitivity.output
  -> runModule.run.sensitivity.analysis(settings, samples, sensitivity.samples, sensitivity.output, ...)
      -> if objects missing: deprecated fallback loader with warning
      -> extract/pass required attrs per site
      -> run.sensitivity.analysis(sensitivity, pfts, run, outdir, samples, sensitivity.samples, sensitivity.output, ...)
      -> optionally write files
      -> return list(results = ..., files_written = ..., metadata = ...)
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `run.sensitivity.analysis` | [uncertainty.md - Function: run.sensitivity.analysis](#function-runsensitivityanalysis) | Supply explicit sensitivity-analysis inputs from the wrapper and keep compatibility loading outside the core. |

## Function: sensitivity.filename

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `sensitivity.filename(settings, ...)` | `sensitivity.filename(outdir, pfts, ...)` |
| Load files | No file load, but read `settings$outdir` and `settings$pfts` internally | No file load; uses explicit `outdir` and `pfts` |
| Save files | No save behavior | No save behavior |
| Settings-derived inputs | Took the full `settings` object to get `outdir` and `pfts` | Requires only explicit `outdir`, `pfts`, and optional context args |
| Flow | Read `settings$outdir` and `settings$pfts` internally to build paths | Receives required values directly and remains a path-construction helper |
| Return | Filename path | Filename path |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Limited direct coverage existed | Add tests that only `outdir` and `pfts` are required in the strict path |
| Edge cases | PFT null/unmatched cases were not isolated | Add tests for null PFT handling, per-PFT paths, and unmatched-PFT fallback |
| Side effects / integration points | Helper depended on full settings object | Assert no settings-object dependency in the strict path |

### Call Flow Comparison

Old flow:

```text
sensitivity.filename(settings, ...)
  -> read settings$outdir and settings$pfts
  -> build output path
```

New flow:

```text
sensitivity.filename(outdir, pfts, ...)
  -> build output path from explicit outdir and pfts
```

### Refactored Dependency References
- No dependencies

## Function: spline.ensemble

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: tundra.flux.uncertainty

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: variance.stats

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: vd.variance

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: write.ensemble.configs

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

## Function: write.sa.configs

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | TBD | TBD |
| Load files | TBD | Passed as explicit parameters or not needed |
| Save files | TBD | Returned explicitly or handled by wrapper |
| Settings-derived inputs | TBD | Only required settings-derived values are passed |
| Flow | TBD | TBD |
| Return | TBD | TBD |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | TBD | TBD |
| Edge cases | TBD | TBD |
| Side effects / integration points | TBD | TBD |

### Call Flow Comparison

Old flow:

```text
TBD
```

New flow:

```text
TBD
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| TBD | TBD | TBD |

