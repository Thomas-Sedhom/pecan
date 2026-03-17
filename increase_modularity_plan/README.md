# Increase Modularity Plan

This directory contains planning documents for package-by-package function refactors across `base`, `modules`, and `models`.

## Overview

Each package file in this folder is the planning space for refactoring the functions that currently exist in that package. For each function, the plan should capture:

- the refactor summary table
- the old vs new load-file behavior
- the old vs new save-file behavior
- the old settings-object usage vs the new required settings-derived inputs
- the old vs new call flow
- the test changes required by the refactor
- the dependency references to other refactored functions

Call dependencies should be tracked through the `Refactored Dependency References` table inside each function section. If `func1` changes because `func2` was already refactored somewhere else, do not repeat the full `func2` refactor inside `func1`. Link to the source-of-truth function section where `func2` is documented, then describe only what `func1` must change as a caller.

## Layout

- `base/`: one markdown file per package under `base`
- `modules/`: one markdown file per package under `modules`
- `models/`: one markdown file per package under `models`

## How To Use These Files

- Fill each function section as you design that refactor.
- Use the `Refactor Summary` table for old vs new parameters, load-file behavior, save-file behavior, settings-derived inputs, flow, and return values.
- Update `Test Refactor` with the expected test changes driven by the new behavior.
- Use `Call Flow Comparison` for a simple old-graph vs new-graph function call sketch.
- Use `Refactored Dependency References` to point to another function plan instead of repeating already-documented dependency refactor logic.
