#' Summarised Lesion Count Data
#'
#' A dataset of summarised chickpea ascochyta blight lesions from experimental
#' plots located at Horsham and Curyo.
#'
#' @format A \code{data.frame} with 336 rows and 17 variables:
#' \describe{
#'   \item{SpEv}{Spread event. An identifier that includes the site and
#'     replicate number}
#'   \item{site}{Location where trial was located}
#'   \item{rep}{Replicate number. The sequential number of rain or irrigation
#'    event for a given site}
#'   \item{distance}{Distance of station locations along transect from infected
#'    plot source in metres}
#'   \item{station}{Number assigned to each respective station at a given
#'    distance on a given transect}
#'   \item{transect}{Number identifying one of ten transects upon which the
#'    stations were placed}
#'   \item{plant_no}{Number identifying a given plant in a pot}
#'   \item{pot_no}{Number identifying a given pot}
#'   \item{counts_p1}{Total recorded number of lesions on a given plant within the specified pot}
#'   \item{counts_p2}{Total recorded number of lesions on a given plant within the specified pot}
#'   \item{counts_p3}{Total recorded number of lesions on a given plant within the specified pot}
#'   \item{counts_p4}{Total recorded number of lesions on a given plant within the specified pot}
#'   \item{counts_p5}{Total recorded number of lesions on a given plant within the specified pot}
#'   \item{degrees}{Compass degrees for a given transect}
#'   \item{ptype}{Type of precipitation for an event, one of three, 
#'   \code{rainfall}, \code{irrigation} or \code{mixed}}
#'   \item{mean_pot_count}{Mean value of lesion counts per plant in the specified pot}
#' }
#' @source GRDC Project USQ1903-003-RTX
"lesion_counts"
