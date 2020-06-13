# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:4.0.0

# required
MAINTAINER Adam Sparks adamhsparks@gmail.com

COPY --chown=rstudio . /home/rstudio/ChickpeaAscoDispersal

# install system-level libs
RUN apt-get update && \
    apt-get install -y libudunits2-dev libgdal-dev && \
    rm -r /var/lib/apt/lists/*

# go into the repo directory
RUN . /etc/environment \
  \
 # build this compendium package
  && R -e "devtools::install('home/rstudio/ChickpeaAscoDispersal', dep=TRUE)"
