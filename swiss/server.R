library(shiny)
source("utils.R")

location <- function(input, output, dataset){
   output$min <- renderText({
     min(dataset)
   })
   
   output$max <- renderText({
     max(dataset)
   })
   
   output$median <- renderText({
     median(dataset)
   })
   
   output$midrange <- renderText({
     midrange(dataset)
   })
}

variation <- function(input, output, dataset){
  
   output$range <- renderText({
     range(dataset)
   })
   
   output$standardDeviation <- renderText({
     sd(dataset)
   })
   
   output$madMean <- renderText({
     mad(dataset, center=mean(dataset))
   })
   
   output$madMedian <- renderText({
     mad(dataset, center=median(dataset))
   })
   
  
   output$medmed <- renderText({
     medmed(dataset)
   })
  
}

server <- function(input, output) {
  
  location(input, output, swiss[[input$dataFrameColumn]])
   
  variation(input, output, swiss[[input$dataFrameColumn]])
}
