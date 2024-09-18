library(shiny)
library(capture)

ui <- fluidPage(
  tags$h2("Capture example"),
  capture(
    selector = "body",
    filename = "all-page",
    icon("camera"), "Take screenshot of all page",
    format = "png"
  ),
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
      ),
      capture(
        selector = "#result-block",
        filename = "results-screenshot",
        icon("camera"), "Take screenshot of results",
        options = list(backgroundColor = "#FFF")
      ),
      capture(
        selector = "#result-block",
        filename = "results-screenshot",
        icon("camera"), "Take screenshot of results (bigger scale)",
        scale = 3,
        options = list(backgroundColor = "#FFF")
      ),
      capture(
        selector = "#result-block",
        filename = NULL, # no download client side
        icon("camera"), "Take screenshot of results (retrieve server side)",
        inputId = "screenshot",
        options = list(backgroundColor = "#FFF")
      ),
      uiOutput("out")
    )
  )
)

server <- function(input, output, session) {
  
  output$out <- renderUI({
    # # Here we display image back in interface, 
    # # but you can also write image on disk
    # write_png <- function(x, filename) {
    #   x <- sub(".*,", "", x)
    #   x <- base64enc::base64decode(x)
    #   png::writePNG(png::readPNG(x), filename)
    # }
    # write_png(input$screenshot, "myimage.png")
    
    tags$img(src = input$screenshot)
  })
  
  
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
