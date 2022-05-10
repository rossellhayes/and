tag <- function(...) {
  return("")
}

ascii <- function(x) {
  tolower(iconv(x, to = "ASCII//TRANSLIT"))
}
