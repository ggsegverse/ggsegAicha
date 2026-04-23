

<!-- README.md is generated from README.qmd. Please edit that file -->

# ggsegAicha <img src='man/figures/logo.png' align="right" height="138.5" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/ggsegverse/ggsegAicha/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ggsegverse/ggsegAicha/actions/workflows/R-CMD-check.yaml)
[![r-universe](https://ggseg.r-universe.dev/badges/ggsegAicha.png)](https://ggseg.r-universe.dev/ggsegAicha)
<!-- badges: end -->

This package contains dataset for plotting the AICHA atlas for ggseg.

Joliot M, Jobard G, Naveau M, Delcroix N, Petit L, Zago L, … &
Tzourio-Mazoyer N (2015). AICHA: An atlas of intrinsic connectivity of
homotopic areas. *Journal of Neuroscience Methods*, 254, 46-59.

## Installation

We recommend installing the ggseg-atlases through the ggseg
[r-universe](https://ggseg.r-universe.dev/ui#builds):

``` r
options(repos = c(
  ggseg = "https://ggseg.r-universe.dev",
  CRAN = "https://cloud.r-project.org"
))

install.packages("ggsegAicha")
```

You can install this package from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("ggsegverse/ggsegAicha")
```

## AICHA atlas

``` r
library(ggseg)
library(ggsegAicha)

plot(aicha())
```

<img src="man/figures/README-aicha-1.png" style="width:100.0%" />

## Data source

Joliot M, Jobard G, Naveau M, Delcroix N, Petit L, Zago L, … &
Tzourio-Mazoyer N (2015). AICHA: An atlas of intrinsic connectivity of
homotopic areas. *Journal of Neuroscience Methods*, 254, 46-59.
