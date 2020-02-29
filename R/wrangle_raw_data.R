# wrangle data for Ascochyta condia dispersal model
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse)

dat <-
   read_csv("data/CPSporesSpatial version 2.csv") %>%
   mutate(site = str_remove(site, " SPA")) %>%
   drop_na(counts_p1) %>%
   mutate(dist = as.numeric(str_replace(distance, " m", ""))) %>%
   mutate(rainfall = precip + mrain) %>%
   add_column(sum_rain = NA) %>%
   unite(SpEv, c(site, rep), remove = FALSE) %>%
   mutate(
      degrees = case_when(
         site == "Curyo" & transect == 1 ~ 290,
         site == "Curyo" & transect == 2 ~ 300,
         site == "Curyo" & transect == 3 ~ 310,
         site == "Curyo" & transect == 4 ~ 320,
         site == "Curyo" & transect == 5 ~ 330,
         site == "Curyo" & transect == 6 ~ 340,
         site == "Curyo" & transect == 7 ~ 350,
         site == "Curyo" & transect == 8 ~ 360,
         site == "Curyo" & transect == 9 ~ 10,
         site == "Curyo" & transect == 10 ~ 20,
         site == "Horsham" & transect == 1 ~ 45,
         site == "Horsham" & transect == 2 ~ 55,
         site == "Horsham" & transect == 3 ~ 65,
         site == "Horsham" & transect == 4 ~ 75,
         site == "Horsham" & transect == 5 ~ 85,
         site == "Horsham" & transect == 6 ~ 95,
         site == "Horsham" & transect == 7 ~ 105,
         site == "Horsham" & transect == 8 ~ 115,
         site == "Horsham" & transect == 9 ~ 125,
         site == "Horsham" & transect == 10 ~ 135,
         site == "pbc" & transect == 1 ~ 45,
         site == "pbc" & transect == 2 ~ 55,
         site == "pbc" & transect == 3 ~ 65,
         site == "pbc" & transect == 4 ~ 75,
         site == "pbc" & transect == 5 ~ 85,
         site == "pbc" & transect == 6 ~ 95,
         site == "pbc" & transect == 7 ~ 105,
         site == "pbc" & transect == 8 ~ 115,
         site == "pbc" & transect == 9 ~ 125,
         site == "pbc" & transect == 10 ~ 135
      )
   ) %>%
   mutate_at(vars(site, rep, station, transect, plant_no, pot_no, SpEv),
             factor)

### Curyo weather
#Sum rainfall data
curyo0 <-
   read.csv(
      "data/Curyo SPA 2019 - Curyo SPA 2019 - Buffer 0 - 01-01-2019 to 06-12-2019.csv",
      stringsAsFactors = FALSE
   )

#format time/date
curyo0$Time <- as.POSIXlt(curyo0$Time, format = "%d/%m/%Y %H:%M")

# subset by spread event
curSE <-
   curyo0[curyo0$Time >= as.POSIXct("15/10/2019 08:00", format = "%d/%m/%Y %H:%M") &
             curyo0$Time <= as.POSIXct("17/10/2019 18:00", format = "%d/%m/%Y %H:%M"), ]

dat[dat$SpEv == "Curyo_1", "sum_rain"] <-
   sum(curSE$Rainfall....mm., na.rm = TRUE)

### Horsham weather
#Sum rainfall data
Horsham0 <-
   read.csv(
      "data/Horsham SPA 2019 - Horsham SPA 2019 - Buffer 0 - 01-01-2019 to 06-12-2019.csv",
      stringsAsFactors = FALSE
   )

#format time/date
Horsham0$Time <-
   as.POSIXlt(Horsham0$Time, format = "%d/%m/%Y %H:%M")

# Horsham irrigated
# subset by spread event 1
HorshamSE1 <-
   Horsham0[Horsham0$Time >= as.POSIXct("09/10/2019 18:00", format = "%d/%m/%Y %H:%M") &
               Horsham0$Time <= as.POSIXct("10/10/2019 18:00", format = "%d/%m/%Y %H:%M"), ]

dat[dat$SpEv == "pbc_1", "sum_rain"] <-
   sum(if (all(is.na(HorshamSE1$Rainfall....mm.))) {
      NA
   } else{
      sum(HorshamSE1$Rainfall....mm., na.rm = TRUE)
   },
   if (all(is.na(HorshamSE1$Rainfall))) {
      NA
   } else{
      sum(HorshamSE1$Rainfall, na.rm = TRUE)
   },
   if (all(is.na(HorshamSE1$Irrigation))) {
      NA
   } else{
      sum(HorshamSE1$Irrigation, na.rm = TRUE)
   },
   10,
   na.rm = TRUE)

# Horsham irrigated
# subset by spread event 2
HorshamSE2 <-
   Horsham0[Horsham0$Time >= as.POSIXct("14/10/2019 18:00", format = "%d/%m/%Y %H:%M") &
               Horsham0$Time <= as.POSIXct("15/10/2019 18:00", format = "%d/%m/%Y %H:%M"), ]

dat[dat$SpEv == "pbc_2", "sum_rain"] <-
   sum(if (all(is.na(HorshamSE2$Rainfall....mm.))) {
      NA
   } else{
      sum(HorshamSE2$Rainfall....mm., na.rm = TRUE)
   },
   if (all(is.na(HorshamSE2$Rainfall))) {
      NA
   } else{
      sum(HorshamSE2$Rainfall, na.rm = TRUE)
   },
   if (all(is.na(HorshamSE2$Irrigation))) {
      NA
   } else{
      sum(HorshamSE2$Irrigation, na.rm = TRUE)
   },
   10,
   na.rm = TRUE)

# Horsham irrigated
# subset by spread event 3
HorshamSE3 <-
   Horsham0[Horsham0$Time >= as.POSIXct("06/11/2019 18:00", format = "%d/%m/%Y %H:%M") &
               Horsham0$Time <= as.POSIXct("07/11/2019 18:00", format = "%d/%m/%Y %H:%M"), ]

dat[dat$SpEv == "pbc_3", "sum_rain"] <-
   sum(if (all(is.na(HorshamSE3$Rainfall....mm.))) {
      NA
   } else{
      sum(HorshamSE3$Rainfall....mm., na.rm = TRUE)
   },
   if (all(is.na(HorshamSE3$Rainfall))) {
      NA
   } else{
      sum(HorshamSE3$Rainfall, na.rm = TRUE)
   },
   if (all(is.na(HorshamSE3$Irrigation))) {
      NA
   } else{
      sum(HorshamSE3$Irrigation, na.rm = TRUE)
   },
   10,
   na.rm = TRUE)


# Horsham dryland
# subset by spread event 1
HorshamSE1.dl <-
   Horsham0[Horsham0$Time >= as.POSIXct("15/10/2019 08:00", format = "%d/%m/%Y %H:%M") &
               Horsham0$Time <= as.POSIXct("17/10/2019 18:00", format = "%d/%m/%Y %H:%M"), ]

dat[dat$SpEv == "Horsham_1", "sum_rain"] <-
   sum(if (all(is.na(HorshamSE1.dl$Rainfall....mm.))) {
      NA
   } else{
      sum(HorshamSE1.dl$Rainfall....mm., na.rm = TRUE)
   },
   if (all(is.na(HorshamSE1.dl$Rainfall))) {
      NA
   } else{
      sum(HorshamSE1.dl$Rainfall, na.rm = TRUE)
   },
   if (all(is.na(HorshamSE1.dl$Irrigation))) {
      NA
   } else{
      sum(HorshamSE1.dl$Irrigation, na.rm = TRUE)
   },
   na.rm = TRUE)


# Horsham dryland
# subset by spread event 2
HorshamSE2.dl <-
   Horsham0[Horsham0$Time >= as.POSIXct("01/11/2019 08:00", format = "%d/%m/%Y %H:%M") &
               Horsham0$Time <= as.POSIXct("08/11/2019 18:00", format = "%d/%m/%Y %H:%M"), ]

dat[dat$SpEv == "Horsham_2", "sum_rain"] <-
   sum(if (all(is.na(HorshamSE2.dl$Rainfall....mm.))) {
      NA
   } else{
      sum(HorshamSE2.dl$Rainfall....mm., na.rm = TRUE)
   },
   if (all(is.na(HorshamSE2.dl$Rainfall))) {
      NA
   } else{
      sum(HorshamSE2.dl$Rainfall, na.rm = TRUE)
   },
   if (all(is.na(HorshamSE2.dl$Irrigation))) {
      NA
   } else{
      sum(HorshamSE2.dl$Irrigation, na.rm = TRUE)
   },
   na.rm = TRUE)
