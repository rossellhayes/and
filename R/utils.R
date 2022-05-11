tag <- function(...) {
  return("")
}

ascii <- function(x) {
  x <- tryCatch(
    chartr(accented_vowels$unicode, accented_vowels$ascii, x),
    error = function(e) {
      str_replace_all(x, accented_vowels_regex)
    }
  )

  x <- iconv(x, to = "ASCII//TRANSLIT")
  tolower(x)
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
