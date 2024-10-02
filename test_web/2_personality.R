# 필요한 패키지 로드
library(shiny)

# IPIP 30 문항 데이터 생성
questions <- c(
  "1. 나는 대화를 시작하는 것을 좋아한다.",
  "2. 나는 대체로 침착하고 쉽게 화를 내지 않는다.",
  "3. 나는 다른 사람을 도우려는 경향이 있다.",
  "4. 나는 체계적으로 일을 처리한다.",
  "5. 나는 스트레스를 쉽게 받는다.",
  "6. 나는 새로운 경험에 대해 열린 마음을 가지고 있다.",
  "7. 나는 대체로 조용하고 내성적이다.",
  "8. 나는 자주 걱정한다.",
  "9. 나는 다른 사람의 감정을 이해하는 편이다.",
  "10. 나는 일을 계획적으로 처리하는 것을 선호한다.",
  "11. 나는 쉽게 불안해진다.",
  "12. 나는 창의적인 활동을 즐긴다.",
  "13. 나는 사람들과 어울리는 것을 좋아한다.",
  "14. 나는 사소한 일에 쉽게 신경을 쓰지 않는다.",
  "15. 나는 다른 사람을 배려하는 편이다.",
  "16. 나는 일을 미리 계획하고 실행한다.",
  "17. 나는 감정적으로 안정적이다.",
  "18. 나는 예술적인 관심이 많다.",
  "19. 나는 사회적 상황에서 말을 많이 한다.",
  "20. 나는 스트레스 상황에서 평정을 유지한다.",
  "21. 나는 협동적이다.",
  "22. 나는 일을 철저하게 한다.",
  "23. 나는 종종 불안감을 느낀다.",
  "24. 나는 새로운 아이디어에 열려 있다.",
  "25. 나는 외향적이다.",
  "26. 나는 작은 일에 쉽게 동요되지 않는다.",
  "27. 나는 남을 잘 돕는다.",
  "28. 나는 질서를 중시한다.",
  "29. 나는 종종 긴장한다.",
  "30. 나는 상상력이 풍부하다."
)

# UI 구성
ui <- fluidPage(
  titlePanel("IPIP 30 문항 성격 검사"),
  
  # 설문 조사 섹션
  fluidRow(
    column(12,
           lapply(1:30, function(i) {
             radioButtons(inputId = paste0("Q", i),
                          label = questions[i],
                          choices = list("1" = 1, "2" = 2, "3" = 3, "4" = 4, "5" = 5),
                          selected = 3)
           }),
           actionButton("submit", "결과 제출", class = "btn-primary")
    )
  )
)

# 서버 로직 구성
server <- function(input, output, session) {
  
  observeEvent(input$submit, {
    # 설문조사 결과 수집
    responses <- sapply(1:30, function(i) as.numeric(input[[paste0("Q", i)]]))
    
    # 성격 특성 계산
    personality_traits <- data.frame(
      Trait = c("외향성", "정서적 안정성", "우호성", "성실성", "개방성"),
      Score = c(
        mean(responses[c(1, 7, 13, 19, 25)]),  # 외향성
        mean(responses[c(2, 8, 14, 20, 26)]),  # 정서적 안정성
        mean(responses[c(3, 9, 15, 21, 27)]),  # 우호성
        mean(responses[c(4, 10, 16, 22, 28)]), # 성실성
        mean(responses[c(6, 12, 18, 24, 30)])  # 개방성
      )
    )
    
    # 결과 출력
    showModal(modalDialog(
      title = "검사 결과",
      renderTable({ personality_traits }),
      easyClose = TRUE,
      footer = modalButton("닫기")
    ))
  })
}

# 앱 실행
shinyApp(ui = ui, server = server)
