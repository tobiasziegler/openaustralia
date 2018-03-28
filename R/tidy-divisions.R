#' Process list data of divisions and return a tidy tibble
#'
#' @param data A nested list (list of lists) with each item in the top-level
#'   list representing a division
#' @return A tibble with each division represented by one row.
tidy_divisions <- function(data) {
  tibble::tibble(
    name = map_chr(data, "name", .null = NA_character_)
  )
}
