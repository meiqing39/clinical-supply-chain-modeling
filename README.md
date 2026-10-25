# Clinical Supply Chain Modeling

A data pipeline and time-series analysis modeling the impact of epidemiological surges on clinical laboratory supply chains. This project builds a predictive framework to help hospital networks and pharmaceutical logistics teams optimize inventory buffers and prevent critical diagnostic stockouts during sudden public health events.

## Project Impact
* **The Problem:** Sudden patient surges create unpredictable demand for clinical tests, leading to laboratory supply shortages and delayed patient diagnoses.
* **The Solution:** An end-to-end R pipeline that forecasts testing asset consumption rates by matching historical patient admission data with inventory tracking logs.
* **The Benefit:** Allows healthcare operators to adjust safety stock thresholds before a bottleneck occurs, reducing supply chain downtime.

## Industry Applications

### Clinical & Health System Operations
* **Turnaround Time Optimization:** Models diagnostic testing throughput to support physicians in receiving time-sensitive patient results without operational delays.
* **Laboratory Resource Allocation:** Provides actionable, data-driven insights for hospital operations managers to optimize laboratory staffing and reagent inventory levels during high-occupancy census periods.

### Biopharma & HealthTech Infrastructure
* **Reproducible Data Pipelines:** Implements modular R programming patterns engineered for production-readiness, data verification, and strict regulatory compliance environments.
* **Predictive Logistics:** Translates external public health and epidemiological data streams into direct supply signals for clinical manufacturing and distribution workflows.


## Directory Structure
The repository is split into isolated directories to maintain clean data and code separation:
* `data/` : Local datasets containing historical clinical testing and inventory volumes.
* `scripts/` : Modular R code handling data cleaning, variable transformations, and forecasting calculations.
* `reports/` : Rendered markdown files and plots visualizing the final data insights.

## Tech Stack & Methods
* **Language:** R
* **Libraries:** tidyverse (data manipulation), ggplot2 (visualization)
* **Methods:** Time-Series Forecasting, Inventory Optimization Modeling

## How to Run the Project
1. Clone the repository:
   ```bash
   git clone https://github.com
   ```
2. Open `clinical-supply-chain-modeling-main.Rproj` in RStudio.
3. Run the main processing script in your R console:
   ```R
   source("scripts/main_pipeline.R") 
   ```
   *(Note: replace "main_pipeline.R" with the actual name of your primary R script file)*

## License
This project is licensed under the MIT License. See the LICENSE file for details.
