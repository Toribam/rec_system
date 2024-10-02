library(readxl)
df <- read_xlsx('raw_data/refined_data.xlsx')

df <- as.data.frame(df)

rownames(df) <- df[[1]]

df <- df[-1]

### correlation coefficient

result_cor1 <- cos(df)

plot(df)


#install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

chart.Correlation(df, histogram = TRUE, method = "pearson")


#install.packages("psych")
library(psych)

corPlot(df, cex = 1.2)



### cosine similarity

install.packages("lsa", dependencies = TRUE)
library(lsa)

