
<!-- README.md is generated from README.Rmd. Please edit that file -->

# and <img src="man/figures/logo.png?raw=TRUE" align="right" height="138" />

<!-- badges: start -->
<!-- [![](https://www.r-pkg.org/badges/version/and?color=brightgreen)](https://cran.r-project.org/package=and) -->

[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blueviolet.svg)](https://cran.r-project.org/web/licenses/MIT)
<!-- [![R build status](https://github.com/rossellhayes/and/workflows/R-CMD-check/badge.svg)](https://github.com/rossellhayes/and/actions) -->
<!-- [![](https://codecov.io/gh/rossellhayes/and/branch/master/graph/badge.svg)](https://app.codecov.io/gh/rossellhayes/and) -->
<!-- [![Dependencies](https://tinyverse.netlify.com/badge/and)](https://cran.r-project.org/package=and) -->
<!-- badges: end -->

**and** constructs language-aware lists in R. It extends the
functionality of functions like `knitr::combine_words()` and
`glue::glue_collapse()` to make “and”-separated and “or”-separated lists
that automatically conform to the user’s R language settings.

## Installation

<!-- You can install the released version of **nombre** from [CRAN](https://CRAN.R-project.org) with: -->
<!-- ``` {r eval = FALSE} -->
<!-- install.packages("nombre") -->
<!-- ``` -->

You can install the development version of **and** from GitHub with:

``` r
# install.packages("pak")
pak::pkg_install("rossellhayes/and")
```

## Usage

`and()` creates “and”-separated lists from vectors.

``` r
names <- c("John", "Paul", "George", "Ringo")
and(names)
#> [1] "John, Paul, George, and Ringo"
```

But the Oxford comma is less common in other varieties of English, what
happens if I change my R language to British English?

``` r
Sys.setenv(LANG = "en_GB")
and(names)
#> [1] "John, Paul, George and Ringo"
```

What about other languages?

``` r
Sys.setenv(LANG = "es")
and(names)
#> [1] "John, Paul, George y Ringo"
Sys.setenv(LANG = "fr")
and(names)
#> [1] "John, Paul, George et Ringo"
Sys.setenv(LANG = "eu")
and(names)
#> [1] "John, Paul, George eta Ringo"
```

### Handling the nuances

Creating a list is not as simple as putting a different word between the
last two items. For example, in Spanish and Italian, the word for “and”
changes depending on the first letter of the next word:

``` r
princess_bride <- c("Wesley", "Fezzik", "Iñigo Montoya")
Sys.setenv(LANG = "es")
and(princess_bride)
#> [1] "Wesley, Fezzik e Iñigo Montoya"
Sys.setenv(LANG = "it")
and(princess_bride)
#> [1] "Wesley, Fezzik e Iñigo Montoya"

the_boss <- c("Bruce Springsteen", "E Street Band")
Sys.setenv(LANG = "es")
and(the_boss)
#> [1] "Bruce Springsteen y E Street Band"
Sys.setenv(LANG = "it")
and(the_boss)
#> [1] "Bruce Springsteen ed E Street Band"
```

### “or”-separated lists

Everything `and()` can do `or()` can do better. Just use `or()` to
create “or”-separated lists with all the same contextual awareness.

``` r
outcomes <- c("win", "lose", "draw")
Sys.setenv(LANG = "en_US")
or(outcomes)
#> [1] "win, lose, or draw"
Sys.setenv(LANG = "es")
or(outcomes)
#> [1] "win, lose o draw"
```

### Hardcoding language

Don’t want the language of you string to depend on the user’s
environment variables? You can explicitly set the language using the
`lang` argument.

``` r
and(names, lang = "en_US")
#> [1] "John, Paul, George, and Ringo"
and(names, lang = "en_GB")
#> [1] "John, Paul, George and Ringo"
and(names, lang = "es")
#> [1] "John, Paul, George y Ringo"
and(names, lang = "fr")
#> [1] "John, Paul, George et Ringo"
```

------------------------------------------------------------------------

Please note that **nombre** is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
