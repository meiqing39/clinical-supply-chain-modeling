# Purpose: Scrub phase (OSEMN). Cleans, formats dates, and merges datasets.

library(tidyverse)
library(lubridate) 
library(janitor)

# 1. Load raw datasets
covid_raw <- read_csv("data/raw/time_series_covid19_confirmed_US.csv")
fda_raw <- read_csv("data/raw/fda_device_shortages_raw.csv")

# Clean COVID-19 Data
covid_clean <- covid_raw %>%
  # Drop columns not needed
  select(-UID, -iso2, -iso3, -code3, -FIPS, -Admin2, -Province_State, -Country_Region, -Lat, -Long_, -Combined_Key) %>%
  pivot_longer(cols = everything(), 
               names_to = "Date_String", 
               values_to = "Cumulative_Cases") %>% # pivot to 2 columns
  mutate(Date = mdy(Date_String)) %>%
  group_by(Date) %>%
  summarize(Total_US_Cases = sum(Cumulative_Cases, na.rm = TRUE)) %>%
  mutate(New_Cases = Total_US_Cases - lag(Total_US_Cases, default = 0)) # calculate daily cases (demand spikes)

# Clean FDA Shortage Data
fda_clean <- fda_raw %>%
  clean_names() %>%
  # Filter inventory (keywords)
  filter(str_detect(str_to_lower(product_code_description), "tube|specimen|citrate|blood|coagulation")) %>%
  mutate(Date = ymd(str_extract(date_yyyy_mm_dd, "\\d{4}/\\d{2}/\\d{2}"))) %>%
  select(Date, category, product_code_description, reason_for_interruption_per_506j) #pick columns from table for time-series analysis

#Merge tables
final_merged_data <- covid_clean %>%
  left_join(fda_clean, by = "Date") %>% # Keep covid timelime + attach fda shortage 
  mutate(Shortage_Flag = ifelse(!is.na(product_code_description), 1, 0)) #Binary indictor, 1 = shortage and 0 = none

# Save to the Processed Folder
# Check if processed directory exists, create if not
if (!dir.exists("data/processed")) {
  dir.create("data/processed", recursive = TRUE)
  message("Created directory: data/processed")
}

# Export final analytical dataset
write_csv(final_merged_data, "data/processed/clean_supply_data.csv")

