
#' Plot a windrose
#'
#' Plot a windrose showing the wind speed and direction for given facets using
#' \pkg{ggplot2}.
#'
#' This is intended to be used as a stand-alone function for any wind dataset. A
#' different windrose is plotted for each level of the faceting variable which
#' is coerced to a factor if necessary. The facets will generally be the station
#' where the data were collected, seasons or dates. Currently only one faceting
#' variable is allowed and is passed to \code{\link[ggplot2]{facet_wrap}} with
#' the formula \code{~facet}.
#'
#' @section Theme Selection:
#' For black and white windroses that may be preferred if plots are to be used
#' in journal articles for example, recommended \code{ggtheme}s are \code{'bw'},
#' \code{'linedraw'}, \code{'minimal'} or \code{'classic'} and
#' the \code{col_pal} should be \code{'Greys'}. Otherwise, any of the sequential
#' \code{\link[RColorBrewer]{brewer.pal.info}} or discrete palettes from
#' \code{\link[viridis]{viridis_pal}} colour palettes are recommended for colour
#'  plots.
#'
#' @return a \code{ggplot} object.
#'
#' @param speed numeric vector of wind speeds.
#' @param direction numeric vector of wind directions.
#' @param facet character or factor vector of the facets used to plot the various
#'              windroses.
#' @param n_directions the number of direction bins to plot (petals on the rose).
#'                     The number of directions defaults to 12.
#' @param n_speeds the number of equally spaced wind speed bins to plot. This is
#'                 used if \code{speed_cuts} is \code{NA} (default 5).
#' @param speed_cuts numeric vector containing the cut points for the wind speed
#'                 intervals, or \code{NA} (default).
#' @param calm_wind the upper limit for wind speed that is considered calm
#'                  (default 0).
#' @param variable_wind numeric code for variable winds (if applicable).
#' @param legend_title character string to be used for the legend title.
#' @param col_pal character string indicating the name of the
#'                \code{\link[RColorBrewer]{brewer.pal.info}} or
#'                \code{\link[viridis]{viridis_pal}} colour palette to be
#'                used for plotting, see 'Theme Selection' below.
#' @param ggtheme character string (partially) matching the
#'                \code{\link[ggplot2]{ggtheme}} to be used for plotting, see
#'                'Theme Selection' below.
#' @param n_col The number of columns of plots (default 1).
#' @param ... further arguments passed to \code{\link[ggplot2]{theme}}.
#'
#' @seealso \code{\link[ggplot2]{theme}} for more possible arguments to pass to
#' \code{windrose}.
#' 
#' @note This is a modified version of the function adapted from \pkg{clifro}.
#' This version adds the \pkg{viridis} colour scales.
#'
#' @author Blake Seers, blake.seers@@gmail.com
#'
#' @examples
#' # Create some dummy wind data with predominant south to westerly winds, and
#' # occasional yet higher wind speeds from the NE (not too dissimilar to
#' # Auckland).
#'
#' wind_df = data.frame(wind_speeds = c(rweibull(80, 2, 4), rweibull(20, 3, 9)),
#'                      wind_dirs = c(rnorm(80, 135, 55), rnorm(20, 315, 35)) %% 360,
#'                      station = rep(rep(c("Station A", "Station B"), 2),
#'                                    rep(c(40, 10), each = 2)))
#'
#' # Plot a simple windrose using all the defaults, ignoring any facet variable
#' with(wind_df, windrose(wind_speeds, wind_dirs))
#'
#' # Create custom speed bins, add a legend title, and change to a B&W theme
#' with(wind_df, windrose(wind_speeds, wind_dirs,
#'                        speed_cuts = c(3, 6, 9, 12),
#'                        legend_title = "Wind Speed\n(m/s)",
#'                        legend.title.align = .5,
#'                        ggtheme = "bw",
#'                        col_pal = "Greys"))
#'
#' # Note that underscore-separated arguments come from the windrose method, and
#' # period-separated arguments come from ggplot2::theme().
#'
#' # Include a facet variable with one level
#' with(wind_df, windrose(wind_speeds, wind_dirs, "Artificial Auckland Wind"))
#'
#' # Plot a windrose for each level of the facet variable (each station)
#' with(wind_df, windrose(wind_speeds, wind_dirs, station, n_col = 2))
#'
#' \dontrun{
#' # Save the plot as a png to the current working directory
#' library(ggplot2)
#' ggsave("my_windrose.png")
#' }
#'
#' @importFrom RColorBrewer brewer.pal
#' @importFrom viridis viridis_pal
#' @importFrom scales percent_format
#' @importFrom ggplot2 ggplot coord_polar geom_bar cut_interval aes_string
#' scale_x_discrete scale_fill_manual theme_grey theme_bw theme_classic
#' theme_gray theme_linedraw theme_light theme_minimal element_blank
#' element_text facet_wrap scale_y_continuous theme
#' @importFrom methods missingArg
#' @export
windrose = function(speed,
                    direction,
                    facet,
                    n_directions = 12,
                    n_speeds = 5,
                    speed_cuts = NA,
                    col_pal = "GnBu",
                    ggtheme = c("grey", "gray", "bw", "linedraw",
                                "light", "minimal", "classic"),
                    legend_title = "Wind Speed",
                    calm_wind = 0,
                    variable_wind = 990,
                    n_col = 1,
                    ...) {
   if (missingArg(speed))
      stop("speed can't be missing")
   
   if (missingArg(direction))
      stop("direction can't be missing")
   
   include_facet = !missingArg(facet)
   if (include_facet) {
      if (!is.character(facet) && !is.factor(facet))
         stop("the faceting variable needs to be character or factor")
      
      if (length(facet) == 1)
         facet = rep(facet, length(speed))
      
      if (length(facet) != length(speed))
         stop("the facet variable must be the same length as the wind
                   speeds")
   }
   
   if (!is.numeric(speed))
      stop("wind speeds need to be numeric")
   
   if (!is.numeric(direction))
      stop("wind directions need to be numeric")
   
   if (length(speed) != length(direction))
      stop("wind speeds and directions must be the same length")
   
   if (any((direction > 360 |
            direction < 0) & (direction != variable_wind),
           na.rm = TRUE))
      stop("wind directions can't be outside the interval [0, 360]")
   
   if (!is.numeric(n_directions) || length(n_directions) != 1)
      stop("n_directions must be a numeric vector of length 1")
   
   if (!is.numeric(n_speeds) || length(n_speeds) != 1)
      stop("n_speeds must be a numeric vector of length 1")
   
   if (!is.numeric(variable_wind) || length(variable_wind) != 1)
      stop("variable_wind must be a numeric vector of length 1")
   
   if (!is.numeric(calm_wind) || length(calm_wind) != 1)
      stop("calm_wind must be a numeric vector of length 1")
   
   if ((!is.character(legend_title) &&
        !is.expression(legend_title)) || length(legend_title) != 1)
      stop("legend title must be a single character string or expression")
   
   if (n_directions > 180) {
      n_directions = 180
      warning("using the maximum number of wind directions; 180")
   }
   
   if (n_directions < 4) {
      n_directions = 4
      warning("using the minimum number of wind directions; 4")
   }
   
   if (!missing(speed_cuts) && length(speed_cuts) < 3) {
      warning("using the minimum 3 speed cuts")
      speed_cuts = 3
   }
   
   ggtheme = match.arg(ggtheme)
   
   ## Optimising the input - select values for n_directions so that bins center
   ## on all N, E, S and W
   optimal_n_dir = seq(1, 45, 2) * 4
   if (is.na(match(n_directions, optimal_n_dir))) {
      n_directions = optimal_n_dir[which.min(abs(n_directions - optimal_n_dir))]
      message("using the closest optimal number of wind directions (",
              n_directions,
              ")")
   }
   
   ## Remove the variable winds
   not_variable = (direction != variable_wind)
   speed = speed[not_variable]
   direction = direction[not_variable]
   
   if (include_facet)
      facet = facet[not_variable]
   
   ## Create factor variable for wind direction intervals
   dir_bin_width = 360 / n_directions
   dir_bin_cuts = seq(dir_bin_width / 2, 360 - dir_bin_width / 2, dir_bin_width)
   dir_intervals = findInterval(c(direction, dir_bin_cuts), dir_bin_cuts)
   dir_intervals[dir_intervals == n_directions] = 0
   factor_labs = paste(c(utils::tail(dir_bin_cuts, 1), utils::head(dir_bin_cuts, -1)),
                       dir_bin_cuts, sep = ", ")
   dir_bin = head::head(factor(dir_intervals, labels = paste0("(", factor_labs, "]")),
                  -n_directions)
   
   
   ## Create a factor variable for wind speed intervals
   if (!missing(speed_cuts)) {
      if (speed_cuts[1] > min(speed, na.rm = TRUE))
         speed_cuts = c(0, speed_cuts)
      
      if (utils::tail(speed_cuts, 1) < max(speed, na.rm = TRUE))
         speed_cuts = c(speed_cuts, max(speed, na.rm = TRUE))
      spd_bin = cut(speed, speed_cuts)
   } else
      spd_bin = cut_interval(speed, n_speeds)
   
   ## select the colour palette from viridis or brewer
   if (nchar(col_pal) == 1) {
      spd_cols = viridis_pal(option = col_pal, direction = -1)(length(levels(spd_bin)))
   } else {
      spd_cols = brewer.pal(length(levels(spd_bin)), col_pal)
   }
   
   if (length(spd_cols) != length(levels(spd_bin)))
      spd_bin = cut_interval(speed, length(spd_cols))
   
   ## Create the dataframe suitable for plotting
   if (include_facet) {
      ggplot_df = as.data.frame(table(dir_bin, spd_bin, facet))
      ggplot_df$proportion = unlist(by(ggplot_df$Freq, ggplot_df$facet,
                                       function(x)
                                          x / sum(x)),
                                    use.names = FALSE)
   } else {
      ggplot_df = data.frame(table(dir_bin, spd_bin))
      ggplot_df$proportion = ggplot_df$Freq / sum(ggplot_df$Freq)
   }
   
   ## (gg)Plot me
   ggwindrose = ggplot(data = ggplot_df,
                       aes_string(x = "dir_bin", fill = "spd_bin", y = "proportion")) +
      geom_bar(stat = "identity") +
      scale_x_discrete(
         breaks = levels(ggplot_df$dir_bin)[seq(1, n_directions,
                                                n_directions / 4)],
         labels = c("N", "E", "S", "W"),
         drop = FALSE
      ) +
      scale_fill_manual(name = legend_title, values = spd_cols) +
      coord_polar(start = 2 * pi - pi / n_directions) +
      scale_y_continuous(labels = percent_format()) +
      eval(call(paste0("theme_", ggtheme))) +
      theme(axis.title = element_blank(), ...)
   
   if (include_facet)
      ggwindrose = ggwindrose + facet_wrap( ~ facet, ncol = n_col)
   
   return(ggwindrose)
}
