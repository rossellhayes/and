remotes::install_local(here::here(), upgrade = "never")

with_language <- function(lang, expr) {
  callr::r(
    as.function(list(substitute(expr))),
    env = c("LANGUAGE" = lang)
  )
}

test_that("and", {
  expect_equal(
    with_language("en_US", and::and(c("Euridice", "Orpheus"))),
    "Euridice and Orpheus"
  )

  expect_equal(
    with_language("en_GB", and::and(c("Euridice", "Orpheus"))),
    "Euridice and Orpheus"
  )

  expect_equal(
    with_language("es", and::and(c("Euridice", "Orpheus"))),
    "Euridice y Orpheus"
  )

  expect_equal(
    with_language("fr", and::and(c("Euridice", "Orpheus"))),
    "Euridice et Orpheus"
  )

  expect_equal(
    with_language("pt", and::and(c("Euridice", "Orpheus"))),
    "Euridice e Orpheus"
  )

  expect_equal(
    with_language("pt_BR", and::and(c("Euridice", "Orpheus"))),
    "Euridice e Orpheus"
  )

  expect_equal(
    with_language("en_US", and::and(c("James", "Betty", "Inez"))),
    "James, Betty, and Inez"
  )

  expect_equal(
    with_language("en_GB", and::and(c("James", "Betty", "Inez"))),
    "James, Betty and Inez"
  )

  expect_equal(
    with_language("es", and::and(c("James", "Betty", "Inez"))),
    "James, Betty e Inez"
  )

  expect_equal(
    with_language("fr", and::and(c("James", "Betty", "Inez"))),
    "James, Betty et Inez"
  )

  expect_equal(
    with_language("pt", and::and(c("James", "Betty", "Inez"))),
    "James, Betty e Inez"
  )

  expect_equal(
    with_language("pt_BR", and::and(c("Euridice", "Orpheus"))),
    "Euridice e Orpheus"
  )
})

test_that("or", {
  expect_equal(
    with_language("en_US", and::or(c("Euridice", "Orpheus"))),
    "Euridice or Orpheus"
  )

  expect_equal(
    with_language("en_GB", and::or(c("Euridice", "Orpheus"))),
    "Euridice or Orpheus"
  )

  expect_equal(
    with_language("es", and::or(c("Euridice", "Orpheus"))),
    "Euridice u Orpheus"
  )

  expect_equal(
    with_language("fr", and::or(c("Euridice", "Orpheus"))),
    "Euridice ou Orpheus"
  )

  expect_equal(
    with_language("pt", and::or(c("Euridice", "Orpheus"))),
    "Euridice ou Orpheus"
  )

  expect_equal(
    with_language("pt_BR", and::or(c("Euridice", "Orpheus"))),
    "Euridice ou Orpheus"
  )

  expect_equal(
    with_language("en_US", and::or(c("James", "Betty", "Inez"))),
    "James, Betty, or Inez"
  )

  expect_equal(
    with_language("en_GB", and::or(c("James", "Betty", "Inez"))),
    "James, Betty or Inez"
  )

  expect_equal(
    with_language("es", and::or(c("James", "Betty", "Inez"))),
    "James, Betty o Inez"
  )

  expect_equal(
    with_language("fr", and::or(c("James", "Betty", "Inez"))),
    "James, Betty ou Inez"
  )

  expect_equal(
    with_language("pt", and::or(c("James", "Betty", "Inez"))),
    "James, Betty ou Inez"
  )
})
