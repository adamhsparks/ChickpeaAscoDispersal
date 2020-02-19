Fit GAMs to dispersal patterns of *Ascochyta* conidia
================
A.H. Sparks
2020-02-20

## Load Libraries and Import Data

``` r
library("tidyverse")
library("mgcv")
```

``` r
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

# set factors
dat[, c("site", "distance", "rep")] <-
   lapply(dat[, c("site", "distance", "rep")], as.factor)
```

## Fit GAMs

### Distance

``` r
mod1 <-
   gam(
      mean_count_pot ~ s(dist, k = 5),
      data = dat
   )

plot(mod1)
```

![](GAM_files/figure-gfm/fit-mod1-1.png)<!-- -->

The `k` value has to be set to 5, default is 10. Else the model will not
fit due to lack of degrees of freedom.

### Windspeed

``` r
mod2 <-
   gam(
      mean_count_pot ~ s(mws, k = 5),
      data = dat
   )

plot(mod2)
```

![](GAM_files/figure-gfm/fit-mod2-1.png)<!-- -->

The `k` value has to be set to 5, default is 10. Else the model will not
fit due to lack of degrees of freedom.
