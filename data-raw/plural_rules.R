library(purrr)
library(rlang)
library(rvest)
library(xml2)

plural_rules <- read_html("https://php-gettext.github.io/Languages/") %>%
  html_elements(".table > tbody > tr") %>%
  purrr::map(
    function(x) {
      language  <- html_element(x, "td:nth-child(1)") %>% html_text()
      n_plurals <- html_element(x, "td:nth-child(3)") %>% html_text()
      formula   <- html_element(x, "td:nth-child(4)") %>% html_text()

      rlang::list2(
        language = language,
        plurals = paste0("nplurals=", n_plurals, "; plural=", formula, ";")
      )
    }
  ) %>%
  set_names(purrr::map_chr(., ~ .$language))

usethis::use_data(plural_rules, overwrite = TRUE)
