test_that("and", {
  names <- c("John", "Paul", "George", "Ringo")

  expect_equal(withr::with_language("en_US", and(1:2)), "1 and 2")
  expect_equal(withr::with_language("en_US", and(1:4)), "1, 2, 3, and 4")
  expect_equal(withr::with_language("en_US", and(names)), "John, Paul, George, and Ringo")

  skip_on_cran()

  expect_equal(withr::with_language("en_GB", and(1:2)), "1 and 2")
  expect_equal(withr::with_language("ca",    and(1:2)), "1 i 2")
  expect_equal(withr::with_language("cy",    and(1:2)), "1 a 2")
  expect_equal(withr::with_language("es",    and(1:2)), "1 y 2")
  expect_equal(withr::with_language("eu",    and(1:2)), "1 eta 2")
  expect_equal(withr::with_language("fr",    and(1:2)), "1 et 2")
  expect_equal(withr::with_language("it",    and(1:2)), "1 e 2")
  expect_equal(withr::with_language("pt",    and(1:2)), "1 e 2")

  expect_equal(withr::with_language("en_GB", and(1:4)), "1, 2, 3 and 4")
  expect_equal(withr::with_language("ca",    and(1:4)), "1, 2, 3 i 4")
  expect_equal(withr::with_language("cy",    and(1:4)), "1, 2, 3 a 4")
  expect_equal(withr::with_language("es",    and(1:4)), "1, 2, 3 y 4")
  expect_equal(withr::with_language("eu",    and(1:4)), "1, 2, 3 eta 4")
  expect_equal(withr::with_language("fr",    and(1:4)), "1, 2, 3 et 4")
  expect_equal(withr::with_language("it",    and(1:4)), "1, 2, 3 e 4")
  expect_equal(withr::with_language("pt",    and(1:4)), "1, 2, 3 e 4")

  expect_equal(withr::with_language("en_GB", and(names)), "John, Paul, George and Ringo")
  expect_equal(withr::with_language("ca",    and(names)), "John, Paul, George i Ringo")
  expect_equal(withr::with_language("cy",    and(names)), "John, Paul, George a Ringo")
  expect_equal(withr::with_language("es",    and(names)), "John, Paul, George y Ringo")
  expect_equal(withr::with_language("eu",    and(names)), "John, Paul, George eta Ringo")
  expect_equal(withr::with_language("fr",    and(names)), "John, Paul, George et Ringo")
  expect_equal(withr::with_language("it",    and(names)), "John, Paul, George e Ringo")
  expect_equal(withr::with_language("pt",    and(names)), "John, Paul, George e Ringo")
})

test_that("or", {
  expect_equal(withr::with_language("en_US", or(1:2)), "1 or 2")
  expect_equal(withr::with_language("en_US", or(1:4)), "1, 2, 3, or 4")

  skip_on_cran()

  expect_equal(withr::with_language("en_GB", or(1:2)), "1 or 2")
  expect_equal(withr::with_language("ca",    or(1:2)), "1 o 2")
  expect_equal(withr::with_language("cy",    or(1:2)), "1 neu 2")
  expect_equal(withr::with_language("es",    or(1:2)), "1 o 2")
  expect_equal(withr::with_language("eu",    or(1:2)), "1 edo 2")
  expect_equal(withr::with_language("fr",    or(1:2)), "1 ou 2")
  expect_equal(withr::with_language("it",    or(1:2)), "1 o 2")
  expect_equal(withr::with_language("pt",    or(1:2)), "1 ou 2")

  expect_equal(withr::with_language("en_GB", or(1:4)), "1, 2, 3 or 4")
  expect_equal(withr::with_language("ca",    or(1:4)), "1, 2, 3 o 4")
  expect_equal(withr::with_language("cy",    or(1:4)), "1, 2, 3 neu 4")
  expect_equal(withr::with_language("es",    or(1:4)), "1, 2, 3 o 4")
  expect_equal(withr::with_language("eu",    or(1:4)), "1, 2, 3 edo 4")
  expect_equal(withr::with_language("fr",    or(1:4)), "1, 2, 3 ou 4")
  expect_equal(withr::with_language("it",    or(1:4)), "1, 2, 3 o 4")
  expect_equal(withr::with_language("pt",    or(1:4)), "1, 2, 3 ou 4")
})

test_that("set language manually", {
  expect_equal(and(1:4, language = "en_US"), "1, 2, 3, and 4")

  skip_on_cran()

  expect_equal(and(1:4, language = "en_GB"), "1, 2, 3 and 4")
  expect_equal(and(1:4, language = "ca"),    "1, 2, 3 i 4")
  expect_equal(and(1:4, language = "cy"),    "1, 2, 3 a 4")
  expect_equal(and(1:4, language = "es"),    "1, 2, 3 y 4")
  expect_equal(and(1:4, language = "eu"),    "1, 2, 3 eta 4")
  expect_equal(and(1:4, language = "fr"),    "1, 2, 3 et 4")
  expect_equal(and(1:4, language = "it"),    "1, 2, 3 e 4")
  expect_equal(and(1:4, language = "pt"),    "1, 2, 3 e 4")
})

test_that("languages with unavailable territories fallback", {
  expect_equal(and(1:4, language = "en_PR"), "1, 2, 3, and 4")

  skip_on_cran()

  expect_equal(and(1:4, language = "ca_AD"), "1, 2, 3 i 4")
  expect_equal(and(1:4, language = "cy_AR"), "1, 2, 3 a 4")
  expect_equal(and(1:4, language = "es_MX"), "1, 2, 3 y 4")
  expect_equal(and(1:4, language = "eu_FR"), "1, 2, 3 eta 4")
  expect_equal(and(1:4, language = "fr_CA"), "1, 2, 3 et 4")
  expect_equal(and(1:4, language = "it_CH"), "1, 2, 3 e 4")
  expect_equal(and(1:4, language = "pt_MO"), "1, 2, 3 e 4")
})

test_that("- convereted to _ in language", {
  expect_equal(and(1:4, language = "en-US"), "1, 2, 3, and 4")

  skip_on_cran()

  expect_equal(and(1:4, language = "en-GB"), "1, 2, 3 and 4")
  expect_equal(and(1:4, language = "es-MX"), "1, 2, 3 y 4")
  expect_equal(and(1:4, language = "fr-CA"), "1, 2, 3 et 4")
  expect_equal(and(1:4, language = "pt-BR"), "1, 2, 3 e 4")
})

test_that("special handling of vowels in Spanish, Italian, and Welsh", {
  skip_on_cran()

  expect_equal(
    withr::with_language("cy", and(c("t", "u", "v"))),
    "t, u a v"
  )
  expect_equal(
    withr::with_language("cy", and(c("u", "v", "w"))),
    "u, v ac w"
  )

  expect_equal(
    withr::with_language("es", and(c("f", "g", "h"))),
    "f, g y h"
  )
  expect_equal(
    withr::with_language("es", and(c("g", "h", "i"))),
    "g, h e i"
  )

  expect_equal(
    withr::with_language("es", or(c("l", "m", "n"))),
    "l, m o n"
  )
  expect_equal(
    withr::with_language("es", or(c("m", "n", "o"))),
    "m, n u o"
  )

  expect_equal(
    withr::with_language("it", and(c("b", "c", "d"))),
    "b, c e d"
  )
  expect_equal(
    withr::with_language("it", and(c("c", "d", "e"))),
    "c, d ed e"
  )

  expect_equal(
    withr::with_language("it", or(c("l", "m", "n"))),
    "l, m o n"
  )
  expect_equal(
    withr::with_language("it", or(c("m", "n", "o"))),
    "m, n od o"
  )
})

test_that("special handling of capital vowels in Spanish, Italian, and Welsh", {
  skip_on_cran()

  expect_equal(
    withr::with_language("cy", and(c("T", "U", "V"))),
    "T, U a V"
  )
  expect_equal(
    withr::with_language("cy", and(c("U", "V", "W"))),
    "U, V ac W"
  )

  expect_equal(
    withr::with_language("es", and(c("F", "G", "H"))),
    "F, G y H"
  )
  expect_equal(
    withr::with_language("es", and(c("G", "H", "I"))),
    "G, H e I"
  )

  expect_equal(
    withr::with_language("es", or(c("L", "M", "N"))),
    "L, M o N"
  )
  expect_equal(
    withr::with_language("es", or(c("M", "N", "O"))),
    "M, N u O"
  )

  expect_equal(
    withr::with_language("it", and(c("B", "C", "D"))),
    "B, C e D"
  )
  expect_equal(
    withr::with_language("it", and(c("C", "D", "E"))),
    "C, D ed E"
  )

  expect_equal(
    withr::with_language("it", or(c("L", "M", "N"))),
    "L, M o N"
  )
  expect_equal(
    withr::with_language("it", or(c("M", "N", "O"))),
    "M, N od O"
  )
})

test_that("special handling of formatted vowels in Spanish, Italian, and Welsh", {
  skip_on_cran()

  expect_equal(
    withr::with_language("cy", and(c("_u_", "_v_", "_w_"))),
    "_u_, _v_ ac _w_"
  )

  expect_equal(
    withr::with_language("es", and(c("_g_", "_h_", "_i_"))),
    "_g_, _h_ e _i_"
  )
  expect_equal(
    withr::with_language("es", or(c("_m_", "_n_", "_o_"))),
    "_m_, _n_ u _o_"
  )

  expect_equal(
    withr::with_language("it", and(c("_c_", "_d_", "_e_"))),
    "_c_, _d_ ed _e_"
  )
  expect_equal(
    withr::with_language("it", or(c("_m_", "_n_", "_o_"))),
    "_m_, _n_ od _o_"
  )
})

test_that("special handling of accented vowels in Spanish, Italian, and Welsh", {
  skip_on_cran()

  expect_equal(and(c("c", "b", "á"), language = "cy"), "c, b ac á")
  expect_equal(and(c("c", "b", "à"), language = "cy"), "c, b ac à")
  expect_equal(and(c("c", "b", "â"), language = "cy"), "c, b ac â")
  expect_equal(and(c("c", "b", "ä"), language = "cy"), "c, b ac ä")
  expect_equal(and(c("c", "d", "é"), language = "cy"), "c, d ac é")
  expect_equal(and(c("c", "d", "è"), language = "cy"), "c, d ac è")
  expect_equal(and(c("c", "d", "ê"), language = "cy"), "c, d ac ê")
  expect_equal(and(c("c", "d", "ë"), language = "cy"), "c, d ac ë")
  expect_equal(and(c("g", "h", "í"), language = "cy"), "g, h ac í")
  expect_equal(and(c("g", "h", "ì"), language = "cy"), "g, h ac ì")
  expect_equal(and(c("g", "h", "î"), language = "cy"), "g, h ac î")
  expect_equal(and(c("g", "h", "ï"), language = "cy"), "g, h ac ï")
  expect_equal(and(c("m", "n", "ó"), language = "cy"), "m, n ac ó")
  expect_equal(and(c("m", "n", "ò"), language = "cy"), "m, n ac ò")
  expect_equal(and(c("m", "n", "ô"), language = "cy"), "m, n ac ô")
  expect_equal(and(c("m", "n", "ö"), language = "cy"), "m, n ac ö")
  expect_equal(and(c("s", "t", "ú"), language = "cy"), "s, t ac ú")
  expect_equal(and(c("s", "t", "ù"), language = "cy"), "s, t ac ù")
  expect_equal(and(c("s", "t", "û"), language = "cy"), "s, t ac û")
  expect_equal(and(c("s", "t", "ü"), language = "cy"), "s, t ac ü")
  expect_equal(and(c("u", "v", "ẃ"), language = "cy"), "u, v ac ẃ")
  expect_equal(and(c("u", "v", "ẁ"), language = "cy"), "u, v ac ẁ")
  expect_equal(and(c("u", "v", "ŵ"), language = "cy"), "u, v ac ŵ")
  expect_equal(and(c("u", "v", "ẅ"), language = "cy"), "u, v ac ẅ")
  expect_equal(and(c("w", "x", "ý"), language = "cy"), "w, x ac ý")
  expect_equal(and(c("w", "x", "ỳ"), language = "cy"), "w, x ac ỳ")
  expect_equal(and(c("w", "x", "ŷ"), language = "cy"), "w, x ac ŷ")
  expect_equal(and(c("w", "x", "ÿ"), language = "cy"), "w, x ac ÿ")

  expect_equal(and(c("g", "h", "í"), language = "es"), "g, h e í")
  expect_equal(and(c("w", "x", "ý"), language = "es"), "w, x e ý")

  expect_equal(or(c("m", "n", "ó"), language = "es"), "m, n u ó")

  expect_equal(and(c("c", "d", "é"), language = "it"), "c, d ed é")
  expect_equal(and(c("c", "d", "è"), language = "it"), "c, d ed è")
  expect_equal(and(c("c", "d", "ê"), language = "it"), "c, d ed ê")
  expect_equal(and(c("c", "d", "ë"), language = "it"), "c, d ed ë")

  expect_equal(or(c("m", "n", "ó"), language = "it"), "m, n od ó")
  expect_equal(or(c("m", "n", "ò"), language = "it"), "m, n od ò")
  expect_equal(or(c("m", "n", "ô"), language = "it"), "m, n od ô")
  expect_equal(or(c("m", "n", "ö"), language = "it"), "m, n od ö")
})

test_that("special handling of 8 in Spanish and Italian", {
  expect_equal(
    withr::with_language("en_US", or(1:8)),
    "1, 2, 3, 4, 5, 6, 7, or 8"
  )

  skip_on_cran()

  expect_equal(
    withr::with_language("es", or(1:8)),
    "1, 2, 3, 4, 5, 6, 7 u 8"
  )
  expect_equal(
    withr::with_language("it", or(1:8)),
    "1, 2, 3, 4, 5, 6, 7 od 8"
  )
})

test_that("early return if length(x) == 1", {
  expect_equal(withr::with_language("en_US", and("test")), "test")
  expect_equal(withr::with_language("en_GB", and("test")), "test")
  expect_equal(withr::with_language("ca",    and("test")), "test")
  expect_equal(withr::with_language("cy",    and("test")), "test")
  expect_equal(withr::with_language("es",    and("test")), "test")
  expect_equal(withr::with_language("eu",    and("test")), "test")
  expect_equal(withr::with_language("fr",    and("test")), "test")
  expect_equal(withr::with_language("it",    and("test")), "test")
  expect_equal(withr::with_language("pt",    and("test")), "test")
})

test_that("ensure `conjoin()` always returns a length 1 string", {
  and_1 <- and(1)
  and_2 <- and(1:2)
  and_3 <- and(1:3)
  and_100 <- and(1:100)

  expect_equal(class(and_1), "character")
  expect_equal(class(and_2), "character")
  expect_equal(class(and_3), "character")
  expect_equal(class(and_100), "character")

  expect_equal(length(and_1), 1)
  expect_equal(length(and_2), 1)
  expect_equal(length(and_3), 1)
  expect_equal(length(and_100), 1)
})

test_that("invalid language falls back to English", {
  expect_equal(
    withr::with_language("zxx", and(1:2)),
    withr::with_language("en", and(1:2))
  )

  expect_equal(
    withr::with_language("zxx", or(1:2)),
    withr::with_language("en", or(1:2))
  )

  expect_equal(
    withr::with_language("zxx", and(1:8)),
    withr::with_language("en", and(1:8))
  )

  expect_equal(
    withr::with_language("zxx", or(1:8)),
    withr::with_language("en", or(1:8))
  )
})

test_that("unset language", {
  old_language <- set_language("en")
  expect_equal(Sys.getenv("LANGUAGE"), "en")

  set_language("")
  expect_equal(Sys.getenv("LANGUAGE", "UNSET"), "UNSET")

  set_language(NULL)
  expect_equal(Sys.getenv("LANGUAGE", "UNSET"), "UNSET")

  set_language(character(0))
  expect_equal(Sys.getenv("LANGUAGE", "UNSET"), "UNSET")

  set_language(old_language)
})

test_that("supports factors", {
  withr::local_language("en_US")

  expect_equal(and(factor(c("one", "two", "three"))), "one, two, and three")
  expect_equal(or(factor(c("one", "two", "three"))), "one, two, or three")
})

test_that("error if language is not a string", {
  expect_error(and(1:4, language = 1), class = "and_invalid_language")
  expect_error(and(1:4, language = c("en", "fr")), class = "and_invalid_language")
})
