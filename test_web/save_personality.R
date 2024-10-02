# 필요한 패키지 로드
library(shiny)
library(htmlwidgets)

# Shiny UI 및 서버 함수
ui <- fluidPage(
  titlePanel("IPIP 30 문항 성격 검사"),
  
  tags$style(HTML("
    .question-row {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 10px;
    }
    .question-text {
      flex: 1;
      margin-right: 20px;
    }
    .radio-buttons {
      display: flex;
      flex-direction: row;
    }
  ")),
  
  fluidRow(
    column(12,
           lapply(1:30, function(i) {
             div(class = "question-row",
                 div(class = "question-text", questions[i]),
                 div(class = "radio-buttons",
                     radioButtons(inputId = paste0("Q", i),
                                  label = NULL,
                                  choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5),
                                  selected = 3,
                                  inline = TRUE)
                 )
             )
           }),
           actionButton("submit", "결과 제출", class = "btn-primary")
    )
  )
)

server <- function(input, output, session) {
  
  observeEvent(input$submit, {
    responses <- sapply(1:30, function(i) as.numeric(input[[paste0("Q", i)]]))
    
    personality_traits <- data.frame(
      Trait = c("외향성", "정서적 안정성", "우호성", "성실성", "개방성"),
      Score = c(
        mean(responses[c(1, 7, 13, 19, 25)]),  
        mean(responses[c(2, 8, 14, 20, 26)]),  
        mean(responses[c(3, 9, 15, 21, 27)]),  
        mean(responses[c(4, 10, 16, 22, 28)]), 
        mean(responses[c(6, 12, 18, 24, 30)])  
      )
    )
    
    showModal(modalDialog(
      title = "검사 결과",
      renderTable({ personality_traits }),
      easyClose = TRUE,
      footer = modalButton("닫기")
    ))
  })
}

# Shiny 앱을 HTML 파일로 저장
app <- shinyApp(ui = ui, server = server)

# 앱 실행 후 저장 (기본 브라우저에서 HTML로 실행 및 저장)
saveWidget(app, "shiny_app.html", selfcontained = TRUE)
