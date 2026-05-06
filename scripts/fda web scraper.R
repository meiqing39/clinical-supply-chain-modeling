# Purpose: Obtain phase (OSEMN). Scrapes the FDA Medical Device Shortages list.


# Load necessary libraries
library(tidyverse)
library(rvest)
library(httr)   #bypass fda bot
library(janitor)

# 1. Define the URL and your local destination path
fda_url <- "https://www.fda.gov/medical-devices/medical-device-supply-chain-and-shortages/medical-device-shortages-list"
local_file <- "data/raw/fda_device_shortages_raw.csv"

# 2. The Data Engineer Logic: Check if the file already exists
if (!file.exists(local_file)) {
  message("Dataset not found locally. Initiating web scraper...")
  
  response <- GET(
    url = fda_url, 
    add_headers(`User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"))

  #check
  stop_for_status(response)
  
  # Read the HTML from our disguised response
  webpage <- read_html(response)
  
  # Extract the HTML table
  fda_table <- webpage %>% 
    html_node("table") %>% 
    html_table(fill = TRUE) |> 
    clean_names()
  
  # Save the raw scraped data as a CSV
  write_csv(fda_table, local_file)
  
  message("Scraping complete. Raw table saved to data/raw/")
} else {
  message("Local dataset already exists. Skipping web scraper to ensure reproducibility.")
  
  # Load the existing data
  fda_table <- read_csv(local_file)
}

view(fda_table)

