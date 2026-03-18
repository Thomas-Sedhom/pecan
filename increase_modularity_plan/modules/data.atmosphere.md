# data.atmosphere Refactor Plan

Package path: `modules/data.atmosphere`

## Package Summary

| Item | Value |
|---|---|
| Package | `data.atmosphere` |
| Layer | `modules` |
| Source path | `modules/data.atmosphere` |
| Functions detected | `1` |

## Function Inventory

- [met.process](#function-metprocess)

## Function: met.process

### Refactor Summary

| Aspect | Old | New |
|---|---|---|
| Parameters | `met.process(site, input_met, start_date, end_date, model, host, dbparms, dir, ...)` | Same + `dbCon = NULL` |
| Load files | Opens BETY DB internally and reads registration XML | Uses explicit `dbCon` in strict path; registration XML read remains |
| Save files | Writes met outputs and registers them in BETY | Same behavior, but via explicit BETY connection |
| Settings-derived inputs | Relied on implicit DB access for site/format queries | Requires explicit DB connection for queries; other inputs are passed explicitly |
| Flow | Open DB, read register, resolve stages, download/convert/standardize/modelize met | Same flow; DB access is explicit and forwarded |
| Return | Updated `input_met` with generated paths | Updated `input_met` with generated paths |
### Test Refactor

| Test area | Legacy coverage | Required update |
|---|---|---|
| Happy path | Internal DB opens were assumed | Add tests that explicit `dbCon` is used for format/site queries and registration |
| Edge cases | Stage selection and source fallbacks not isolated | Add tests for explicit `dbCon` across stage branches and warning on missing `dbCon` |
| Side effects / integration points | DB registration and file outputs not separated | Assert no internal DB open in strict path and returned paths are preserved |

### Call Flow Comparison

Old flow:

```text
met.process(site, input_met, start_date, end_date, model, host, dbparms, dir, ...)
  -> open BETY DB
  -> read.register(...)
  -> resolve stage via met.process.stage(...)
  -> download raw, met2cf, standardize, met2model
  -> register outputs in BETY
  -> return input_met
```

New flow:

```text
met.process(site, input_met, start_date, end_date, model, host, dbparms, dir, dbCon = NULL, ...)
  -> use dbCon (compat opens if missing)
  -> read.register(...)
  -> resolve stage via met.process.stage(...)
  -> download raw, met2cf, standardize, met2model
  -> register outputs in BETY via dbCon
  -> return input_met
```

### Caller References

| Caller function | Location |
|---|---|
| `do_conversions` | `base/workflow/R/do_conversions.R` |
| `kill.tunnel` | `scripts/workflow.bm.R` |
| `status.skip` | `scripts/workflow.pda.R` |
