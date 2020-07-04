library(dplyr)
library(shiny)
library(leaflet)
library(leaflet.minicharts)
library(readr)

eur <- read_csv("eur.csv")


# Production columns
prodCols <- names(eur)[3:5]

# Create base map
tilesURL <- "http://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}"

basemap <- leaflet(width = "100%", height = "400px") %>%
  addTiles(tilesURL) 
