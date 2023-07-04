library(dplyr)
library(fs)
library(poio)
library(purrr)
library(stringr)
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
    example_and_4 = map_chr(code, ~ and(1:4, language = .)),
    example_or_2  = map_chr(code, ~ or(1:2, language = .)),
    example_or_4  = map_chr(code, ~ or(1:4, language = .)),
    across(
      starts_with("example"),
      function(x) {
        is_rtl <- grepl(
          "[\u0591-\u07FF\u200F\u202B\u202E\uFB1D-\uFDFD\uFE70-\uFEFC]",
          x,
          perl = TRUE
        )

        x[is_rtl] <- paste0("\u200F", x[is_rtl], "\u200E")
        x
      }
    ),
    support = if_else(
      !str_detect(language, "English") & (
        example_and_2 == example_and_2[language == "English"] |
        example_and_4 == example_and_4[language == "English"] |
        example_or_2 == example_or_2[language == "English"] |
        example_or_4 == example_or_4[language == "English"]
      ),
      "partial",
      "full"
    )
  ) %>%
  arrange(str_detect(language, "English"), language)

usethis::use_data(and_languages, overwrite = TRUE)
