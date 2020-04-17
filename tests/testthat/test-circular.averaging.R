
context("circular.averaging()")

# Test that circular.averaging() returns expected results
test_that("circular.averaging returns expected results", {
   identical(circular.averaging(c(0, 90, 180, 270)), NA)
   identical(circular.averaging(c(70, 82, 96, 110, 119, 259)), 99.68)
})
