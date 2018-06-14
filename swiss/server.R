library(shiny)
library(moments) #needed for kurtosis
library(vioplot)
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

showPlots <- function(input, output, dataset) {
  output$histogram <- renderPlot({
    hist(dataset()[[input$col]], main = "Histogram", xlab = input$col)
  })
  
  output$boxPlot <- renderPlot({
    boxplot(
      dataset()[[input$col]],
      data = dataset(),
      main = "Box Plot",
      xlab = input$col,
      horizontal = TRUE
    )
  })
  
  output$violinPlot <- renderPlot({
    vioplot(
      dataset()[[input$col]],
      names = c(paste("Density of ", input$col)),
      horizontal = TRUE,
      col = "gold"
    )
    title("Violin Plot")
  })
  
  output$kernelDensityPlot <- renderPlot({
    plot(density(dataset()[[input$col]]), main = "Kernel Density Plot", xlab =
           input$col)
  })
  
  output$quantileQuantilePlot <- renderPlot({
    qqnorm(dataset()[[input$col]], main = "Normal Q-Q Plot", xlab = input$col)
    qqline(dataset()[[input$col]], distribution = qnorm)
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
  
  showPlots(input, output, dataset)
}
