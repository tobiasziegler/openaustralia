#' Fetch Debates
#'
#' This includes oral questions.
#'
#' @param tidy Convert the output list to a tidyverse-ready format
#' @param type One of "representatives" or "senate"
#' @param date Fetch the debates for this date
#' @param search Fetch the debates that contain this term
#' @param person Fetch the debates by a particular person ID
#' @param gid Fetch the speech or debate that matches this GID
#' @param order d for date ordering, r for relevance ordering
#' @param page Page of results to return
#' @param num Number of results to return
#'
#' @export
get_debates <- function(tidy = TRUE, type = NULL, date = NULL, search = NULL,
                        person = NULL, gid = NULL, order = NULL, page = NULL,
                        num = NULL) {
  getDebates(tidy, type, date, search, person, gid, order, page, num)
}

#' @rdname get_debates
getDebates <- function(tidy = TRUE, type = NULL, date = NULL, search = NULL,
                       person = NULL, gid = NULL, order = NULL, page = NULL,
                       num = NULL) {
  params <- params_from_call(match.call())
  response <- do.call("call_api", params)

  if (!tidy)
    return(response)

  # The structure of the returned JSON depends on which parameters are passed.
  # TODO: Add conversion to an appropriate data structure for all parameters.
  if (!is.null(date)) {
    return(tidy_debates_by_date(response))
  }

  response
}
