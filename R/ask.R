ask <- function(..., randomize = FALSE) {
  if (!interactive()) {stop("`ask()` cannot be used non-interactively.")}

  if (randomize) {
    yes_num <- sample(1:2, 1)
    no_num  <- setdiff(1:2, yes_num)
  } else {
    yes_num <- 1
    no_num  <- 2
  }

  yes <- paste(yes_num, gettext("yes", domain = "R-and"), sep = ": ")
  no  <- paste(no_num,  gettext("no", domain = "R-and"),  sep = ": ")

  yes_alt <- c(
    unlist(strsplit(gettext("y{tag(yes_alt)}", domain = "R-and"), ":")),
    yes_num
  )
  no_alt <- c(
    unlist(strsplit(gettext("n{tag(no_alt)}", domain = "R-and"), ":")),
    no_num
  )

  repeat {
    cat(..., "\n", sep = "")
    cat(sort(c(yes, no)), sep = "\n")

    response <- readline(prompt = "> ")
    if (response %in% yes_alt) {return(TRUE)}
    if (response %in% no_alt) {return(FALSE)}
    if (response == 0) {return(NA)}
  }
}
