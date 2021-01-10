
library(shiny)
library(quantmod)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    output$plot <- renderPlot({
        data <- getSymbols(input$symb, src = "yahoo", 
                           from = input$dates[1],
                           to = input$dates[2],
                           auto.assign = FALSE)
        adjusted <- paste(input$symb,".Adjusted",sep="")
        data <- data[, adjusted, drop=F]
        
        ##chartSeries(data,name=input$symb)
        plot(data, type = "l", col="blue", xlab = "Date", ylab="Price")
        sma = SMA(data, n= 20)
        lines(sma,type = "l", col = "red")

        
    })
    output$table <- renderTable({
        data <- getSymbols(input$symb, src = "yahoo", 
                           from = input$dates[1],
                           to = input$dates[2],
                           auto.assign = FALSE)
        adjusted <- paste(input$symb,".Adjusted",sep="")
        data <- data[, adjusted, drop=F]
        
        data.frame(x=monthlyReturn(data))
    })
    output$documentation <- renderText({
        paste("This app pulls the specified historical stock prices based on the provided ticker symbol.",
        "The blue line in the graph shows the historical prices and the red line shows a 20-Day Simple Moving Average.",
        "The Monthly Return Table shows the monthly returns in decimals. To get the percentage, just multiply number with 100.",
        "The date range follows the YYYY-MM-DD format. You can also use the calendar to select the date.",
        sep="\n")
        
    })
    
})