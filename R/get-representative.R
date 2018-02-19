#' Fetch a particular member of the House of Representatives
#'
#' @param id If you know the person ID for the member you want (returned from
#'   get_representatives or elsewhere), this will return data for that person
#' @param division The name of an electoral division; OpenAustralia will try and
#'   work it out from whatever you give them
#' @param always_return For the division option, sets whether to always try and
#'   return a Representative, even if the seat is currently vacant
#'
#' @export
get_representative <- function(id = NULL, division = NULL,
                               always_return = NULL) {
  getRepresentative(id, division, always_return)
}

#' @rdname get_representative
getRepresentative <- function(id = NULL, division = NULL,
                              always_return = NULL) {
  params <- params_from_call(match.call())
  do.call("call_api", params)
}
