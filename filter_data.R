library(magrittr)
library(dplyr)
library(lubridate)
library(tidyr)
library(stringr)
# might can erasse after this..
library(usmap)
library(maps)
library(ggplot2)
library(ggmap)
library(maptools)
library(rgdal)
#new stuff
library(shiny)
library(sf)
#library(tidyverse)
library(tmap)
library(tmaptools)
library(leaflet)
options(scipen = 999)



#put your file path to the Crime_Data.csv into this function to filter it to the appropriate years of interest for this project
filter_dates <- function(Crime_Data){

crime_data <- read.csv("Crime_Datav2.csv")  
  
#uses lubridate to construct a Year Occurred and Month Occurred column
data <-
  crime_data %>%
  mutate(Date.Occurred = as.Date(mdy_hm(crime_data$Report.DateTime))) %>%
  select(-Report.DateTime) %>% 
  mutate(Year.Occurred = year(Date.Occurred)) %>%
  mutate(Month.Occurred = paste0(month(Date.Occurred))) %>%
  mutate(total_crime = 1)

#convert month.occured to string value
data$Month.Occurred <- as.numeric(as.factor(data$Month.Occurred))


filtered_data <- 
  data %>% 
  filter(Year.Occurred == '2008' | Year.Occurred == '2009' | Year.Occurred == '2010' | Year.Occurred == '2011' | Year.Occurred == '2012' | Year.Occurred == '2013' 
         | Year.Occurred == '2014' | Year.Occurred == '2015' | Year.Occurred == '2016' | Year.Occurred == '2017' | Year.Occurred == '2018' |  Year.Occurred == '2019') %>%
  select(Offense.Parent.Group,Year.Occurred,MCPP,total_crime, Precinct,Month.Occurred,Crime.Against.Category,Latitude,Longitude)
}



























