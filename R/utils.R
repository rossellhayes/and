tag <- function(...) {
  return("")
}

ascii <- function(x) {
  stringi::stri_trans_tolower(stringi::stri_trans_general(x, "Latin-ASCII"))
}
