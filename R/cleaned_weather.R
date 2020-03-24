#' Cleaned Weather Data from Horsham and Curyo
#'
#' A dataset of ten-minute observation weather data from on-site weather
#'  stations at Horsham and Curyo.
#'
#' @format A \code{data.frame} with 2202 rows and 6 variables:
#' \describe{
#'   \item{site}{Location where trial was located}
#'   \item{rep}{Replicate number. The sequential number of rain or irrigation
#'    event for a given site}
#'   \item{time}{Date in POSIXct, format YYYY-MM-DD HH:MM:SS}
#'   \item{wind_speed}{Recorded wind speed in metres per second}
#'   \item{wind_direction}{Recorded wind direction in compass degrees}
#'   \item{rainfall}{Recorded precipitation in millimetres}
#' }
#' @source Dr Joshua Fanning, AgricultureVictoria, Horsham, Vic, AUS
"cleaned_weather"
