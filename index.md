# and

**and** constructs language-aware lists in R. It extends the
functionality of functions like
[`knitr::combine_words()`](https://rdrr.io/pkg/knitr/man/combine_words.html)
and
[`glue::glue_collapse()`](https://glue.tidyverse.org/reference/glue_collapse.html)
to make *and*-separated and *or*-separated lists that automatically
conform to the user’s R language settings.

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

[`and()`](https://pkg.rossellhayes.com/and/reference/and.md) creates
“and”-separated lists from vectors.

``` r
names <- c("John", "Paul", "George", "Ringo")
and(names)
#> [1] "John, Paul, George, and Ringo"
```

But the Oxford comma is less common in other varieties of English, what
happens if I change my R language to British English?

``` r
local_language("en_GB")
and(names)
#> [1] "John, Paul, George and Ringo"
```

What about other languages?

``` r
local_language("es")
and(names)
#> [1] "John, Paul, George y Ringo"

local_language("eu")
and(names)
#> [1] "John, Paul, George eta Ringo"

local_language("ko")
and(names)
#> [1] "John, Paul, George 및 Ringo"
```

### Handling the nuances

Creating a list is not as simple as putting a different word between the
last two items. For example, in Spanish, the word for *and* changes if
the next word starts with an ⟨i⟩ or ⟨y⟩:

``` r
princess_bride <- c("Vizzini", "Fezzik", "Inigo Montoya")
local_language("es")
and(princess_bride)
#> [1] "Vizzini, Fezzik e Inigo Montoya"
```

Special rules like this are implemented for Spanish, Italian, Welsh, and
Luxembourgish.

### *or*-separated lists

Everything [`and()`](https://pkg.rossellhayes.com/and/reference/and.md)
can do [`or()`](https://pkg.rossellhayes.com/and/reference/and.md) can
do better. Just use
[`or()`](https://pkg.rossellhayes.com/and/reference/and.md) to create
*or*-separated lists with all the same contextual awareness.

``` r
outcomes <- c("win", "lose", "draw")
local_language("en_US")
or(outcomes)
#> [1] "win, lose, or draw"

local_language("ja")
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

| Language                                                                                                                       | Code             | *and* example    | *or* example               |
|:-------------------------------------------------------------------------------------------------------------------------------|:-----------------|:-----------------|:---------------------------|
| [Afrikaans](https://en.wikipedia.org/wiki/Afrikaans_language)                                                                  | `af`             | 1, 2, 3 en 4     | 1, 2, 3 of 4               |
| [Akan](https://en.wikipedia.org/wiki/Akan_language)                                                                            | `ak`             | 1, 2, 3, ne 4    | 1, 2, 3, anaa 4            |
| [Albanian](https://en.wikipedia.org/wiki/Albanian_language)                                                                    | `sq`             | 1, 2, 3 dhe 4    | 1, 2, 3 ose 4              |
| [Amharic](https://en.wikipedia.org/wiki/Amharic_language)                                                                      | `am`             | 1፣ 2፣ 3 እና 4     | 1፣ 2፣ 3 ወይም 4              |
| [Anii](https://en.wikipedia.org/wiki/Anii_language)                                                                            | `blo`            | 1, 2, 3 na 4     | 1, 2, 3 koo 4              |
| [Arabic](https://en.wikipedia.org/wiki/Arabic_language)                                                                        | `ar`             | ‏1 و2 و3 و4‎       | ‏1 أو 2 أو 3 أو 4‎           |
| [Armenian](https://en.wikipedia.org/wiki/Armenian_language)                                                                    | `hy`             | 1, 2, 3 և 4      | 1, 2, 3 կամ 4              |
| [Assamese](https://en.wikipedia.org/wiki/Assamese_language)                                                                    | `as`             | 1, 2, 3 আৰু 4     | 1, 2, 3 বা 4               |
| [Asturian](https://en.wikipedia.org/wiki/Asturian_language)                                                                    | `ast`            | 1, 2, 3 y 4      | 1, 2, 3 o 4                |
| [Azerbaijani](https://en.wikipedia.org/wiki/Azerbaijani_language)                                                              | `az`             | 1, 2, 3 və 4     | 1, 2, 3, yaxud 4           |
| [Bangla](https://en.wikipedia.org/wiki/Bangla_language)                                                                        | `bn`             | 1, 2, 3 এবং 4    | 1, 2, 3, বা 4              |
| [Bashkir](https://en.wikipedia.org/wiki/Bashkir_language)                                                                      | `ba`             | 1, 2, 3 һәм 4    | 1, 2, 3 йәки 4             |
| [Basque](https://en.wikipedia.org/wiki/Basque_language)                                                                        | `eu`             | 1, 2, 3 eta 4    | 1, 2, 3 edo 4              |
| [Belarusian](https://en.wikipedia.org/wiki/Belarusian_language)                                                                | `be`             | 1, 2, 3 і 4      | 1, 2, 3 ці 4               |
| [Bosnian](https://en.wikipedia.org/wiki/Bosnian_language)                                                                      | `bs`             | 1, 2, 3 i 4      | 1, 2, 3 ili 4              |
| [Breton](https://en.wikipedia.org/wiki/Breton_language)                                                                        | `br`             | 1, 2, 3 ha 4     | 1, 2, 3 pe 4               |
| [Bulgarian](https://en.wikipedia.org/wiki/Bulgarian_language)                                                                  | `bg`             | 1, 2, 3 и 4      | 1, 2, 3 или 4              |
| [Burmese](https://en.wikipedia.org/wiki/Burmese_language)                                                                      | `my`             | 1 - 2 - 3နှင့် 4    | 1 - 2 - 3 သို့မဟုတ် 4           |
| [Cantonese](https://en.wikipedia.org/wiki/Cantonese_language)                                                                  | `yue`            | 1、2、3同4       | 1、2、3 或 4               |
| [Catalan](https://en.wikipedia.org/wiki/Catalan_language)                                                                      | `ca`             | 1, 2, 3 i 4      | 1, 2, 3 o 4                |
| [Cebuano](https://en.wikipedia.org/wiki/Cebuano_language)                                                                      | `ceb`            | 1, 2, 3, ug 4    | 1, 2, 3, o 4               |
| [Cherokee](https://en.wikipedia.org/wiki/Cherokee_language)                                                                    | `chr`            | 1, 2, 3, ᎠᎴ 4    | 1, 2, 3, ᎠᎴᏱᎩ 4            |
| [Chinese](https://en.wikipedia.org/wiki/Chinese_language)                                                                      | `zh`             | 1、2、3和4       | 1、2、3或4                 |
| [Chuvash](https://en.wikipedia.org/wiki/Chuvash_language)                                                                      | `cv`             | 1, 2, 3 тата 4   | 1, 2, 3 е 4                |
| [Croatian](https://en.wikipedia.org/wiki/Croatian_language)                                                                    | `hr`             | 1, 2, 3 i 4      | 1, 2, 3 ili 4              |
| [Czech](https://en.wikipedia.org/wiki/Czech_language)                                                                          | `cs`             | 1, 2, 3 a 4      | 1, 2, 3 nebo 4             |
| [Danish](https://en.wikipedia.org/wiki/Danish_language)                                                                        | `da`             | 1, 2, 3 og 4     | 1, 2, 3 eller 4            |
| [Dutch](https://en.wikipedia.org/wiki/Dutch_language)                                                                          | `nl`             | 1, 2, 3 en 4     | 1, 2, 3 of 4               |
| [English](https://en.wikipedia.org/wiki/English_language) (with [Oxford comma](https://en.wikipedia.org/wiki/Serial_comma))    | `en`             | 1, 2, 3, and 4   | 1, 2, 3, or 4              |
| [English](https://en.wikipedia.org/wiki/English_language) (without [Oxford comma](https://en.wikipedia.org/wiki/Serial_comma)) | `en_GB` et al.\* | 1, 2, 3 and 4    | 1, 2, 3 or 4               |
| [Esperanto](https://en.wikipedia.org/wiki/Esperanto_language)                                                                  | `eo`             | 1, 2, 3 kaj 4    | 1, 2, 3 aŭ 4               |
| [Estonian](https://en.wikipedia.org/wiki/Estonian_language)                                                                    | `et`             | 1, 2, 3 ja 4     | 1, 2, 3 või 4              |
| [Faroese](https://en.wikipedia.org/wiki/Faroese_language)                                                                      | `fo`             | 1, 2, 3, og 4    | 1, 2, 3, ella 4            |
| [Filipino](https://en.wikipedia.org/wiki/Filipino_language)                                                                    | `fil`            | 1, 2, 3, at 4    | 1, 2, 3, o 4               |
| [Finnish](https://en.wikipedia.org/wiki/Finnish_language)                                                                      | `fi`             | 1, 2, 3 ja 4     | 1, 2, 3 tai 4              |
| [French](https://en.wikipedia.org/wiki/French_language)                                                                        | `fr`             | 1, 2, 3 et 4     | 1, 2, 3 ou 4               |
| [Galician](https://en.wikipedia.org/wiki/Galician_language)                                                                    | `gl`             | 1, 2, 3 e 4      | 1, 2, 3 ou 4               |
| [Georgian](https://en.wikipedia.org/wiki/Georgian_language)                                                                    | `ka`             | 1, 2, 3 და 4     | 1, 2, 3 ან 4               |
| [German](https://en.wikipedia.org/wiki/German_language)                                                                        | `de`             | 1, 2, 3 und 4    | 1, 2, 3 oder 4             |
| [Greek](https://en.wikipedia.org/wiki/Greek_language)                                                                          | `el`             | 1, 2, 3 και 4    | 1, 2, 3 ή 4                |
| [Gujarati](https://en.wikipedia.org/wiki/Gujarati_language)                                                                    | `gu`             | 1, 2, 3 અને 4     | 1, 2, 3, અથવા 4            |
| [Haitian Creole](https://en.wikipedia.org/wiki/Haitian_Creole_language)                                                        | `ht`             | 1, 2, 3 et 4     | 1, 2, 3 ou 4               |
| [Hausa](https://en.wikipedia.org/wiki/Hausa_language)                                                                          | `ha`             | 1, 2, 3, da 4    | 1, 2, 3 ko 4               |
| [Hebrew](https://en.wikipedia.org/wiki/Hebrew_language)                                                                        | `he`             | ‏1, 2, 3 ו4‎       | ‏1, 2, 3 או 4‎               |
| [Hindi](https://en.wikipedia.org/wiki/Hindi_language)                                                                          | `hi`             | 1, 2, 3, और 4    | 1, 2, 3 या 4               |
| [Hungarian](https://en.wikipedia.org/wiki/Hungarian_language)                                                                  | `hu`             | 1, 2, 3 és 4     | 1, 2, 3 vagy 4             |
| [Icelandic](https://en.wikipedia.org/wiki/Icelandic_language)                                                                  | `is`             | 1, 2, 3 og 4     | 1, 2, 3 eða 4              |
| [Igbo](https://en.wikipedia.org/wiki/Igbo_language)                                                                            | `ig`             | 1, 2, 3, na 4    | 1, 2, 3, ma ọ bụ 4         |
| [Indonesian](https://en.wikipedia.org/wiki/Indonesian_language)                                                                | `id`             | 1, 2, 3, dan 4   | 1, 2, 3, atau 4            |
| [Interlingua](https://en.wikipedia.org/wiki/Interlingua_language)                                                              | `ia`             | 1, 2, 3 e 4      | 1, 2, 3 o 4                |
| [Irish](https://en.wikipedia.org/wiki/Irish_language)                                                                          | `ga`             | 1, 2, 3 agus 4   | 1, 2, 3 nó 4               |
| [Italian](https://en.wikipedia.org/wiki/Italian_language)                                                                      | `it`             | 1, 2, 3 e 4      | 1, 2, 3 o 4                |
| [Japanese](https://en.wikipedia.org/wiki/Japanese_language)                                                                    | `ja`             | 1、2、3、4       | 1、2、3、または4           |
| [Javanese](https://en.wikipedia.org/wiki/Javanese_language)                                                                    | `jv`             | 1, 2, 3, lan 4   | 1, 2, 3, utowo 4           |
| [Kabuverdianu](https://en.wikipedia.org/wiki/Kabuverdianu_language)                                                            | `kea`            | 1, 2, 3 i 4      | 1, 2, 3 o 4                |
| [Kaingang](https://en.wikipedia.org/wiki/Kaingang_language)                                                                    | `kgp`            | 1, 2, 3 kar 4    | 1, 2, 3 ketũmỹr 4          |
| [Kangri](https://en.wikipedia.org/wiki/Kangri_language)                                                                        | `xnr`            | 1, 2, 3, कने 4    | 1, 2, 3 या 4               |
| [Kannada](https://en.wikipedia.org/wiki/Kannada_language)                                                                      | `kn`             | 1, 2, 3, ಮತ್ತು 4  | 1, 2, 3, ಅಥವಾ 4            |
| [Kazakh](https://en.wikipedia.org/wiki/Kazakh_language)                                                                        | `kk`             | 1, 2, 3, 4       | 1, 2, 3, не болмаса 4      |
| [Khmer](https://en.wikipedia.org/wiki/Khmer_language)                                                                          | `km`             | 1, 2, 3 និង 4     | 1, 2, 3 ឬ 4                |
| [Konkani](https://en.wikipedia.org/wiki/Konkani_language)                                                                      | `kok`            | 1, 2, 3, 4       | 1, 2, 3, वा 4              |
| [Korean](https://en.wikipedia.org/wiki/Korean_language)                                                                        | `ko`             | 1, 2, 3 및 4     | 1, 2, 3 또는 4             |
| [Kurdish](https://en.wikipedia.org/wiki/Kurdish_language)                                                                      | `ku`             | 1, 2, 3 û 4      | 1, 2, 3 an 4               |
| [Kuvi](https://en.wikipedia.org/wiki/Kuvi_language)                                                                            | `kxv`            | 1, 2, 3, aḍe 4   | 1, 2, 3, aadtẽ 4           |
| [Kyrgyz](https://en.wikipedia.org/wiki/Kyrgyz_language)                                                                        | `ky`             | 1, 2, 3 жана 4   | 1, 2, 3 же 4               |
| [Ladin](https://en.wikipedia.org/wiki/Ladin_language)                                                                          | `lld`            | 1, 2, 3 y 4      | 1, 2, 3 o 4                |
| [Lao](https://en.wikipedia.org/wiki/Lao_language)                                                                              | `lo`             | 1, 2, 3, 4       | 1, 2, 3 ຫຼື 4                |
| [Latvian](https://en.wikipedia.org/wiki/Latvian_language)                                                                      | `lv`             | 1, 2, 3 un 4     | 1, 2, 3 vai 4              |
| [Lithuanian](https://en.wikipedia.org/wiki/Lithuanian_language)                                                                | `lt`             | 1, 2, 3 ir 4     | 1, 2, 3 ar 4               |
| [Lower Sorbian](https://en.wikipedia.org/wiki/Lower_Sorbian_language)                                                          | `dsb`            | 1, 2, 3 a 4      | 1, 2, 3 abo 4              |
| [Macedonian](https://en.wikipedia.org/wiki/Macedonian_language)                                                                | `mk`             | 1, 2, 3 и 4      | 1, 2, 3 или 4              |
| [Malay](https://en.wikipedia.org/wiki/Malay_language)                                                                          | `ms`             | 1, 2, 3 dan 4    | 1, 2, 3, atau 4            |
| [Malayalam](https://en.wikipedia.org/wiki/Malayalam_language)                                                                  | `ml`             | 1, 2, 3, 4       | 1, 2, 3, അല്ലെങ്കിൽ 4        |
| [Marathi](https://en.wikipedia.org/wiki/Marathi_language)                                                                      | `mr`             | 1, 2, 3 आणि 4    | 1, 2, 3, किंवा 4            |
| [Mongolian](https://en.wikipedia.org/wiki/Mongolian_language)                                                                  | `mn`             | 1, 2, 3, 4       | 1, 2, 3, 4 зэргийн аль нэг |
| [Māori](https://en.wikipedia.org/wiki/M%C4%81ori_language)                                                                     | `mi`             | 1, 2, 3, 4       | 1, 2, 3, 4 rānei           |
| [Nepali](https://en.wikipedia.org/wiki/Nepali_language)                                                                        | `ne`             | 1, 2, 3 र 4      | 1, 2, 3, वा 4              |
| [Nheengatu](https://en.wikipedia.org/wiki/Nheengatu_language)                                                                  | `yrl`            | 1, 2, 3 asuí 4   | 1, 2, 3 u 4                |
| [Nigerian Pidgin](https://en.wikipedia.org/wiki/Nigerian_Pidgin_language)                                                      | `pcm`            | 1, 2, 3, an 4    | 1, 2, 3 ọ 4                |
| [Norwegian](https://en.wikipedia.org/wiki/Norwegian_language)                                                                  | `no`             | 1, 2, 3 og 4     | 1, 2, 3 eller 4            |
| [Norwegian Bokmål](https://en.wikipedia.org/wiki/Norwegian_Bokm%C3%A5l_language)                                               | `nb`             | 1, 2, 3 og 4     | 1, 2, 3 eller 4            |
| [Norwegian Nynorsk](https://en.wikipedia.org/wiki/Norwegian_Nynorsk_language)                                                  | `nn`             | 1, 2, 3 og 4     | 1, 2, 3 eller 4            |
| [Odia](https://en.wikipedia.org/wiki/Odia_language)                                                                            | `or`             | 1, 2, 3, ଓ 4     | 1, 2, 3 କିମ୍ବା 4             |
| [Persian](https://en.wikipedia.org/wiki/Persian_language)                                                                      | `fa`             | ‏1،‏ 2،‏ 3، و 4‎     | ‏1،‏ 2،‏ 3، یا 4‎              |
| [Polish](https://en.wikipedia.org/wiki/Polish_language)                                                                        | `pl`             | 1, 2, 3 i 4      | 1, 2, 3 lub 4              |
| [Portuguese](https://en.wikipedia.org/wiki/Portuguese_language)                                                                | `pt`             | 1, 2, 3 e 4      | 1, 2, 3 ou 4               |
| [Punjabi](https://en.wikipedia.org/wiki/Punjabi_language)                                                                      | `pa`             | 1, 2, 3 ਅਤੇ 4     | 1, 2, 3 ਜਾਂ 4               |
| [Quechua](https://en.wikipedia.org/wiki/Quechua_language)                                                                      | `qu`             | 1, 2, 3, 4       | 1, 2, 3, utaq 4            |
| [Romanian](https://en.wikipedia.org/wiki/Romanian_language)                                                                    | `ro`             | 1, 2, 3 și 4     | 1, 2, 3 sau 4              |
| [Romansh](https://en.wikipedia.org/wiki/Romansh_language)                                                                      | `rm`             | 1, 2, 3 e 4      | 1, 2, 3 u 4                |
| [Russian](https://en.wikipedia.org/wiki/Russian_language)                                                                      | `ru`             | 1, 2, 3 и 4      | 1, 2, 3 или 4              |
| [Sardinian](https://en.wikipedia.org/wiki/Sardinian_language)                                                                  | `sc`             | 1, 2, 3 e 4      | 1, 2, 3 o 4                |
| [Scottish Gaelic](https://en.wikipedia.org/wiki/Scottish_Gaelic_language)                                                      | `gd`             | 1, 2, 3 agus 4   | 1, 2, 3 no 4               |
| [Serbian](https://en.wikipedia.org/wiki/Serbian_language)                                                                      | `sr`             | 1, 2, 3 и 4      | 1, 2, 3 или 4              |
| [Shan](https://en.wikipedia.org/wiki/Shan_language)                                                                            | `shn`            | 1၊ 2၊ 3 လႄႈ 4    | 1၊ 2၊ 3၊ ႁိုဝ် 4              |
| [Sichuan Yi](https://en.wikipedia.org/wiki/Sichuan_Yi_language)                                                                | `ii`             | 1、2、3ꌋꆀ4     | 1、2、3ꅀ4                 |
| [Sicilian](https://en.wikipedia.org/wiki/Sicilian_language)                                                                    | `scn`            | 1, 2, 3 e 4      | 1, 2, 3 o 4                |
| [Sindhi](https://en.wikipedia.org/wiki/Sindhi_language)                                                                        | `sd`             | ‏1، 2، 3، ۽ 4‎     | ‏1, 2, 3, يا 4‎              |
| [Sinhala](https://en.wikipedia.org/wiki/Sinhala_language)                                                                      | `si`             | 1, 2, 3, සහ 4    | 1, 2, 3, හෝ 4              |
| [Slovak](https://en.wikipedia.org/wiki/Slovak_language)                                                                        | `sk`             | 1, 2, 3 a 4      | 1, 2, 3 alebo 4            |
| [Slovenian](https://en.wikipedia.org/wiki/Slovenian_language)                                                                  | `sl`             | 1, 2, 3 in 4     | 1, 2, 3 ali 4              |
| [Somali](https://en.wikipedia.org/wiki/Somali_language)                                                                        | `so`             | 1, 2, 3 iyo 4    | 1, 2, 3 ama 4              |
| [Spanish](https://en.wikipedia.org/wiki/Spanish_language)                                                                      | `es`             | 1, 2, 3 y 4      | 1, 2, 3 o 4                |
| [Swahili](https://en.wikipedia.org/wiki/Swahili_language)                                                                      | `sw`             | 1, 2, 3 na 4     | 1, 2, 3 au 4               |
| [Swampy Cree](https://en.wikipedia.org/wiki/Swampy_Cree_language)                                                              | `csw`            | 1, 2, 3, 4       | 1, 2, 3, ᐊᐍᑳ 4             |
| [Swedish](https://en.wikipedia.org/wiki/Swedish_language)                                                                      | `sv`             | 1, 2, 3 och 4    | 1, 2, 3 eller 4            |
| [Syriac](https://en.wikipedia.org/wiki/Syriac_language)                                                                        | `syr`            | ‏1 ܘ2 ܘ3 ܘ4‎       | ‏1 ܐܘ 2 ܐܘ 3 ܐܘ 4‎           |
| [Tajik](https://en.wikipedia.org/wiki/Tajik_language)                                                                          | `tg`             | 1, 2, 3, 4       | 1, 2, 3, ё 4               |
| [Tamil](https://en.wikipedia.org/wiki/Tamil_language)                                                                          | `ta`             | 1, 2, 3 மற்றும் 4  | 1, 2, 3 அல்லது 4            |
| [Tatar](https://en.wikipedia.org/wiki/Tatar_language)                                                                          | `tt`             | 1, 2, 3 һәм 4    | 1, 2, 3, яки 4             |
| [Telugu](https://en.wikipedia.org/wiki/Telugu_language)                                                                        | `te`             | 1, 2, 3 మరియు 4   | 1, 2, 3 లేదా 4               |
| [Thai](https://en.wikipedia.org/wiki/Thai_language)                                                                            | `th`             | 1 2 3 และ4       | 1, 2, 3 หรือ 4              |
| [Tigrinya](https://en.wikipedia.org/wiki/Tigrinya_language)                                                                    | `ti`             | 1፣ 2፣ 3ን 4ን      | 1፣ 2፣ 3 ወይ 4               |
| [Tongan](https://en.wikipedia.org/wiki/Tongan_language)                                                                        | `to`             | 1 mo 2 mo 3 mo 4 | 1, 2, 3, pē 4              |
| [Turkish](https://en.wikipedia.org/wiki/Turkish_language)                                                                      | `tr`             | 1, 2, 3 ve 4     | 1, 2, 3 veya 4             |
| [Turkmen](https://en.wikipedia.org/wiki/Turkmen_language)                                                                      | `tk`             | 1, 2, 3 we 4     | 1, 2, 3 ýa-da 4            |
| [Ukrainian](https://en.wikipedia.org/wiki/Ukrainian_language)                                                                  | `uk`             | 1, 2, 3 і 4      | 1, 2, 3 або 4              |
| [Upper Sorbian](https://en.wikipedia.org/wiki/Upper_Sorbian_language)                                                          | `hsb`            | 1, 2, 3 a 4      | 1, 2, 3 abo 4              |
| [Urdu](https://en.wikipedia.org/wiki/Urdu_language)                                                                            | `ur`             | ‏1، 2، 3، اور 4‎   | ‏1، 2، 3، یا 4‎              |
| [Uzbek](https://en.wikipedia.org/wiki/Uzbek_language)                                                                          | `uz`             | 1, 2, 3 va 4     | 1, 2, 3 yoki 4             |
| [Venetian](https://en.wikipedia.org/wiki/Venetian_language)                                                                    | `vec`            | 1, 2, 3 e 4      | 1, 2, 3, o 4               |
| [Vietnamese](https://en.wikipedia.org/wiki/Vietnamese_language)                                                                | `vi`             | 1, 2, 3 và 4     | 1, 2, 3 hoặc 4             |
| [Welsh](https://en.wikipedia.org/wiki/Welsh_language)                                                                          | `cy`             | 1, 2, 3 a 4      | 1, 2, 3 neu 4              |
| [Yoruba](https://en.wikipedia.org/wiki/Yoruba_language)                                                                        | `yo`             | 1, 2, 3, 4       | 1, 2, 3, tabi 4            |
| [Yoruba (Benin)](https://en.wikipedia.org/wiki/Yoruba_language)                                                                | `yo_BJ`          | 1, 2, 3, 4       | 1 pɛ̀lú 2, 3, tabi 4        |

\* The following English variants use no Oxford comma: `AG`, `AI`, `AT`,
`AU`, `BB`, `BE`, `BM`, `BS`, `BW`, `BZ`, `CA`, `CC`, `CH`, `CK`, `CM`,
`CX`, `CY`, `CZ`, `DE`, `DG`, `DK`, `DM`, `EE`, `ER`, `ES`, `FI`, `FJ`,
`FK`, `FM`, `FR`, `GB`, `GD`, `GE`, `GG`, `GH`, `GI`, `GM`, `GS`, `GY`,
`HK`, `HU`, `ID`, `IE`, `IL`, `IM`, `IN`, `IO`, `IT`, `JE`, `JM`, `KE`,
`KI`, `KN`, `KY`, `LC`, `LR`, `LS`, `LT`, `LV`, `MG`, `MO`, `MS`, `MT`,
`MU`, `MV`, `MW`, `MY`, `NA`, `NF`, `NG`, `NL`, `NO`, `NR`, `NU`, `NZ`,
`PG`, `PK`, `PL`, `PN`, `PT`, `PW`, `RO`, `RW`, `SB`, `SC`, `SD`, `SE`,
`SG`, `SH`, `SI`, `SK`, `SL`, `SS`, `SX`, `SZ`, `TC`, `TK`, `TO`, `TT`,
`TV`, `TZ`, `UA`, `UG`, `VC`, `VG`, `VU`, `WS`, `ZA`, `ZM`, and `ZW`.

#### Partially supported languages

Partially supported languages generally localize
[`and()`](https://pkg.rossellhayes.com/and/reference/and.md) but not
[`or()`](https://pkg.rossellhayes.com/and/reference/and.md).

| Language                                                                  | Code  | *and* example               |
|:--------------------------------------------------------------------------|:------|:----------------------------|
| [Bodo](https://en.wikipedia.org/wiki/Bodo_language)                       | `brx` | 1, 2, 3, आरो 4              |
| [Chakma](https://en.wikipedia.org/wiki/Chakma_language)                   | `ccp` | 1, 2, 3 𑄃𑄳𑄃 4                |
| [Colognian](https://en.wikipedia.org/wiki/Colognian_language)             | `ksh` | 1, 2, 3 un 4                |
| [Dogri](https://en.wikipedia.org/wiki/Dogri_language)                     | `doi` | 1, 2, 3, ते 4                |
| [Dzongkha](https://en.wikipedia.org/wiki/Dzongkha_language)               | `dz`  | 1 དང་ 2 དང་ 3 དང་ 4         |
| [Ewe](https://en.wikipedia.org/wiki/Ewe_language)                         | `ee`  | 1, 2, 3, kple 4             |
| [Friulian](https://en.wikipedia.org/wiki/Friulian_language)               | `fur` | 1, 2, 3 e 4                 |
| [Interlingue](https://en.wikipedia.org/wiki/Interlingue_language)         | `ie`  | 1, 2, 3, 4                  |
| [Kashmiri](https://en.wikipedia.org/wiki/Kashmiri_language)               | `ks`  | ‏1، 2، 3، تٕہ 4‎               |
| [Luxembourgish](https://en.wikipedia.org/wiki/Luxembourgish_language)     | `lb`  | 1, 2, 3 a 4                 |
| [Maithili](https://en.wikipedia.org/wiki/Maithili_language)               | `mai` | 1, 2, 3, और 4               |
| [Maltese](https://en.wikipedia.org/wiki/Maltese_language)                 | `mt`  | 1, 2, 3, u 4                |
| [Manipuri](https://en.wikipedia.org/wiki/Manipuri_language)               | `mni` | 1, 2, 3 অমসুং 4              |
| [Ngomba](https://en.wikipedia.org/wiki/Ngomba_language)                   | `jgo` | 1, ŋ́gɛ 2, ŋ́gɛ 3, ḿbɛn ŋ́gɛ 4 |
| [Northern Sami](https://en.wikipedia.org/wiki/Northern_Sami_language)     | `se`  | 1, 2, 3 ja 4                |
| [Ossetic](https://en.wikipedia.org/wiki/Ossetic_language)                 | `os`  | 1, 2, 3 ӕмӕ 4               |
| [Pashto](https://en.wikipedia.org/wiki/Pashto_language)                   | `ps`  | ‏1، 2، 3، او 4‎               |
| [Sanskrit](https://en.wikipedia.org/wiki/Sanskrit_language)               | `sa`  | 1, 2, 3, तथा 4              |
| [Sundanese](https://en.wikipedia.org/wiki/Sundanese_language)             | `su`  | 1, 2, 3, sareng 4           |
| [Swiss German](https://en.wikipedia.org/wiki/Swiss_German_language)       | `gsw` | 1, 2, 3 und 4               |
| [Walser](https://en.wikipedia.org/wiki/Walser_language)                   | `wae` | 1, 2, 3 und 4               |
| [Western Balochi](https://en.wikipedia.org/wiki/Western_Balochi_language) | `bgn` | ‏1، 2، 3، و 4‎                |
| [Western Frisian](https://en.wikipedia.org/wiki/Western_Frisian_language) | `fy`  | 1, 2, 3 en 4                |
| [Yakut](https://en.wikipedia.org/wiki/Yakut_language)                     | `sah` | 1, 2, 3 уонна 4             |
| [Yiddish](https://en.wikipedia.org/wiki/Yiddish_language)                 | `yi`  | ‏1, 2, 3 און 4‎               |
| [Zulu](https://en.wikipedia.org/wiki/Zulu_language)                       | `zu`  | 1, 2, 3, ne-4               |

------------------------------------------------------------------------

Hex sticker image by Flavia Rossell Hayes.

Please note that **and** is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
