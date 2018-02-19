#' Fetch Debates
#'
#' This includes oral questions.
#'
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
get_debates <- function(type = NULL, date = NULL, search = NULL, person = NULL,
                        gid = NULL, order = NULL, page = NULL, num = NULL) {
  getDebates(type, date, search, person, gid, order, page, num)
}

#' @rdname get_debates
getDebates <- function(type = NULL, date = NULL, search = NULL, person = NULL,
                       gid = NULL, order = NULL, page = NULL, num = NULL) {
  params <- params_from_call(match.call())
  do.call("call_api", params)
}
