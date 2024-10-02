
### read dataset
df <- read.csv('raw_data/personality.csv')

summary(df)


### refining data
vars_to_convert <- c("sEXT", "sNEU", "sAGR", "sCON", "sOPN")

for (var in vars_to_convert){
  df[[var]] <- as.numeric(df[[var]])
}

rm(list = ls(pattern = "var"))

### calc mean scores by ID

library(dplyr)

result <- df %>%
  group_by(ID) %>%
  summarise(
    EXT = mean(sEXT, na.rm = TRUE),
    NEU = mean(sNEU, na.rm = TRUE),
    AGR = mean(sAGR, na.rm = TRUE),
    CON = mean(sCON, na.rm = TRUE),
    OPN = mean(sOPN, na.rm = TRUE)
  )

print(result)



# save this file as numerical data

library(writexl)

write_xlsx(result, path = "raw_data/refined_data.xlsx")