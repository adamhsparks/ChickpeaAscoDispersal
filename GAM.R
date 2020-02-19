library("tidyverse")
library("gamm4")

# update this when OneDrive decides to work
dat <-
   read_csv("data/CPSporesSpatial version 2.csv") %>%
   group_by(site, rep, transect, distance, station, mat, mah, mws, mwd) %>%
   drop_na(dist_stat)

dbl <-
   c(
      "counts_p1",
      "counts_p2",
      "counts_p3",
      "counts_p4",
      "counts_p5",
      "mean_count_pot",
      "precip",
      "mrain",
      "mwd",
      "mws"
   )

# format lesion counts into integers
dat[, dbl] <- lapply(dat[, dbl], as.double)

# change distance to continuous variable
dat$dist <- as.numeric(gsub(" m", "", dat$distance))

dat[, c("site", "distance", "rep")] <-
   lapply(dat[, c("site", "distance", "rep")], as.factor)

mod1 <-
   gam(
      mean_count_pot ~ s(dist, k = 5),
      data = dat
   )


mod2 <-
   gam(
      mean_count_pot ~ s(mws, k = 5),
      data = dat
   )
