#' Supported languages
#'
#' A list of supported languages and examples of their usage.
#'
#' @format A data frame with 6 variables:
#' \describe{
#'   \item{language}{The name of the language, possibly with a territory in parentheses}
#'   \item{code}{The language code}
#'   \item{example_and_2}{An example of a conjunctive list with two elements in the language}
#'   \item{example_and_4}{An example of a conjunctive list with four elements in the language}
#'   \item{example_or_2}{An example of a disjunctive list with two elements in the language}
#'   \item{example_or_4}{An example of a disjunctive list with four elements in the language}
#'   \item{support}{Either "full" or "partial". Partially supported languages generally localize [and()] but not [or()].}
#' }
#'
#' @source Language data is derived from the
#'   [Unicode Common Locale Data Repository (CLDR)](https://cldr.unicode.org/)
"and_languages"
