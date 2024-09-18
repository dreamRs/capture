library(shiny)
library(capture)

ui <- fluidPage(
  tags$h2("Capture scale examples"),
  capture(
    selector = "body",
    filename = "scale-default",
    icon("camera"), "Default scale",
    format = "png"
  ),
  capture(
    selector = "body",
    filename = "scale-2",
    icon("camera"), "Scale = 2",
    scale = 2,
    format = "png"
  ),
  capture(
    selector = "body",
    filename = "scale-5",
    icon("camera"), "Scale = 5",
    scale = 5,
    format = "png"
  ),
  capture(
    selector = "body",
    filename = "scale-05",
    icon("camera"), "Scale = 0.5",
    scale = 0.5,
    format = "png"
  ),
  capture(
    selector = "body",
    filename = "scale-15",
    icon("camera"), "Scale = 1.5",
    scale = 1.5,
    format = "png"
  ),
  tags$br(),
  fluidRow(
    column(
      width = 4,
      wellPanel(
        tags$b("Parameters :"),
        radioButtons(
          inputId = "loi",
          label = "Law:",
          choices = c("normal", "uniform", "exponential")
        )
      )
    ),
    column(
      width = 8,
      tags$div(
        id = "result-block",
        tags$b("Results :"),
        plotOutput(outputId = "plot"),
        uiOutput(outputId = "mean"),
        verbatimTextOutput(outputId = "raw")
      )
    )
  )
)

server <- function(input, output, session) {

  distrib_r <- reactive({
    switch(
      input$loi,
      "normal" = rnorm(1000),
      "uniform" = runif(1000),
      "exponential" = rexp(1000)
    )
  })
  
  output$plot <- renderPlot({
    hist(distrib_r())
  })
  
  output$mean <- renderUI({
    tags$p(tags$b("The mean is :"), round(mean(distrib_r()), 2))
  })
  
  output$raw <- renderPrint({
    summary(distrib_r())
  })
}

if (interactive())
  shinyApp(ui, server)
