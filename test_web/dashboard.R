library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "대시보드 제목..."), ## header
  
  dashboardSidebar(## Sidebar
    sidebarMenu(
      menuItem("소개", tabName = "소개", icon = icon("th")),
      menuItem("히스토그램", tabName = "히스토그램", icon = icon("dashboard"))
    )
  ),
  
  dashboardBody(## Body
    tabItems(
      # First tab content
      tabItem(tabName = "소개",
              fluidRow(
                h2("대시보드 연습입니다...."),
                HTML("메뉴의 [소개]를 클릭.......")
              )
      ),
      # Second tab content
      tabItem(tabName = "히스토그램",
              fluidRow(
                HTML("메뉴의 [히스토그램]를 클릭......."),
                hr(),
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                ),
                box(plotOutput("plot1", height = 250))
              )
      )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)