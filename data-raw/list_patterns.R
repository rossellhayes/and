library(archive)
library(digest)
library(dplyr)
library(fs)
library(glue)
library(incase)
library(jsonlite)
library(purrr)
library(rlang)
library(stringr)
library(tidyr)

rlang::check_installed("pak")
if (!rlang::is_installed("poio")) {
  pak::pkg_install(c(
    "git::https://bitbucket.org/richierocks/assertive.base.git",
    "git::https://bitbucket.org/richierocks/assertive.files.git",
    "git::https://bitbucket.org/richierocks/assertive.numbers.git",
    "git::https://bitbucket.org/richierocks/assertive.properties.git",
    "git::https://bitbucket.org/richierocks/assertive.sets.git",
    "git::https://bitbucket.org/richierocks/assertive.strings.git",
    "git::https://bitbucket.org/richierocks/assertive.types.git",
    "RL10N/poio"
  ))
}
library(poio)

tempdir <- tempdir()

archive_files <- archive::archive(
  "https://github.com/unicode-org/cldr-json/archive/refs/heads/main.zip"
) %>%
  pull(path)

archive::archive_extract(
  "https://github.com/unicode-org/cldr-json/archive/refs/heads/main.zip",
  tempdir,
  files = c(
    "cldr-json-main/cldr-json/cldr-localenames-full/main/en/languages.json",
    "cldr-json-main/cldr-json/cldr-localenames-full/main/en/territories.json",
    archive_files %>%
      str_subset(
        "cldr-json-main/cldr-json/cldr-misc-full/main/.+/listPatterns\\.json"
      )
  )
)

languages <- fs::path(
  tempdir,
  "cldr-json-main/cldr-json/cldr-localenames-full/main/en/languages.json"
) %>%
  jsonlite::read_json() %>%
  purrr::pluck("main", "en", "localeDisplayNames", "languages") %>%
  unlist() %>%
  tibble::enframe() |>
  dplyr::bind_rows(
    tibble::tibble(name = "lld", value = "Ladin")
  ) |>
  filter(row_number() == 1, .by = name)

territories <- fs::path(
  tempdir,
  "cldr-json-main/cldr-json/cldr-localenames-full/main/en/territories.json"
) %>%
  jsonlite::read_json() %>%
  purrr::pluck("main", "en", "localeDisplayNames", "territories") %>%
  unlist() %>%
  tibble::enframe() %>%
  filter(!name %in% c("HK", "MM", "MO", "PS")) %>%
  mutate(
    name = case_match(
      name,
      "HK-alt-short" ~ "HK",
      "MM-alt-short" ~ "MM",
      "MO-alt-short" ~ "MO",
      "PS-alt-short" ~ "PS",
      .default = name
    )
  )

list_pattern_files <- fs::dir_ls(
  path(tempdir, "cldr-json-main", "cldr-json", "cldr-misc-full", "main"),
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

simplified_chinese_patterns <- list_patterns_raw %>%
  filter(language == "zh", script == "Hans", is.na(territory)) %>%
  mutate(territory = list(c("CN", "MY", "SG"))) %>%
  unnest(territory)

traditional_chinese_patterns <- list_patterns_raw %>%
  filter(language == "zh", script == "Hant", is.na(territory)) %>%
  mutate(territory = list(c("HK", "MO", "TW"))) %>%
  unnest(territory)

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
  # Remove non-English languages that do not differ from English
  filter(
    !(
      and_start == "{0}, {1}" &
      and_middle == "{0}, {1}" &
      and_end %in% c("{0} {1}", "{0}, {1}", "{0} and {1}", "{0}, and {1}") &
      and_2 %in% c("{0} {1}", "{0}, {1}", "{0} and {1}", "{0}, and {1}") &
      or_start == "{0}, {1}" &
      or_middle == "{0}, {1}" &
      or_end %in% c("{0} {1}", "{0}, {1}", "{0} or {1}", "{0}, or {1}") &
      or_2 %in% c("{0} {1}", "{0}, {1}", "{0} or {1}", "{0}, or {1}")
    ) |
    language == "en"
  ) %>%
  # Remove territories that do not differ from the base case for their language
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
  arrange(language) %>%
  # Remove data that doesn't differ from the fallback language
  mutate(
    and_start = if_else(and_start == "{0}, {1}", NA, and_start),
    and_middle = if_else(and_middle == "{0}, {1}", NA, and_middle),
    and_end = if_else(
      !str_detect(language, "^en") & and_end %in% c("{0} and {1}", "{0}, and {1}"),
      NA, and_end
    ),
    and_2 = if_else(and_2 == "{0} and {1}", NA, and_2),
    or_start = if_else(or_start == "{0}, {1}", NA, or_start),
    or_middle = if_else(or_middle == "{0}, {1}", NA, or_middle),
    or_end = if_else(
      !str_detect(language, "^en") & or_end %in% c("{0} or {1}", "{0}, or {1}"),
      NA, or_end
    ),
    or_2 = if_else(or_2 == "{0} or {1}", NA, or_2)
  )

list_glue_patterns <- list_patterns %>%
  mutate(
    across(
      -starts_with("language"),
      function(x) str_replace_all(x, "\\{(\\d)\\}", "{x\\1}")
    )
  )

list_glue_patterns[list_glue_patterns$language == "cy", ] <-
  list_glue_patterns[list_glue_patterns$language == "cy", ] %>%
  mutate(
    and_end = "{x0} {if (grepl('^[^a-z0-9]*[aeiouwy]', normalize(x1))) 'ac' else 'a'} {x1}",
    and_2 = and_end
  )

list_glue_patterns[list_glue_patterns$language == "es", ] <-
  list_glue_patterns[list_glue_patterns$language == "es", ] %>%
  mutate(
    and_end = "{x0} {if (grepl('^[^a-z0-9]*h?[iy]', normalize(x1))) 'e' else 'y'} {x1}",
    and_2 = and_end,
    or_end = "{x0} {if (grepl('^[^a-z0-9]*(h?o|8)', normalize(x1))) 'u' else 'o'} {x1}",
    or_2 = or_end
  )

list_glue_patterns[list_glue_patterns$language == "it", ] <-
  list_glue_patterns[list_glue_patterns$language == "it", ] %>%
  mutate(
    and_end = "{x0} {if (grepl('^[^a-z0-9]*h?e', normalize(x1))) 'ed' else 'e'} {x1}",
    and_2 = and_end,
    or_end = "{x0} {if (grepl('^[^a-z0-9]*(h?o|8)', normalize(x1))) 'od' else 'o'} {x1}",
    or_2 = or_end
  )

list_glue_patterns[list_glue_patterns$language == "lb", ] <-
  list_glue_patterns[list_glue_patterns$language == "lb", ] %>%
  mutate(
    and_end = "{x0} {if (grepl('^[^a-z0-9]*([aeioudhntz012389]|y[bcdfghjklmnpqrstvwxz])', normalize(x1))) 'an' else 'a'} {x1}",
    and_2 = and_end
  )

list_glue_patterns <- list_glue_patterns %>%
  rename_with(
    .cols = c(ends_with("start"), ends_with("middle")),
    ~ paste0("{x0}, {x1}{tag(", ., ")}")
  ) %>%
  rename(
    "{x0}, and {x1}{tag(and_end)}" = and_end,
    "{x0} and {x1}{tag(and_2)}" = and_2,
    "{x0}, or {x1}{tag(or_end)}" = or_end,
    "{x0} or {x1}{tag(or_2)}" = or_2
  )

metadata <- tribble(
  ~ name,                      ~ value,
  "Project-Id-Version",        "and 0.0.0.9000",
  "POT-Creation-Date",         format(Sys.time(), format = "%Y-%m-%d"),
  "PO-Revision-Date",          format(Sys.time(), format = "%Y-%m-%d"),
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
      cli::cli_bullets(c("*" = "Building {.val {row$language}}"))

      po <- generate_po_from_pot(pot, lang = row$language)

      if (is.na(po$metadata[po$metadata$name == "Plural-Forms", "value"])) {
        po$metadata[po$metadata$name == "Plural-Forms", "value"] <-
          "nplurals=1; plural=0;"
      }

      po$initial_comments <- c(po$initial_comments, row$language_full)

      data <- row %>%
        select(-starts_with("language")) %>%
        pivot_longer(everything(), names_to = "msgid", values_to = "msgstr")

      po$direct <- po$direct %>%
        select(-msgstr) %>%
        left_join(data, by = "msgid") %>%
        relocate(msgstr, .after = 1) %>%
        drop_na(msgstr)

      po
    }
  )

# Install po files
po_files %>%
  purrr::iwalk(
    function(po, language) {
      path <- glue("po/R-{language}.po")
      cli::cli_bullets(c("*" = "Installing {.path {path}}"))

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
