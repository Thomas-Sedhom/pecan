# meta.analysis Refactor Plan

Package path: `modules/meta.analysis`

## Package Summary

| Item | Value |
|---|---|
| Package | `meta.analysis` |
| Layer | `modules` |
| Source path | `modules/meta.analysis` |
| Functions detected | `15` |

## Function Inventory

- [approx.posterior](#function-approxposterior)
- [assign_treatments](#function-assign_treatments)
- [check_consistent](#function-check_consistent)
- [jagify](#function-jagify)
- [meta_analysis_standalone](#function-meta_analysis_standalone)
- [p.point.in.prior](#function-ppointinprior)
- [pecan.ma](#function-pecanma)
- [pecan.ma.summary](#function-pecanmasummary)
- [rename_jags_columns](#function-rename_jags_columns)
- [run.meta.analysis](#function-runmetaanalysis)
- [run.meta.analysis.pft](#function-runmetaanalysispft)
- [runModule.run.meta.analysis](#function-runmodulerunmetaanalysis)
- [single.MA](#function-singlema)
- [transform.nas](#function-transformnas)
- [write.ma.model](#function-writemamodel)

## Function: approx.posterior

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

## Function: assign_treatments

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

## Function: check_consistent

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

## Function: jagify

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

## Function: meta_analysis_standalone

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | Already explicit object inputs | Explicit object API retained; optional artifact controls added such as `write_artifacts` and `artifact_dir` |
| Load files | No workflow `.Rdata` load in the function body, but lower layers still assumed artifact paths | No strict-path workflow file load; compute runs from explicit `trait_data` and `priors` only |
| Save files | Lower layers could still write logs/model/PDF artifacts through `outdir` | Returns optional `files_written` metadata; artifact generation becomes explicit and optional |
| Settings-derived inputs | No direct settings-object dependency | No direct settings-object dependency; wrapper supplies explicit analysis inputs only |
| Flow | Core analysis already ran from explicit `trait_data` and `priors`, but lower layers still wrote artifacts through `outdir` | Remains the core compute function; lower-level artifact generation becomes optional and explicit |
| Return | In-memory result list | In-memory result list plus optional `files_written` and metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing tests emphasize core meta-analysis behavior | Add tests that expected structured outputs are returned from explicit inputs |
| Edge cases | Artifact behavior was not separated from computation | Add tests for disabled artifact writing and enabled artifact-target generation |
| Side effects / integration points | Lower-level artifact generation leaked through `outdir` | Assert no persistent artifact writes when disabled in the strict path |

### Call Flow Comparison

Old flow:

```text
meta_analysis_standalone(trait_data, priors, ...)
  -> compute meta-analysis outputs
  -> lower-level code may write logs/model/PDF artifacts via outdir
```

New flow:

```text
meta_analysis_standalone(trait_data, priors, ..., write_artifacts = FALSE, artifact_dir = NULL)
  -> compute meta-analysis outputs
  -> optionally generate artifact payload/paths
  -> return results + metadata + optional files_written
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `run.meta.analysis.pft` | [meta.analysis.md - Function: run.meta.analysis.pft](#function-runmetaanalysispft) | Call this as the core compute layer and keep workflow-file persistence outside unless explicitly enabled. |

## Function: p.point.in.prior

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

## Function: pecan.ma

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

## Function: pecan.ma.summary

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

## Function: rename_jags_columns

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

## Function: run.meta.analysis

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | Positional args plus internal DB open/close | Explicit attrs and named object maps: `pfts, iterations, trait_data_by_pft, prior_distns_by_pft, random, threshold, use_ghs, update, write_outputs, register_outputs, dbfiles, dbcon` |
| Load files | No direct `load()` in this function, but it depended on downstream implicit loads and opened DB internally | No strict-path internal `load()` and no internal `db.open()`; all required maps are passed explicitly |
| Save files | Indirectly caused downstream workflow saves and DB registration | Returns named per-PFT results plus optional file/DB metadata; persistence remains explicit |
| Settings-derived inputs | Relied on settings-derived DB and workflow state reaching it indirectly | Uses only required attrs already extracted by the wrapper and explicit object maps keyed by PFT |
| Flow | Opened a BETY connection internally, looped over PFTs, and relied on downstream implicit loads in `run.meta.analysis.pft()` | Orchestrates per-PFT execution without internal `load()` or `db.open()` in the strict path |
| Return | `lapply()` result existed but was effectively ignored by callers | Named result list by PFT with optional file and DB metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing coverage centered on workflow-level behavior | Add tests that explicit maps keyed by PFT name are used correctly |
| Edge cases | Missing map entries and internal DB behavior were not isolated | Add tests for map validation and no internal `db.open()` in the strict path |
| Side effects / integration points | Per-PFT invocation count and result structure were not asserted | Add tests that the wrapper calls `run.meta.analysis.pft()` once per PFT and returns named results |

### Call Flow Comparison

Old flow:

```text
run.meta.analysis(...)
  -> db.open(settings$database$bety)
  -> run.meta.analysis.pft(pft, ...)
  -> db.close(...)
```

New flow:

```text
run.meta.analysis(pfts, iterations, trait_data_by_pft, prior_distns_by_pft, ..., dbcon = dbcon)
  -> validate input maps
  -> loop over pfts
      -> run.meta.analysis.pft(pft, trait_data, priors, ..., dbcon = dbcon)
  -> return named per-PFT results
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `run.meta.analysis.pft` | [meta.analysis.md - Function: run.meta.analysis.pft](#function-runmetaanalysispft) | Pass explicit `trait_data` and `priors` maps into the per-PFT execution layer. |
| `meta_analysis_standalone` | [meta.analysis.md - Function: meta_analysis_standalone](#function-meta_analysis_standalone) | Treat it as pure compute and keep persistence optional. |

## Function: run.meta.analysis.pft

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `pft + dbfiles + dbcon` with internal file loads | Explicit `pft, trait_data, priors, iterations, random, threshold, use_ghs` plus optional `write_outputs`, `register_outputs`, `dbfiles`, and `dbcon` |
| Load files | Loaded `trait.data.Rdata` and `prior.distns.Rdata` from each `pft$outdir` | No strict-path file load; required `trait_data` and `priors` are passed explicitly |
| Save files | Saved `jagged.data.Rdata`, `trait.mcmc.Rdata`, `post.distns.MA.Rdata`, `post.distns.Rdata`, and registered outputs in DB storage | Returns results, `files_written`, and registration metadata; writing/registration are optional explicit behaviors |
| Settings-derived inputs | Relied on settings-derived PFT outdir and DB state being available implicitly | Uses only explicit per-PFT analysis inputs and optional wrapper-supplied persistence controls |
| Flow | Loaded `trait.data.Rdata` and `prior.distns.Rdata`, ran `meta_analysis_standalone()`, saved workflow outputs, then copied/registered files in DB storage | Computes from explicit objects, optionally writes workflow outputs, and optionally registers them in DB storage |
| Return | `NA` or implicit side effects | Structured per-PFT payload with results, files, registration metadata, and per-PFT information |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing tests focused on saved artifact behavior | Add tests that explicit `trait_data` and `priors` are required in the strict path |
| Edge cases | Legacy internal loads dominated the implementation | Add tests that the strict path performs no internal `load()` and uses passed `dbcon` only when registration is requested |
| Side effects / integration points | File writing and DB registration were always coupled to compute | Add tests for optional file writing and optional DB registration returning explicit metadata |

### Call Flow Comparison

Old flow:

```text
run.meta.analysis.pft(pft, ...)
  -> load trait.data.Rdata
  -> load prior.distns.Rdata
  -> meta_analysis_standalone(...)
  -> save workflow outputs
  -> copy/register files in DB storage
```

New flow:

```text
run.meta.analysis.pft(pft, trait_data, priors, ...)
  -> meta_analysis_standalone(trait_data, priors, ...)
  -> optionally write workflow outputs
  -> optionally register outputs in DB storage
  -> return structured per-PFT payload
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `meta_analysis_standalone` | [meta.analysis.md - Function: meta_analysis_standalone](#function-meta_analysis_standalone) | Use it as the explicit compute core and keep artifact writing optional. |

## Function: runModule.run.meta.analysis

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `settings` only | `settings, trait_data_by_pft = NULL, prior_distns_by_pft = NULL, dbcon = NULL, ...` |
| Load files | Relied on downstream hidden file loads from `pft$outdir` when object maps were absent | No strict-path file load; explicit maps are passed in, and fallback loading is isolated in the wrapper |
| Save files | Downstream workflow files were written implicitly through lower layers | Returns structured per-PFT results and `files_written_by_pft`; wrapper-controlled persistence remains explicit |
| Settings-derived inputs | Full workflow settings object was passed through into the meta-analysis chain | Extracts only required settings-derived attrs such as `pfts`, iterations, random/threshold flags, update, and `dbfiles` |
| Flow | Delegated to `run.meta.analysis(...)` with hidden file and DB behavior below it | Wrapper extracts only required attrs, supports `Settings` and `MultiSettings` orchestration, and uses a deprecated fallback loader only when explicit object maps are missing |
| Return | Mostly side effects | Structured return with `results_by_pft`, `files_written_by_pft`, and metadata |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Existing workflow coverage verified broad behavior only | Add tests that the explicit map path is used when maps are provided |
| Edge cases | Compatibility loading and deprecation behavior were not isolated | Add tests for missing-map fallback with warning |
| Side effects / integration points | `MultiSettings` dispatch and deduping were not asserted at the modular boundary | Add tests for per-site dispatch, deduping, and structured returned metadata |

### Call Flow Comparison

Old flow:

```text
runModule.run.meta.analysis(settings)
  -> run.meta.analysis(...)
      -> db.open(...)
      -> run.meta.analysis.pft(...)
```

New flow:

```text
Caller
  -> prepare explicit maps: trait_data_by_pft, prior_distns_by_pft, optional dbcon
  -> runModule.run.meta.analysis(settings, trait_data_by_pft, prior_distns_by_pft, dbcon, ...)
      -> if maps missing: deprecated fallback loader with warning
      -> extract attrs from settings
      -> run.meta.analysis(pfts, iterations, trait_data_by_pft, prior_distns_by_pft, ..., dbcon = dbcon)
      -> return list(results_by_pft = ..., files_written_by_pft = ..., metadata = ...)
```

### Refactored Dependency References

| Called function | Source of truth | Caller update after dependency refactor |
|---|---|---|
| `run.meta.analysis` | [meta.analysis.md - Function: run.meta.analysis](#function-runmetaanalysis) | Use it as the explicit per-PFT orchestrator once object maps are prepared. |

## Function: single.MA

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

## Function: transform.nas

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

## Function: write.ma.model

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

