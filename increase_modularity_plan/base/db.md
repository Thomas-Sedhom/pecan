## Function Inventory

- [get.trait.data](#function-gettraitdata)
- [get.trait.data.pft](#function-gettraitdatapft)

## Function: get.trait.data

### Refactor Summary


| Aspect                  | Old                                                                                                                                                            | New                                                                                                                                                 |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `get.trait.data(pfts, modeltype, dbfiles, database, forceupdate, ..., input_file = NULL)`                                                                      | `get.trait.data(pfts, modeltype, trait.names, trait_data_flat = NULL, dbcon = NULL, ...)`                                                           |
| Load files              | Opened DB internally and optionally read flat trait/prior data from `input_file`                                                                               | No strict-path workflow file load; optional flat data is passed as `trait_data_flat` and query outputs are prepared explicitly                      |
| Save files              | Delegated persistence to downstream per-PFT logic that wrote workflow artifacts                                                                                | Returns `trait_inputs_by_pft` and metadata; no strict-path file writing                                                                             |
| Settings-derived inputs | Consumed DB-related settings-derived inputs indirectly through callers                                                                                         | Uses only required values already extracted by the wrapper/caller, such as `pfts`, `modeltype`, `trait.names`, and optional `dbcon`                 |
| Flow                    | Opened/closed DB internally, optionally read flat files internally, looped over PFTs, and called `get.trait.data.pft()` as part of the same orchestration step | Becomes the preparation step that builds explicit per-PFT inputs and returns them without calling `get.trait.data.pft()` in the strict modular path |
| Return                  | List of updated PFTs                                                                                                                                           | `trait_inputs_by_pft` plus metadata                                                                                                                 |


### Test Refactor


| Test area                         | Legacy coverage                                                               | Required update                                                                                         |
| --------------------------------- | ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Happy path                        | Existing tests focused on side effects and downstream workflow behavior       | Add tests that the primary path returns `trait_inputs_by_pft` directly                                  |
| Edge cases                        | Input-file and DB fallback behavior were mixed into the same execution path   | Add tests for explicit `trait_data_flat` handling and deprecated legacy parameter fallback              |
| Side effects / integration points | Calls into `get.trait.data.pft()` and file-writing behavior were not isolated | Assert that the primary path does not call `get.trait.data.pft()` and performs no workflow-file writing |


### Call Flow Comparison

Old flow:

```text
get.trait.data(pfts, modeltype, dbfiles, database, forceupdate, ..., input_file = NULL)
  -> db.open(database) OR read input_file CSV
  -> loop over pfts
      -> get.trait.data.pft(...)
      -> write/register outputs downstream
  -> db.close(...)
```

New flow:

```text
get.trait.data(pfts, modeltype, trait.names, trait_data_flat = NULL, dbcon = NULL, ...)
  -> build or normalize per-PFT input objects
  -> return list(trait_inputs_by_pft = ..., metadata = ...)
  -> no per-PFT workflow call in strict path
```

### Caller References


| Caller function            | Location                                           |
| -------------------------- | -------------------------------------------------- |
| `get_pft`                  | `base/db/tests/testthat/test-get.trait.data.pft.R` |
| `runModule.get.trait.data` | `base/workflow/R/runModule.get.trait.data.R`       |
| `kill.tunnel`              | `scripts/workflow.bm.R`                            |
| `status.skip`              | `scripts/workflow.pda.R`                           |
| `runmeta`                  | `tests/testpfts.R`                                 |


## Function: get.trait.data.pft

### Refactor Summary


| Aspect                  | Old                                                                                                                                             | New                                                                                                                                                         |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Parameters              | `pft + modeltype + dbfiles + dbcon + trait.names` with internal queries, reuse checks, and file writes                                          | Explicit `pft, pft_members, prior.distns, trait.data, forceupdate` plus optional `write_outputs`, `register_outputs`, `dbfiles`, `posteriorid`, and `dbcon` |
| Load files              | Loaded legacy workflow files during reuse/update checks (`prior.distns.Rdata`, `trait.data.Rdata`, membership CSVs)                             | No strict-path legacy file load; all required objects are passed explicitly                                                                                 |
| Save files              | Wrote membership/prior/trait workflow files and optionally registered them in DB storage                                                        | Returns structured per-PFT payload including `files_written` and `registered_files`; wrapper-controlled persistence remains explicit                        |
| Settings-derived inputs | Depended on settings-derived DB/file context passed indirectly through callers                                                                  | Uses only explicit per-PFT objects and optional wrapper-supplied persistence controls                                                                       |
| Flow                    | Queried DB, loaded legacy files for reuse checks, wrote workflow artifacts, and optionally registered outputs in DB storage inside one function | Primary path is object-driven and focuses on one PFT; optional workflow-file writing and DB registration remain explicit wrapper controls                   |
| Return                  | Updated `pft` only                                                                                                                              | `pft`, `results`, `files_written`, `registered_files`, and metadata                                                                                         |


### Test Refactor


| Test area                         | Legacy coverage                                                         | Required update                                                                                                              |
| --------------------------------- | ----------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| Happy path                        | Current tests center on side effects and implicit DB/file behavior      | Add tests that strict-path calls require explicit `pft_members`, `prior.distns`, and `trait.data`                            |
| Edge cases                        | Legacy reuse checks and compatibility loads dominated the function body | Add tests that the strict path does not load legacy workflow files and that optional write/register controls remain explicit |
| Side effects / integration points | DB registration and file writing were inseparable from computation      | Assert structured per-PFT return payloads and wrapper-only persistence behavior                                              |


### Call Flow Comparison

Old flow:

```text
get.trait.data.pft(pft, ...)
  -> query_pfts
  -> query.pft_species / query.pft_cultivars
  -> query.priors
  -> query.traits(update.check.only = TRUE/FALSE)
  -> load prior.distns.Rdata, trait.data.Rdata, membership CSV
  -> write workflow files
  -> optionally register outputs in DB storage
```

New flow:

```text
get.trait.data.pft(pft, pft_members, prior.distns, trait.data, ...)
  -> operate from explicit objects
  -> optionally write workflow files
  -> optionally register files in DB storage
  -> return structured per-PFT payload
```

### Caller References


| Caller function  | Location                                           |
| ---------------- | -------------------------------------------------- |
| `get.trait.data` | `base/db/R/get.trait.data.R`                       |
| `get_pft`        | `base/db/tests/testthat/test-get.trait.data.pft.R` |


