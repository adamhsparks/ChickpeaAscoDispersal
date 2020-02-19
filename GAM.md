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

### mod1 - s(Distance)

``` r
mod1 <-
   gam(
      mean_count_pot ~ s(dist, k = 5),
      data = dat
   )

plot(mod1)
```

![](GAM_files/figure-gfm/fit-mod1-1.png)<!-- -->

``` r
summary(mod1)
```

    ## 
    ## Family: gaussian 
    ## Link function: identity 
    ## 
    ## Formula:
    ## mean_count_pot ~ s(dist, k = 5)
    ## 
    ## Parametric coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  1.08024    0.04751   22.74   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Approximate significance of smooth terms:
    ##           edf Ref.df    F p-value    
    ## s(dist) 3.926  3.996 78.4  <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## R-sq.(adj) =  0.482   Deviance explained = 48.8%
    ## GCV = 0.76522  Scale est. = 0.75394   n = 334

``` r
AIC(mod1)
```

    ## [1] 860.4022

The `k` value has to be set to 5, default is 10. Else the model will not
fit due to lack of degrees of freedom.

### mod2 - s(Distance) plus Precipitation

``` r
mod2 <-
   gam(
      mean_count_pot ~ precip + s(dist, k = 5),
      data = dat
   )

plot(mod2)
```

![](GAM_files/figure-gfm/fit-mod2-1.png)<!-- -->

``` r
summary(mod2)
```

    ## 
    ## Family: gaussian 
    ## Link function: identity 
    ## 
    ## Formula:
    ## mean_count_pot ~ precip + s(dist, k = 5)
    ## 
    ## Parametric coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.806387   0.064128  12.575  < 2e-16 ***
    ## precip      0.054385   0.009042   6.015 4.81e-09 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Approximate significance of smooth terms:
    ##           edf Ref.df     F p-value    
    ## s(dist) 3.933  3.996 86.84  <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## R-sq.(adj) =  0.532   Deviance explained = 53.9%
    ## GCV = 0.69345  Scale est. = 0.68113   n = 334

``` r
AIC(mod2)
```

    ## [1] 827.4725

The `k` value has to be set to 5, default is 10. Else the model will not
fit due to lack of degrees of freedom.

### mod3 - s(Distance and Windspeed) plus Precipitation

``` r
mod3 <-
   gam(
      mean_count_pot ~ precip + s(dist + mws, k = 3),
      data = dat
   )
```

    ## Warning in term[i] <- attr(terms(reformulate(term[i])), "term.labels"): number
    ## of items to replace is not a multiple of replacement length

``` r
plot(mod3)
```

![](GAM_files/figure-gfm/fit-mod3-1.png)<!-- -->

``` r
summary(mod3)
```

    ## 
    ## Family: gaussian 
    ## Link function: identity 
    ## 
    ## Formula:
    ## mean_count_pot ~ precip + s(dist + mws, k = 3)
    ## 
    ## Parametric coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.806692   0.067273  11.991  < 2e-16 ***
    ## precip      0.054325   0.009486   5.727  2.3e-08 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Approximate significance of smooth terms:
    ##           edf Ref.df     F p-value    
    ## s(dist) 1.987      2 140.1  <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## R-sq.(adj) =  0.485   Deviance explained = 48.9%
    ## GCV = 0.75865  Scale est. = 0.74959   n = 334

``` r
AIC(mod3)
```

    ## [1] 857.5465

The `k` value has to be set to 3, default is 10. Else the model will not
fit due to lack of degrees of freedom.

## Thoughts

Examining the AIC, GCV and R^2 values, the best fitting model so far is
`mod2` with the smoothed distance and precipitation. Adding windspeed
decreases the model’s fitness and the graph indicates less of a good
explainer for dispersal as well.
