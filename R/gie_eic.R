#' Get the historical data export for for a specific company within a country.
#'
#' @param country_code Two digit country code. Ex: NL, DE, DK, SE, FI etc.
#' @param eic_code The 21 digit eic code of the company as found on the API page.
#' @param api_key The default is NULL and searches for your GIE_PAT in you .Renviron
#'     file.
#' @param max_pages Maximum number of pages.
#'
#' @export
#'
#' @examples
#'
#' library(tidyverse)
#' library(gie)
#'
#' head(gie_gas_eic("AT", "25X-GSALLC-----E"))
#'
gie_gas_eic <- function(country_code, eic_code, api_key = NULL, max_pages = 3){

  country_code <- toupper(country_code)

  if(length(country_code) > 1){
    stop("country_code only accepts a vector of length one.")
  }


  url <- paste0("https://agsi.gie.eu/api/data/", eic_code, "/", country_code)

  cont_df <- gie_internal_page_request(url, api_key, max_pages = max_pages, country_code = country_code)

  if(nrow(cont_df) == 0){
    stop("No data with these parameters.")
  }

  cont_df$info <- sapply(cont_df$info, function(x){
    if(length(x) < 1){
      x <- as.character(NA)
    } else {
      x <- paste(x, collapse = ";")
    }
    x
  })
  cont_df <- suppressMessages(readr::type_convert(cont_df, na = c("", "NA", "-")))

  cont_df
}


#' Get the historical data export for for a specific company within a country.
#'
#' @param country_code Two digit country code. Ex: NL, DE, DK, SE, FI etc.
#' @param eic_code The 21 digit eic code of the company as found on the API page.
#' @param api_key The default is NULL and searches for your GIE_PAT in you .Renviron
#'     file.
#' @param max_pages Maximum number of pages.
#'
#' @export
#'
#'
gie_lng_eic <- function(country_code, eic_code, api_key = NULL, max_pages = 3){

  country_code <- toupper(country_code)

  if(length(country_code) > 1){
    stop("country_code only accepts a vector of length one.")
  }


  url <- paste0("https://alsi.gie.eu/api/data/", eic_code, "/", country_code)

  cont_df <- gie_internal_page_request(url, api_key, max_pages = max_pages, country_code = country_code)

  if(nrow(cont_df) == 0){
    stop("No data with these parameters.")
  }

  cont_df$info <- sapply(cont_df$info, function(x){
    if(length(x) < 1){
      x <- as.character(NA)
    } else {
      x <- paste(x, collapse = ";")
    }
    x
  })
  cont_df <- suppressMessages(readr::type_convert(cont_df, na = c("", "NA", "-")))

  cont_df
}


#' Function to get a list of EIC units.
#'
#' @param unnest_facilities Defaults to true.
#'
#' @export
#'
#'
gie_lng_eic_list <- function(unnest_facilities = TRUE){

  eic <- jsonlite::fromJSON("https://alsi.gie.eu/api/about?show=listing", simplifyDataFrame = TRUE, simplifyVector = TRUE, simplifyMatrix = TRUE, flatten = TRUE)
  eic <- tibble::as_tibble(eic)

  if(unnest_facilities){
    eic <- tidyr::unnest(eic, facilities, names_sep = "_")
  }
  eic
}

#' Function to get a list of EIC units with some more info.
#'
#' @export
#'
#'
gie_lng_eic_list_full <- function(){

  eic <- jsonlite::fromJSON("https://alsi.gie.eu/api/about", simplifyDataFrame = TRUE, simplifyVector = TRUE, simplifyMatrix = TRUE, flatten = TRUE)
  eic <- tibble::as_tibble(eic)
  eic <- tidyr::unnest(eic, LSO)
  eic <- tidyr::unnest(eic, LSO)
  eic <- dplyr::mutate(eic,
                facilities = lapply(facilities,
                                    function(x){names(x) <- paste0("facilities_", names(x));x}))
  eic <- tidyr::unnest(eic, facilities)
  names(eic) <- stringr::str_replace_all(names(eic), "[.]", "_")

  eic
}


#' Function to get a list of EIC units.
#'
#' @param unnest_facilities Defaults to true.
#'
#' @export
#'
#'
gie_gas_eic_list <- function(unnest_facilities = TRUE){

  eic <- jsonlite::fromJSON("https://agsi.gie.eu/api/about?show=listing", simplifyDataFrame = TRUE, simplifyVector = TRUE, simplifyMatrix = TRUE, flatten = TRUE)
  eic <- tibble::as_tibble(eic)

  if(unnest_facilities){
    eic <- tidyr::unnest(eic, facilities, names_sep = "_")
  }
  eic
}

#' Function to get a list of EIC units with some more info.
#'
#' @export
#'
#'
gie_gas_eic_list_full <- function(){

  eic <- jsonlite::fromJSON("https://agsi.gie.eu/api/about", simplifyDataFrame = TRUE, simplifyVector = TRUE, simplifyMatrix = TRUE, flatten = TRUE)
  eic <- tibble::as_tibble(eic)
  eic <- tidyr::unnest(eic, SSO)
  eic <- tidyr::unnest(eic, SSO)
  eic <- dplyr::mutate(eic,
                       facilities = lapply(facilities,
                                           function(x){names(x) <- paste0("facilities_", names(x));x}))
  eic <- tidyr::unnest(eic, facilities)
  names(eic) <- stringr::str_replace_all(names(eic), "[.]", "_")

  eic
}
