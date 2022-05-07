set_language <- function(language) {
  old_language <- Sys.getenv("LANGUAGE", unset = "en")
  old_text <- gettext("{x0}, {x1}{tag(and_start)}", domain = "R-and")

  Sys.setenv("LANGUAGE" = language)

  new_language <- Sys.getenv("LANGUAGE", unset = "en")
  new_text <- gettext("{x0}, {x1}{tag(and_start)}", domain = "R-and")

  if (!identical(old_language, new_language) && identical(old_text, new_text)) {
    # On Linux, message translations are cached
    # Messages from the old language may be shown in the new language
    # If this happens, invalidate the cache so new messages have to generate
    base_dir <- bindtextdomain("R-base")
    bindtextdomain("R-base", tempfile())
    bindtextdomain("R-base", base_dir)
  }

  return(old_language)
}

ascii <- function(x) {
  stringi::stri_trans_tolower(stringi::stri_trans_general(x, "Latin-ASCII"))
}
