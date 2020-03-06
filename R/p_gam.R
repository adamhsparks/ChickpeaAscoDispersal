
#' Generic function to print GAMs using mgcViz
#'
#' @param x a GAM object created by `[mgcv]gam()`
#'
#' @return a `ggplot2` graph object of the GAM
#' @export p_gam
#'
#' @examples
#' library(mgcv)
#' set.seed(2) ## simulate some data... 
#' dat <- gamSim(1,n=400,dist="normal",scale=2)
#' b <- gam(y~s(x0)+s(x1)+s(x2)+s(x3),data=dat)
#' p_gam(b)

p_gam <- function(x) {
   plot(x, allTerms = T) +
      mgcViz::l_points() +
      mgcViz::l_fitLine(linetype = 1)  +
      mgcViz::l_ciLine(linetype = 3) +
      mgcViz::l_ciBar() +
      mgcViz::l_rug()
}
