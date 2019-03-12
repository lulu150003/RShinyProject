
#install.packages("data.table")
#install.packages("dplyr")
#install.packages("shiny")
#install.packages("shinydashboard")
#install.packages("googleVis")
#install.packages("ggplot2")
#install.packages('leaflet.extras')
#install devtools


library(data.table)
library(dplyr)
library(googleVis)
library(ggmap)
library(leaflet)
library(leaflet.extras)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(rgdal)
library(maptools)

# Load data
data.og <- read.csv("trip_stats_taz.csv")
data.og <- data.og %>% mutate(hour = hour - 3)

map.og <- readOGR("TAZ981.shp")

# Transform shape file as a polygon to be used with leaflet or ggplot2
map <- spTransform(map.og, CRS("+proj=longlat +ellps=GRS80"))
