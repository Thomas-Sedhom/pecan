---
title: "PEcAn Modular Config Workflow Migration"
---

## Overview

This document describes the migration from implicit `samples.Rdata`-based state
handoff to explicit object passing for config generation.

## Old Flow

1. `runModule.run.write.configs(settings)` generated input designs.
2. `generate_joint_ensemble_design(settings, ...)` could call `get.parameter.samples(settings, ...)`.
3. `get.parameter.samples()` wrote `samples.Rdata`.
4. `run.write.configs()` loaded `samples.Rdata` from disk.

This created hidden dependencies between steps and reduced testability.

## New Flow

1. `runModule.run.write.configs(settings, dbCon = dbCon)` orchestrates explicit object assembly.
2. Internal helper loaders resolve:
   - `distns`
   - `trait.mcmc`
   - optional ensemble sample structures
3. `get.parameter.samples(...)` returns a structured `samples` object.
4. `generate_joint_ensemble_design(run, ensemble, ensemble_size, samples, ...)` builds design without sampling side effects.
5. `generate_OAT_SA_design(ensemble, samples)` builds OAT design without sampling side effects.
6. `run.write.configs(..., samples = samples)` consumes explicit samples directly.

## New Samples Object Contract

The `samples` object passed through workflow/config layers is a list with:

- `trait.samples`
- `sa.samples`
- `ensemble.samples`
- `runs.samples`
- `env.samples`

## Deprecations

The following compatibility paths remain temporarily and emit deprecation warnings:

- Passing `settings` to `get.parameter.samples()`
- Calling `run.write.configs()` without `samples`
- Passing `settings` to `generate_joint_ensemble_design()`
- Passing `settings`/`sa_samples` to `generate_OAT_SA_design()`
- Passing `settings` to `input.ens.gen()`

## Recommended Usage

```r
dbCon <- PEcAn.DB::db.open(settings$database$bety)
on.exit(try(PEcAn.DB::db.close(dbCon), silent = TRUE), add = TRUE)

settings <- PEcAn.workflow::runModule.run.write.configs(
  settings = settings,
  dbCon = dbCon
)
```

## Migration Notes

- Existing workflows can continue using compatibility paths during the deprecation window.
- New development should pass explicit objects and avoid relying on `samples.Rdata`.
