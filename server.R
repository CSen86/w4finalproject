library(dplyr)
library(shiny)
library(leaflet)
library(leaflet.minicharts)

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


# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
    
    # Initialize map
    output$map <- renderLeaflet({
        basemap %>%
            addMinicharts(
                eur$lng, eur$ltd,
                layerId = eur$region,
                width = 45, height = 45
            )
    })
    
    # Update charts each time input value changes, inputs are defined in the ui
    observe({
        if (length(input$prods) == 0) {
            data <- 1
        } else {
            data <-eur[, input$prods]
        }
        maxValue <- max(as.matrix(data))
        
        leafletProxy("map", session) %>%
            updateMinicharts(
                eur$region,
                chartdata = data,
                maxValues = maxValue,
                time = eur$year,
                type = ifelse(length(input$prods) < 2, "polar-area", input$type),
                showLabels = input$labels
            )
    })
    
})
