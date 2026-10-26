# Figure 7.3: Major Bank Enforcement Settlements Involving Sanctions
# Purpose: Visualize largest financial penalties for sanctions violations
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)
library(scales)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Major OFAC sanctions penalties data
penalties_data <- tibble(
  Institution = c("BNP Paribas", "HSBC", "Standard Chartered",
                  "UniCredit", "Commerzbank", "ING Bank",
                  "Credit Suisse", "Barclays", "Deutsche Bank"),
  Country = c("France", "UK", "UK", "Italy", "Germany",
              "Netherlands", "Switzerland", "UK", "Germany"),
  Penalty_Billions = c(8.9, 1.9, 1.1, 1.3, 1.45, 0.619, 0.536, 0.298, 0.258),
  Year = c(2014, 2012, 2019, 2019, 2015, 2012, 2009, 2010, 2015),
  Violation_Type = c("Sudan, Cuba, Iran", "Drug cartels, Iran",
                     "Iran, Myanmar", "Iran, Libya", "Iran, Sudan",
                     "Cuba", "Iran", "Cuba", "Iran, Syria")
)

# Sort by penalty amount
penalties_data <- penalties_data %>%
  mutate(
    Institution = fct_reorder(Institution, Penalty_Billions),
    Penalty_Label = ifelse(Penalty_Billions >= 1,
                           paste0("$", round(Penalty_Billions, 1), "B"),
                           paste0("$", round(Penalty_Billions * 1000), "M"))
  )

# Summary statistics
total_penalties <- sum(penalties_data$Penalty_Billions)

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# --- Panel A: Horizontal Bar Chart of Penalties ---
p1 <- ggplot(penalties_data, aes(x = Penalty_Billions, y = Institution)) +
  geom_col(fill = lws_colors[["fade"]], width = 0.7) +
  geom_col(data = penalties_data %>% filter(Institution == "BNP Paribas"), fill = lws_colors[["red"]], width = 0.7) +
  geom_text(aes(label = paste0(Penalty_Label, "  (", Year, ")")), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.25)), labels = function(x) paste0("$", x, "B"), breaks = seq(0, 10, 2)) +
  labs(title = "A. Selected settlements by institution (year of settlement)", x = "Penalty (billions of US dollars)", y = NULL) +
  theme_book_h()

violation_summary <- tibble(
  Sanctioned_Country = c("Iran", "Cuba", "Sudan", "Libya", "Myanmar", "Syria", "Other"),
  Total_Penalties = c(12.5, 1.4, 1.2, 0.3, 0.2, 0.1, 0.8)
) %>% mutate(Sanctioned_Country = fct_reorder(Sanctioned_Country, Total_Penalties))

p3 <- ggplot(violation_summary, aes(x = Total_Penalties, y = Sanctioned_Country)) +
  geom_col(fill = lws_colors[["fade"]], width = 0.7) +
  geom_col(data = violation_summary %>% filter(Sanctioned_Country == "Iran"), fill = lws_colors[["red"]], width = 0.7) +
  geom_text(aes(label = paste0("$", round(Total_Penalties, 1), "B")), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.2)), labels = function(x) paste0("$", x, "B")) +
  labs(title = "B. Estimated allocation by sanctioned country", x = "Estimated penalties (billions of US dollars)", y = NULL) +
  theme_book_h()

combined <- p1 / p3 + plot_layout(heights = c(1.5, 1)) +
  plot_annotation(
    caption = paste(strwrap("Source: U.S. Treasury Office of Foreign Assets Control and Department of Justice. Totals combine sanctions and, in some cases, anti-money-laundering penalties; BNP Paribas also pleaded guilty to criminal charges. The country allocation in panel B is an estimate that is not reconciled to panel A.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here("figures", "fig_07_03_sanctions_programs.png"), combined, width = 6, height = 5.8)

cat("\nFigure 7.3 Summary:\n")
cat(sprintf("  Total penalties: $%.1f billion\n", total_penalties))
