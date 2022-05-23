cldr_targets <- list2(
  tar_target(
    cldr_archive,
    "https://github.com/unicode-org/cldr-json/archive/refs/heads/main.zip",
    format = "url"
  ),
  tar_target(cldr_archive_files, archive::archive(cldr_archive) %>% pull(path)),
  tar_target(
    cldr_files,
    archive::archive_extract(
      cldr_archive,
      "data-raw",
      files = c(
        "cldr-json-main/cldr-json/cldr-localenames-modern/main/en/languages.json",
        "cldr-json-main/cldr-json/cldr-localenames-modern/main/en/territories.json",
        stringr::str_subset(cldr_archive_files, "(listPatterns|posix)\\.json$")
      )
    ) %>%
      fs::path("data-raw", .)
  ),

  tar_target(
    languages,
    cldr_files %>%
      fs::path_filter("*/languages.json") %>%
      jsonlite::read_json() %>%
      purrr::pluck("main", "en", "localeDisplayNames", "languages") %>%
      unlist() %>%
      tibble::enframe()
  ),

  tar_target(
    territories,
    cldr_files %>%
      fs::path_filter("*/territories.json") %>%
      jsonlite::read_json() %>%
      purrr::pluck("main", "en", "localeDisplayNames", "territories") %>%
      unlist() %>%
      tibble::enframe()
  ),

  tar_target(
    list_patterns_raw,
    map_dfr(
      cldr_files,
      function(file) {
        data <- jsonlite::read_json(file)[[1]][[1]]

        tibble::tibble(
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
  ),

  tar_target(
    yesno_raw,
    map_dfr(
      cldr_files,
      function(file) {
        data <- jsonlite::read_json(file)[[1]][[1]]

        tibble::tibble(
          language = data$identity$language,
          script = data$identity$script,
          variant = data$identity$variant,
          territory = data$identity$territory,
          as_tibble(data$posix$messages)
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
  ),

  tar_target(
    data_raw,
    full_join(
      list_patterns_raw, yesno_raw, by = c("language", "script", "territory")
    )
  ),

  tar_target(
    all_data,
    (function(data_raw) {
      data_raw[data_raw$language == "en" & is.na(data_raw$territory), ] <-
        data_raw[data_raw$language == "en" & is.na(data_raw$territory), ] %>%
        mutate(territory = "US")

      data_raw[data_raw$language == "en" & data_raw$territory == "GB", ] <-
        data_raw[data_raw$language == "en" & data_raw$territory == "GB", ] %>%
        mutate(territory = NA)

      simplified_chinese_data <- data_raw %>%
        filter(language == "zh", script == "Hans", is.na(territory)) %>%
        select(-territory) %>%
        mutate(script = NA) %>%
        crossmap::cross_join(tibble(territory = c("CN", "MY", "SG")))

      traditional_chinese_data <- data_raw %>%
        filter(language == "zh", script == "Hant", is.na(territory)) %>%
        select(-territory) %>%
        mutate(script = NA) %>%
        crossmap::cross_join(tibble(territory = c("HK", "MO", "TW")))

      bind_rows(data_raw, simplified_chinese_data, traditional_chinese_data) %>%
        filter(is.na(script)) %>%
        select(-script) %>%
        distinct()
    })(data_raw)
  ),

  tar_target(
    data,
    all_data %>%
      # Remove languages that do not differ from English
      filter(
        !(
          language != "en" &
            (str_detect(and_end, "and") | str_detect(and_end, fixed("{0}, {1}"))) &
            (str_detect(and_2, "and") | str_detect(and_2, fixed("{0}, {1}"))) &
            str_detect(or_end, "or") &
            str_detect(or_2, "or") &
            str_detect(yesstr, "(?i)yes") &
            str_detect(nostr, "(?i)no")
        )
      ) %>%
      # Remove territories that do not differ from base case
      filter(
        map2_lgl(
          language, territory,
          function(this_language, this_territory) {
            if (is.na(this_territory)) {
              return(TRUE)
            }

            matched_data <- filter(
              all_data,
              language == this_language,
              territory == this_territory | is.na(territory)
            ) %>%
              select(-territory)

            nrow(distinct(matched_data)) > 1
          }
        )
      ) %>%
      left_join(territories, by = c("territory" = "name")) %>%
      mutate(territory_full = value, .keep = "unused") %>%
      left_join(languages, by = c("language" = "name")) %>%
      mutate(
        language_full = if_else(
          is.na(territory_full),
          value,
          paste0(value, " (", territory_full, ")")
        ),
        language = if_else(
          is.na(territory),
          language,
          paste(language, territory, sep = "_")
        ),
        .before = 1,
        .keep = "unused"
      ) %>%
      arrange(language)
  ),

  tar_target(
    glue_data,
    (function(data) {
      # Fix typo in Khmer
      data[data$language == "km", ] <-
        data[data$language == "km", ] %>%
        mutate(
          yesstr = str_remove(yesstr, " y"),
          nostr = str_remove(nostr, " n"),
        )

      glue_data <- data %>%
        mutate(
          across(
            c(starts_with("and"), starts_with("or")),
            str_replace_all, "\\{(\\d)\\}", "{x\\1}"
          )
        ) %>%
        mutate(
          yes = str_replace(yesstr, "(.*?):.*", "\\1") %>%
            stringi::stri_trans_totitle(type = "sentence"),
          yes_alt = str_replace(yesstr, "/", ":") %>%
            stringi::stri_trans_tolower(),
          no = str_replace(nostr, "(.*?):.*", "\\1") %>%
            stringi::stri_trans_totitle(type = "sentence"),
          no_alt = str_replace(nostr, "/", ":") %>%
            stringi::stri_trans_tolower(),
          # Add "y" and "n" as alternates for all languages
          # (unless "y" and "n" are alternates for the opposite!)
          yes_alt = if_else(
            str_detect(yes_alt, "(?i)y") | str_detect(no_alt, "(?i)y"),
            true = yes_alt,
            false = paste0(yes_alt, ":y")
          ),
          no_alt = if_else(
            str_detect(yes_alt, "(?i)n") | str_detect(no_alt, "(?i)n"),
            true = no_alt,
            false = paste0(no_alt, ":n")
          ),
          .keep = "unused"
        )

      glue_data[glue_data$language == "cy", ] <-
        glue_data[glue_data$language == "cy", ] %>%
        mutate(
          and_end = "{x0} {if (grepl('^[^a-z0-9]*[aeiouwy]', normalize(x1))) 'ac' else 'a'} {x1}",
          and_2 = and_end
        )

      glue_data[glue_data$language == "es", ] <-
        glue_data[glue_data$language == "es", ] %>%
        mutate(
          and_end = "{x0} {if (grepl('^[^a-z0-9]*h?[iy]', normalize(x1))) 'e' else 'y'} {x1}",
          and_2 = and_end,
          or_end = "{x0} {if (grepl('^[^a-z0-9]*(h?o|8)', normalize(x1))) 'u' else 'o'} {x1}",
          or_2 = or_end
        )

      glue_data[glue_data$language == "it", ] <-
        glue_data[glue_data$language == "it", ] %>%
        mutate(
          and_end = "{x0} {if (grepl('^[^a-z0-9]*h?e', normalize(x1))) 'ed' else 'e'} {x1}",
          and_2 = and_end,
          or_end = "{x0} {if (grepl('^[^a-z0-9]*(h?o|8)', normalize(x1))) 'od' else 'o'} {x1}",
          or_2 = or_end
        )

      glue_data <- glue_data %>%
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
        ) %>%
        rename(
          "y{tag(yes_alt)}" = yes_alt,
          "n{tag(no_alt)}" = no_alt,
        )
    })(data)
  ),

  tar_target(
    poio_metadata,
    tibble::tribble(
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
  ),

  tar_target(
    poio_direct,
    tibble::tibble(
      msgid = setdiff(names(glue_data), c("language", "language_full"))
    ) %>%
      mutate(
        msgstr = "",
        is_obsolete = FALSE,
        msgctxt = list(character(0)),
        translator_comments = list(character(0)),
        source_reference_comments = list(character(0)),
        flags_comments = list(character(0)),
        previous_string_comments = list(character(0)),
        msgkey = digest::digest(c(msgid, msgctxt), algo = "xxhash32")
      )
  ),

  tar_target(
    pot,
    poio::po(
      source_type = "r",
      file_type = "pot",
      initial_comments = "Read only. This file is automatically generated from data-raw/_targets.R",
      metadata = poio_metadata,
      direct = poio_direct
    )
  ),
  tar_target(
    write_pot,
    (function(pot) {
      fs::dir_create("po")
      try(fs::file_chmod("po/R-and.pot", "u+w"), silent = TRUE)
      poio::write_po(pot, "po/R-and.pot")
      fs::file_chmod("po/R-and.pot", "u-w")
    })(pot),
    format = "file"
  ),

  tar_target(
    po_files,
    glue_data %>%
      group_by(language) %>%
      group_split() %>%
      purrr::set_names(glue_data$language) %>%
      purrr::map(
        function(row) {
          cli::cli_bullets(c("*" = "Building {.path {row$language}}"))

          po <- poio::generate_po_from_pot(pot, lang = row$language)

          po$initial_comments <- c(po$initial_comments, row$language_full)

          data <- row %>%
            select(-starts_with("language")) %>%
            tidyr::pivot_longer(
              everything(), names_to = "msgid", values_to = "msgstr"
            )

          po$direct <- po$direct %>%
            select(-msgstr) %>%
            left_join(data, by = "msgid") %>%
            relocate(msgstr, .after = 1)

          po
        }
      )
  ),
  tar_target(
    write_po_files,
    po_files %>%
      purrr::iwalk(
        function(po, language) {
          cli::cli_bullets(c("*" = "Installing {.path {language}}"))
          path <- glue("po/R-{language}.po")

          try(file_chmod(path, "u+w"), silent = TRUE)
          poio::write_po(po, path)
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
  )
)
