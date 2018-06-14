library(shiny)
library(moments) #needed for kurtosis
source("utils.R")

location <- function(input, output, dataset) {
  output$min <- renderText({
    min(dataset()[[input$col]])
  })
  
  output$max <- renderText({
    max(dataset()[[input$col]])
  })
  
  output$median <- renderText({
    median(dataset()[[input$col]])
  })
  
  output$mean <- renderText({
    mean(dataset()[[input$col]])
  })
  
  output$mode <- renderText({
    mode(dataset()[[input$col]])
  })
  
  output$midrange <- renderText({
    midrange(dataset()[[input$col]])
  })
}

variation <- function(input, output, dataset) {
  output$range <- renderText({
    range(dataset()[[input$col]])
  })
  
  output$standardDeviation <- renderText({
    sd(dataset()[[input$col]])
  })
  
  output$madMean <- renderText({
    mad(dataset()[[input$col]], center = mean(dataset()[[input$col]]))
  })
  
  output$madMedian <- renderText({
    mad(dataset()[[input$col]], center = median(dataset()[[input$col]]))
  })
  
  
  output$medmed <- renderText({
    medmed(dataset()[[input$col]])
  })
  
  output$coefficientOfVariance <- renderText({
    coefficientOfVariance(dataset()[[input$col]])
  })
  
}

distribution <- function(input, output, dataset) {
  output$skewness <- renderText({
    skewness(dataset()[[input$col]])
  })
  
  output$peakedness <- renderText({
    kurtosis(dataset()[[input$col]])
  })
}

server <- function(input, output) {
  
  dataset <- reactive({
    switch(input$dataset,
           "swiss" = swiss,
           "states77" = as.data.frame(state.x77))
  })
  
  output$datasetColumns <- renderUI({
    selectInput("col", "Variable:", colnames(dataset()))
  })
  
  location(input, output, dataset)
  
  variation(input, output, dataset)
  
  distribution(input, output, dataset)
}
