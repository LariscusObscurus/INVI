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
                        plotOutput("mosaicPlot", height = "900px")
                      ),
                      column(
                        12,
                        tableOutput("data")
                      )
                    )
                  )
                )
)
