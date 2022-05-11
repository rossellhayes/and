accented_vowels <- list(
  unicode = "ÁÀÂÄÉÈÊËÍÌÎÏÓÒÔÖÚÙÛÜẂẀŴẄÝỲŶŸáàâäéèêëíìîïóòôöúùûüẃẁŵẅýỳŷÿ",
  ascii   = "AAAAEEEEIIIIOOOOUUUUWWWWYYYYaaaaeeeeiiiioooouuuuwwwwyyyy"
)

accented_vowels_regex <- c(
  "[ÁÀÂÄ]" = "A",
  "[ÉÈÊË]" = "E",
  "[ÍÌÎÏ]" = "I",
  "[ÓÒÔÖ]" = "O",
  "[ÚÙÛÜ]" = "U",
  "[ẂẀŴẄ]" = "W",
  "[ÝỲŶŸ]" = "Y",
  "[áàâä]" = "a",
  "[éèêë]" = "e",
  "[íìîï]" = "i",
  "[óòôö]" = "o",
  "[úùûü]" = "u",
  "[ẃẁŵẅ]" = "w",
  "[ýỳŷÿ]" = "y"
)

usethis::use_data(
  accented_vowels, accented_vowels_regex,
  internal = TRUE, overwrite = TRUE
)
