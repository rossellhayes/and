library(conflicted)
library(dplyr)
conflict_prefer("filter", "dplyr")
library(fs)
library(poio)
library(purrr)
devtools::load_all()

and_languages <- fs::dir_ls("po", glob = "*.po") %>%
  map_dfr(function(po) {
    po <- poio::read_po(po)
    tibble(
      language = po$initial_comments[[2]],
      code = po$metadata %>% filter(name == "Language") %>% pull(value)
    )
  }) %>%
  mutate(
    example_and_2 = map_chr(code, ~ and(1:2, language = .)),
    example_and_3 = map_chr(code, ~ and(1:3, language = .)),
    example_or_2  = map_chr(code, ~ or(1:2, language = .)),
    example_or_3  = map_chr(code, ~ or(1:3, language = .)),
  )

use_data(and_languages, overwrite = TRUE)
