test_that("pm_fuzzy_match gets distances right", {
  expect_equal(pm_fuzzy_match(survey_data = data.frame(party = c("RevoLutionary", "Swiss Populist")),
                              meta_data = data.frame(name = c("Revolutionary", "populist")),
                              by = c("party" = "name"), threshold = 6
                              ),
               data.frame(party = c("RevoLutionary", "Swiss Populist"),
                          name = c("Revolutionary", NA_character_),
                          distance = c(1, NA))
               )
}
)

test_that("pm_fuzzy_match gets distances right", {
  expect_equal(
    pm_fuzzy_match(survey_data = data.frame(party = c("RevoLutionary", "Swiss Populist")),
                   meta_data = data.frame(name = c("Revolutionary", "populist")),
                   by = c("party" = "name"), threshold = 8),
    data.frame(party = c("RevoLutionary", "Swiss Populist"),
               name = c("Revolutionary", "populist"),
               distance = c(1, 7))
  )
}
)

test_that("pm_fuzzy_match recognize bad inputs", {
  expect_error(
    pm_fuzzy_match(survey_data = data.frame(party = c("RevoLutionary", "Swiss Populist")),
                   meta_data = c("Revolutionary", "populist"),
                   by = c("party" = "name"), threshold = 8)
  )
}
)
