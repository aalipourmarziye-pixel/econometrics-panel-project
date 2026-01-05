# scripts/03_analysis.R

library(readr)
library(plm)
library(lmtest)
library(sandwich)
library(modelsummary)

# Load data
panel <- read_csv("data/processed/panel.csv", show_col_types = FALSE)

# 1) OLS
ols_1 <- lm(growth ~ inv + infl + open, data = panel)

# 2) Fixed Effects (within)
fe_1 <- plm(
  growth ~ inv + infl + open,
  data  = panel,
  index = c("iso3c", "year"),
  model = "within"
)

# 3) Random Effects
re_1 <- plm(
  growth ~ inv + infl + open,
  data  = panel,
  index = c("iso3c", "year"),
  model = "random"
)

# 4) Hausman Test (FE vs RE)
hausman_test <- phtest(fe_1, re_1)
print(hausman_test)

# 5) Robust SE + Regression Table (HTML)
vcov_list <- list(
  "OLS" = vcovHC(ols_1, type = "HC1"),
  "FE (within)" = vcovHC(fe_1, type = "HC1", cluster = "group"),
  "RE" = vcovHC(re_1, type = "HC1", cluster = "group")
)

dir.create("outputs", showWarnings = FALSE)

modelsummary(
  list(
    "OLS" = ols_1,
    "FE (within)" = fe_1,
    "RE" = re_1
  ),
  vcov = vcov_list,
  stars = TRUE,
  output = "outputs/regression_table.html"
)

