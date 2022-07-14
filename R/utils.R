tag <- function(...) {
  return("")
}

# @staticimports pkg:staticimports
#  is_windows

# @staticimports pkg:stringstatic
#  str_replace_all

normalize <- function(x) {
  if (rlang::is_installed("stringi")) {
    return(
      stringi::stri_trans_tolower(
        stringi::stri_trans_general(x, "Any-Latin; Latin-ASCII")
      )
    )
  }

  if (!is_windows()) {
    ascii <- iconv(x, to = "ASCII//TRANSLIT")
  }

  if (is_windows() || is.na(ascii)) {
    ascii <- str_replace_all(x, accented_vowels_regex)
  }

  tolower(ascii)
}
