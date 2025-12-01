# Supported languages

A list of supported languages and examples of their usage.

## Usage

``` r
and_languages
```

## Format

A data frame with 6 variables:

- language:

  The name of the language, possibly with a territory in parentheses

- code:

  The language code

- example_and_2:

  An example of a conjunctive list with two elements in the language

- example_and_4:

  An example of a conjunctive list with four elements in the language

- example_or_2:

  An example of a disjunctive list with two elements in the language

- example_or_4:

  An example of a disjunctive list with four elements in the language

- support:

  Either "full" or "partial". Partially supported languages generally
  localize [`and()`](https://pkg.rossellhayes.com/and/reference/and.md)
  but not [`or()`](https://pkg.rossellhayes.com/and/reference/and.md).

## Source

Language data is derived from the [Unicode Common Locale Data Repository
(CLDR)](https://cldr.unicode.org/)

## Examples

``` r
and_languages
#> # A tibble: 251 × 7
#>    language  code  example_and_2 example_and_4 example_or_2 example_or_4 support
#>    <chr>     <chr> <chr>         <chr>         <chr>        <chr>        <chr>  
#>  1 Afrikaans af    1 en 2        1, 2, 3 en 4  1 of 2       1, 2, 3 of 4 full   
#>  2 Akan      ak    1 ne 2        1, 2, 3, ne 4 1 anaa 2     1, 2, 3, an… full   
#>  3 Albanian  sq    1 dhe 2       1, 2, 3 dhe 4 1 ose 2      1, 2, 3 ose… full   
#>  4 Amharic   am    1 እና 2        1፣ 2፣ 3 እና 4  1 ወይም 2      1፣ 2፣ 3 ወይም… full   
#>  5 Anii      blo   1 na 2        1, 2, 3 na 4  1 koo 2      1, 2, 3 koo… full   
#>  6 Arabic    ar    ‏1 و2‎          ‏1 و2 و3 و4‎    ‏1 أو 2‎       ‏1 أو 2 أو …  full   
#>  7 Armenian  hy    1 և 2         1, 2, 3 և 4   1 կամ 2      1, 2, 3 կամ… full   
#>  8 Assamese  as    1 আৰু 2        1, 2, 3 আৰু 4  1 বা 2       1, 2, 3 বা 4 full   
#>  9 Asturian  ast   1 y 2         1, 2, 3 y 4   1 o 2        1, 2, 3 o 4  full   
#> 10 Azerbaij… az    1 və 2        1, 2, 3 və 4  1 yaxud 2    1, 2, 3, ya… full   
#> # ℹ 241 more rows
```
