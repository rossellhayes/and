library(archive)
library(crossmap)
library(digest)
library(dplyr)
library(fs)
library(glue)
library(jsonlite)
library(poio)
library(purrr)
library(rlang)
library(stringr)
library(tidyr)

tempdir <- tempdir()

archive_files <- archive::archive(
  "https://github.com/unicode-org/cldr-json/archive/refs/heads/main.zip"
) %>%
  pull(path)

archive::archive_extract(
  "https://github.com/unicode-org/cldr-json/archive/refs/heads/main.zip",
  tempdir,
  files = c(
    "cldr-json-main/cldr-json/cldr-localenames-modern/main/en/languages.json",
    "cldr-json-main/cldr-json/cldr-localenames-modern/main/en/territories.json",
    archive_files %>%
      str_subset(
        "cldr-json-main/cldr-json/cldr-misc-modern/main/.+/listPatterns\\.json"
      )
  )
)

languages <- fs::path(
  tempdir,
  "cldr-json-main/cldr-json/cldr-localenames-modern/main/en/languages.json"
) %>%
  jsonlite::read_json() %>%
  purrr::pluck("main", "en", "localeDisplayNames", "languages") %>%
  unlist() %>%
  tibble::enframe()

territories <- fs::path(
  tempdir,
  "cldr-json-main/cldr-json/cldr-localenames-modern/main/en/territories.json"
) %>%
  jsonlite::read_json() %>%
  purrr::pluck("main", "en", "localeDisplayNames", "territories") %>%
  unlist() %>%
  tibble::enframe()

list_pattern_files <- fs::dir_ls(
  path(tempdir, "cldr-json-main", "cldr-json", "cldr-misc-modern", "main"),
  recurse = TRUE, glob = "*/listPatterns.json"
)

list_patterns_raw <- list_pattern_files %>%
  map_dfr(
    function(file) {
      data <- read_json(file)[[1]][[1]]

      tibble(
        language = data$identity$language,
        script = data$identity$script,
        variant = data$identity$variant,
        territory = data$identity$territory,
        data$listPatterns$`listPattern-type-standard` %>%
          as_tibble() %>%
          rename_with(~ paste0("and_", .)),
        data$listPatterns$`listPattern-type-or` %>%
          as_tibble()%>%
          rename_with(~ paste0("or_", .))
      )
    }
  ) %>%
  relocate(language, script, variant, territory) %>%
  filter(
    nchar(language) %in% 2:3,
    is.na(variant),
    is.na(territory) | str_detect(territory, "^[A-Z]{2}$")
  ) %>%
  select(-variant)

list_patterns_raw[list_patterns_raw$language == "en" & is.na(list_patterns_raw$territory), ] <-
  list_patterns_raw[list_patterns_raw$language == "en" & is.na(list_patterns_raw$territory), ] %>%
  mutate(territory = "US")

list_patterns_raw[list_patterns_raw$language == "en" & list_patterns_raw$territory == "GB", ] <-
  list_patterns_raw[list_patterns_raw$language == "en" & list_patterns_raw$territory == "GB", ] %>%
  mutate(territory = NA)

simplified_chinese_patterns <- list_patterns_raw %>%
  filter(language == "zh", script == "Hans", is.na(territory)) %>%
  select(-territory) %>%
  mutate(script = NA) %>%
  cross_join(tibble(territory = c("CN", "MY", "SG")))

traditional_chinese_patterns <- list_patterns_raw %>%
  filter(language == "zh", script == "Hant", is.na(territory)) %>%
  select(-territory) %>%
  mutate(script = NA) %>%
  cross_join(tibble(territory = c("HK", "MO", "TW")))

all_list_patterns <- bind_rows(
  list_patterns_raw,
  simplified_chinese_patterns,
  traditional_chinese_patterns
) %>%
  filter(is.na(script)) %>%
  select(-script) %>%
  left_join(territories, by = c("territory" = "name"), copy = TRUE) %>%
  mutate(territory_full = value, .keep = "unused") %>%
  left_join(languages, by = c("language" = "name"), copy = TRUE) %>%
  mutate(
    language_full = if_else(
      is.na(territory_full), value,
      paste0(value, " (", territory_full, ")")
    ),
    .before = 1,
    .keep = "unused"
  )

list_patterns <- all_list_patterns %>%
  # Remove territories that do not differ from base case
  filter(
    map2_lgl(
      language, territory,
      function(this_language, this_territory) {
        if (is.na(this_territory)) {
          return(TRUE)
        }

        matched_data <- filter(
          all_list_patterns,
          language == this_language,
          territory == this_territory | is.na(territory)
        ) %>%
          select(-language_full, -territory)

        nrow(distinct(matched_data)) > 1
      }
    )
  ) %>%
  mutate(
    language = if_else(
      is.na(territory),
      language,
      paste(language, territory, sep = "_"))
  ) %>%
  select(-territory) %>%
  arrange(language)

list_glue_patterns <- list_patterns %>%
  mutate(
    across(-starts_with("language"), str_replace_all, "\\{(\\d)\\}", "{x\\1}")
  )

list_glue_patterns[list_glue_patterns$language == "cy", ] <-
  list_glue_patterns[list_glue_patterns$language == "cy", ] %>%
  mutate(
    and_end = "{x0} {if (grepl('^[^a-z0-9]*[aeiouwy]', ascii(x1))) 'ac' else 'a'} {x1}",
    and_2 = and_end
  )

list_glue_patterns[list_glue_patterns$language == "es", ] <-
  list_glue_patterns[list_glue_patterns$language == "es", ] %>%
  mutate(
    and_end = "{x0} {if (grepl('^[^a-z0-9]*h?[iy]', ascii(x1))) 'e' else 'y'} {x1}",
    and_2 = and_end,
    or_end = "{x0} {if (grepl('^[^a-z0-9]*(h?o|8)', ascii(x1))) 'u' else 'o'} {x1}",
    or_2 = or_end
  )

list_glue_patterns[list_glue_patterns$language == "it", ] <-
  list_glue_patterns[list_glue_patterns$language == "it", ] %>%
  mutate(
    and_end = "{x0} {if (grepl('^[^a-z0-9]*h?e', ascii(x1))) 'ed' else 'e'} {x1}",
    and_2 = and_end,
    or_end = "{x0} {if (grepl('^[^a-z0-9]*(h?o|8)', ascii(x1))) 'od' else 'o'} {x1}",
    or_2 = or_end
  )

list_glue_patterns <- list_glue_patterns %>%
  rename_with(
    .cols = c(ends_with("start"), ends_with("middle")),
    ~ paste0("{x0}, {x1}{tag(", ., ")}")
  ) %>%
  rename_with(
    .cols = c(and_end, and_2),
    ~ paste0("{x0} and {x1}{tag(", ., ")}")
  ) %>%
  rename_with(
    .cols = c(or_end, or_2),
    ~ paste0("{x0} or {x1}{tag(", ., ")}")
  )

metadata <- tribble(
  ~ name,                      ~ value,
  "Project-Id-Version",        "and 0.0.0.9000",
  "POT-Creation-Date",         format(Sys.time(), format = "%Y-%m-%d %H:%M %Z"),
  "PO-Revision-Date",          format(Sys.time(), format = "%Y-%m-%d %H:%M %Z"),
  "Last-Translator",           "Alexander Rossell Hayes <alexander@rossellhayes.com>",
  "Language-Team",             "Alexander Rossell Hayes <alexander@rossellhayes.com>",
  "Language",                  " ",
  "MIME-Version",              "1.0",
  "Content-Type",              "text/plain; charset=UTF-8",
  "Content-Transfer-Encoding", "8bit"
)

direct <- tibble(
  msgid = setdiff(names(list_glue_patterns), c("language", "language_full"))
) %>%
  mutate(
    msgstr = "",
    is_obsolete = FALSE,
    msgctxt = list(character(0)),
    translator_comments = list(character(0)),
    source_reference_comments = list(character(0)),
    flags_comments = list(character(0)),
    previous_string_comments = list(character(0)),
    msgkey = digest(c(msgid, msgctxt), algo = "xxhash32")
  )

pot <- po(
  source_type = "r",
  file_type = "pot",
  initial_comments = "Read only. This file is automatically generated from data-raw/list_patterns.R",
  metadata = metadata,
  direct = direct
)

dir_create("po")
try(file_chmod("po/R-and.pot", "u+w"), silent = TRUE)
write_po(pot, "po/R-and.pot")
file_chmod("po/R-and.pot", "u-w")

po_files <- list_glue_patterns %>%
  group_by(language) %>%
  group_split() %>%
  set_names(list_glue_patterns$language) %>%
  purrr::map(
    function(row) {
      cli::cli_bullets(c("*" = "Building {.path {row$language}}"))

      po <- generate_po_from_pot(pot, lang = row$language)

      po$initial_comments <- c(po$initial_comments, row$language_full)

      data <- row %>%
        select(-starts_with("language")) %>%
        pivot_longer(everything(), names_to = "msgid", values_to = "msgstr")

      po$direct <- po$direct %>%
        select(-msgstr) %>%
        left_join(data, by = "msgid") %>%
        relocate(msgstr, .after = 1)

      po
    }
  )

# Install po files
po_files %>%
  purrr::iwalk(
    function(po, language) {
      cli::cli_bullets(c("*" = "Installing {.path {language}}"))
      path <- glue("po/R-{language}.po")

      try(file_chmod(path, "u+w"), silent = TRUE)
      write_po(po, path)
      file_chmod(path, "u-w")

      inst_path <- path("inst", "po", language, "LC_MESSAGES")
      dir_create(inst_path, recurse = TRUE)
      inst_path <- path(inst_path, "R-and.mo")
      cmd <- paste(
        "msgfmt -c --statistics -o", shQuote(inst_path), shQuote(path)
      )
      if (system(cmd) != 0L) {
        warning(glue("running msgfmt on {path_file(path)} failed"))
      }
    }
  )
