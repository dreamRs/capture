
library(shiny)
library(capture)

ui <- fluidPage(
  tags$h2("Lookbook example"),
  lookbook("my-app"),
  tags$br(),
  fluidRow(
    column(
      width = 4,
      wellPanel(
        tags$b("Parameters :"),

        selectInput(
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
