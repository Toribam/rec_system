library(readxl)
df <- read_xlsx('raw_data/refined_data.xlsx')

df <- as.data.frame(df)

rownames(df) <- df[[1]]

df <- df[-1]