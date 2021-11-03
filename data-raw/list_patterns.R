library(archive)
library(fs)
library(jsonlite)
library(poio)
library(rlang)
library(stringr)

tempdir <- tempdir()

archive::archive_extract(
  "https://github.com/unicode-org/cldr-json/archive/refs/heads/main.zip",
  tempdir
)

list_pattern_files <- fs::dir_ls(
  fs::path(tempdir, "cldr-json-main", "cldr-json", "cldr-misc-full", "main"),
  recurse = TRUE, glob = "*/listPatterns.json"
)

list_patterns <- list_pattern_files %>%
  purrr::map(
    function (x) {
      data <- jsonlite::read_json(x)[[1]][[1]]

      language  <- data$identity$language
      script    <- data$identity$script
      territory <- data$identity$territory

      if (language == "zh") {
        if (is.null(territory) && identical(script, "Hant")) {
          territory <- "TW"
        } else if (
          identical(script, "Hans") &&
          !(identical(territory, "SG") || identical(territory, NULL))
        ) {
          return(0)
        }
      } else if (!is.null(script)) {
        return(0)
      } else if (language == "en") {
        if (is.null(territory)) {
          territory <- "US"
        } else if (territory == "GB") {
          territory <- NULL
        }
      }

      if (!is.null(territory)) {
        language <- paste(language, territory, sep = "_")
      }

      if (identical(language, "zh") && identical(script, "Hant")) {
        language <- "zh_TW"
      }

      and <- data$listPatterns$`listPattern-type-standard` %>%
        purrr::map(
          ~ str_replace_all(., c("\\{0\\}" = "{x[1]}", "\\{1\\}" = "{x[2]}"))
        )

      or <- data$listPatterns$`listPattern-type-or` %>%
        purrr::map(
          ~ str_replace_all(., c("\\{0\\}" = "{x[1]}", "\\{1\\}" = "{x[2]}"))
        )

      purrr::compact(rlang::dots_list(language, and, or, .named = TRUE))
    }
  ) %>%
  purrr::discard(~ identical(., 0)) %>%
  rlang::set_names(purrr::map_chr(., ~ .$language))

identical_variants <- list_patterns %>%
  purrr::map_lgl(
    function(x) {
      if (!grepl("_", x$language)) {return(FALSE)}
      base <- list_patterns[[gsub("_.*", "", x$language)]]
      identical(x[-1], base[-1])
    }
  )

list_patterns[identical_variants] <- NULL

poio::

usethis::use_data(list_patterns, overwrite = TRUE)
