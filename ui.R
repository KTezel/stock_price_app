#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Stock Price Chart"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
         helpText("Input a stock symbol with a date range",
                  br(),
                 "Stock symbol should exactly match the spelling"),
        
         
         textInput("symb", "Symbol", "MSFT"),
         
         dateRangeInput("dates",
                        "Date range",
                        start = "2013-01-01"),
                        end = as.character(Sys.Date())),

        # Show a plot of the stock prices for the specified date range
        mainPanel(tabsetPanel(type = "tabs",
                              tabPanel("Plot", plotOutput("plot")),
                              tabPanel("Monthly Return Table", tableOutput("table")),
                              tabPanel("Documentation", textOutput("documentation"))
        )
    )
)))
