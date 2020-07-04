
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    titlePanel("Wine, beer and olive oil production in Europe"),
    p("The data are not official, it is just for test leaflet and shiny functions"),
    
    sidebarLayout(
        
        sidebarPanel(
            selectInput("prods", "Select productions", choices = c("vino","birra","olio"), multiple = TRUE),
            selectInput("type", "Chart type", choices = c("bar","pie", "polar-area", "polar-radius")),
            checkboxInput("labels", "Show values")
        ),
        
        mainPanel(
            leafletOutput("map")
        )
        
    )
))
