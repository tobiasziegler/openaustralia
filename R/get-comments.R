#' Fetch comments left on OpenAustralia
#'
#' @param date Fetch the comments for this date
#' @param search Fetch the comments that contain this term
#' @param user_id Fetch the comments by a particular user ID
#' @param pid Fetch the comments made on a particular person ID
#'   (Representative/Senator)
#' @param page Page of results to return
#' @param num Number of results to return
#'
#' @export
get_comments <- function(date = NULL, search = NULL, user_id = NULL, pid = NULL,
                         page = NULL, num = NULL) {
  getComments(date, search, user_id, pid, page, num)
}

#' @rdname get_comments
getComments <- function(date = NULL, search = NULL, user_id = NULL, pid = NULL,
                        page = NULL, num = NULL) {
  params <- params_from_call(match.call())
  do.call("call_api", params)
}
