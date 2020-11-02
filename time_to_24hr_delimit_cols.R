### (created 11/2/2020)
### Lauren Bolotin (bolotinljb@gmail.com)
### This script:
###### 1) sends text to columns when the .txt or .csv files will not properly go to columns in Microsoft Excel
###### 2) converts 12-hr time with AM/PM to 24-hr time
###### 3) outputs a new .csv that can easily be appended to previous data
######################################################################################################################################
library(data.table)
library(tidyverse)
library(lubridate)
setwd("/Volumes/My Passport/West Shore Tahoe/All raw data pulled 10_30_2020")

dat <- read.table(file = "miller_Append_2020-10-30_10-13-21-757.csv", skip = 73, header = FALSE) ###########CHANGE FILENAME############
head(dat)

## Name columns
colnames(dat) <- c("date", "time", "am_pm", "elapsed_seconds", "pressure_psi", "temperature_C", "depth_ft")
dat <- dat %>%
  mutate(time_24hr = paste(time, am_pm, sep = " "))
head(dat)

## Convert 12-hour time to 24-hour time
dat$time_24hr <- format(strptime(dat$time_24hr, '%I:%M:%S %p'), format = "%H:%M:%S")
head(dat)

## Convert the date to POSIX.ct format
dat$date <- mdy(dat$date)

## Create DateTime column
dat <- dat %>%
  mutate(DateTime = paste(date, time_24hr, sep = " "))

## Reorder columns
head(dat)
dat <- select(dat, c("DateTime", "elapsed_seconds", "pressure_psi", "temperature_C", "depth_ft"))

## Output new .csv
head(dat)  
write.csv(dat, "miller_10_30_2020_Rformatted.csv") ############CHANGE FILENAME#########################################################
