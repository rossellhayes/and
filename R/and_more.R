#' Combine a vector into a natural language string with a limited length
#'
#' These functions combine a specified number of elements of a vector into a
#' single string indicating how many more elements are in the vector.
#' `and_more()` and `or_more()` natively support localization, using
#' translations and punctuation to match the users' language settings.
#' (See section "Language" for more details.)
#' * `and_more()` combines words using the native conjunctive ("and" in English)
#' * `or_more()` combines words using the native disjunctive ("or" in English)
#'
#' @section Languages:
#'
#' Translations are available in the following languages:
#'
#' **code** | **language** |            | **and ... more**
#' --       |--            |--          |--
#' ca       | català       | Catalan    | i ... més
#' de       | Deutsch      | German     | und ... weitere
#' en       | English      |            | and ... more
#' en_US    | US English   |            | and ... more
#' eo       | esperanto    | Esperanto  | kaj ... pli
#' es       | español      | Spanish    | y ... más
#' eu       | euskara      | Basque     | eta ... gehiago
#' fr       | français     | French     | et 1 de plus / et ... autres
#' it       | italiano     | Italian    | e 1 altro / e ... altri
#' pt       | português    | Portuguese | e mais ...
#' tr       | Türkçe       | Turkish    | ve ... tane daha
#'
#' @export
#'
#' @examples
#' and_more(letters)
#' or_more(letters)
#'
#' and_more(letters, max = 10)
#'
#' and_more(letters, lang = "es")
#' and_more(letters, lang = "fr")
#'
#' @inheritParams and
#' @param max
#'
#' @return A [character] string of length 1
and_more <- function(x, max = 3, ..., lang = NULL) {
  check_dots_empty0(...)
  conjoin_more(x, max = max, conjunction = "and", lang = lang)
}

or_more <- function(x, max = 3, ..., lang = NULL) {
  check_dots_empty0(...)
  conjoin_more(x, conjunction = "or", max = max, lang = lang)
}

conjoin_more <- function(
  x, max = 3, ..., conjunction = c("and", "or"), lang = NULL
) {
  check_dots_empty0(...)

  max <- validate_max(max)

  if (!is.null(lang) && !is.na(lang)) {
    validate_lang(lang)
    old_lang <- set_lang(lang)
    on.exit(set_lang(old_lang))
  }

  if (length(x) > max) {
    if (max < 1) {
      max <- 0
    } else {
      max <- floor(max)
    }

    n <- length(x) - max

    x <- c(
      x[seq_len(max)],
      glue::glue(gettext("{n} more", domain = "R-and"))
    )
  }

  conjoin(x, conjunction = conjunction)
}
