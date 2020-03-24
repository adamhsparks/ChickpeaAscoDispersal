
#' Generic function to print GAMs using mgcViz
#'
#' @param x a GAM object created by `[mgcv]gam()`
#'
#' @return a `ggplot2` graph object of the GAM
#' @export p_gam
#'
#' @examples
#' # load necessary libraries
#' library("tidyverse")
#' library("mgcv")
#' library("mgcViz")
#' library("ChickpeaAscoDispersal")
#' 
#' # these data are automatically loaded
#' dat <- left_join(lesion_counts, summary_weather, by = c("site", "rep"))
#' 
#' mod1 <- gam(
#'   mean_pot_count ~ s(distance, k = 5),
#'   data = dat
#' )
#' 
#' print(p_gam(x = getViz(mod1)) +
#'         ggtitle("s(Distance)"),
#'       pages = 1)
#'       

p_gam <- function(x) {
   graphics::plot(x, allTerms = T) +
      mgcViz::l_points() +
      mgcViz::l_fitLine(linetype = 1)  +
      mgcViz::l_ciLine(linetype = 3) +
      mgcViz::l_ciBar() +
      mgcViz::l_rug()
}
