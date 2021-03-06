library(shiny)
library(purrr)

server <- function(input, output) {
  output$dimensions <- renderUI({
    selectInput("dimensions", "Dimension:",
                names(dimnames(Titanic)),
                multiple = TRUE,
                selected = c("Class", "Survived"))
  })

  output$mosaicPlot <- renderPlot({
    dims <- paste(input$dimensions, collapse = " + ")
    formula <- as.formula(paste("~ ", dims, sep = ""))
    mosaicplot(formula, data = Titanic, color = TRUE)
  })

  output$data <- renderTable({
    cols <- unlist(map(input$dimensions, function (c) which( names(dimnames(Titanic)) == c ) ))
    apply(Titanic, cols, sum)
  }, rownames = TRUE)
}
