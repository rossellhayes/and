test_that("and", {
  expect_equal(withr::with_language("en_US", and(1:2)), "1 and 2")
  expect_equal(withr::with_language("en_GB", and(1:2)), "1 and 2")
  expect_equal(withr::with_language("ca",    and(1:2)), "1 i 2")
  expect_equal(withr::with_language("cy",    and(1:2)), "1 a 2")
  expect_equal(withr::with_language("es",    and(1:2)), "1 y 2")
  expect_equal(withr::with_language("eu",    and(1:2)), "1 eta 2")
  expect_equal(withr::with_language("fr",    and(1:2)), "1 et 2")
  expect_equal(withr::with_language("it",    and(1:2)), "1 e 2")
  expect_equal(withr::with_language("pt",    and(1:2)), "1 e 2")

  expect_equal(withr::with_language("en_US", and(1:4)), "1, 2, 3, and 4")
  expect_equal(withr::with_language("en_GB", and(1:4)), "1, 2, 3 and 4")
  expect_equal(withr::with_language("ca",    and(1:4)), "1, 2, 3 i 4")
  expect_equal(withr::with_language("cy",    and(1:4)), "1, 2, 3 a 4")
  expect_equal(withr::with_language("es",    and(1:4)), "1, 2, 3 y 4")
  expect_equal(withr::with_language("eu",    and(1:4)), "1, 2, 3 eta 4")
  expect_equal(withr::with_language("fr",    and(1:4)), "1, 2, 3 et 4")
  expect_equal(withr::with_language("it",    and(1:4)), "1, 2, 3 e 4")
  expect_equal(withr::with_language("pt",    and(1:4)), "1, 2, 3 e 4")

  names <- c("John", "Paul", "George", "Ringo")

  expect_equal(withr::with_language("en_US", and(names)), "John, Paul, George, and Ringo")
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
  expect_equal(withr::with_language("en_GB", or(1:2)), "1 or 2")
  expect_equal(withr::with_language("ca",    or(1:2)), "1 o 2")
  expect_equal(withr::with_language("cy",    or(1:2)), "1 neu 2")
  expect_equal(withr::with_language("es",    or(1:2)), "1 o 2")
  expect_equal(withr::with_language("eu",    or(1:2)), "1 edo 2")
  expect_equal(withr::with_language("fr",    or(1:2)), "1 ou 2")
  expect_equal(withr::with_language("it",    or(1:2)), "1 o 2")
  expect_equal(withr::with_language("pt",    or(1:2)), "1 ou 2")

  expect_equal(withr::with_language("en_US", or(1:4)), "1, 2, 3, or 4")
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
  expect_equal(and(1:4, language = "en_AU"), "1, 2, 3 and 4")
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
  expect_equal(and(1:4, language = "en-GB"), "1, 2, 3 and 4")
  expect_equal(and(1:4, language = "es-MX"), "1, 2, 3 y 4")
  expect_equal(and(1:4, language = "fr-CA"), "1, 2, 3 et 4")
  expect_equal(and(1:4, language = "pt-BR"), "1, 2, 3 e 4")
})

test_that("special handling of vowels in Spanish, Italian, and Welsh", {
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

  expect_equal(
    withr::with_language("en_US", or(1:8)),
    "1, 2, 3, 4, 5, 6, 7, or 8"
  )
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

test_that("error if language is not a string", {
  expect_error(and(1:4, language = 1), class = "and_invalid_language")
  expect_error(and(1:4, language = character(0)), class = "and_invalid_language")
  expect_error(and(1:4, language = c("en", "fr")), class = "and_invalid_language")
})
