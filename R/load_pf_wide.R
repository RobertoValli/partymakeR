#' Helper to load wide version of PartyFacts external data
#'
#' @param countries A character vector of VDEM country codes.
#' @param keep_sources A character vector of dataset names included in PartyFacts external data. These include:
#' "manifesto", "parlgov", "wikipedia", "ches", "clea", "ejpr", "vparty", "chisols", "dpi", "essprtc", "essprtv", "huber", "kitschelt", "polcon", "ppmd", "whogov", "wvs", "afrelec", "afro", "ccdd", "ccs", "coppedge", "cses", "elecglob", "epac", "hix", "erdda", "euandi", "gloelec", "gpd", "gps", "ipod", "janda", "jw", "kurep", "laeda", "latino", "laverhunt", "leadglob", "mackie", "mapp", "morgan", "mudde", "nped", "parlspeech", "postyug", "pip", "poppa", "ppdb", "ppla", "ppmdall", "ray", "tap", "populist", "voteview", "ees14", "ppepe", "thomas"
#' Note: source data are matched with a regex, so "manif" works just like "manifesto".
#'
#' @return A tibble with PartyFacts data for the countries and datasets of interest.
#' @export load_pf_external
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
#' dat_pf_external <- load_pf_external(countries = countries, keep_sources = "manifesto")
#' dat_pf_external
#'
#' }
#'
load_pf_external <- function(countries = NULL, keep_sources = NULL) {

  # Filter countries
  if (is.null(countries)) {

    dat <- readr::read_csv(here::here("data_intermediate", "partyfacts_processed",
                                      "partyfacts_external_wide.csv"))

  } else if (is.character(countries)) {

    dat <- readr::read_csv(here::here("data_intermediate", "partyfacts_processed",
                                      "partyfacts_external_wide.csv"))
    dat <- dat[dat$country %in% countries, ]
  }

  # Filter party name sources of interest
  if (is.null(keep_sources)) {

    dat

  } else if (is.character(keep_sources)) {

    pattern <- paste(keep_sources, collapse = "|")

    dplyr::select(dat, country, partyfacts_id, tidyselect::matches(pattern))

  }

}
