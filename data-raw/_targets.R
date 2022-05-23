library(rlang)
library(targets)

tar_option_set(
  packages = readLines("data-raw/_packages"),
  format = "qs"
)

source("data-raw/cldr_targets.R")

list2(
  yesno_targets
)
