# scripts/02_clean.R
# Clean WDI raw data and create a panel dataset

library(tidyverse)

# 1) Read raw data
raw <- read_csv("data/raw/wdi_raw.csv", show_col_types = FALSE)

# 2) Keep key columns and basic cleaning
panel <- raw |>
  transmute(
    country = country,
    iso3c   = iso3c,
    year    = year,
    growth  = growth,
    inv     = inv,
    infl    = infl,
    open    = open
  ) |>
  filter(!is.na(iso3c)) |>
  arrange(iso3c, year) |>
  # 3) Keep rows where the main outcome exists
  filter(!is.na(growth))

# 4) Save cleaned data
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
write_csv(panel, "data/processed/panel.csv")

message("Saved cleaned panel data to data/processed/panel.csv")
message("Rows: ", nrow(panel), " | Countries: ", n_distinct(panel$iso3c))
