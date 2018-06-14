library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(# Application title
  titlePanel("Swiss"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(sidebarPanel(
    selectInput("dataset", "Dataset:", c("swiss", "states77")),
    uiOutput("datasetColumns")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    fluidRow(
    column(
      3,
      h3("Location"),
      
      h5(strong("Mean")),
      textOutput("mean"),
      
      h5(strong("Median")),
      textOutput("median"),
      
      h5(strong("Min")),
      textOutput("min"),
      
      h5(strong("Max")),
      textOutput("max"),
      
      h5(strong("Mode")),
      textOutput("mode"),
      
      h5(strong("Midrange")),
      textOutput("midrange")
      
    ),
    column(
      3,
      h3("Variation"),
      
      h5(strong("Range")),
      textOutput("range"),
      
      h5(strong("StandardDeviation")),
      textOutput("standardDeviation"),
      
      h5(strong("MAD (mean)")),
      textOutput("madMean"),
      
      h5(strong("MAD (median)")),
      textOutput("madMedian"),
      
      h5(strong("Medmed")),
      textOutput("medmed"),
      
      h5(strong("CoefficientOfVariance")),
      textOutput("coefficientOfVariance")
    ),
    column(
      3,
      h3("Distribution"),
      
      h5(strong("Skewness")),
      textOutput("skewness"),
      
      h5(strong("Peakedness")),
      textOutput("peakedness")
    )
    
  ))))
