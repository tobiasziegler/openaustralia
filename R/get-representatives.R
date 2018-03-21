#' Fetch a list of members of the House of Representatives
#'
#' @param postcode Fetch the list of Representatives whose electoral division
#'   lies within the postcode (there may be more than one)
#' @param date Fetch the list of members of the House of Representatives as it
#'   was on this date
#' @param party Fetch the list of Representatives from the given party
#' @param search Fetch the list of Representatives that match this search string
#'   in their name
#'
#' @export
get_representatives <- function(postcode = NULL, date = NULL, party = NULL,
                                search = NULL) {
  getRepresentatives(postcode, date, party, search)
}

#' @rdname get_representatives
getRepresentatives <- function(postcode = NULL, date = NULL, party = NULL,
                               search = NULL) {
  params <- params_from_call(match.call())
  robj <- do.call("call_api", params)

  # Separate the list into those with office data and those without
  has_office <- purrr::map_lgl(robj, ~ purrr::has_element(names(.x), "office"))
  reps_office <- robj[has_office]
  reps_no_office <- robj[!has_office]

  # Convert each sub-list into a tibble
  reps_office_tbl <- tibble::tibble(
    member_id = purrr::map_chr(reps_office, "member_id"),
    house = purrr::map_chr(reps_office, "house"),
    first_name = purrr::map_chr(reps_office, "first_name"),
    last_name = purrr::map_chr(reps_office, "last_name"),
    constituency = purrr::map_chr(reps_office, "constituency"),
    party = purrr::map_chr(reps_office, "party"),
    entered_house = purrr::map_chr(reps_office, "entered_house"),
    left_house = purrr::map_chr(reps_office, "left_house"),
    entered_reason = purrr::map_chr(reps_office, "entered_reason"),
    left_reason = purrr::map_chr(reps_office, "left_reason"),
    person_id = purrr::map_chr(reps_office, "person_id"),
    title = purrr::map_chr(reps_office, "title"),
    lastupdate = purrr::map_chr(reps_office, "lastupdate"),
    full_name = purrr::map_chr(reps_office, "full_name"),
    name = purrr::map_chr(reps_office, "name"),
    image = purrr::map_chr(reps_office, "image"),
    office = purrr::map(
      reps_office,
      ~ tibble::tibble(
        moffice_id = purrr::map_chr(.x[["office"]], "moffice_id"),
        dept = purrr::map_chr(.x[["office"]], "dept"),
        position = purrr::map_chr(.x[["office"]], "position"),
        from_date = purrr::map_chr(.x[["office"]], "from_date"),
        to_date = purrr::map_chr(.x[["office"]], "to_date"),
        person = purrr::map_chr(.x[["office"]], "person"),
        source = purrr::map_chr(.x[["office"]], "source")
      )
    )
  )

  reps_no_office_tbl <- tibble::tibble(
    member_id = purrr::map_chr(reps_no_office, "member_id"),
    house = purrr::map_chr(reps_no_office, "house"),
    first_name = purrr::map_chr(reps_no_office, "first_name"),
    last_name = purrr::map_chr(reps_no_office, "last_name"),
    constituency = purrr::map_chr(reps_no_office, "constituency"),
    party = purrr::map_chr(reps_no_office, "party"),
    entered_house = purrr::map_chr(reps_no_office, "entered_house"),
    left_house = purrr::map_chr(reps_no_office, "left_house"),
    entered_reason = purrr::map_chr(reps_no_office, "entered_reason"),
    left_reason = purrr::map_chr(reps_no_office, "left_reason"),
    person_id = purrr::map_chr(reps_no_office, "person_id"),
    title = purrr::map_chr(reps_no_office, "title"),
    lastupdate = purrr::map_chr(reps_no_office, "lastupdate"),
    full_name = purrr::map_chr(reps_no_office, "full_name"),
    name = purrr::map_chr(reps_no_office, "name"),
    image = purrr::map_chr(reps_no_office, "image"),
    office = purrr::map(
      reps_no_office,
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

  # Join the sub-tibbles back into a single dataset
  reps_tbl <- dplyr::bind_rows(reps_office_tbl, reps_no_office_tbl)

  reps_tbl
}
