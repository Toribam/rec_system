library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Display Plots"),
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", 
                  label = "Choose a variable to display",
                  choices = list("Sepal.Length",
                                 "Sepal.Width",
                                 "Petal.Length",
                                 "Petal.Width"),
                  selected = "Sepal.Length"),
      radioButtons("plot_type", 
                   h3("Select the plot type"),
                   choices = list("Histogram" = 1,
                                  "Box plot" = 2,
                                  "Density plot" = 3,
                                  "Violin plot"=4),
                   selected = 1),
      
      submitButton(text = '실행',  icon = icon("bar-chart-o"))
    ),
    mainPanel(
      plotOutput("distPlot", width='80%', height='600px')
    )
  )
)
server <- function(input, output) {
  output$distPlot <- renderPlot({
    g = ggplot(iris, aes_string(x = input$xvar, y="Species", fill="Species") ) 
    if(input$plot_type == 1){
      g = ggplot(iris, aes_string(x = input$xvar, fill="Species") ) 
      g = g + geom_histogram(alpha=0.9)
    }else if(input$plot_type == 2){
      g = g + geom_boxplot()  + coord_flip()
    }else if(input$plot_type == 3){
      g = ggplot(iris, aes_string(x = input$xvar, fill="Species") ) + 
        geom_density(alpha = 0.8)
    }else if(input$plot_type == 4){
      g = g + geom_violin() + coord_flip()
    }else{
      NULL
    }
    g + theme_bw(base_size = 20) +
      theme(legend.position = "bottom")
  })
}

shinyApp(ui = ui, server = server)