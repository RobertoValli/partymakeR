#' Helper to load core PartyFacts data
#'
#' @description This function allows to conveniently load PartyFacts data and subset the countries of interest.
#'
#' @param countries A character vector of VDEM country codes.
#'
#' @return A tibble with PartyFacts data for the countries of interest.
#' @export load_pf_core
#'
#' @examples
#'
#' library(partymakeR)
#'
#' \dontrun{
#'
#' # Define countries of interest
#' countries <- c("AFG", "AIA")
#'
#' # Load data
#' dat_pf_core <- load_pf_core(countries = countries)
#'
#' }
#'
load_pf_core <- function(countries = NULL) {

  if (is.null(countries)) {

    readr::read_csv(here::here("data_input", "partyfacts",
                               "partyfacts-core-parties.csv"))

  } else if (is.character(countries)) {

    dat <- readr::read_csv(here::here("data_input", "partyfacts",
                                      "partyfacts-core-parties.csv"))
    dat[dat$country %in% countries, ]

  }

}
