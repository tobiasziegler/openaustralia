#' Process nested list data of members and return a tidy nested tibble
#'
#' @param data A nested list (list of lists) with each item in the top-level
#'   list representing a member
#' @return A tibble with each member represented by one row.
tidy_members <- function(data) {
  # Convert the list into a tibble
  members_tbl <- tibble_members(data)

  members_tbl
}

#' Convert a list of members into a nested tibble
#'
#' @param data A nested list (list of lists) with each item in the top-level
#'   list representing a member.
#' @return A tibble with each member represented by one row.
tibble_members <- function(data) {
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
    office = purrr::map(data, tibble_office)
  )
}

#' Convert a list of offices held by a member into a tibble, or create an
#' empty tibble if the member has no office data.
#'
#' @param data A list with each item representing an office held by the member.
#'
#' @return A tibble with each office represented by one row.
tibble_office <- function(data) {
  if ("office" %in% names(data)) {
    office <- tibble::tibble(
      moffice_id = purrr::map_chr(data[["office"]], "moffice_id", .null = NA_character_),
      dept = purrr::map_chr(data[["office"]], "dept", .null = NA_character_),
      position = purrr::map_chr(data[["office"]], "position", .null = NA_character_),
      from_date = purrr::map_chr(data[["office"]], "from_date", .null = NA_character_),
      to_date = purrr::map_chr(data[["office"]], "to_date", .null = NA_character_),
      person = purrr::map_chr(data[["office"]], "person", .null = NA_character_),
      source = purrr::map_chr(data[["office"]], "source", .null = NA_character_)
    )
  } else {
    office <- tibble::tibble(
      moffice_id = character(),
      dept = character(),
      position = character(),
      from_date = character(),
      to_date = character(),
      person = character(),
      source = character()
    )
  }

  office
}
