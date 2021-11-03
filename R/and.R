#' Combine a vector into a natural language string
#'
#' These functions transform a vector into a single string similar to
#' [knitr::combine_words()] or [glue::glue_collapse()]. `and()` and `or()`
#' natively support localization, using translations and punctuation to match
#' the users' language settings. (See section "Language" for more details.)
#' * `and()` combines words using the native conjunctive ("and" in English)
#' * `or()` combines words using the native disjunctive ("or" in English)
#'
#' @section Languages:
#'
#' Translations are available in the following languages:
#'
#' **code** | **language** |            | **and** | **or** |   |
#' --       |--            |--          |--       |--      |--
#' ca       | català       | Catalan    | i       | o      |
#' de       | Deutsch      | German     | und     | oder   |
#' en       | English      |            | and     | or     |
#' en_US    | US English   |            | and     | or     | (uses Oxford comma)
#' eo       | esperanto    | Esperanto  | kaj     | aŭ     |
#' es       | español      | Spanish    | y / e   | o / u  |
#' eu       | euskara      | Basque     | eta     | edo    |
#' fr       | français     | French     | et      | ou     |
#' it       | italiano     | Italian    | e / ed  | o / od |
#' pt       | português    | Portuguese | e       | ou     |
#' tr       | Türkçe       | Turkish    | ve      | veya   |
#'
#' @export
#'
#' @examples
#' and(c("Betty", "James", "Inez"))
#' or(c("win", "lose", "draw"))
#'
#' and(c("libre", "soberana", "independiente"), lang = "es")
#' and(c("liberté", "égalité", "fraternité"), lang = "fr")
#'
#' @param x A list of [character] strings to combine
#' @param ... These dots are for future extensions and must be empty.
#' @param lang The language to use. If [`NULL`], the default, the language of
#'   the user's R session is used.
#'
#'
#' @return A [character] string of length 1
and <- function(x, ..., lang = NULL) {
  check_dots_empty0(...)
  conjoin(x, conjunction = "and", lang = lang)
}

#' @rdname and
#' @export
or <- function(x, ..., lang = NULL) {
  check_dots_empty0(...)
  conjoin(x, conjunction = "or", lang = lang)
}

conjoin <- function(x, ..., conjunction = c("and", "or"), lang = NULL) {
  check_dots_empty0(...)

  if (!is.null(lang)) {
    validate_lang(lang)
    old_lang <- set_lang(lang)
    on.exit(set_lang(old_lang))
  }

  lang <- gettext("en")

  if (length(x) == 1) {
    return(x)
  }

  conj <- glue::glue(
    switch(
      match.arg(conjunction),
      and = gettext("{''} and {''}", domain = "R-and"),
      or  = gettext("{''} or {''}", domain = "R-and")
    )
  )

  if (length(x) == 2) {
    return(paste(x, collapse = conj))
  }

  sep <- glue::glue(gettext("{''}, {''}", domain = "R-and"))

  x <- rbind(x, sep)
  x[length(x)] <- ""
  x[length(x) - 2] <- conj

  paste(x, collapse = "")
}
