 <!-- badges: start -->
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable) [![DOI](https://zenodo.org/badge/241245286.svg)](https://zenodo.org/badge/latestdoi/241245286)
<!-- badges: end -->
  
# The role of conidia in the dispersal of _Ascochyta rabiei_

The goal of this research is to examine the role of _Ascochyta rabiei_ conidia dispersal of chickpea ascochyta blight in Australia.

A user-friendly website of this research compendium is available here, <https://adamhsparks.github.io/ChickpeaAscoDispersal/>.
Interested parties may wish to view the data analysis and visualisation pipeline as well as model fitting, these are available under the "Articles" menu item of the [web page](https://adamhsparks.github.io/ChickpeaAscoDispersal/).

A preprint of this paper is available from: <https://doi.org/10.1101/2020.05.12.091827> and is included in "analysis/paper/".

## Reproducibility

This analysis is packaged a fully complete Docker instance.
To get started, install Docker for your respective OS, https://docs.docker.com/get-docker/, and run the following commands.

```
docker pull adamhsparks/chickpea_asco_dispersal:main
docker run -p 8787:8787 -d adamhsparks/chickpea_asco_dispersal:main
```

Once the image is running, open a browser window and go to `localhost:8787`, log in with `rstudio` and password `rstudio`.

From there, the files are available in the "ChickpeaAscoDispersal" folder shown in the lower right-hand window pane.
The paper is located in "analysis/paper".
The vignettes, located in "vignettes" detail the data processing, weather data validation and and modelling work.
These files can be opened and run interactively or knit using the "knit" button in RStudio to recreate the full analysis.

## Data availability

All data from this work are included in this repository and R package in the "inst/extdata" folder but also archived and documented with Zenodo, [10.5281/zenodo.3842293](https://doi.org/10.5281/zenodo.3842293), for reuse.

## Project team

- Dr Ihsanul Khaliq, University of Southern Queensland, Centre for Crop Health, Toowoomba, Queensland 4350, Australia

- Dr Joshua Fanning, Agriculture Victoria, Horsham, Victoria, 3401, Australia

- Dr Paul Melloy, University of Southern Queensland, Centre for Crop Health, Toowoomba, Queensland 4350, Australia

- Ms Jean Galloway, Department of Primary Industries and Regional Development (DPIRD), Northam, WA, 6401, Australia

- Dr Kevin Moore, New South Wales Department of Primary Industries, 4 Marsden Park Rd, Tamworth, NSW, 2340, Australia

- Mr Daniel Burrell, University of Southern Queensland, Centre for Crop Health, Toowoomba, Queensland 4350, Australia

**Project PI:**

- Associate Professor Adam H. Sparks, University of Southern Queensland, Centre for Crop Health, Toowoomba, Queensland 4350, Australia

## Abstract

_Ascochyta rabiei_ asexual spores (conidia) were assumed to spread over short distances (~10 m) in combination of rain and strong wind. We investigated the potential distance of conidial spread in three rainfall and three sprinkler irrigation events. Chickpea trap plants were distributed at the distances of 0, 10, 25, 50 and 75 m from infested chickpea plots before scheduled irrigation and forecast rainfall events. Trap plants were transferred to a controlled temperature room (20 °C) for 48 h (100% humidity) after being exposed in the field for 2–6 days for rainfall events, and for one day for irrigation events. After 48 h incubation period, trap plants were transferred to a glasshouse (20 °C) to allow lesion development. Lesions on all plant parts were counted after two weeks, which gave an estimate of the number of conidia released and the distance travelled. Trap plants at all distances were infected in all sprinkler irrigation and rainfall events. The highest number of lesions on trap plants were recorded closest to the infested plots – the numbers decreased as the distance from the infested plots increased. There was a positive relationship between the amount of rainfall and the number of lesions recorded on trap plants. A generalised additive model was developed that efficiently described spatial patterns of conidial spread. With further development, the model can be used to predict the spread of _A. rabiei_. This is the first systematic study to show that conidia distribute _A. rabiei_ over longer distances than previously reported.

## Citation

Please cite this research compendium as:  

> Ihsanul Khaliq, Joshua Fanning, Paul Melloy, Jean Galloway, Kevin Moore, Daniel Burrell and Adam H. Sparks. ChickpeaAscoDispersal: A research compendium to accompany 'The role of conidia in the dispersal of _Ascochyta rabiei_'. Online at https://doi.org/10.5281/zenodo.3810826.

## Licences

Data: [CC-BY-4.0 International](http://creativecommons.org/licenses/by/4.0/legalcode) attribution requested in reuse  
Manuscript: [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/)  
Code: [GPL (>= 3)](https://opensource.org/licenses/GPL-3.0)
Year: 2020, copyright holder: University of Southern Queensland (USQ) and Grains Research and Development Corporation (GRDC)

## Contributions

We welcome contributions from everyone.
Before you get started, please see our [contributor guidelines](CONTRIBUTING.html).
Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.html).
By participating in this project you agree to abide by its terms.
