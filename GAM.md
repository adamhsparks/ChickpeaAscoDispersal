Fit GAMs to dispersal patterns of *Ascochyta* conidia
================
A.H. Sparks
2020-02-21

## Import Data

See “R/wrangle\_raw\_data.R” for the script that handles the data
import. This Rmd file focuses on the models themselves.

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

    ## # A tibble: 5 x 2
    ##   name  value
    ##   <chr> <dbl>
    ## 1 mod4  0.515
    ## 2 mod5  0.515
    ## 3 mod3  0.504
    ## 4 mod2  0.498
    ## 5 mod1  0.482

### Coefficients

    ## 
    ## mod1

    ## (Intercept)   s(dist).1   s(dist).2   s(dist).3   s(dist).4 
    ##    1.080240  -13.444330    7.368783   -1.254080   -2.291845

    ## 
    ## mod2

    ##  (Intercept)     sum_rain    s(dist).1    s(dist).2    s(dist).3    s(dist).4 
    ##   0.81692128   0.02877889 -13.40978000   7.33464779  -1.25209090  -2.29384111

    ## 
    ## mod3

    ## (Intercept)         mws   s(dist).1   s(dist).2   s(dist).3   s(dist).4 
    ##   0.6440143   0.1227341 -13.4868763   7.3983152  -1.2560432  -2.2949104

    ## 
    ## mod4

    ##  (Intercept)     sum_rain          mws    s(dist).1    s(dist).2    s(dist).3 
    ##   0.47344866   0.02400933   0.10891607 -13.45271077   7.36612892  -1.25413637 
    ##    s(dist).4 
    ##  -2.29619141

    ## 
    ## mod5

    ##  (Intercept)     sum_rain    s(dist).1    s(dist).2    s(dist).3    s(dist).4 
    ##   0.81692128   0.02877889 -13.40978000   7.33464779  -1.25209090  -2.29384111

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
