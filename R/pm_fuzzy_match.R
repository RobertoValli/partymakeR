
#' Get fuzzy party name matches
#'
#' @description This function is a helper to match party names in new data to a
#' "meta dataset" of other party names using a distance metric. It output is a
#' dataframe that can be checked and manually adjusted.
#'
#' @param survey_data A dataframe or similar object with unique party names in survey or poll data
#' @param meta_data A dataframe or similar object with unique party names in reference party-level dataset (e.g., ParlGov)
#' @param by Expression that defines the variables to be matched in the two dataset, e.g.
#' c("name_party_survey" = "name_party_meta)
#' @param method One of stringdist matching methods ("osa", "lv", "dl", "hamming", "lcs", "qgram", "cosine", "jaccard", "jw", "soundex")
#' @param threshold Maximum distance value to be kept
#' @param ... Additional parameters to pass to \code{fuzzyjoin::stringdist_left_join} and \code{stringdist::stringdist}
#'
#' @return A dataframe of matched strings that respect the distance threshold.
#' @export pm_fuzzy_match
#'
#' @examples
#' # Load package
#' library(partymakeR)
#'
#' # Create example datasets
#' dat_survey <- data.frame(
#'   party_names = c("Big party", "Nationals' assembly", "Loser party"),
#'   party_id = 1:3)
#' dat_meta <- data.frame(
#'   name_party = c("big parties", "Nationalist party", "losers"),
#'   id_party = letters[1:3])
#'
#' # Compute match (1 result)
#' pm_fuzzy_match(survey_data = dat_survey, meta_data = dat_meta,
#'                c("party_names" = "name_party"), threshold = 5)
#'
#' # Compute match (6 results)
#' pm_fuzzy_match(survey_data = dat_survey, meta_data = dat_meta,
#'                c("party_names" = "name_party"), threshold = 12)
pm_fuzzy_match <- function(survey_data, meta_data, by,
                           method = "osa", threshold = 5, ...) {

  requireNamespace("magrittr", quitely = T)

  # Check that input types are correct
  stopifnot("survey_data must be a data.frame, tbl_df or tibble" =
              class(survey_data) %in% c("tbl_df", "tbl", "data.frame"))
  stopifnot("meta_data must be a data.frame, tbl_df or tibble" =
              class(meta_data) %in% c("tbl_df", "tbl", "data.frame"))

  dplyr::distinct(
    fuzzyjoin::stringdist_left_join(
      x = survey_data,
      y = meta_data,
      method = method,
        by = by,
      distance_col = "distance",
      max_dist = threshold
    )
  )
}

