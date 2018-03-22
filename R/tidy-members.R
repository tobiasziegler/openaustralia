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
    member_id = purrr::map_chr(data, "member_id", .null = NA_character_),
    house = purrr::map_chr(data, "house", .null = NA_character_),
    first_name = purrr::map_chr(data, "first_name", .null = NA_character_),
    last_name = purrr::map_chr(data, "last_name", .null = NA_character_),
    constituency = purrr::map_chr(data, "constituency", .null = NA_character_),
    party = purrr::map_chr(data, "party", .null = NA_character_),
    entered_house = purrr::map_chr(data, "entered_house", .null = NA_character_),
    left_house = purrr::map_chr(data, "left_house", .null = NA_character_),
    entered_reason = purrr::map_chr(data, "entered_reason", .null = NA_character_),
    left_reason = purrr::map_chr(data, "left_reason", .null = NA_character_),
    person_id = purrr::map_chr(data, "person_id", .null = NA_character_),
    title = purrr::map_chr(data, "title", .null = NA_character_),
    lastupdate = purrr::map_chr(data, "lastupdate", .null = NA_character_),
    full_name = purrr::map_chr(data, "full_name", .null = NA_character_),
    name = purrr::map_chr(data, "name", .null = NA_character_),
    image = purrr::map_chr(data, "image", .null = NA_character_),
    office = ifelse(
      has_office,
      purrr::map(
        data,
        ~ tibble::tibble(
          moffice_id = purrr::map_chr(.x[["office"]], "moffice_id", .null = NA_character_),
          dept = purrr::map_chr(.x[["office"]], "dept", .null = NA_character_),
          position = purrr::map_chr(.x[["office"]], "position", .null = NA_character_),
          from_date = purrr::map_chr(.x[["office"]], "from_date", .null = NA_character_),
          to_date = purrr::map_chr(.x[["office"]], "to_date", .null = NA_character_),
          person = purrr::map_chr(.x[["office"]], "person", .null = NA_character_),
          source = purrr::map_chr(.x[["office"]], "source", .null = NA_character_)
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
