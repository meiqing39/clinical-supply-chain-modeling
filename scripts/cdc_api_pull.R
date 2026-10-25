
# Purpose: Obtain phase (OSEMN). Downloads historical COVID-19 data from JHU github repo.

library(tidyverse)
library(httr)
library(here) # ADDED: Resolves directory pathing issues

# 1. Define raw URL and local destination path
jhu_url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv"
local_dir <- here("data", "raw") # UPDATED
local_file <- here("data", "raw", "time_series_covid19_confirmed_US.csv") # UPDATED

# 2. Create the data/raw/ directory
if (!dir.exists(local_dir)) {
  dir.create(local_dir, recursive = TRUE)
  message("Created directory: ", local_dir)
}

# 3. Check if the file already exists
if (!file.exists(local_file)) {
  message("Dataset not found locally. Downloading from raw GitHub URL...")
  
  # UPDATED: Execute the raw URL download strategy using httr
  response <- GET(
    url = jhu_url, 
    add_headers(`User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
  )
  
  stop_for_status(response)
  writeBin(content(response, "raw"), local_file)
  
  message("Download complete and saved to data/raw/")
} else {
  message("Local dataset already exists. Skipping download to save time.")
}

# 4. Load data 
covid_raw_data <- read_csv(local_file)

# Double that it was loaded
glimpse(covid_raw_data)

