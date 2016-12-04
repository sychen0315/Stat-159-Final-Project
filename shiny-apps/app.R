library(shiny)
library(leaflet)
library(RColorBrewer)
library(dplyr)

clean_data <- read.csv("../data/data-sets/cleaned-data-set/clean-data.csv")
vars <- c(
  "Number of students applied" = "STU_APPLIED",
  "Median earnings" = "MD_EARN_WNE_P10",
  "Percentage of loaa" = "PCTFLOAN",
  "Completion rate" = "C100_4",
  "Cost of attendence" = "COSTT4_A",
  "Major city" = "MAJOR_CITY",
  "Minority ratior" = "MINORATIO"
)


parameters <- list("STU_APPLIED", "MD_EARN_WNE_P10", "PCTFLOAN", "C100_4", "COSTT4_A", "MAJOR_CITY",
                "MINORATIO")

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                textInput(inputId = "state", "State", value = "CA"),
                #selectInput("var", "Parameter", parameters),
                #sliderInput("range", "Percentile", 0, 100,
                #            value = range(seq(0,100,1)), step = 1
                #),
                selectInput("color", "Color", vars),
                selectInput("size", "Size", vars, selected = "STU_APPLIED"),
                #selectInput("colors", "Color Scheme",
                #            rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
                #),
                checkboxInput("legend", "Show legend", TRUE)
  )
)

server <- function(input, output, session) {
  
  
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    #clean_data[clean_data[, input$var] >= min_value & clean_data[, input$var] <= max_value , ]
    clean_data[, c(input$color, input$size)]
    })
  
  filteredData2 <- reactive(clean_data[clean_data$STABBR==input$state, ])
  
  
  # This reactive expression represents the palette function,
  # which changes as the user makes selections in UI.
  #colorpal <- reactive({
  #  colorNumeric(input$colors, clean_data$MINORATIO)
  #})
  
  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated)
    
    leaflet(filteredData2()) %>%  addTiles(
      urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
      attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
    )
  })
  
  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  observe({
    colorBy <- input$color
    sizeBy <- input$size
    colorData <- clean_data[[colorBy]]
    pal <- colorBin("Spectral", colorData, 7, pretty = FALSE)
    radius <- clean_data[[sizeBy]] / max(clean_data[[sizeBy]]) * 30000
    
    
    #pal <- colorpal()
    dt <- filteredData()
    dt <- clean_data[clean_data$STABBR==input$state, ]
    leafletProxy("map", data = clean_data) %>%
      clearShapes() %>%
      addCircles(~LONGITUDE,~LATITUDE,radius = radius, stroke=FALSE, fillOpacity=0.4, fillColor=pal(colorData), 
                 popup = ~paste("Minority ratio:", MINORATIO) 
      )  %>%
      fitBounds(min(dt$LONGITUDE), min(dt$LATITUDE), max(dt$LONGITUDE), max(dt$LATITUDE))
  })
  

  # Use a separate observer to recreate the legend as needed.
  observe({
    colorData <- clean_data[[input$color]]
    pal <- colorBin("Spectral", colorData, 7, pretty = FALSE)
    
    proxy <- leafletProxy("map", data = clean_data)
    
    # Remove any existing legend, and only if the legend is
    # enabled, create a new one.
    proxy %>% clearControls()
    if (input$legend) {
      #pal <- colorpal()
      proxy %>% addLegend(position = "bottomright",
                          pal = pal, values = colorData,
                          title=input$color
      )
    }
  })
  
}

shinyApp(ui, server)