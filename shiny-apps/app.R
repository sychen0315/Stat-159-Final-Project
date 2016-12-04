library(shiny)
library(leaflet)
library(RColorBrewer)
library(dplyr)
library(lattice)

clean_data <- read.csv("../data/data-sets/cleaned-data-set/clean-data.csv")
clean_data$STU_APPLIED <- round(clean_data$STU_APPLIED)
clean_data$PCTFLOAN <- round(clean_data$PCTFLOAN, 2)
clean_data$C100_4 <- round(clean_data$C100_4, 2)
clean_data$MINORATIO <- round(clean_data$MINORATIO, 2)
clean_data$ln_STU_APPLIED <- log(clean_data$STU_APPLIED)
clean_data$ln_MD_EARN_WNE_P10 <- log(clean_data$MD_EARN_WNE_P10)
clean_data$ln_PCTFLOAN <- log(clean_data$PCTFLOAN)
clean_data$ln_C100_4 <- log(clean_data$C100_4)
clean_data$ln_COSTT4_A <- log(clean_data$COSTT4_A)


vars <- c(
  "Number of students applied" = "STU_APPLIED",
  "Median earnings" = "MD_EARN_WNE_P10",
  "Percentage of loan" = "PCTFLOAN",
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
  absolutePanel(fixed = TRUE,
                draggable = TRUE, top = 60, left = 20, right = 'auto', bottom = "auto",
                width = 330, height = "auto",
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
                checkboxInput("legend", "Show legend", TRUE),
                plotOutput("scatterStuIncome", height = 200)
  )
)

server <- function(input, output, session) {
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    #clean_data[clean_data[, input$var] >= min_value & clean_data[, input$var] <= max_value , ]
    clean_data
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
  
  output$scatterStuIncome <- renderPlot({
    # If no zipcodes are in view, don't plot
    if (nrow(filteredData2()) == 0)
      return(NULL)
    
    print(xyplot(ln_STU_APPLIED ~ ln_MD_EARN_WNE_P10, data = filteredData2(), 
                 xlim = range(clean_data$ln_MD_EARN_WNE_P10), ylim = range(clean_data$ln_STU_APPLIED),
                 type = c("p", "r"),col.line = "darkorange", lwd = 3,
                 main = "log meadian earnings versus student applied"))
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
    dt <- filteredData2()
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>%
      addCircles(~LONGITUDE,~LATITUDE,radius = radius, stroke=FALSE, fillOpacity=0.4, fillColor=pal(colorData), 
                 popup = ~paste("<strong>University: </strong>", INSTNM,
                                "<br><strong>City, State: </strong>", CITY, STABBR,
                                "<br><strong>Major City: </strong>", MAJOR_CITY,
                                "<br><strong>Student applied: </strong>", STU_APPLIED,
                                "<br><strong>Percent load: </strong>", PCTFLOAN,
                                "<br><strong>Minority ratio: </strong>", MINORATIO,
                                "<br><strong>Completion rate: </strong>", C100_4,
                                "<br><strong>Cost: </strong>", COSTT4_A,
                                "<br><strong>Median earnings: </strong>", MD_EARN_WNE_P10
                                
                   ) 
      ) 
  })
  
  observe({
    proxy <- leafletProxy("map", data = filteredData2())
    proxy %>%
      fitBounds(~min(LONGITUDE)-2 , ~min(LATITUDE)-1, ~max(LONGITUDE), ~max(LATITUDE))
    
  })
  
  observe({
    colorData <- clean_data[[input$color]]
    pal <- colorBin("Spectral", colorData, 7, pretty = FALSE)
    proxy <- leafletProxy("map", data = filteredData())
    dt <- filteredData2()
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