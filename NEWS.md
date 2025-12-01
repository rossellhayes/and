# and 0.1.7

* Updated `and` with data from the latest Unicode CLDR release: [CLDR 47](https://github.com/unicode-org/cldr-json/releases/tag/47.0.0).

## New languages

* Haitian Creole (`ht`)

## Improved languages

* Luxembourgish (`lb`)

# and 0.1.6

* Updated `and` with data from the latest Unicode CLDR release: [CLDR 47 beta 1](https://github.com/unicode-org/cldr-json/releases/tag/47.0.0-BETA1).

## New languages

* Akan (`ak`)
* Anii (`blo`)
* Interlingue (`ie`)
* Kangri (`xnr`)
* Kuvi (`kxv`)
* Ladin (`lld`)
* Sichuan Ye (`ii`)
* Swampy Cree (`csw`)
* Tajik (`tg`)

## Improved languages

* Amharic (`am`)
* Igbo (`ig`)
* Māori (`mi`)
* Sindhi (`sd`)
* Tatar (`tt`)
* Yoruba (`yo`)

# and 0.1.5

* Updated `and` with data from the latest Unicode CLDR release: [CLDR 44 alpha 2](https://github.com/unicode-org/cldr-json/releases/tag/44.0.0-ALPHA2).

## New languages

* Māori (`mi`)
* Venetian (`vec`)

## Improved languages

* Amharic (`am`)
* Faroese (`fo`)
* Syriac (`syr`)

## Bug fixes

* Fixed a bug where commas between list elements would not be localized.
* Fixed a bug that would emit a warning whenever using a language whose `.po` file did not include a valid pluralization rule.
* Fixed display issues when switching between left-to-right and right-to-left scripts in `and_languages` examples.

# and 0.1.4

* Updated `and` with data from the latest Unicode CLDR release: [CLDR 43](https://cldr.unicode.org/index/downloads/cldr-43).

## New languages

* Syriac (`syr`)
* Western Balochi (`bgn`) (partially supported)
	
## Bug fixes

* `and()` and `or()` no longer produce unexpected results when `x` is a factor.

# and 0.1.3

* Updated `and` with data from the latest Unicode CLDR release: [CLDR 42](https://cldr.unicode.org/index/downloads/cldr-42).

## New fully supported languages
* Asturian (`ast`)
* Breton (`br`)
* Cebuano (`ceb`)
* Cherokee (`chr`)
* Chuvash (`cv`)
* Dzongkha (`dz`)
* Faroese (`fo`)
* Hausa (`ha`)
* Interlingua (`ia`)
* Kabuverdianu (`kea`)
* Kaingang (`kgp`)
* Konkani (`kok`)
* Kurdish (`ku`)
* Lower Sorbian (`dsb`)
* Nheengatu (`yrl`)
* Nigerian Pidgin (`pcm`)
* Quechua (`qu`)
* Romansh (`rm`)
* Sardinian (`sc`)
* Scottish Gaelic (`gd`)
* Tigrinya (`ti`)
* Tongan (`to`)
* Upper Sorbian (`hsb`)
* Yoruba (`yo`)
* Yoruba (Benin) (`yo_BJ`)

## New partially supported languages
Partially supported languages support "and", but not "or".

* Bodo (`brx`)
* Chakma (`ccp`)
* Colognian (`ksh`)
* Dogri (`doi`)
* Ewe (`ee`)
* Friulian (`fur`)
* Igbo (`ig`)
* Kashmiri (`ks`)
* Luxembourgish (`lb`)
* Maithili (`mai`)
* Maltese (`mt`)
* Manipuri (`mni`)
* Ngomba (`jgo`)
* Northern Sami (`se`)
* Ossetic (`os`)
* Sanskrit (`sa`)
* Sundanese (`su`)
* Swiss German (`gsw`)
* Tatar (`tt`)
* Walser (`wae`)
* Western Frisian (`fy`)
* Yakut (`sah`)
* Yiddish (`yi`)

## Improved languages
* Czech (`cs`)
* Irish (`ga`)

# and 0.1.2

* Add support for Unix machines without UTF-8 support.

# and 0.1.1

* `set_language()` can now unset the `LANGUAGE` environment variable if its input is an empty string (`""`) or has length 0 (e.g. `NULL`).

# and 0.1.0

* Initial release.
