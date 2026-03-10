# data.atmosphere Refactor Plan

Package path: `modules/data.atmosphere`

## Package Summary

| Item | Value |
|---|---|
| Package | `data.atmosphere` |
| Layer | `modules` |
| Source path | `modules/data.atmosphere` |
| Functions detected | `144` |

## Function Inventory

- [AirDens](#function-airdens)
- [align.met](#function-alignmet)
- [AmeriFlux_met_ensemble](#function-ameriflux_met_ensemble)
- [arrow_env_vars](#function-arrow_env_vars)
- [Average_ERA5_2_GeoTIFF](#function-average_era5_2_geotiff)
- [build_cf_variables_table_url](#function-build_cf_variables_table_url)
- [cfmet.downscale.daily](#function-cfmetdownscaledaily)
- [cfmet.downscale.subdaily](#function-cfmetdownscalesubdaily)
- [cfmet.downscale.time](#function-cfmetdownscaletime)
- [check_met_coverage_for_fallback](#function-check_met_coverage_for_fallback)
- [check_met_input_file](#function-check_met_input_file)
- [check_unit](#function-check_unit)
- [closest_xy](#function-closest_xy)
- [col2ncvar](#function-col2ncvar)
- [copyvals](#function-copyvals)
- [cos_solar_zenith_angle](#function-cos_solar_zenith_angle)
- [daygroup](#function-daygroup)
- [debias.met](#function-debiasmet)
- [debias.met.regression](#function-debiasmetregression)
- [download.Ameriflux](#function-downloadameriflux)
- [download.Ameriflux.site](#function-downloadamerifluxsite)
- [download.AmerifluxLBL](#function-downloadamerifluxlbl)
- [download.CRUNCEP](#function-downloadcruncep)
- [download.ERA5_cds](#function-downloadera5_cds)
- [download.FACE](#function-downloadface)
- [download.Fluxnet2015](#function-downloadfluxnet2015)
- [download.FluxnetLaThuile](#function-downloadfluxnetlathuile)
- [download.FluxnetLaThuile.site](#function-downloadfluxnetlathuilesite)
- [download.Geostreams](#function-downloadgeostreams)
- [download.GFDL](#function-downloadgfdl)
- [download.GLDAS](#function-downloadgldas)
- [download.MACA](#function-downloadmaca)
- [download.MERRA](#function-downloadmerra)
- [download.MsTMIP_NARR](#function-downloadmstmip_narr)
- [download.NARR](#function-downloadnarr)
- [download.NARR_site](#function-downloadnarr_site)
- [download.NEONmet](#function-downloadneonmet)
- [download.NLDAS](#function-downloadnldas)
- [download.NOAA_GEFS](#function-downloadnoaa_gefs)
- [download.PalEON](#function-downloadpaleon)
- [download.PalEON_ENS](#function-downloadpaleon_ens)
- [download.US_WCr](#function-downloadus_wcr)
- [download.US_Wlef](#function-downloadus_wlef)
- [download_file_shim](#function-download_file_shim)
- [download_grid](#function-download_grid)
- [download_NOAA_GEFS_EFI](#function-download_noaa_gefs_efi)
- [downscale_one_cfmet_day](#function-downscale_one_cfmet_day)
- [downscale_repeat_6hr_to_half_hrly](#function-downscale_repeat_6hr_to_half_hrly)
- [downscale_repeat_6hr_to_hrly](#function-downscale_repeat_6hr_to_hrly)
- [downscale_ShortWave_to_half_hrly](#function-downscale_shortwave_to_half_hrly)
- [downscale_ShortWave_to_hrly](#function-downscale_shortwave_to_hrly)
- [downscale_solar_geom](#function-downscale_solar_geom)
- [downscale_solar_geom_halfhour](#function-downscale_solar_geom_halfhour)
- [downscale_spline_to_half_hrly](#function-downscale_spline_to_half_hrly)
- [downscale_spline_to_hrly](#function-downscale_spline_to_hrly)
- [equation_of_time](#function-equation_of_time)
- [ERA5_met_process](#function-era5_met_process)
- [exner](#function-exner)
- [extract.local.CMIP5](#function-extractlocalcmip5)
- [extract.local.NLDAS](#function-extractlocalnldas)
- [extract.nc](#function-extractnc)
- [extract.success](#function-extractsuccess)
- [gen.subdaily.models](#function-gensubdailymodels)
- [generate_narr_url](#function-generate_narr_url)
- [get.es](#function-getes)
- [get.lv](#function-getlv)
- [get.ncvector](#function-getncvector)
- [get.rh](#function-getrh)
- [get.vpd](#function-getvpd)
- [get_cf_variables_table](#function-get_cf_variables_table)
- [get_clowderauth](#function-get_clowderauth)
- [get_merra_date](#function-get_merra_date)
- [get_NARR_thredds](#function-get_narr_thredds)
- [get_narr_url](#function-get_narr_url)
- [getLatLon](#function-getlatlon)
- [insertPmet](#function-insertpmet)
- [latlon2lcc](#function-latlon2lcc)
- [latlon2narr](#function-latlon2narr)
- [lightME](#function-lightme)
- [lm_ensemble_sims](#function-lm_ensemble_sims)
- [load.cfmet](#function-loadcfmet)
- [merge_met_variable](#function-merge_met_variable)
- [met.conv](#function-metconv)
- [met.process](#function-metprocess)
- [met.process.stage](#function-metprocessstage)
- [met_temporal_downscale.Gaussian_ensemble](#function-met_temporal_downscalegaussian_ensemble)
- [met2CF.ALMA](#function-met2cfalma)
- [met2CF.Ameriflux](#function-met2cfameriflux)
- [met2CF.AmerifluxLBL](#function-met2cfamerifluxlbl)
- [met2CF.csv](#function-met2cfcsv)
- [met2CF.ERA5](#function-met2cfera5)
- [met2CF.FACE](#function-met2cfface)
- [met2CF.Geostreams](#function-met2cfgeostreams)
- [met2CF.NARR](#function-met2cfnarr)
- [met2cf.nc](#function-met2cfnc)
- [met2CF.PalEON](#function-met2cfpaleon)
- [met2CF.PalEONregional](#function-met2cfpaleonregional)
- [metgapfill](#function-metgapfill)
- [metgapfill.NOAA_GEFS](#function-metgapfillnoaa_gefs)
- [model.train](#function-modeltrain)
- [nc.merge](#function-ncmerge)
- [neonmet.getDates](#function-neonmetgetdates)
- [neonmet.getVals](#function-neonmetgetvals)
- [noaa_gefs](#function-noaa_gefs)
- [noaa_gefs_stage](#function-noaa_gefs_stage)
- [noaa_grid_download](#function-noaa_grid_download)
- [noaa_stage2](#function-noaa_stage2)
- [par2ppfd](#function-par2ppfd)
- [permute.nc](#function-permutenc)
- [post_process](#function-post_process)
- [predict_subdaily_met](#function-predict_subdaily_met)
- [prepare_narr_year](#function-prepare_narr_year)
- [process_gridded_noaa_download](#function-process_gridded_noaa_download)
- [qair2rh](#function-qair2rh)
- [qcprecip](#function-qcprecip)
- [qcrh](#function-qcrh)
- [qcshum](#function-qcshum)
- [qcsolar](#function-qcsolar)
- [qctemp](#function-qctemp)
- [qcwind](#function-qcwind)
- [read.register](#function-readregister)
- [read_narr_var](#function-read_narr_var)
- [rh2qair](#function-rh2qair)
- [sat_vapor_pressure](#function-sat_vapor_pressure)
- [save.betas](#function-savebetas)
- [save.model](#function-savemodel)
- [site.lst](#function-sitelst)
- [site_from_tag](#function-site_from_tag)
- [solarMJ2ppfd](#function-solarmj2ppfd)
- [spin.met](#function-spinmet)
- [split_wind](#function-split_wind)
- [step_means](#function-step_means)
- [subdaily_pred](#function-subdaily_pred)
- [substrRight](#function-substrright)
- [sw2par](#function-sw2par)
- [sw2ppfd](#function-sw2ppfd)
- [t2es](#function-t2es)
- [temporal.downscale.functions](#function-temporaldownscalefunctions)
- [temporal_downscale](#function-temporal_downscale)
- [temporal_downscale_half_hour](#function-temporal_downscale_half_hour)
- [unset_arrow_vars](#function-unset_arrow_vars)
- [upscale_met](#function-upscale_met)
- [wide2long](#function-wide2long)
- [write_noaa_gefs_netcdf](#function-write_noaa_gefs_netcdf)

## Function: AirDens

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

## Function: align.met

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

## Function: AmeriFlux_met_ensemble

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

## Function: arrow_env_vars

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

## Function: Average_ERA5_2_GeoTIFF

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

## Function: build_cf_variables_table_url

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

## Function: cfmet.downscale.daily

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

## Function: cfmet.downscale.subdaily

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

## Function: cfmet.downscale.time

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

## Function: check_met_coverage_for_fallback

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

## Function: check_met_input_file

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

## Function: check_unit

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

## Function: closest_xy

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

## Function: col2ncvar

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

## Function: copyvals

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

## Function: cos_solar_zenith_angle

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

## Function: daygroup

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

## Function: debias.met

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

## Function: debias.met.regression

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

## Function: download.Ameriflux

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

## Function: download.Ameriflux.site

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

## Function: download.AmerifluxLBL

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

## Function: download.CRUNCEP

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

## Function: download.ERA5_cds

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

## Function: download.FACE

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

## Function: download.Fluxnet2015

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

## Function: download.FluxnetLaThuile

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

## Function: download.FluxnetLaThuile.site

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

## Function: download.Geostreams

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

## Function: download.GFDL

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

## Function: download.GLDAS

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

## Function: download.MACA

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

## Function: download.MERRA

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

## Function: download.MsTMIP_NARR

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

## Function: download.NARR

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

## Function: download.NARR_site

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

## Function: download.NEONmet

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

## Function: download.NLDAS

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

## Function: download.NOAA_GEFS

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

## Function: download.PalEON

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

## Function: download.PalEON_ENS

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

## Function: download.US_WCr

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

## Function: download.US_Wlef

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

## Function: download_file_shim

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

## Function: download_grid

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

## Function: download_NOAA_GEFS_EFI

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

## Function: downscale_one_cfmet_day

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

## Function: downscale_repeat_6hr_to_half_hrly

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

## Function: downscale_repeat_6hr_to_hrly

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

## Function: downscale_ShortWave_to_half_hrly

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

## Function: downscale_ShortWave_to_hrly

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

## Function: downscale_solar_geom

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

## Function: downscale_solar_geom_halfhour

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

## Function: downscale_spline_to_half_hrly

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

## Function: downscale_spline_to_hrly

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

## Function: equation_of_time

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

## Function: ERA5_met_process

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

## Function: exner

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

## Function: extract.local.CMIP5

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

## Function: extract.local.NLDAS

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

## Function: extract.nc

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

## Function: extract.success

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

## Function: gen.subdaily.models

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

## Function: generate_narr_url

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

## Function: get.es

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

## Function: get.lv

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

## Function: get.ncvector

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

## Function: get.rh

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

## Function: get.vpd

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

## Function: get_cf_variables_table

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

## Function: get_clowderauth

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

## Function: get_merra_date

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

## Function: get_NARR_thredds

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

## Function: get_narr_url

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

## Function: getLatLon

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

## Function: insertPmet

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

## Function: latlon2lcc

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

## Function: latlon2narr

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

## Function: lightME

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

## Function: lm_ensemble_sims

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

## Function: load.cfmet

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

## Function: merge_met_variable

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

## Function: met.conv

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

## Function: met.process

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

## Function: met.process.stage

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

## Function: met_temporal_downscale.Gaussian_ensemble

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

## Function: met2CF.ALMA

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

## Function: met2CF.Ameriflux

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

## Function: met2CF.AmerifluxLBL

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

## Function: met2CF.csv

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

## Function: met2CF.ERA5

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

## Function: met2CF.FACE

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

## Function: met2CF.Geostreams

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

## Function: met2CF.NARR

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

## Function: met2cf.nc

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

## Function: met2CF.PalEON

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

## Function: met2CF.PalEONregional

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

## Function: metgapfill

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

## Function: metgapfill.NOAA_GEFS

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

## Function: model.train

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

## Function: nc.merge

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

## Function: neonmet.getDates

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

## Function: neonmet.getVals

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

## Function: noaa_gefs

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

## Function: noaa_gefs_stage

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

## Function: noaa_grid_download

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

## Function: noaa_stage2

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

## Function: par2ppfd

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

## Function: permute.nc

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

## Function: post_process

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

## Function: predict_subdaily_met

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

## Function: prepare_narr_year

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

## Function: process_gridded_noaa_download

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

## Function: qair2rh

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

## Function: qcprecip

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

## Function: qcrh

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

## Function: qcshum

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

## Function: qcsolar

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

## Function: qctemp

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

## Function: qcwind

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

## Function: read.register

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

## Function: read_narr_var

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

## Function: rh2qair

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

## Function: sat_vapor_pressure

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

## Function: save.betas

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

## Function: save.model

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

## Function: site.lst

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

## Function: site_from_tag

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

## Function: solarMJ2ppfd

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

## Function: spin.met

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

## Function: split_wind

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

## Function: step_means

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

## Function: subdaily_pred

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

## Function: substrRight

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

## Function: sw2par

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

## Function: sw2ppfd

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

## Function: t2es

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

## Function: temporal.downscale.functions

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

## Function: temporal_downscale

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

## Function: temporal_downscale_half_hour

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

## Function: unset_arrow_vars

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

## Function: upscale_met

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

## Function: wide2long

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

## Function: write_noaa_gefs_netcdf

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

