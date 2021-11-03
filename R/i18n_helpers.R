set_lang <- function(lang) {
  old_lang <- Sys.getenv("LANGUAGE", unset = "en")
  old_text <- gettext("{''} and {''}", domain = "R-and")

  Sys.setenv("LANGUAGE" = lang)

  new_lang <- Sys.getenv("LANGUAGE", unset = "en")
  new_text <- gettext("{''} and {''}", domain = "R-and")

  if (!identical(old_lang, new_lang) && identical(old_text, new_text)) {
    # On Linux, message translations are cached
    # Messages from the old language may be shown in the new language
    # If this happens, invalidate the cache so new messages have to generate
    base_dir <- bindtextdomain("R-base")
    bindtextdomain("R-base", tempfile())
    bindtextdomain("R-base", base_dir)
  }

  return(old_lang)
}

ascii <- function(x) {
  stringi::stri_trans_tolower(stringi::stri_trans_general(x, "Latin-ASCII"))
}
