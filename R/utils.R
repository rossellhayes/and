tag <- function(...) {
  return("")
}

ascii <- function(x) {
  x <- chartr(accented_vowels$unicode, accented_vowels$ascii, x)
  x <- iconv(x, to = "ASCII//TRANSLIT")
  tolower(x)
}
