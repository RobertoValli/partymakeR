#' A helper to check content of /data_input directory
#'
#' @description This function assumes a standardized RProject folder structure with a "data_input" folder at top level. The function is a wrapper of \code{\link[here]{here}} and allows to quickly inspect files and folders.
#' @param ... A set of quoted nested folder names.
#'
#' @return A tibble with a column of file names and a column of relative paths.
#' @export see_inputs
#'
#' @examples
#'
#' library(partymakeR)
#'
#' \dontrun{
#'
#' # See main data_input directory
#' see_inputs()
#'
#' # See top level
#' see_inputs("..")
#'
#' # Enter any number of nested folders
#' see_inputs("folder", "subfolder")
#'
#' }
#'
see_inputs <- function(... = NULL) {

  # Combine arguments
  if (!is.null(...)) {
    dir <- c(...)
  }


  # Add warning
  stopifnot("Input must be quoted file or dir names!" = is.character(dir))
  stopifnot("data_input folder doesn't exist!" = dir.exists(here::here("data_input")))


  if(!exists(dir)) {

    tibble::tibble(
      file = list.files(here::here("data_input")),
      path = here::here("data_input", list.files(here::here("data_input"))))

  } else {

    tibble::tibble(
      file = list.files(here::here("data_input", dir)),
      path = here::here("data_input", list.files(here::here("data_input", dir))))
  }

}
