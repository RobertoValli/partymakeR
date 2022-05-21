



pm_fuzzy_match <- function(survey_data, meta_data, survey_name, meta_name,
                           method = "osa", threshold = 5, ...) {
  require(fuzzyjoin)

  stopifnot("survey_data and meta_data must be data.frames or tibbles" =
              class(survey_data) %in% c("data.frame", "tibble") &
              class(meta_data) %in% c("data.frame", "tibble"))

  stringdist_left_join(
      x = survey_data,
      y = meta_data,
    method = method,
    by = c(survey_name = meta_name),
    distance_col = "distance",
    max_dist = threshold,
    ...
  )%>%
    distinct()
}

