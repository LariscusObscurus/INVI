library(shiny)
library(moments) #needed for kurtosis
library(vioplot)
source("utils.R")

makeModel <- function(input, dataset) {
  formula <-
    as.formula(paste(paste(
      Map(surroundWhitespace, input$explain), "~"
    ),
    paste(
      Map(surroundWhitespace, input$using), collapse = " + "
    )))
  print(formula)
  lm1 <- lm(formula, data = dataset())
}

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
    hist(dataset()[[input$col]],
         main = "Histogram",
         xlab = input$col,
         col = "powderblue")
  })
  
  output$boxPlot <- renderPlot({
    boxplot(
      dataset()[[input$col]],
      data = dataset(),
      main = "Box Plot",
      xlab = input$col,
      horizontal = TRUE,
      col = "powderblue"
    )
  })
  
  output$violinPlot <- renderPlot({
    vioplot(
      dataset()[[input$col]],
      names = c(paste("Density of ", input$col)),
      horizontal = TRUE,
      col = "powderblue"
    )
    title("Violin Plot")
  })
  
  output$kernelDensityPlot <- renderPlot({
    plot(density(dataset()[[input$col]]),
         main = "Kernel Density Plot",
         xlab = input$col)
  })
  
  output$quantileQuantilePlot <- renderPlot({
    qqnorm(dataset()[[input$col]], main = "Normal Q-Q Plot", xlab = input$col)
    qqline(dataset()[[input$col]], distribution = qnorm)
  })
  
  output$scatterPlot <- renderPlot({
    if (length(input$colMulti) > 1) {
      logDirection <- ""
      
      
      if (input$logx) {
        logDirection <- paste(logDirection, "x", sep = "")
      }
      
      if (input$logy) {
        logDirection <- paste(logDirection, "y", sep = "")
      }
      
      formula <-
        as.formula(paste("~ ", paste(
          Map(surroundWhitespace, input$colMulti), collapse = " + "
        )))
      print(formula)
      pairs(
        formula,
        lower.panel = panel.smooth,
        data = dataset(),
        log = logDirection
      )
    }
  })
  
  output$correlationPlot <- renderPlot({
    if (dim(dataset())[2] > 1) {
      pairs(dataset(),
            lower.panel = panel.smooth,
            upper.panel = panel.cor)
    }
  })
  
  output$selfChoosyCorrelationPlot <- renderPlot({
    if (length(input$using) > 1) {
      formula <-
        as.formula(paste("~ ", paste(
          Map(surroundWhitespace, input$using), collapse = " + "
        )))
      pairs(
        formula,
        data = dataset(),
        lower.panel = panel.smooth,
        upper.panel = panel.cor
      )
    }
  })
  
  output$fitting <- renderPlot({
    if (length(input$using) > 1) {
      lm1 <- makeModel(input, dataset)
      plot(lm1, which = c(1))
    }
  })
  
  output$modelQuantileQuantilePlot <- renderPlot({
    if (length(input$using) > 1) {
      lm1 <- makeModel(input, dataset)
      plot(lm1, which = c(2))
    }
  })
  
  output$outliers <- renderPlot({
    if (length(input$using) > 1) {
      lm1 <- makeModel(input, dataset)
      plot(lm1)
    }
  })
  
  
}

summaries <- function(input, output, dataset) {
  output$summary <- renderPrint({
    if (length(input$using) > 1) {
      lm1 <- makeModel(input, dataset)
      summary(lm1)
    }
  })
  
}

server <- function(input, output) {
  dataset <- reactive({
    switch(
      input$dataset,
      "swiss" = swiss,
      "states77" = as.data.frame(state.x77),
      "LakeHuron" = {
        df <- as.data.frame(LakeHuron)
        names(df) <- "level"
        df
      }
    )
  })
  
  output$datasetColumns <- renderUI({
    selectInput("col", "Variable:", colnames(dataset()))
  })
  
  output$datasetColumnsMulti <- renderUI({
    selectInput("colMulti", "Variable:", colnames(dataset()), multiple = TRUE)
  })
  
  #It is impossible to use the same output twice https://github.com/rstudio/shiny/issues/743
  output$datasetColumnsMulti2 <- renderUI({
    selectInput("using", "Using:", colnames(dataset()), multiple = TRUE)
  })
  
  output$datasetColumnsExplain <- renderUI({
    selectInput("explain", "Explain:", colnames(dataset()))
  })
  
  location(input, output, dataset)
  
  variation(input, output, dataset)
  
  distribution(input, output, dataset)
  
  showPlots(input, output, dataset)
  
  summaries(input, output, dataset)
}
