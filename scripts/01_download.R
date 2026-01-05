# scripts/01_download.R
# Download World Bank WDI data for panel econometrics project

# install.packages(c("WDI", "tidyverse"))
library(WDI)
library(tidyverse)

indicators <- c(
  growth = "NY.GDP.PCAP.KD.ZG",  # GDP per capita growth (%)
  inv    = "NE.GDI.FTOT.ZS",     # Gross capital formation (% of GDP)
  infl   = "FP.CPI.TOTL.ZG",     # Inflation (%)
  open   = "NE.TRD.GNFS.ZS"      # Trade (% of GDP)
)

data_raw <- WDI(
  country = "all",
  indicator = indicators,
  start = 1995,
  end = 2022,
  extra = TRUE
) |>
  as_tibble() |>
  filter(region != "Aggregates")

dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)
write_csv(data_raw, "data/raw/wdi_raw.csv")

message("WDI raw data saved in data/raw/wdi_raw.csv")
