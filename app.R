library(shiny)
source("covarying_viz.R")

rep_con_data <- readRDS("data/rep_con_data.rds")
rep_con_forms <- unique(rep_con_data$construction.name)


ui <- fluidPage(
    titlePanel("Covarying Collexeme Analysis"),
    sidebarPanel(
            textInput("word", "Constant Word", "了"),
            selectInput("rep_con_form", "Construction Form", rep_con_forms),
            width = 3
    ),
    mainPanel(
        plotOutput("covaryingPlot", width = "100%", height = "680px")
    )
)

server <- function(input, output, session) {
    
    observe({
        if(!is.null(input$word))
            updateSelectInput(session, "rep_con_form", 
                              choices = rep_con_forms[grepl(trimws(input$word), rep_con_forms)], 
                              selected = input$word )
    })
    
    output$covaryingPlot <- renderPlot({
        covarying_viz(input$rep_con_form)
    })
}

shinyApp(ui, server)

library(rsconnect)

rsconnect::setAccountInfo(name='andreashih', token='C5A50294AD7796DD1A85A3A9E5F044BC', 
                          secret='ttM0yLgMP0uZDSNO9S/rWzgUHNayw+EvNoJcukqS')
deployApp()
