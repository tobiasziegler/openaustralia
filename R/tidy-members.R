#' Process nested list data of members and return a tidy nested tibble
#'
#' @param data A nested list (list of lists) with each item in the top-level
#'   list representing a member
#' @return A tibble with each member represented by one row.
tidy_members <- function(data) {
  tibble_members(data) %>%     # Convert the list into a tibble
    type_convert_members() %>% # Convert column data types
    dplyr::mutate(             # Convert types in each nested office tibble
      office = purrr::map(office, type_convert_offices)
    )
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

#' Convert the column types for a tibble of members from strings (character) to
#' integers, dates, etc., and replace empty strings and dummy dates with NA
#' values.
#'
#' @param data A tibble with each member represented by one row.
#'
#' @return A tibble with column types converted and NA values applied.
type_convert_members <- function(data) {
  converted_data <- readr::type_convert(
    data,
    col_types = readr::cols(
      member_id = readr::col_integer(),
      house = readr::col_integer(),
      first_name = readr::col_character(),
      last_name = readr::col_character(),
      constituency = readr::col_character(),
      party = readr::col_character(),
      entered_house = readr::col_date(),
      left_house = readr::col_date(),
      entered_reason = readr::col_character(),
      left_reason = readr::col_character(),
      person_id = readr::col_integer(),
      title = readr::col_character(),
      lastupdate = readr::col_datetime(),
      full_name = readr::col_character(),
      name = readr::col_character(),
      image = readr::col_character()
    ),
    na = c("", "NA", "9999-12-31")
  )

  converted_data
}


#' Convert the column types for a tibble of offices from strings (character) to
#' integers, dates, etc., and replace empty strings and dummy dates with NA
#' values.
#'
#' @param data A tibble with each office represented by one row.
#'
#' @return A tibble with column types converted and NA values applied.
type_convert_offices <- function(data) {
  converted_data <- readr::type_convert(
    data,
    col_types = readr::cols(
      moffice_id = readr::col_integer(),
      dept = readr::col_character(),
      position = readr::col_character(),
      from_date = readr::col_date(),
      to_date = readr::col_date(),
      person = readr::col_character(),
      source = readr::col_character()
    ),
    na = c("", "NA", "9999-12-31")
  )

  converted_data
}
