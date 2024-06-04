
<!-- README.md is generated from README.Rmd. Please edit that file -->

# FoReco 0.2.6 <img src="man/figures/logo.svg" alt="logo" align="right" width="150" style="border: none; float: right;"/>

**Warning: This package version is no longer supported. Please upgrade
to FoReco 1.0, which includes significant changes and is not compatible
with previous versions.**

The **FoReco** (**Fo**recast **Reco**nciliation) package is designed for
forecast reconciliation, a **post-forecasting** process aimed to improve
the accuracy of the base forecasts for a system of linearly constrained
(e.g. hierarchical/grouped) time series.

It offers classical (bottom-up and top-down), and modern (optimal and
heuristic combination) forecast reconciliation procedures for
cross-sectional, temporal, and cross-temporal linearly constrained time
series.

The main functions are:

- `htsrec()`: cross-sectional (contemporaneous) forecast reconciliation.
- `thfrec()`: forecast reconciliation for a single time series through
  temporal hierarchies.
- `lccrec()`: level conditional forecast reconciliation for genuine
  hierarchical/grouped time series.
- `tdrec()`: top-down (cross-sectional, temporal, cross-temporal)
  forecast reconciliation for genuine hierarchical/grouped time series.
- `ctbu()`: bottom-up cross-temporal forecast reconciliation.
- `tcsrec()`: heuristic first-temporal-then-cross-sectional
  cross-temporal forecast reconciliation.
- `cstrec()`: heuristic first-cross-sectional-then-temporal
  cross-temporal forecast reconciliation.
- `iterec()`: heuristic iterative cross-temporal forecast
  reconciliation.
- `octrec()`: optimal combination cross-temporal forecast
  reconciliation.

## Installation

You can also install from [Github](https://github.com/daniGiro/FoReco)

``` r
# install.packages("devtools")
devtools::install_github("daniGiro/FoReco026")
```

## Links

- Source code: <https://github.com/daniGiro/FoReco026>
- Site documentation: <https://danigiro.github.io/FoReco026/>

## Getting help

If you encounter a clear bug, please file a minimal reproducible example
on [GitHub](https://github.com/daniGiro/FoReco/issues).
