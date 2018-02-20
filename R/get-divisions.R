#' Fetch a list of electoral divisions
#'
#' @param postcode Fetch the list of electoral divisions that are within the
#'   given postcode (there can be more than one)
#' @param date ISO-style date, e.g. "1990-01-02", to fetch the list of electoral
#'   divisions as it was on this date
#' @param search Fetch the list of electoral divisions that match this search
#'   string
#'
#' @export
get_divisions <- function(postcode = NULL, date = NULL, search = NULL) {
  getDivisions(postcode, date, search)
}

#' @rdname get_divisions
getDivisions <- function(postcode = NULL, date = NULL, search = NULL) {
  params <- params_from_call(match.call())
  robj <- do.call("call_api", params)
  tibble::as_tibble(robj)
}
