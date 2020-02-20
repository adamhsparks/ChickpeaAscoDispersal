Fit GAMs to dispersal patterns of *Ascochyta* conidia
================
A.H. Sparks
2020-02-20

## Load Libraries and Import Data

``` r
library("tidyverse")
library("mgcv")
library("theme.usq")
library("broom")
```

``` r
source("R/wrangle_raw_data.R")
glimpse(dat)
```

    ## Observations: 336
    ## Variables: 29
    ## $ SpEv           <fct> pbc_1, pbc_1, pbc_1, pbc_1, pbc_1, pbc_1, pbc_1, pbc_1…
    ## $ site           <fct> pbc, pbc, pbc, pbc, pbc, pbc, pbc, pbc, pbc, pbc, pbc,…
    ## $ rep            <fct> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
    ## $ distance       <chr> "0 m", "0 m", "0 m", "0 m", "0 m", "0 m", "0 m", "0 m"…
    ## $ station        <fct> 1, 1, 2, 2, 3, 3, 4, 4, 1, 1, 2, 2, 3, 3, 4, 4, 1, 1, …
    ## $ transect       <fct> 1, 1, 4, 4, 7, 7, 10, 10, 1, 1, 4, 4, 7, 7, 10, 10, 1,…
    ## $ dist_stat      <chr> "0m_1", "0m_1", "0m_2", "0m_2", "0m_3", "0m_3", "0m_4"…
    ## $ plant_no       <fct> 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, …
    ## $ pot_no         <fct> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,…
    ## $ counts_p1      <dbl> 1, 2, 3, 5, 3, 0, 2, 0, 0, 1, 3, 0, 0, 2, 1, 6, 3, 1, …
    ## $ counts_p2      <dbl> 2, 5, 3, 3, 1, 3, 2, 3, 2, 0, 0, 2, 1, 0, 0, 3, 0, 1, …
    ## $ counts_p3      <dbl> 2, 1, 4, 1, 4, 2, 1, 5, 0, 0, 0, 5, 1, 4, 1, 2, 1, 2, …
    ## $ counts_p4      <dbl> 0, 1, 3, 3, 5, 3, 1, 4, 0, 0, 1, 0, 0, 0, 0, 3, 0, 2, …
    ## $ counts_p5      <dbl> 3, 4, 2, 2, 3, 2, 1, 2, 0, 2, 1, 2, 0, 0, 0, 2, 0, 0, …
    ## $ mean_count_pot <dbl> 1.6, 2.6, 3.0, 2.8, 3.2, 2.0, 1.4, 2.8, 0.4, 0.6, 1.0,…
    ## $ SD_count_pot   <dbl> 1.1401754, 1.8165902, 0.7071068, 1.4832397, 1.4832397,…
    ## $ mat            <dbl> 11.27586, 11.27586, 11.27586, 11.27586, 11.27586, 11.2…
    ## $ mah            <dbl> 70.69931, 70.69931, 70.69931, 70.69931, 70.69931, 70.6…
    ## $ minws          <dbl> 0.7834483, 0.7834483, 0.7834483, 0.7834483, 0.7834483,…
    ## $ mws            <dbl> 1.902828, 1.902828, 1.902828, 1.902828, 1.902828, 1.90…
    ## $ maxws          <dbl> 3.357724, 3.357724, 3.357724, 3.357724, 3.357724, 3.35…
    ## $ mwd            <dbl> 211.3756, 211.3756, 211.3756, 211.3756, 211.3756, 211.…
    ## $ precip         <dbl> 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10…
    ## $ ptype          <chr> "simRain", "simRain", "simRain", "simRain", "simRain",…
    ## $ mdp            <dbl> 5.568493, 5.568493, 5.568493, 5.568493, 5.568493, 5.56…
    ## $ mrain          <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
    ## $ dist           <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 10, 10, 10…
    ## $ rainfall       <dbl> 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10…
    ## $ sum_rain       <dbl> 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10…

## Visualise the Dispersal Data

``` r
ggplot(dat, aes(x = dist, y = mean_count_pot)) +
   geom_count(na.rm = TRUE, alpha = 0.5) +
   stat_summary(fun.y = "median",
                geom = "line",
                na.rm = TRUE) +
   stat_summary(
      fun.y = "median",
      colour = usq_cols("usq yellow"),
      na.rm = TRUE,
      size = 5.5,
      geom = "point",
      alpha = 0.65
   ) +
   theme_usq() +
   ylab("Median and high/low mean lesion count values") +
   xlab("Distance (m)")
```

![](GAM_files/figure-gfm/visualise_data-1.png)<!-- -->

## Fit GAMs

### mod1 - s(Distance)

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

The `k` value has to be set to 5, default is 10. Else the model will not
fit due to lack of degrees of freedom.

### mod2 - s(Distance) plus Precipitation

    ## 
    ## Family: gaussian 
    ## Link function: identity 
    ## 
    ## Formula:
    ## mean_count_pot ~ sum_rain + s(dist, k = 5)
    ## 
    ## Parametric coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.816921   0.090724   9.004  < 2e-16 ***
    ## sum_rain    0.028779   0.008496   3.387 0.000792 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Approximate significance of smooth terms:
    ##           edf Ref.df     F p-value    
    ## s(dist) 3.928  3.996 80.95  <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## R-sq.(adj) =  0.498   Deviance explained = 50.5%
    ## GCV = 0.74389  Scale est. = 0.73069   n = 334

### mod3 - s(Distance) Windspeed

    ## 
    ## Family: gaussian 
    ## Link function: identity 
    ## 
    ## Formula:
    ## mean_count_pot ~ mws + s(dist, k = 5)
    ## 
    ## Parametric coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  0.64401    0.11825   5.446 1.01e-07 ***
    ## mws          0.12273    0.03059   4.012 7.47e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Approximate significance of smooth terms:
    ##           edf Ref.df     F p-value    
    ## s(dist) 3.929  3.996 81.99  <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## R-sq.(adj) =  0.504   Deviance explained = 51.2%
    ## GCV = 0.73389  Scale est. = 0.72086   n = 334

### mod4 - s(Distance) Windspeed plus Precipitation

    ## 
    ## Family: gaussian 
    ## Link function: identity 
    ## 
    ## Formula:
    ## mean_count_pot ~ sum_rain + mws + s(dist, k = 5)
    ## 
    ## Parametric coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.473449   0.131519   3.600 0.000368 ***
    ## sum_rain    0.024009   0.008457   2.839 0.004808 ** 
    ## mws         0.108916   0.030659   3.552 0.000438 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Approximate significance of smooth terms:
    ##          edf Ref.df    F p-value    
    ## s(dist) 3.93  3.996 83.8  <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## R-sq.(adj) =  0.515   Deviance explained = 52.3%
    ## GCV = 0.72064  Scale est. = 0.70569   n = 334

### mod5 - s(Distance + Windspeed) plus Precipitation

    ## Warning in term[i] <- attr(terms(reformulate(term[i])), "term.labels"): number
    ## of items to replace is not a multiple of replacement length

    ## 
    ## Family: gaussian 
    ## Link function: identity 
    ## 
    ## Formula:
    ## mean_count_pot ~ sum_rain + s(dist + mws, k = 5)
    ## 
    ## Parametric coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.816921   0.090724   9.004  < 2e-16 ***
    ## sum_rain    0.028779   0.008496   3.387 0.000792 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Approximate significance of smooth terms:
    ##           edf Ref.df     F p-value    
    ## s(dist) 3.928  3.996 80.95  <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## R-sq.(adj) =  0.498   Deviance explained = 50.5%
    ## GCV = 0.74389  Scale est. = 0.73069   n = 334

## Compare the Models

### AIC, BIC

    ## # A tibble: 5 x 7
    ##   model    df logLik   AIC   BIC deviance df.residual
    ##   <chr> <dbl>  <dbl> <dbl> <dbl>    <dbl>       <dbl>
    ## 1 mod4   6.93  -412.  840.  871.     231.        327.
    ## 2 mod3   5.93  -416.  846.  873.     236.        328.
    ## 3 mod2   5.93  -419.  851.  877.     240.        328.
    ## 4 mod5   5.93  -419.  851.  877.     240.        328.
    ## 5 mod1   4.93  -424.  860.  883.     248.        329.

### R<sup>2</sup>

    ## # A tibble: 4 x 2
    ##   name  value
    ##   <chr> <dbl>
    ## 1 mod4  0.515
    ## 2 mod3  0.504
    ## 3 mod2  0.498
    ## 4 mod1  0.482

### ANOVA

    ## Analysis of Deviance Table
    ## 
    ## Model 1: mean_count_pot ~ s(dist, k = 5)
    ## Model 2: mean_count_pot ~ sum_rain + s(dist, k = 5)
    ## Model 3: mean_count_pot ~ mws + s(dist, k = 5)
    ## Model 4: mean_count_pot ~ sum_rain + mws + s(dist, k = 5)
    ## Model 5: mean_count_pot ~ sum_rain + s(dist + mws, k = 5)
    ##   Resid. Df Resid. Dev          Df Deviance          F    Pr(>F)    
    ## 1       329     248.10                                              
    ## 2       328     239.72  1.00019797   8.3816    11.8748 0.0006427 ***
    ## 3       328     236.49  0.00017108   3.2247 26709.8941 2.926e-06 ***
    ## 4       327     230.81  1.00011438   5.6857     8.0561 0.0048171 ** 
    ## 5       328     239.72 -1.00028547  -8.9104    12.6230 0.0004365 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### Visualise the Models

![](GAM_files/figure-gfm/vis-mods-1.png)<!-- -->![](GAM_files/figure-gfm/vis-mods-2.png)<!-- -->
