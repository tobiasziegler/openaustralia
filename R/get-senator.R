#' Fetch a particular Senator
#'
#' @param id If you know the person ID for the Senator you want, this will
#'   return data for that person
#'
#' @export
get_senator <- function(id = NULL) {
  getSenator(id)
}

#' @rdname get_senator
getSenator <- function(id = NULL) {
  params <- params_from_call(match.call())
  do.call("call_api", params)
}
