#' Change the language of the current R environment
#'
#' @description
#' Changes the value of the `LANGUAGE` environment variable.
#'
#' Returns the value of the `LANGUAGE` environment variable before it
#' was changed.
#' This allows you to use the following structure to temporarily change
#' the language:
#' ```r
#' old_language <- set_language("es")
#' on.exit(set_language(old_language))
#' ```
#'
#' @examples
#' \dontrun{
#' # Change language to Korean
#' set_language("ko")
#'
#' # Change language to Mexican Spanish, which may fall back to "es"
#' set_language("es_MX")
#'
#' # Change to an invalid language, which generally falls back to English
#' set_language("zxx")
#'
#' # Temporarily set the language to Cantonese
#' old_language <- set_language("yue")
#' on.exit(set_language(old_language))
#' }
#'
#' @param language A language code.
#'
#'   Codes should should be two or three lowercase letters representing the
#'   language, optionally followed by an underscore and two uppercase letters
#'   representing a territory.
#'   For example, `"es"` represents Spanish and
#'   `"en_US"` represents American English.
#'
#'   If a territory is specified but there is no specific translation for that
#'   territory, translations fall back to the general language.
#'   For example, if there are no specific translations for Canadian French,
#'   `"fr_CA"` will fall back to `"fr"`.
#'
#'   If a language is specified but there is no translation for that language,
#'   translations generally fall back to English.
#'
#' @return Returns the pre-existing value of the `LANGUAGE` environment variable
#' @export
set_language <- function(language) {
  language <- validate_language(language)

  old_language <- Sys.getenv("LANGUAGE", unset = "")
  old_text <- gettext("{x0}, {x1}{tag(and_start)}", domain = "R-and")

  Sys.setenv("LANGUAGE" = language)

  new_language <- Sys.getenv("LANGUAGE", unset = "")
  new_text <- gettext("{x0}, {x1}{tag(and_start)}", domain = "R-and")

  if (!identical(old_language, new_language) && identical(old_text, new_text)) {
    # On Linux, message translations are cached
    # Messages from the old language may be shown in the new language
    # If this happens, invalidate the cache so new messages have to generate
    base_dir <- bindtextdomain("R-base")
    bindtextdomain("R-base", tempfile())
    bindtextdomain("R-base", base_dir)
  }

  return(invisible(old_language))
}

validate_language <- function(language, call = rlang::caller_env()) {
  if (!is.character(language) || length(language) != 1) {
    rlang::abort(
      "`language` must be a character vector of length 1 or NULL.",
      class = "and_invalid_language",
      call = call
    )
  }

  gsub("-", "_", language)
}
