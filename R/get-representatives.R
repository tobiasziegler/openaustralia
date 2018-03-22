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
  do.call("call_api", params) %>%
    tidy_members()
}
