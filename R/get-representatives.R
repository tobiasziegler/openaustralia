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
  do.call("call_api", params) %>%     # Call the generic API function
    tibble::as_tibble() %>%           # Convert the response to a tibble
    readr::type_convert(              # By default all variables are strings
      col_types = readr::cols(        # Specify all column types
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
      )
    )
}
