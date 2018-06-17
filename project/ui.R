library(shiny)

ui <- fluidPage(titlePanel("Datavisualiser"),
                
                tabsetPanel(
                  tabPanel("SomePlots",
                           sidebarLayout(
                             sidebarPanel(
                               selectInput("dataset", "Dataset:", c("swiss", "states77", "LakeHuron")),
                               uiOutput("datasetColumns"),
                               uiOutput("binsSlider")
                             ),
                             
                             mainPanel(fluidRow(
                               column(
                                 4,
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
                                 4,
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
                                 4,
                                 h3("Distribution"),
                                 
                                 h5(strong("Skewness")),
                                 textOutput("skewness"),
                                 textOutput("skewnessDescription"),
                                 
                                 h5(strong("Peakedness")),
                                 textOutput("peakedness"),
                                 textOutput("peakednessDescription")
                               ),
                               fluidRow(
                                 column(6,
                                        plotOutput("histogram")),
                                 column(6,
                                        plotOutput("kernelDensityPlot")),
                                 column(6,
                                        plotOutput("boxPlot")),
                                 column(6,
                                        plotOutput("quantileQuantilePlot")),
                                 column(6,
                                        plotOutput("violinPlot"))
                               )
                             ))
                           )),
                  tabPanel("Relations",
                           sidebarLayout(
                             sidebarPanel(
                               uiOutput("datasetColumnsMulti"),
                               checkboxInput("logx", "Log x-axis"),
                               checkboxInput("logy", "Log y-axis")),
                             mainPanel(
                               fluidRow(
                                 column(12,
                                        plotOutput("scatterPlot", height = "900px"))
                               )
                             )
                           )),
                  tabPanel(
                    "Correlation & LinearModel",
                    sidebarLayout(
                      sidebarPanel(
                        uiOutput("datasetColumnsExplain"),
                        uiOutput("datasetColumnsMulti2")
                        ),
                      mainPanel(
                       plotOutput("correlationPlot", height = "900px"),
                       plotOutput("selfChoosyCorrelationPlot"),
                       verbatimTextOutput("summary"),
                       plotOutput("fitting"),
                       plotOutput("modelQuantileQuantilePlot"),
                       plotOutput("outliers")
                      )
                    )
                  )
                ))
