test_that("and", {
  expect_equal(
    withr::with_language("en_US", and(c("Euridice", "Orpheus"))),
    "Euridice and Orpheus"
  )

  expect_equal(
    withr::with_language("en_GB", and(c("Euridice", "Orpheus"))),
    "Euridice and Orpheus"
  )

  expect_equal(
    withr::with_language("es", and(c("Euridice", "Orpheus"))),
    "Euridice y Orpheus"
  )

  expect_equal(
    withr::with_language("fr", and(c("Euridice", "Orpheus"))),
    "Euridice et Orpheus"
  )

  expect_equal(
    withr::with_language("pt", and(c("Euridice", "Orpheus"))),
    "Euridice e Orpheus"
  )

  expect_equal(
    withr::with_language("pt_BR", and(c("Euridice", "Orpheus"))),
    "Euridice e Orpheus"
  )

  expect_equal(
    withr::with_language("en_US", and(c("James", "Betty", "Inez"))),
    "James, Betty, and Inez"
  )

  expect_equal(
    withr::with_language("en_GB", and(c("James", "Betty", "Inez"))),
    "James, Betty and Inez"
  )

  expect_equal(
    withr::with_language("es", and(c("James", "Betty", "Inez"))),
    "James, Betty e Inez"
  )

  expect_equal(
    withr::with_language("fr", and(c("James", "Betty", "Inez"))),
    "James, Betty et Inez"
  )

  expect_equal(
    withr::with_language("pt", and(c("James", "Betty", "Inez"))),
    "James, Betty e Inez"
  )

  expect_equal(
    withr::with_language("pt_BR", and(c("James", "Betty", "Inez"))),
    "James, Betty e Inez"
  )
})

test_that("or", {
  expect_equal(
    withr::with_language("en_US", or(c("Euridice", "Orpheus"))),
    "Euridice or Orpheus"
  )

  expect_equal(
    withr::with_language("en_GB", or(c("Euridice", "Orpheus"))),
    "Euridice or Orpheus"
  )

  expect_equal(
    withr::with_language("es", or(c("Euridice", "Orpheus"))),
    "Euridice u Orpheus"
  )

  expect_equal(
    withr::with_language("fr", or(c("Euridice", "Orpheus"))),
    "Euridice ou Orpheus"
  )

  expect_equal(
    withr::with_language("pt", or(c("Euridice", "Orpheus"))),
    "Euridice ou Orpheus"
  )

  expect_equal(
    withr::with_language("pt_BR", or(c("Euridice", "Orpheus"))),
    "Euridice ou Orpheus"
  )

  expect_equal(
    withr::with_language("en_US", or(c("James", "Betty", "Inez"))),
    "James, Betty, or Inez"
  )

  expect_equal(
    withr::with_language("en_GB", or(c("James", "Betty", "Inez"))),
    "James, Betty or Inez"
  )

  expect_equal(
    withr::with_language("es", or(c("James", "Betty", "Inez"))),
    "James, Betty o Inez"
  )

  expect_equal(
    withr::with_language("fr", or(c("James", "Betty", "Inez"))),
    "James, Betty ou Inez"
  )

  expect_equal(
    withr::with_language("pt", or(c("James", "Betty", "Inez"))),
    "James, Betty ou Inez"
  )
})
