library(magrittr)
library(dplyr)
library(lubridate)
library(tidyr)
library(stringr)
library(usmap)
library(maps)
library(ggplot2)
library(ggmap)
library(maptools)
library(rgdal)


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


# data <- 
#   crime_data %>% 
#   mutate(Date.Occurred = mdy(Occurred.Date)) %>% 
#   select(-Occurred.Date) %>% 
#   mutate(Year.Occurred = year(Date.Occurred)) %>%
#   mutate(Month.Occurred = paste0(month(Date.Occurred))) %>%
#   mutate(total_crime = 1)

#convert month.occured to string value
data$Month.Occurred <- as.numeric(as.factor(data$Month.Occurred))

# converts month digit to month names(e.g. 1 = Jan)
# data <- data %>%
#   mutate(Month.Occurred = ifelse(grepl(1, Month.Occurred, fixed = TRUE), 'Jan', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(2, Month.Occurred, fixed = TRUE), 'Feb', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(3, Month.Occurred, fixed = TRUE), 'March', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(4, Month.Occurred, fixed = TRUE), 'April', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(5, Month.Occurred, fixed = TRUE), 'May', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(6, Month.Occurred, fixed = TRUE), 'June', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(7, Month.Occurred, fixed = TRUE), 'July', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(8, Month.Occurred, fixed = TRUE), 'Aug', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(9, Month.Occurred, fixed = TRUE), 'Sept', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(10, Month.Occurred, fixed = TRUE), 'Oct', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(11, Month.Occurred, fixed = TRUE), 'Nov', Month.Occurred)) %>%
#   mutate(Month.Occurred = ifelse(grepl(12, Month.Occurred, fixed = TRUE), 'Dec', Month.Occurred)) 


##series of functions that does data cleansing, combines subcategories
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"AGGRAVATED ASSAULT-DV","AGGRAVATED ASSAULT")
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"BURGLARY-COMMERCIAL","BURGLARY")
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"BURGLARY-RESIDENTIAL","BURGLARY")
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"BURGLARY-SECURE PARKING","BURGLARY")
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"ROBBERY-COMMERCIAL","ROBBERY")
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"ROBBERY-RESIDENTIAL","ROBBERY")
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"ROBBERY-STREET","ROBBERY")
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"THEFT-BUILDING","THEFT-ALL OTHER")
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"THEFT-SHOPLIFT","SHOPLIFTING")
# data$Crime.Subcategory <- str_replace_all(data$Crime.Subcategory,"THEFT-BICYCLE","BICYCLE THEFT")
#data$Crime.Subcategory <- str_remove_all(data$Crime.Subcategory,"THEFT-ALL OTHER")

# i decided to delete this because i was this cateorgry was ambiguous
#data <- data[!grepl("THEFT-ALL OTHER", data$Crime.Subcategory),]



#filters the data to just 2008-2018
# filtered_data <- 
#   data %>% 
#   filter(Year.Occurred == '2008' | Year.Occurred == '2009' | Year.Occurred == '2010' | Year.Occurred == '2011' | Year.Occurred == '2012' | Year.Occurred == '2013' 
#          | Year.Occurred == '2014' | Year.Occurred == '2015' | Year.Occurred == '2016' | Year.Occurred == '2017' | Year.Occurred == '2018') %>%
#   select(Crime.Subcategory,Year.Occurred,Neighborhood,total_crime, Precinct,Month.Occurred)
#}

filtered_data <- 
  data %>% 
  filter(Year.Occurred == '2008' | Year.Occurred == '2009' | Year.Occurred == '2010' | Year.Occurred == '2011' | Year.Occurred == '2012' | Year.Occurred == '2013' 
         | Year.Occurred == '2014' | Year.Occurred == '2015' | Year.Occurred == '2016' | Year.Occurred == '2017' | Year.Occurred == '2018' |  Year.Occurred == '2019') %>%
  select(Offense.Parent.Group,Year.Occurred,MCPP,total_crime, Precinct,Month.Occurred,Crime.Against.Category)
}




##testing############################################################
# line_graph_crime <- filtered_data %>%
#   filter(Crime.Subcategory == "SHOPLIFTING") %>%
#   group_by(Crime.Subcategory, Year.Occurred) %>%
#   summarise(total_crime =sum(total_crime))
# 
# 
# ggplot(line_graph_crime, aes(x=line_graph_crime$Year.Occurred,y=line_graph_crime$total_crime))+
#   geom_line() +
#   geom_point()+
#   geom_smooth(method= "lm",se = FALSE,color = "red")+
#   scale_x_continuous(breaks = c(2008,2010,2012,2014,2016,2018),
#                      labels = c(2008,2010,2012,2014,2016,2018))


#######  testing!!! ########################################################
# data <- 
#   crime_data %>% 
#   mutate(Date.Occurred = mdy(Occurred.Date)) %>% 
#   select(-Occurred.Date) %>% 
#   mutate(Year.Occurred = year(Date.Occurred)) %>%
#   mutate(Month.Occurred = paste0(month(Date.Occurred))) %>%
#   mutate(total_crime = 1)
# 
# 
# data <-
#   crime_data %>%
#   mutate(testing = as.Date(mdy_hm(crime_data$Report.DateTime)))































