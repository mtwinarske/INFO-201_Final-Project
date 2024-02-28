# Angel Hill
# Info 201
# 2/20/2024
# I utilized this stack overflow page to help me create income brackets.
#https://stackoverflow.com/questions/12979456/categorize-numeric-variable-into-group-bins-breaks

library(dplyr)
library("stringr")
library(ggplot2)
seattle_transport_df <- read.csv("cleanTransitAlt.csv")
seattle_zipcode_df <- read.csv("zipcodedata.csv")
seattle_zipcode_df <- seattle_zipcode_df %>%
  filter(COUNTY == "King WA") %>%
  select(-contains("CITY")) %>%
  select(-contains("COUNTY")) %>%
  select(-contains("STATE"))
  
seattle_income_df <- read.csv("2021income1.csv", na.strings = c("-", "**"))

seattle_income_df <- seattle_income_df %>%
  select(GEOID, contains("INCOME", ignore.case = FALSE))

# Ensuring all GEOIDS match through the datasets.
seattle_zipcode_df$GEOID <- as.character(seattle_zipcode_df$GEOID)
seattle_income_df$GEOID <- as.character(seattle_income_df$GEOID)
seattle_transport_df$GEOID <- as.character(seattle_transport_df$GEOID)
seattle_zipcode_df$GEOID <- paste0("1400000US", seattle_zipcode_df$GEOID)

seattle_income_df$median_income <- apply(seattle_income_df, 1, median, na.rm = TRUE)

seattle_income_df <- seattle_income_df %>%
  select(GEOID, contains("median_income"))

# Joining first two data sets.
IncomeTransit <- left_join(seattle_income_df, seattle_zipcode_df, by = "GEOID")


# Transit centers by zipcode
King_transit_center_zips <- "98001|98133|98003|98166|98144|98027|98029|98032|98033|98144|98125|98052|98057|98034|98007"
IncomeTransit <- IncomeTransit %>%
  mutate(transit_center_in_zipcode = ifelse(str_detect(ZIPCODE, King_transit_center_zips), "Yes", "No"))

IncomeTransit$median_income <- as.numeric(IncomeTransit$median_income)

# Income brackets
IncomeTransit <- IncomeTransit %>% 
  mutate(incomeBracket = case_when(
    median_income <= 38133 ~ "Low Income",
    median_income > 38133 & median_income <= 114000 ~ "Middle Income",
    median_income > 114000 ~ "High Income"
  ))

IncomeTransit <- IncomeTransit %>%
  filter(!is.na(median_income))

IncomeTransit <- left_join(IncomeTransit, seattle_transport_df, by = "GEOID")

IncomeTransit <- IncomeTransit %>% distinct(GEOID, .keep_all = TRUE)

#write.csv(IncomeTransit, "IncomeTransitAlt.csv")

