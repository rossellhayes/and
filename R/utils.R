tag <- function(...) {
  return("")
}

ascii <- function(x) {
  if (rlang::is_installed("stringi")) {
    return(
      stringi::stri_trans_tolower(
        stringi::stri_trans_general(x, "Any-Latin; Latin-ASCII")
      )
    )
  }

  ascii <- iconv(x, to = "ASCII//TRANSLIT")

  if (is.na(ascii)) {
    ascii <- tryCatch(
      chartr(accented_vowels$unicode, accented_vowels$ascii, x),
      error = function(e) {
        str_replace_all(x, accented_vowels_regex)
      }
    )
  }

  tolower(ascii)
}

str_replace_all <- function(text, pattern, replacement) {
  if (!is.null(names(pattern))) {
    for (i in seq_along(pattern)) {
      text <- gsub(
        pattern = names(pattern)[[i]],
        replacement = pattern[[i]],
        x = text,
        perl = TRUE
      )
    }

    return(text)
  }

  gsub(pattern = pattern, replacement = replacement, x = text, perl = TRUE)
}
