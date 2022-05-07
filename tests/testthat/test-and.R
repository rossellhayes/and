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
