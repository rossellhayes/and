#' Supported languages
#'
#' ```{r echo = FALSE}
#' knitr::kable(
#'   and_languages,
#'   col.names = c("**Language**", "**Code**", "**Examples**", "", "", "")
#' )
#' ```
#'
#' @format A data frame with 3 variables:
#' \describe{
#'   \item{language}{The name of the language, possibly with a territory in parentheses}
#'   \item{code}{The language code}
#'   \item{example_and_2}{An example of a conjunctive list with two elements in the language}
#'   \item{example_and_3}{An example of a conjunctive list with three elements in the language}
#'   \item{example_or_2}{An example of a disjunctive list with two elements in the language}
#'   \item{example_or_3}{An example of a disjunctive list with three elements in the language}
#' }
#'
#' @source Language data is derived from the
#'   [Unicode Common Locale Data Repository (CLDR)](https://cldr.unicode.org/)
"and_languages"