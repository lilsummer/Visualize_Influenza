library(shiny)

flu = read.csv(file = "fluByWeek.csv", header = TRUE, sep = ",", skip = 2)


mylist = list()

for (i in 1: dim(flu)[2]) {
    name = as.character(flu$Country[i])
    mylist[[name]] = i
    
}

shinyUI(pageWithSidebar(
    headerPanel("Influenza Laboratory Surveillance Information, Latest Week"),
    sidebarPanel(
        # Copy the line below to make a select box 
        selectInput("select", label = h3("Select Country"), 
                    choices = mylist, 
                    selected = 1),
        hr(),
        helpText(tags$a(href = "http://gamapserver.who.int/gareports/Default.aspx?ReportNo=2", "Data source")),
        hr(),
        helpText(tags$a(href = "https://github.com/lilsummer/shinyApps/blob/master/readme.md", "Documentation"))
        
    
    
    ),
    mainPanel(
        tabPanel("Plot", 
                 fluidRow(
                     column(8, plotOutput('newbar')),
                     column(12, plotOutput('newmap'))
                    )
                )
            )
    )
)