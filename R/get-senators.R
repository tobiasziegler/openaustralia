#' Fetch a list of Senators
#'
#' @param tidy Convert the output list to a tidyverse-ready format
#' @param date ISO-style date, e.g. "1990-01-02", to fetch the list of Senators
#'   as it was on this date
#' @param party Fetch the list of Senators from the given party
#' @param state Fetch the list of Senators from the given state (NSW, Tasmania,
#'   WA, Queensland, Victoria, SA, NT, ACT)
#' @param search Fetch the list of Senators that match this search string in
#'   their name
#'
#' @export
get_senators <- function(tidy = TRUE, date = NULL, party = NULL,
                         state = NULL, search = NULL) {
  getSenators(tidy, date, party, state, search)
}

#' @rdname get_senators
getSenators <- function(tidy = TRUE, date = NULL, party = NULL,
                        state = NULL, search = NULL) {
  params <- params_from_call(match.call())
  response <- do.call("call_api", params)

  if (!tidy)
    return(response)

  tidy_members(response)
}
