#' Combine a vector into a natural language string
#'
#' @description
#' These functions transform a vector into a single string similar to
#' [knitr::combine_words()] or [glue::glue_collapse()].
#'
#' `and()` and `or()` natively support localization, using translations and
#' punctuation to match the users' language settings.
#' See [and_languages] for available languages.
#'
#' * `and()` combines words using the native conjunctive ("and" in English)
#' * `or()` combines words using the native disjunctive ("or" in English)
#'
#' @source Language data is derived from the
#'   [Unicode Common Locale Data Repository (CLDR)](https://cldr.unicode.org/)
#' @export
#'
#' @examples
#' and(1:3)
#' or(1:3)
#'
#' and(1:3, language = "es")
#' or(1:3, language = "ja")
#'
#' @param x A list of [character] strings to combine
#' @param ... These dots are for future extensions and must be empty.
#' @param language The language to use for translation.
#'   If [`NULL`], the default, the language of the user's R session is used.
#'
#'   Codes should should be two or three lowercase letters representing the
#'   language, optionally followed by an underscore and two uppercase letters
#'   representing a territory.
#'   For example, `"es"` represents Spanish and
#'   `"en_US"` represents American English.
#'
#'   If a territory is specified but there is no specific translation for that
#'   territory, translations fall back to the general language.
#'   For example, `and` does not include specific translations for
#'   Canadian French, so `"fr_CA"` falls back to `"fr"`.
#'
#'   If a language is specified that is not supported by `and`, translations
#'   fall back to English.
#'   For a list of supported languages, see [and_languages].
#'
#' @return A [character] string of length 1
and <- function(x, ..., language = NULL) {
  conjoin(
    x, ..., conjunction = "and",
    language = language, call = rlang::current_env()
  )
}

#' @rdname and
#' @export
or <- function(x, ..., language = NULL) {
  conjoin(
    x, ..., conjunction = "or",
    language = language, call = rlang::current_env()
  )
}

# @staticimports pkg:stringstatic
#  str_remove_all

conjoin <- function(
  x,
  ...,
  conjunction = c("and", "or"),
  language = NULL,
  call = rlang::current_env()
) {
  rlang::check_dots_empty0(..., call = call)

  x <- as.character(x)

  if (length(x) == 1) {
    return(x)
  }

  if (!is.null(language)) {
    old_language <- set_language(language)
    on.exit(set_language(old_language))
  }

  if (length(x) == 2) {
    return(unclass(and_glue(conjunction, "2", list(x0 = x[[1]], x1 = x[[2]]))))
  }

  x[2] <- and_glue(conjunction, "start", list(x0 = x[[1]], x1 = x[[2]]))
  x <- x[-1]

  x[length(x) - 1] <- and_glue(
    conjunction, "end", list(x0 = x[length(x) - 1], x1 = x[length(x)])
  )
  x <- x[-length(x)]

  paste(
    x,
    collapse = str_remove_all(
      and_glue(conjunction, "middle"),
      pattern = "\\{.+?\\}"
    )
  )
}

and_glue <- function(conjunction, suffix, data = list()) {
  if (suffix == "middle") {
    gettext_key <- switch(
      conjunction,
      "and" = "{x0}, {x1}{tag(and_middle)}",
      "or"  = "{x0}, {x1}{tag(or_middle)}"
    )
    return(gettext(gettext_key, domain = "R-and"))
  }

  if (conjunction == "and") {
    gettext_key <- switch(
      suffix,
      "start"  = "{x0}, {x1}{tag(and_start)}",
      "end"    = "{x0}, and {x1}{tag(and_end)}",
      "2"      = "{x0} and {x1}{tag(and_2)}"
    )
  } else if (conjunction == "or") {
    gettext_key <- switch(
      suffix,
      "start"  = "{x0}, {x1}{tag(or_start)}",
      "end"    = "{x0}, or {x1}{tag(or_end)}",
      "2"      = "{x0} or {x1}{tag(or_2)}"
    )
  }

  glue::glue_data(data, gettext(gettext_key, domain = "R-and"))
}
