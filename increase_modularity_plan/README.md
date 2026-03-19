# Increase Modularity Plan

This directory holds the actively documented modularity/refactor plans that remain after placeholder-only sections were removed. It is no longer a full package-by-package scaffold for every PEcAn package; it is a focused set of plan files for the functions that already have real refactor notes written down.

At the moment, the folder contains `7` active plan files and `52` documented function refactor sections across `base` and `modules`.

## Overview

Each documented function section in these files follows the current planning template:

- `Refactor Summary`
- `Test Refactor`
- `Call Flow Comparison`
- `Refactored Dependency References`
- `Caller References`

Together, these sections capture:

- what the function does now versus the proposed modular form
- which inputs, file reads, file writes, and settings-derived values should be made explicit
- how tests need to change
- how the old and new call flow differ
- which already-documented refactored dependencies this function relies on
- which functions or top-level workflow scripts currently call it

## Layout

- `base/db.md`: refactor plans for documented database/trait workflow functions
- `base/workflow.md`: refactor plans for documented workflow orchestration functions
- `modules/assim.batch.md`: refactor plans for documented batch assimilation functions
- `modules/data.atmosphere.md`: refactor plan for the documented atmospheric data-processing function
- `modules/data.land.md`: refactor plans for documented land-data processing functions
- `modules/meta.analysis.md`: refactor plans for documented meta-analysis workflow functions
- `modules/uncertainty.md`: refactor plans for documented uncertainty, ensemble, and sensitivity workflow functions

## Reading Guide

- Use `Refactor Summary` to understand the intended contract change for a function.
- Use `Test Refactor` to see what coverage or assertions should move with that change.
- Use `Call Flow Comparison` to compare the legacy path with the proposed modular path.
- Use `Refactored Dependency References` to find the source-of-truth plan for other documented functions this one depends on.
- Use `Caller References` to see where the function is invoked today, including named callers and important top-level workflow scripts.
- Treat each markdown file as a source-of-truth plan only for the functions still documented in that file

