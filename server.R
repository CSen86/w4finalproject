
library(shiny)

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
    
    # Update charts each time input value changes
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
