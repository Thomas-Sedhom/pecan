# data.land Refactor Plan

Package path: `modules/data.land`

## Package Summary

| Item | Value |
|---|---|
| Package | `data.land` |
| Layer | `modules` |
| Source path | `modules/data.land` |
| Functions detected | `83` |

## Function Inventory

- [BADM_IC_process](#function-badm_ic_process)
- [buildJAGSdata_InventoryRings](#function-buildjagsdata_inventoryrings)
- [Clean_Tucson](#function-clean_tucson)
- [clip_and_save_raster_file](#function-clip_and_save_raster_file)
- [cohort2pool](#function-cohort2pool)
- [dataone_download](#function-dataone_download)
- [download.SM_CDS](#function-downloadsm_cds)
- [download_NEON_soilmoist](#function-download_neon_soilmoist)
- [download_package_rm](#function-download_package_rm)
- [ens_veg_module](#function-ens_veg_module)
- [EPA_ecoregion_finder](#function-epa_ecoregion_finder)
- [estimate_dirichlet_parameters](#function-estimate_dirichlet_parameters)
- [eto_to_etc](#function-eto_to_etc)
- [eto_to_etc_bism](#function-eto_to_etc_bism)
- [extract.stringCode](#function-extractstringcode)
- [extract_FIA](#function-extract_fia)
- [extract_NEON_veg](#function-extract_neon_veg)
- [extract_SM_CDS](#function-extract_sm_cds)
- [extract_soil_gssurgo](#function-extract_soil_gssurgo)
- [extract_soil_nc](#function-extract_soil_nc)
- [extract_veg](#function-extract_veg)
- [fia.to.psscss](#function-fiatopsscss)
- [format_identifier](#function-format_identifier)
- [from.Tag](#function-fromtag)
- [from.TreeCode](#function-fromtreecode)
- [fuse_plot_treering](#function-fuse_plot_treering)
- [generate_soilgrids_ensemble](#function-generate_soilgrids_ensemble)
- [get.attributes](#function-getattributes)
- [get.ed.file.latlon.text](#function-getedfilelatlontext)
- [get.elevation](#function-getelevation)
- [get.latlonbox](#function-getlatlonbox)
- [get.soil](#function-getsoil)
- [get_resource_map](#function-get_resource_map)
- [get_veg_module](#function-get_veg_module)
- [getnetrc](#function-getnetrc)
- [gSSURGO.Query](#function-gssurgoquery)
- [IC_ISCN_SOC](#function-ic_iscn_soc)
- [ic_process](#function-ic_process)
- [id_resolveable](#function-id_resolveable)
- [InventoryGrowthFusion](#function-inventorygrowthfusion)
- [InventoryGrowthFusionDiagnostics](#function-inventorygrowthfusiondiagnostics)
- [is.land](#function-island)
- [load_veg](#function-load_veg)
- [look_up_fertilizer_components](#function-look_up_fertilizer_components)
- [match_pft](#function-match_pft)
- [match_species_id](#function-match_species_id)
- [matchInventoryRings](#function-matchinventoryrings)
- [mpot2smoist](#function-mpot2smoist)
- [netcdf.writer.BADM](#function-netcdfwriterbadm)
- [om2soc](#function-om2soc)
- [parse.MatrixNames](#function-parsematrixnames)
- [partition_roots](#function-partition_roots)
- [plot2AGB](#function-plot2agb)
- [pool_ic_list2netcdf](#function-pool_ic_list2netcdf)
- [pool_ic_netcdf2list](#function-pool_ic_netcdf2list)
- [prepare_pools](#function-prepare_pools)
- [preprocess_soilgrids_data](#function-preprocess_soilgrids_data)
- [put_veg_module](#function-put_veg_module)
- [Read.IC.info.BADM](#function-readicinfobadm)
- [read.plot](#function-readplot)
- [read.velmex](#function-readvelmex)
- [Read_Tucson](#function-read_tucson)
- [reformat_soil_list](#function-reformat_soil_list)
- [remote.copy.update](#function-remotecopyupdate)
- [sample_ic](#function-sample_ic)
- [sclass](#function-sclass)
- [shp2kml](#function-shp2kml)
- [soc2ocs](#function-soc2ocs)
- [soil.units](#function-soilunits)
- [soil_params](#function-soil_params)
- [soil_params_ensemble_soilgrids](#function-soil_params_ensemble_soilgrids)
- [soil_process](#function-soil_process)
- [soil2netcdf](#function-soil2netcdf)
- [soilgrids_ic_process](#function-soilgrids_ic_process)
- [soilgrids_soilC_extract](#function-soilgrids_soilc_extract)
- [Soilgrids_SoilC_prep](#function-soilgrids_soilc_prep)
- [soilgrids_texture_extraction](#function-soilgrids_texture_extraction)
- [subset_layer](#function-subset_layer)
- [to.Tag](#function-totag)
- [to.TreeCode](#function-totreecode)
- [validate_events_json](#function-validate_events_json)
- [write_ic](#function-write_ic)
- [write_veg](#function-write_veg)

## Function: BADM_IC_process

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

## Function: buildJAGSdata_InventoryRings

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

## Function: Clean_Tucson

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

## Function: clip_and_save_raster_file

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

## Function: cohort2pool

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

## Function: dataone_download

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

## Function: download.SM_CDS

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

## Function: download_NEON_soilmoist

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

## Function: download_package_rm

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

## Function: ens_veg_module

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

## Function: EPA_ecoregion_finder

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

## Function: estimate_dirichlet_parameters

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

## Function: eto_to_etc

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

## Function: eto_to_etc_bism

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

## Function: extract.stringCode

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

## Function: extract_FIA

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

## Function: extract_NEON_veg

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

## Function: extract_SM_CDS

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

## Function: extract_soil_gssurgo

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

## Function: extract_soil_nc

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

## Function: extract_veg

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

## Function: fia.to.psscss

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

## Function: format_identifier

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

## Function: from.Tag

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

## Function: from.TreeCode

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

## Function: fuse_plot_treering

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

## Function: generate_soilgrids_ensemble

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

## Function: get.attributes

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

## Function: get.ed.file.latlon.text

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

## Function: get.elevation

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

## Function: get.latlonbox

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

## Function: get.soil

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

## Function: get_resource_map

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

## Function: get_veg_module

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

## Function: getnetrc

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

## Function: gSSURGO.Query

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

## Function: IC_ISCN_SOC

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

## Function: ic_process

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

## Function: id_resolveable

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

## Function: InventoryGrowthFusion

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

## Function: InventoryGrowthFusionDiagnostics

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

## Function: is.land

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

## Function: load_veg

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

## Function: look_up_fertilizer_components

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

## Function: match_pft

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

## Function: match_species_id

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

## Function: matchInventoryRings

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

## Function: mpot2smoist

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

## Function: netcdf.writer.BADM

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

## Function: om2soc

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

## Function: parse.MatrixNames

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

## Function: partition_roots

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

## Function: plot2AGB

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

## Function: pool_ic_list2netcdf

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

## Function: pool_ic_netcdf2list

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

## Function: prepare_pools

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

## Function: preprocess_soilgrids_data

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

## Function: put_veg_module

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

## Function: Read.IC.info.BADM

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

## Function: read.plot

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

## Function: read.velmex

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

## Function: Read_Tucson

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

## Function: reformat_soil_list

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

## Function: remote.copy.update

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

## Function: sample_ic

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

## Function: sclass

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

## Function: shp2kml

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

## Function: soc2ocs

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

## Function: soil.units

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

## Function: soil_params

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

## Function: soil_params_ensemble_soilgrids

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

## Function: soil_process

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

## Function: soil2netcdf

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

## Function: soilgrids_ic_process

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

## Function: soilgrids_soilC_extract

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

## Function: Soilgrids_SoilC_prep

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

## Function: soilgrids_texture_extraction

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

## Function: subset_layer

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

## Function: to.Tag

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

## Function: to.TreeCode

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

## Function: validate_events_json

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

## Function: write_ic

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

## Function: write_veg

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

