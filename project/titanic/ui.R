library(shiny)

ui <- fluidPage(titlePanel("Titanic"),
                sidebarLayout(
                  sidebarPanel(
                    uiOutput("dimensions")
                  ),
                  mainPanel(
                    fluidRow(
                      column(
                        12,
                        plotOutput("mosaicPlot")
                      ),
                      column(
                        12,
                        tableOutput("data")
                      )
                    )
                  )
                )
)
