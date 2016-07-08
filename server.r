library(shiny)
library(UsingR)
library(maps)
library(mapdata)
library(ggmap)
library(rworldmap)

flu = read.csv(file = "fluByWeek.csv", header = TRUE, sep = ",", skip = 2)


mylist = list()

for (i in 1: dim(flu)[2]) {
    name = as.character(flu$Country[i])
    mylist[[name]] = i
    
}

names(flu)[4:14] = c('H1', 'H1N12009', 'H3', 'H5', 'Not Subtyped', 'A-Total', 'Yamagata', 'Victoria', 'Not determined', 'B-Total', 'Influenza - Total')



shinyServer(function(input, output) {
    
        
    # You can access the value of the widget with input$select, e.g.
    #output$value <- renderPrint( {input$select} )
    
    output$newbar <- renderPlot(
        {
            num <- input$select
            newdata <- as.numeric(flu[num, 4:14])
            col = c(rep('coral2', 6), rep('royalblue3', 4), 'black')
            
            names(newdata) = names(flu)[4:14]
            
            
            layout(rbind(1,2), heights=c(2, 7))
            par(mar = c(5, 2, 0, 0))
            plot.new()
            legend("center", 'groups', legend = c("influenza A", "influenza B", "Total"), fill = c("coral2", "royalblue3", "black"), bty = "n", ncol = 3)
           
            barplot(newdata, las = 2, col = col)
        }
       )
    
    output$newmap <- renderPlot(
        {
           ####add a data frame first
            bub <- data.frame(Country = flu$Country, Total = flu$`Influenza - Total`)
            n <- joinCountryData2Map(bub, joinCode = "NAME", nameJoinColumn = 'Total')
            par(mar = c(0,0,0.2,0), xaxs = "i", yaxs = "i")
            mapBubbles(dF = n,
                    nameZSize = "Total",
                    nameZColour = c('red'),
                    colourPalette = 'rainbow',
                    oceanCol = 'lightblue',
                    landCol = 'wheat'
                    )
                
        }
    )
    
    
})