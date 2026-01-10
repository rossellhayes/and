# Changelog

## and (development version)

- Updated `and` with data from the latest Unicode CLDR pre-release:
  [CLDR
  48.1.0](https://github.com/unicode-org/cldr-json/releases/tag/48.1.0).

### New fully supported languages

- Bashkir (`ba`)
- English (Estonia, Georgia, Lithuania, Latvia, and Ukraine) (`en_EE`,
  `en_GE`, `en_LT`, `en_LV`, and `en_UA`)
- Esperanto (`eo`)
- Sicilian (`scn`)
- Shan (`shn`)

### Improved languages

- Malayalam (`ml`)
- Nepali (`ne`)

## and 0.1.7

CRAN release: 2025-12-01

- Updated `and` with data from the latest Unicode CLDR release: [CLDR
  47](https://github.com/unicode-org/cldr-json/releases/tag/47.0.0).

### New languages

- Haitian Creole (`ht`)

### Improved languages

- Luxembourgish (`lb`)

## and 0.1.6

CRAN release: 2025-02-25

- Updated `and` with data from the latest Unicode CLDR release: [CLDR 47
  beta
  1](https://github.com/unicode-org/cldr-json/releases/tag/47.0.0-BETA1).

### New languages

- Akan (`ak`)
- Anii (`blo`)
- Interlingue (`ie`)
- Kangri (`xnr`)
- Kuvi (`kxv`)
- Ladin (`lld`)
- Sichuan Ye (`ii`)
- Swampy Cree (`csw`)
- Tajik (`tg`)

### Improved languages

- Amharic (`am`)
- Igbo (`ig`)
- Māori (`mi`)
- Sindhi (`sd`)
- Tatar (`tt`)
- Yoruba (`yo`)

## and 0.1.5

CRAN release: 2023-09-24

- Updated `and` with data from the latest Unicode CLDR release: [CLDR 44
  alpha
  2](https://github.com/unicode-org/cldr-json/releases/tag/44.0.0-ALPHA2).

### New languages

- Māori (`mi`)
- Venetian (`vec`)

### Improved languages

- Amharic (`am`)
- Faroese (`fo`)
- Syriac (`syr`)

### Bug fixes

- Fixed a bug where commas between list elements would not be localized.
- Fixed a bug that would emit a warning whenever using a language whose
  `.po` file did not include a valid pluralization rule.
- Fixed display issues when switching between left-to-right and
  right-to-left scripts in `and_languages` examples.

## and 0.1.4

CRAN release: 2023-06-14

- Updated `and` with data from the latest Unicode CLDR release: [CLDR
  43](https://cldr.unicode.org/index/downloads/cldr-43).

### New languages

- Syriac (`syr`)
- Western Balochi (`bgn`) (partially supported)

### Bug fixes

- [`and()`](https://pkg.rossellhayes.com/and/reference/and.md) and
  [`or()`](https://pkg.rossellhayes.com/and/reference/and.md) no longer
  produce unexpected results when `x` is a factor.

## and 0.1.3

CRAN release: 2022-10-20

- Updated `and` with data from the latest Unicode CLDR release: [CLDR
  42](https://cldr.unicode.org/index/downloads/cldr-42).

### New fully supported languages

- Asturian (`ast`)
- Breton (`br`)
- Cebuano (`ceb`)
- Cherokee (`chr`)
- Chuvash (`cv`)
- Dzongkha (`dz`)
- Faroese (`fo`)
- Hausa (`ha`)
- Interlingua (`ia`)
- Kabuverdianu (`kea`)
- Kaingang (`kgp`)
- Konkani (`kok`)
- Kurdish (`ku`)
- Lower Sorbian (`dsb`)
- Nheengatu (`yrl`)
- Nigerian Pidgin (`pcm`)
- Quechua (`qu`)
- Romansh (`rm`)
- Sardinian (`sc`)
- Scottish Gaelic (`gd`)
- Tigrinya (`ti`)
- Tongan (`to`)
- Upper Sorbian (`hsb`)
- Yoruba (`yo`)
- Yoruba (Benin) (`yo_BJ`)

### New partially supported languages

Partially supported languages support “and”, but not “or”.

- Bodo (`brx`)
- Chakma (`ccp`)
- Colognian (`ksh`)
- Dogri (`doi`)
- Ewe (`ee`)
- Friulian (`fur`)
- Igbo (`ig`)
- Kashmiri (`ks`)
- Luxembourgish (`lb`)
- Maithili (`mai`)
- Maltese (`mt`)
- Manipuri (`mni`)
- Ngomba (`jgo`)
- Northern Sami (`se`)
- Ossetic (`os`)
- Sanskrit (`sa`)
- Sundanese (`su`)
- Swiss German (`gsw`)
- Tatar (`tt`)
- Walser (`wae`)
- Western Frisian (`fy`)
- Yakut (`sah`)
- Yiddish (`yi`)

### Improved languages

- Czech (`cs`)
- Irish (`ga`)

## and 0.1.2

CRAN release: 2022-08-17

- Add support for Unix machines without UTF-8 support.

## and 0.1.1

CRAN release: 2022-07-18

- [`set_language()`](https://pkg.rossellhayes.com/and/reference/set_language.md)
  can now unset the `LANGUAGE` environment variable if its input is an
  empty string (`""`) or has length 0 (e.g. `NULL`).

## and 0.1.0

- Initial release.
