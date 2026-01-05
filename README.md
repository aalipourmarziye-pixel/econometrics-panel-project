# Panel Econometrics Project: Growth and Investment

## Goal
This project studies the relationship between economic growth and investment
using country-level panel data.

## Data
- Source: World Bank – World Development Indicators (WDI)
- Unit of observation: Country-year
- Period: 1995–2022

## Methods
- Pooled OLS
- Fixed Effects (country and year)
- Random Effects
- Hausman test
- Robust standard errors

## Structure
- data/raw: raw data downloaded from WDI
- data/processed: cleaned panel data
- scripts: R scripts for download, cleaning, and analysis
- outputs: regression tables and figures

## How to run
1. Run scripts/01_download.R
2. Run scripts/02_clean.R
3. Run scripts/03_analysis.R
