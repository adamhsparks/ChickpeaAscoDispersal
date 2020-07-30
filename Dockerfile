# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:4.0.0

# required
MAINTAINER Adam Sparks adamhsparks@gmail.com

COPY --chown=rstudio . /home/rstudio/ChickpeaAscoDispersal

# install system-level libs
RUN apt-get update && \
    apt-get install -y libudunits2-dev libgdal-dev libglu1-mesa-dev && \
    rm -r /var/lib/apt/lists/*

# go into the repo directory
RUN . /etc/environment \
  \
 # build this compendium package
  && R -e "devtools::install('home/rstudio/ChickpeaAscoDispersal', dep=TRUE)"

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Become normal user again
USER ${NB_USER}
