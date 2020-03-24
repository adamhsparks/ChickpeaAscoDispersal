#' Summary of Weather Data from Horsham and Curyo
#'
#' A summarised dataset of weather data from on-site weather stations at Horsham
#'  and Curyo.
#'
#' @format A \code{data.frame} with 2202 rows and 6 variables:
#' \describe{
#'   \item{site}{Location where trial was located}
#'   \item{rep}{Replicate number. The sequential number of rain or irrigation
#'    event for a given site}
#'   \item{mws}{Mean wind speed for the event}
#'   \item{ws_sd}{Standard deviation of the wind speed for the event}
#'   \item{mwd}{Mean recorded wind direction in compass degrees as calcuated by
#'    \code{circular.averaging()}}
#'   \item{sum_rain}{Sum total of recorded precipitation for the event in
#'    millimetres}
#' }
#' @source Dr Joshua Fanning, AgricultureVictoria, Horsham, Vic, AUS
"summary_weather"
