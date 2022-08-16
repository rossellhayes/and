tag <- function(...) {
  return("")
}

# @staticimports pkg:stringstatic
#  str_replace_all str_detect

normalize <- function(x) {
  if (rlang::is_installed("stringi")) {
    return(
      stringi::stri_trans_tolower(
        stringi::stri_trans_general(x, "Any-Latin; Latin-ASCII")
      )
    )
  }

  if (has_utf8_support()) {
    return(tolower(iconv(x, to = "ASCII//TRANSLIT")))
  }

  str_replace_all(x, accented_vowels_regex)
}

has_utf8_support <- function() {
  isTRUE(l10n_info()[["UTF-8"]])
}
