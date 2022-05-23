library(future)
library(here)
plan("multisession")
library(targets)

tar_config_set(
  store = "data-raw/_targets",
  script = "data-raw/_targets.R",
  workers = max(availableCores() - 1, 1),
  config = "data-raw/_targets.yaml"
)

tar_make_future()
