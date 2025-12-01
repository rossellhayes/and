# Change the language of the current R environment

Changes the value of the `LANGUAGE` environment variable.

Returns the value of the `LANGUAGE` environment variable before it was
changed. This allows you to use the following structure to temporarily
change the language:

    old_language <- set_language("es")
    on.exit(set_language(old_language))

## Usage

``` r
set_language(language)
```

## Arguments

- language:

  A language code.

  Codes should should be two or three lowercase letters representing the
  language, optionally followed by an underscore and two uppercase
  letters representing a territory. For example, `"es"` represents
  Spanish and `"en_US"` represents American English.

  If a territory is specified but there is no specific translation for
  that territory, translations fall back to the general language. For
  example, if there are no specific translations for Canadian French,
  `"fr_CA"` will fall back to `"fr"`.

  If a language is specified but there is no translation for that
  language, translations generally fall back to English.

  If `language` is an empty string or `NULL`, the `LANGUAGE` environment
  variable is unset.

## Value

Returns the pre-existing value of the `LANGUAGE` environment variable

## Examples

``` r
# Change language to Korean
set_language("ko")

# Change language to Mexican Spanish, which may fall back to "es"
set_language("es_MX")

# Temporarily set the language to Cantonese
old_language <- set_language("yue")
set_language(old_language)

# Change to an invalid language, which generally falls back to English
set_language("zxx")

# Unset the language environment variable
set_language(NULL)
```
