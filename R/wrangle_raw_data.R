# wrangle data for Ascochyta condia dispersal model

#library("tidyverse")

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

dat$SpEv <- as.factor(paste0(dat$site,dat$rep))

dat$sum_rain <- NA



### Curyo weather
#Sum rainfall data
curyo0 <- read.csv("data/Curyo SPA 2019 - Curyo SPA 2019 - Buffer 0 - 01-01-2019 to 06-12-2019.csv",stringsAsFactors = FALSE)

#format time/date
curyo0$Time <- as.POSIXlt(curyo0$Time, format = "%d/%m/%Y %H:%M")

# subset by spread event
curSE <- curyo0[curyo0$Time >= as.POSIXct("15/10/2019 08:00", format = "%d/%m/%Y %H:%M") &
                   curyo0$Time <= as.POSIXct("17/10/2019 18:00", format = "%d/%m/%Y %H:%M"),]

dat[dat$SpEv == "Curyo1","sum_rain"] <- 
   sum(curSE$Rainfall....mm., na.rm = TRUE)

### Horsham weather
#Sum rainfall data
Horsham0 <- read.csv("data/Horsham SPA 2019 - Horsham SPA 2019 - Buffer 0 - 01-01-2019 to 06-12-2019.csv",stringsAsFactors = FALSE)

#format time/date
Horsham0$Time <- as.POSIXlt(Horsham0$Time, format = "%d/%m/%Y %H:%M")

# Horsham irrigated
# subset by spread event 1 
HorshamSE1 <- Horsham0[Horsham0$Time >= as.POSIXct("09/10/2019 18:00", format = "%d/%m/%Y %H:%M") &
                   Horsham0$Time <= as.POSIXct("10/10/2019 18:00", format = "%d/%m/%Y %H:%M"),]

dat[dat$SpEv == "pbc1","sum_rain"] <- 
   sum(
      if(all(is.na(HorshamSE1$Rainfall....mm.))){NA}else{sum(HorshamSE1$Rainfall....mm., na.rm = TRUE)},
      if(all(is.na(HorshamSE1$Rainfall))){NA}else{sum(HorshamSE1$Rainfall, na.rm = TRUE)},
      if(all(is.na(HorshamSE1$Irrigation))){NA}else{sum(HorshamSE1$Irrigation, na.rm = TRUE)},
      10,
      na.rm = TRUE)

# Horsham irrigated
# subset by spread event 2
HorshamSE2 <- Horsham0[Horsham0$Time >= as.POSIXct("14/10/2019 18:00", format = "%d/%m/%Y %H:%M") &
                          Horsham0$Time <= as.POSIXct("15/10/2019 18:00", format = "%d/%m/%Y %H:%M"),]

dat[dat$SpEv == "pbc2","sum_rain"] <- 
   sum(
      if(all(is.na(HorshamSE2$Rainfall....mm.))){NA}else{sum(HorshamSE2$Rainfall....mm., na.rm = TRUE)},
      if(all(is.na(HorshamSE2$Rainfall))){NA}else{sum(HorshamSE2$Rainfall, na.rm = TRUE)},
      if(all(is.na(HorshamSE2$Irrigation))){NA}else{sum(HorshamSE2$Irrigation, na.rm = TRUE)},
      10,
      na.rm = TRUE)

# Horsham irrigated
# subset by spread event 3
HorshamSE3 <- Horsham0[Horsham0$Time >= as.POSIXct("06/11/2019 18:00", format = "%d/%m/%Y %H:%M") &
                          Horsham0$Time <= as.POSIXct("07/11/2019 18:00", format = "%d/%m/%Y %H:%M"),]

dat[dat$SpEv == "pbc3","sum_rain"] <- 
   sum(
      if(all(is.na(HorshamSE3$Rainfall....mm.))){NA}else{sum(HorshamSE3$Rainfall....mm., na.rm = TRUE)},
      if(all(is.na(HorshamSE3$Rainfall))){NA}else{sum(HorshamSE3$Rainfall, na.rm = TRUE)},
      if(all(is.na(HorshamSE3$Irrigation))){NA}else{sum(HorshamSE3$Irrigation, na.rm = TRUE)},
      10,
      na.rm = TRUE)


# Horsham dryland
# subset by spread event 1
HorshamSE1.dl <- Horsham0[Horsham0$Time >= as.POSIXct("15/10/2019 08:00", format = "%d/%m/%Y %H:%M") &
                          Horsham0$Time <= as.POSIXct("17/10/2019 18:00", format = "%d/%m/%Y %H:%M"),]

dat[dat$SpEv == "Horsham SPA1","sum_rain"] <- 
   sum(
      if(all(is.na(HorshamSE1.dl$Rainfall....mm.))){NA}else{sum(HorshamSE1.dl$Rainfall....mm., na.rm = TRUE)},
      if(all(is.na(HorshamSE1.dl$Rainfall))){NA}else{sum(HorshamSE1.dl$Rainfall, na.rm = TRUE)},
      if(all(is.na(HorshamSE1.dl$Irrigation))){NA}else{sum(HorshamSE1.dl$Irrigation, na.rm = TRUE)},
      na.rm = TRUE)


# Horsham dryland
# subset by spread event 2
HorshamSE2.dl <- Horsham0[Horsham0$Time >= as.POSIXct("01/11/2019 08:00", format = "%d/%m/%Y %H:%M") &
                             Horsham0$Time <= as.POSIXct("08/11/2019 18:00", format = "%d/%m/%Y %H:%M"),]

dat[dat$SpEv == "Horsham SPA2","sum_rain"] <- 
   sum(
      if(all(is.na(HorshamSE2.dl$Rainfall....mm.))){NA}else{sum(HorshamSE2.dl$Rainfall....mm., na.rm = TRUE)},
      if(all(is.na(HorshamSE2.dl$Rainfall))){NA}else{sum(HorshamSE2.dl$Rainfall, na.rm = TRUE)},
      if(all(is.na(HorshamSE2.dl$Irrigation))){NA}else{sum(HorshamSE2.dl$Irrigation, na.rm = TRUE)},
      na.rm = TRUE)


print(dat)
