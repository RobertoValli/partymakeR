#' A helper to check content of /data_intermediate directory
#'
#' @description This function assumes a standardized RProject folder structure with a "data_intermediate" folder at top level. The function is a wrapper of \pkg{here} and allows to quickly inspect files and folders.
#' @param ... A set of quoted nested folder names.
#'
#' @return A tibble with a column of file names and a column of relative paths.
#' @export see_intermediate
#'
#' @examples
#'
#' library(partymakeR)
#'
#' \dontrun{
#'
#' # See main data_input directory
#' see_intermediate()
#'
#' # See top level
#' see_intermediate("..")
#'
#' # Enter any number of nested folders
#' see_intermediate("folder", "subfolder")
#'
#' }
#'
see_intermediate <- function(... = NULL) {

  # Combine arguments
  dir <- c(...)

  # Add warning
  stopifnot("Input must be quoted file or dir names!" = is.character(dir))
  stopifnot("data_input folder doesn't exist!" =
              dir.exists(here::here("data_intermediate")))


  if(any(length(dir) == 0)) {

    tibble::tibble(
      file = list.files(here::here("data_intermediate")),
      path = here::here("data_intermediate", list.files(here::here("data_intermediate"))))

  } else {

    tibble::tibble(
      file = list.files(here::here("data_intermediate", dir)),
      path = here::here("data_intermediate",
                        list.files(here::here("data_intermediate", dir))))
  }

}
