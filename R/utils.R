tag <- function(...) {
  return("")
}

ascii <- function(x) {
  tolower(normalize(x))
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
