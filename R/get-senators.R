#' Fetch a list of Senators
#'
#' @param date ISO-style date, e.g. "1990-01-02", to fetch the list of Senators
#'   as it was on this date
#' @param party Fetch the list of Senators from the given party
#' @param state Fetch the list of Senators from the given state (NSW, Tasmania,
#'   WA, Queensland, Victoria, SA, NT, ACT)
#' @param search Fetch the list of Senators that match this search string in
#'   their name
#'
#' @export
get_senators <- function(date = NULL, party = NULL, state = NULL,
                         search = NULL) {
  getSenators(date, party, state, search)
}

#' @rdname get_senators
getSenators <- function(date = NULL, party = NULL, state = NULL,
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
