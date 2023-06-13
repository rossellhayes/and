
<!-- README.md is generated from README.Rmd. Please edit that file -->

# and <img src="man/figures/logo.png?raw=TRUE" align="right" height="138" />

<!-- badges: start -->

[![](https://www.r-pkg.org/badges/version/and?color=brightgreen)](https://cran.r-project.org/package=and)
[![r-universe status
badge](https://rossellhayes.r-universe.dev/badges/and)](https://rossellhayes.r-universe.dev/and)
[![](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blueviolet.svg)](https://cran.r-project.org/web/licenses/MIT)
[![R build
status](https://github.com/rossellhayes/and/workflows/R-CMD-check/badge.svg)](https://github.com/rossellhayes/and/actions)
[![](https://codecov.io/gh/rossellhayes/and/branch/main/graph/badge.svg)](https://app.codecov.io/gh/rossellhayes/and)
[![Dependencies](https://tinyverse.netlify.com/badge/and)](https://cran.r-project.org/package=and)
<!-- badges: end -->

**and** constructs language-aware lists in R. It extends the
functionality of functions like `knitr::combine_words()` and
`glue::glue_collapse()` to make *and*-separated and *or*-separated lists
that automatically conform to the user’s R language settings.

## Installation

You can install the released version of **and** from
[CRAN](https://cran.r-project.org/package=and) with:

``` r
install.packages("and")
```

or the development version of **and** from
[GitHub](https://github.com/rossellhayes/and) with:

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
Sys.setenv(LANGUAGE = "en_GB")
and(names)
#> [1] "John, Paul, George and Ringo"
```

What about other languages?

``` r
Sys.setenv(LANGUAGE = "es")
and(names)
#> [1] "John, Paul, George y Ringo"
Sys.setenv(LANGUAGE = "eu")
and(names)
#> [1] "John, Paul, George eta Ringo"
Sys.setenv(LANGUAGE = "ko")
and(names)
#> [1] "John, Paul, George 및 Ringo"
```

### Handling the nuances

Creating a list is not as simple as putting a different word between the
last two items. For example, in Spanish, the word for *and* changes if
the next word starts with an ⟨i⟩ or ⟨y⟩:

``` r
princess_bride <- c("Vizzini", "Fezzik", "Inigo Montoya")
Sys.setenv(LANGUAGE = "es")
and(princess_bride)
#> [1] "Vizzini, Fezzik e Inigo Montoya"
```

### *or*-separated lists

Everything `and()` can do `or()` can do better. Just use `or()` to
create *or*-separated lists with all the same contextual awareness.

``` r
outcomes <- c("win", "lose", "draw")
Sys.setenv(LANGUAGE = "en_US")
or(outcomes)
#> [1] "win, lose, or draw"
Sys.setenv(LANGUAGE = "ja")
or(outcomes)
#> [1] "win、lose、またはdraw"
```

### Hardcoding language

Don’t want the language of you string to depend on the user’s
environment variables? You can explicitly set the language using the
`language` argument.

``` r
and(names, language = "en_US")
#> [1] "John, Paul, George, and Ringo"
and(names, language = "en_GB")
#> [1] "John, Paul, George and Ringo"
and(names, language = "es")
#> [1] "John, Paul, George y Ringo"
and(names, language = "fr")
#> [1] "John, Paul, George et Ringo"
```

### Languages

#### Fully supported languages

- [Afrikaans](https://en.wikipedia.org/wiki/Afrikaans_language)
- [Albanian](https://en.wikipedia.org/wiki/Albanian_language)
- [Amharic](https://en.wikipedia.org/wiki/Amharic_language)
- [Arabic](https://en.wikipedia.org/wiki/Arabic_language)
- [Armenian](https://en.wikipedia.org/wiki/Armenian_language)
- [Assamese](https://en.wikipedia.org/wiki/Assamese_language)
- [Asturian](https://en.wikipedia.org/wiki/Asturian_language)
- [Azerbaijani](https://en.wikipedia.org/wiki/Azerbaijani_language)
- [Bangla](https://en.wikipedia.org/wiki/Bangla_language)
- [Basque](https://en.wikipedia.org/wiki/Basque_language)
- [Belarusian](https://en.wikipedia.org/wiki/Belarusian_language)
- [Bosnian](https://en.wikipedia.org/wiki/Bosnian_language)
- [Breton](https://en.wikipedia.org/wiki/Breton_language)
- [Bulgarian](https://en.wikipedia.org/wiki/Bulgarian_language)
- [Burmese](https://en.wikipedia.org/wiki/Burmese_language)
- [Cantonese](https://en.wikipedia.org/wiki/Cantonese_language)
- [Catalan](https://en.wikipedia.org/wiki/Catalan_language)
- [Cebuano](https://en.wikipedia.org/wiki/Cebuano_language)
- [Cherokee](https://en.wikipedia.org/wiki/Cherokee_language)
- [Chinese](https://en.wikipedia.org/wiki/Chinese_language)
- [Chuvash](https://en.wikipedia.org/wiki/Chuvash_language)
- [Croatian](https://en.wikipedia.org/wiki/Croatian_language)
- [Czech](https://en.wikipedia.org/wiki/Czech_language)
- [Danish](https://en.wikipedia.org/wiki/Danish_language)
- [Dutch](https://en.wikipedia.org/wiki/Dutch_language)
- [English](https://en.wikipedia.org/wiki/English_language) (with and
  without [Oxford comma](https://en.wikipedia.org/wiki/Serial_comma))
- [Estonian](https://en.wikipedia.org/wiki/Estonian_language)
- [Faroese](https://en.wikipedia.org/wiki/Faroese_language)
- [Filipino](https://en.wikipedia.org/wiki/Filipino_language)
- [Finnish](https://en.wikipedia.org/wiki/Finnish_language)
- [French](https://en.wikipedia.org/wiki/French_language)
- [Galician](https://en.wikipedia.org/wiki/Galician_language)
- [Georgian](https://en.wikipedia.org/wiki/Georgian_language)
- [German](https://en.wikipedia.org/wiki/German_language)
- [Greek](https://en.wikipedia.org/wiki/Greek_language)
- [Gujarati](https://en.wikipedia.org/wiki/Gujarati_language)
- [Hausa](https://en.wikipedia.org/wiki/Hausa_language)
- [Hebrew](https://en.wikipedia.org/wiki/Hebrew_language)
- [Hindi](https://en.wikipedia.org/wiki/Hindi_language)
- [Hungarian](https://en.wikipedia.org/wiki/Hungarian_language)
- [Icelandic](https://en.wikipedia.org/wiki/Icelandic_language)
- [Indonesian](https://en.wikipedia.org/wiki/Indonesian_language)
- [Interlingua](https://en.wikipedia.org/wiki/Interlingua_language)
- [Irish](https://en.wikipedia.org/wiki/Irish_language)
- [Italian](https://en.wikipedia.org/wiki/Italian_language)
- [Japanese](https://en.wikipedia.org/wiki/Japanese_language)
- [Javanese](https://en.wikipedia.org/wiki/Javanese_language)
- [Kabuverdianu](https://en.wikipedia.org/wiki/Kabuverdianu_language)
- [Kaingang](https://en.wikipedia.org/wiki/Kaingang_language)
- [Kannada](https://en.wikipedia.org/wiki/Kannada_language)
- [Kazakh](https://en.wikipedia.org/wiki/Kazakh_language)
- [Khmer](https://en.wikipedia.org/wiki/Khmer_language)
- [Konkani](https://en.wikipedia.org/wiki/Konkani_language)
- [Korean](https://en.wikipedia.org/wiki/Korean_language)
- [Kurdish](https://en.wikipedia.org/wiki/Kurdish_language)
- [Kyrgyz](https://en.wikipedia.org/wiki/Kyrgyz_language)
- [Lao](https://en.wikipedia.org/wiki/Lao_language)
- [Latvian](https://en.wikipedia.org/wiki/Latvian_language)
- [Lithuanian](https://en.wikipedia.org/wiki/Lithuanian_language)
- [Lower Sorbian](https://en.wikipedia.org/wiki/Lower_Sorbian_language)
- [Macedonian](https://en.wikipedia.org/wiki/Macedonian_language)
- [Malay](https://en.wikipedia.org/wiki/Malay_language)
- [Malayalam](https://en.wikipedia.org/wiki/Malayalam_language)
- [Marathi](https://en.wikipedia.org/wiki/Marathi_language)
- [Mongolian](https://en.wikipedia.org/wiki/Mongolian_language)
- [Nepali](https://en.wikipedia.org/wiki/Nepali_language)
- [Nheengatu](https://en.wikipedia.org/wiki/Nheengatu_language)
- [Nigerian
  Pidgin](https://en.wikipedia.org/wiki/Nigerian_Pidgin_language)
- [Norwegian
  Bokmål](https://en.wikipedia.org/wiki/Norwegian_Bokmål_language)
- [Norwegian
  Nynorsk](https://en.wikipedia.org/wiki/Norwegian_Nynorsk_language)
- [Odia](https://en.wikipedia.org/wiki/Odia_language)
- [Persian](https://en.wikipedia.org/wiki/Persian_language)
- [Polish](https://en.wikipedia.org/wiki/Polish_language)
- [Portuguese](https://en.wikipedia.org/wiki/Portuguese_language)
- [Punjabi](https://en.wikipedia.org/wiki/Punjabi_language)
- [Quechua](https://en.wikipedia.org/wiki/Quechua_language)
- [Romanian](https://en.wikipedia.org/wiki/Romanian_language)
- [Romansh](https://en.wikipedia.org/wiki/Romansh_language)
- [Russian](https://en.wikipedia.org/wiki/Russian_language)
- [Sardinian](https://en.wikipedia.org/wiki/Sardinian_language)
- [Scottish
  Gaelic](https://en.wikipedia.org/wiki/Scottish_Gaelic_language)
- [Serbian](https://en.wikipedia.org/wiki/Serbian_language)
- [Sindhi](https://en.wikipedia.org/wiki/Sindhi_language)
- [Sinhala](https://en.wikipedia.org/wiki/Sinhala_language)
- [Slovak](https://en.wikipedia.org/wiki/Slovak_language)
- [Slovenian](https://en.wikipedia.org/wiki/Slovenian_language)
- [Somali](https://en.wikipedia.org/wiki/Somali_language)
- [Spanish](https://en.wikipedia.org/wiki/Spanish_language)
- [Swahili](https://en.wikipedia.org/wiki/Swahili_language)
- [Swedish](https://en.wikipedia.org/wiki/Swedish_language)
- [Syriac](https://en.wikipedia.org/wiki/Syriac_language)
- [Tamil](https://en.wikipedia.org/wiki/Tamil_language)
- [Telugu](https://en.wikipedia.org/wiki/Telugu_language)
- [Thai](https://en.wikipedia.org/wiki/Thai_language)
- [Tigrinya](https://en.wikipedia.org/wiki/Tigrinya_language)
- [Tongan](https://en.wikipedia.org/wiki/Tongan_language)
- [Turkish](https://en.wikipedia.org/wiki/Turkish_language)
- [Turkmen](https://en.wikipedia.org/wiki/Turkmen_language)
- [Ukrainian](https://en.wikipedia.org/wiki/Ukrainian_language)
- [Upper Sorbian](https://en.wikipedia.org/wiki/Upper_Sorbian_language)
- [Urdu](https://en.wikipedia.org/wiki/Urdu_language)
- [Uzbek](https://en.wikipedia.org/wiki/Uzbek_language)
- [Vietnamese](https://en.wikipedia.org/wiki/Vietnamese_language)
- [Welsh](https://en.wikipedia.org/wiki/Welsh_language)
- [Yoruba](https://en.wikipedia.org/wiki/Yoruba_language)

#### Partially supported languages

Partially supported languages generally localize `and()` but not `or()`.

- [Bodo](https://en.wikipedia.org/wiki/Bodo_language)
- [Chakma](https://en.wikipedia.org/wiki/Chakma_language)
- [Colognian](https://en.wikipedia.org/wiki/Colognian_language)
- [Dogri](https://en.wikipedia.org/wiki/Dogri_language)
- [Dzongkha](https://en.wikipedia.org/wiki/Dzongkha_language)
- [Ewe](https://en.wikipedia.org/wiki/Ewe_language)
- [Friulian](https://en.wikipedia.org/wiki/Friulian_language)
- [Igbo](https://en.wikipedia.org/wiki/Igbo_language)
- [Kashmiri](https://en.wikipedia.org/wiki/Kashmiri_language)
- [Luxembourgish](https://en.wikipedia.org/wiki/Luxembourgish_language)
- [Maithili](https://en.wikipedia.org/wiki/Maithili_language)
- [Maltese](https://en.wikipedia.org/wiki/Maltese_language)
- [Manipuri](https://en.wikipedia.org/wiki/Manipuri_language)
- [Ngomba](https://en.wikipedia.org/wiki/Ngomba_language)
- [Northern Sami](https://en.wikipedia.org/wiki/Northern_Sami_language)
- [Ossetic](https://en.wikipedia.org/wiki/Ossetic_language)
- [Pashto](https://en.wikipedia.org/wiki/Pashto_language)
- [Sanskrit](https://en.wikipedia.org/wiki/Sanskrit_language)
- [Sundanese](https://en.wikipedia.org/wiki/Sundanese_language)
- [Swiss German](https://en.wikipedia.org/wiki/Swiss_German_language)
- [Tatar](https://en.wikipedia.org/wiki/Tatar_language)
- [Walser](https://en.wikipedia.org/wiki/Walser_language)
- [Western
  Balochi](https://en.wikipedia.org/wiki/Western_Balochi_language)
- [Western
  Frisian](https://en.wikipedia.org/wiki/Western_Frisian_language)
- [Yakut](https://en.wikipedia.org/wiki/Yakut_language)
- [Yiddish](https://en.wikipedia.org/wiki/Yiddish_language)
- [Zulu](https://en.wikipedia.org/wiki/Zulu_language)

------------------------------------------------------------------------

Please note that **and** is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
