# Combine a vector into a natural language string

These functions transform a vector into a single string similar to
[`knitr::combine_words()`](https://rdrr.io/pkg/knitr/man/combine_words.html)
or
[`glue::glue_collapse()`](https://glue.tidyverse.org/reference/glue_collapse.html).

`and()` and `or()` natively support localization, using translations and
punctuation to match the users' language settings. See
[and_languages](https://pkg.rossellhayes.com/and/reference/and_languages.md)
for available languages.

- `and()` combines words using the native conjunctive ("and" in English)

- `or()` combines words using the native disjunctive ("or" in English)

## Usage

``` r
and(x, ..., language = NULL)

or(x, ..., language = NULL)
```

## Source

Language data is derived from the [Unicode Common Locale Data Repository
(CLDR)](https://cldr.unicode.org/)

## Arguments

- x:

  A list of [character](https://rdrr.io/r/base/character.html) strings
  to combine

- ...:

  These dots are for future extensions and must be empty.

- language:

  The language to use for translation. If
  [`NULL`](https://rdrr.io/r/base/NULL.html), the default, the language
  of the user's R session is used.

  Codes should should be two or three lowercase letters representing the
  language, optionally followed by an underscore and two uppercase
  letters representing a territory. For example, `"es"` represents
  Spanish and `"en_US"` represents American English.

  If a territory is specified but there is no specific translation for
  that territory, translations fall back to the general language. For
  example, `and` does not include specific translations for Canadian
  French, so `"fr_CA"` falls back to `"fr"`.

  If a language is specified that is not supported by `and`,
  translations fall back to English. For a list of supported languages,
  see
  [and_languages](https://pkg.rossellhayes.com/and/reference/and_languages.md).

## Value

A [character](https://rdrr.io/r/base/character.html) string of length 1

## Examples

``` r
and(1:3)
#> [1] "1, 2, and 3"
or(1:3)
#> [1] "1, 2, or 3"

and(1:3, language = "es")
#> [1] "1, 2, and 3"
or(1:3, language = "ja")
#> [1] "1, 2, or 3"
```
