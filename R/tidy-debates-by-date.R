#' Process nested list data of debates returned from an API search by date and
#' return a tidy nested tibble
#'
#' @param data A nested list (list of lists) with each item in the top-level
#'   list representing a debate
#' @return A tibble with each debate represented by one row.
tidy_debates_by_date <- function(data) {
  tibble_debates_by_date(data)
}

#' Convert a list of debates returned from an API search by date into a nested
#' tibble
#'
#' @param data A nested list (list of lists) with each item in the top-level
#'   list representing a debate.
#' @return A tibble with each debate represented by one row.
tibble_debates_by_date <- function(data) {
  tibble::tibble(
    epobject_id = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "epobject_id"), .null = NA_character_),
    htype = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "htype"), .null = NA_character_),
    gid = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "gid"), .null = NA_character_),
    hpos = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "hpos"), .null = NA_character_),
    section_id = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "section_id"), .null = NA_character_),
    subsection_id = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "subsection_id"), .null = NA_character_),
    hdate = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "hdate"), .null = NA_character_),
    # htime = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "htime"), .null = NA_character_),
    source_url = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "source_url"), .null = NA_character_),
    major = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "major"), .null = NA_character_),
    body = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "body"), .null = NA_character_),
    contentcount = purrr::map_chr(data, ~ purrr::pluck(.x, "entry", "contentcount"), .null = NA_character_),
    subs = purrr::map(data, tibble_subs)
  )
}

#' Convert a list of sub-debates into a tibble.
#'
#' @param data A list with each item representing a sub-debate.
#'
#' @return A tibble with each sub-debate represented by one row.
tibble_subs <- function(data) {
  tibble::tibble(
    epobject_id = purrr::map_chr(data[["subs"]], "epobject_id", .null = NA_character_),
    htype = purrr::map_chr(data[["subs"]], "htype", .null = NA_character_),
    gid = purrr::map_chr(data[["subs"]], "gid", .null = NA_character_),
    hpos = purrr::map_chr(data[["subs"]], "hpos", .null = NA_character_),
    section_id = purrr::map_chr(data[["subs"]], "section_id", .null = NA_character_),
    subsection_id = purrr::map_chr(data[["subs"]], "subsection_id", .null = NA_character_),
    hdate = purrr::map_chr(data[["subs"]], "hdate", .null = NA_character_),
    # htime = purrr::map_chr(data[["subs"]], "htime", .null = NA_character_),
    source_url = purrr::map_chr(data[["subs"]], "source_url", .null = NA_character_),
    major = purrr::map_chr(data[["subs"]], "major", .null = NA_character_),
    body = purrr::map_chr(data[["subs"]], "body", .null = NA_character_),
    contentcount = purrr::map_chr(data[["subs"]], "contentcount", .null = NA_character_)
  )
}
