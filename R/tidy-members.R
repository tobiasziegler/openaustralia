#' Process nested list data of members and return a tidy nested tibble
#'
#' @param data A nested list (list of lists) with each item in the top-level
#'   list representing a member
#' @return A tibble with each member represented by one row
tidy_members <- function(data) {
  # Separate the list into those with office data and those without
  has_office <- purrr::map_lgl(data, ~ purrr::has_element(names(.x), "office"))
  members_office <- data[has_office]
  members_no_office <- data[!has_office]

  # Convert each sub-list into a tibble
  members_office_tbl <- tibble_members(members_office, TRUE)
  members_no_office_tbl <- tibble_members(members_no_office, FALSE)

  # Join the sub-tibbles back into a single dataset
  reps_tbl <- dplyr::bind_rows(members_office_tbl, members_no_office_tbl)

  reps_tbl
}

#' Convert a sub-list of members into a nested tibble
#'
#' @param data A nested list (list of lists) with each item in the top-level
#'   list representing a member. All members must have office data or must not
#'   have office data
#' @param has_office A boolean value indicating whether the sub-list contains
#'   office data
#' @return A tibble with each member represented by one row
tibble_members <- function(data, has_office) {
  tibble::tibble(
    member_id = purrr::map_chr(data, "member_id"),
    house = purrr::map_chr(data, "house"),
    first_name = purrr::map_chr(data, "first_name"),
    last_name = purrr::map_chr(data, "last_name"),
    constituency = purrr::map_chr(data, "constituency"),
    party = purrr::map_chr(data, "party"),
    entered_house = purrr::map_chr(data, "entered_house"),
    left_house = purrr::map_chr(data, "left_house"),
    entered_reason = purrr::map_chr(data, "entered_reason"),
    left_reason = purrr::map_chr(data, "left_reason"),
    person_id = purrr::map_chr(data, "person_id"),
    title = purrr::map_chr(data, "title"),
    lastupdate = purrr::map_chr(data, "lastupdate"),
    full_name = purrr::map_chr(data, "full_name"),
    name = purrr::map_chr(data, "name"),
    image = purrr::map_chr(data, "image"),
    office = ifelse(
      has_office,
      purrr::map(
        data,
        ~ tibble::tibble(
          moffice_id = purrr::map_chr(.x[["office"]], "moffice_id"),
          dept = purrr::map_chr(.x[["office"]], "dept"),
          position = purrr::map_chr(.x[["office"]], "position"),
          from_date = purrr::map_chr(.x[["office"]], "from_date"),
          to_date = purrr::map_chr(.x[["office"]], "to_date"),
          person = purrr::map_chr(.x[["office"]], "person"),
          source = purrr::map_chr(.x[["office"]], "source")
        )
      ),
      purrr::map(
        data,
        ~ tibble::tibble(
          moffice_id = character(),
          dept = character(),
          position = character(),
          from_date = character(),
          to_date = character(),
          person = character(),
          source = character()
        )
      )
    )
  )
}
