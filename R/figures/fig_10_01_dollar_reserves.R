# Figure 10.1: Dollar Share of Global Foreign Exchange Reserves (1995-2050)
# Purpose: Show historical trends and future scenarios for de-dollarization
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Read the data
df <- read_csv(here("data", "sources", "dollar_reserves_projection.csv"))

# Separate historical and projection data
historical <- df %>% filter(Year <= 2024)
projections <- df %>% filter(Year >= 2024)

# ============================================================================
# 2. CREATE VISUALIZATION
# ============================================================================

p <- ggplot() +
  # Historical lines
  geom_line(data = historical,
            aes(x = Year, y = USD_Historical, color = "USD (Historical)"),
            linewidth = 2) +
  geom_point(data = historical,
             aes(x = Year, y = USD_Historical, color = "USD (Historical)"),
             size = 3) +
  geom_line(data = historical,
            aes(x = Year, y = EUR_Historical, color = "EUR (Historical)"),
            linewidth = 1.5) +
  geom_point(data = historical,
             aes(x = Year, y = EUR_Historical, color = "EUR (Historical)"),
             size = 2.5, shape = 15) +
  geom_line(data = historical,
            aes(x = Year, y = CNY_Historical, color = "CNY (Historical)"),
            linewidth = 1.5) +
  geom_point(data = historical,
             aes(x = Year, y = CNY_Historical, color = "CNY (Historical)"),
             size = 2.5, shape = 17) +

  # Projection lines
  geom_line(data = projections,
            aes(x = Year, y = USD_Baseline, color = "USD - Baseline"),
            linewidth = 2, linetype = "dashed") +
  geom_line(data = projections,
            aes(x = Year, y = USD_Slow_Decline, color = "USD - Slow Decline"),
            linewidth = 2, linetype = "dotted") +
  geom_line(data = projections,
            aes(x = Year, y = USD_Accelerated, color = "USD - Accelerated Decline"),
            linewidth = 2, linetype = "dotdash") +

  # Shaded projection range
  geom_ribbon(data = projections,
              aes(x = Year, ymin = USD_Accelerated, ymax = USD_Baseline),
              fill = "gray", alpha = 0.2) +

  # 2024 dividing line
  geom_vline(xintercept = 2024, color = "black", linewidth = 1.5, alpha = 0.5) +
  annotate("label", x = 2024, y = 72,
           label = "← Historical | Projections →",
           size = 4, fontface = "bold", fill = "yellow", alpha = 0.7,
           label.size = 0.5) +

  # Key events
  geom_vline(xintercept = 1999, linetype = "dashed", color = "gray50", alpha = 0.5) +
  annotate("label", x = 1999, y = 75, label = "Euro\nLaunch",
           size = 2.5, fill = "lightgray", alpha = 0.7) +
  geom_vline(xintercept = 2008, linetype = "dashed", color = "gray50", alpha = 0.5) +
  annotate("label", x = 2008, y = 75, label = "Global\nFinancial\nCrisis",
           size = 2.5, fill = "lightgray", alpha = 0.7) +
  geom_vline(xintercept = 2022, linetype = "dashed", color = "gray50", alpha = 0.5) +
  annotate("label", x = 2022, y = 75, label = "Russia\nSanctions",
           size = 2.5, fill = "lightgray", alpha = 0.7) +

  # Colors
  scale_color_manual(
    name = "Currency / Scenario",
    values = c(
      "USD (Historical)" = "#1f77b4",
      "EUR (Historical)" = "#ff7f0e",
      "CNY (Historical)" = "#d62728",
      "USD - Baseline" = "#1f77b4",
      "USD - Slow Decline" = "#2ca02c",
      "USD - Accelerated Decline" = "#d62728"
    ),
    breaks = c("USD (Historical)", "EUR (Historical)", "CNY (Historical)",
               "USD - Baseline", "USD - Slow Decline", "USD - Accelerated Decline")
  ) +

  # Scales and labels
  scale_x_continuous(breaks = seq(1995, 2050, 5), limits = c(1995, 2050)) +
  scale_y_continuous(limits = c(25, 78), labels = function(x) paste0(x, "%")) +

  labs(
    title = "Figure 10.1: U.S. Dollar Share of Global Reserves",
    subtitle = "Historical trends and projected scenarios (1995-2050)",
    x = "Year",
    y = "Share of Global Foreign Exchange Reserves (%)",
    caption = "Sources: IMF COFER Database, author projections based on current trends and scenario analysis."
  ) +

  theme_econ_textbook() +
  theme(
    legend.position = "right",
    legend.key.width = unit(1.5, "cm")
  )

# Add scenario descriptions box
scenario_text <- paste0(
  "Three Scenarios for 2050:\n\n",
  "Baseline (50.5%): Gradual diversification,\n",
  "USD maintains dominance\n\n",
  "Slow Decline (38.0%): Steady shift to\n",
  "multi-polar reserve system\n\n",
  "Accelerated (30.0%): Major disruption,\n",
  "rapid de-dollarization"
)

p <- p +
  annotate("label", x = 2000, y = 35, label = scenario_text,
           hjust = 0, vjust = 0, size = 3,
           fill = "lightyellow", alpha = 0.9, label.size = 0.5)

# Add current statistics box
stats_text <- paste0(
  "Historical Trend:\n",
  "1995: ", round(historical$USD_Historical[1], 1), "%\n",
  "2024: ", round(tail(historical$USD_Historical, 1), 1), "%\n",
  "Change: ", round(tail(historical$USD_Historical, 1) - historical$USD_Historical[1], 1), " pts\n\n",
  "2024 Composition:\n",
  "USD: ", round(tail(historical$USD_Historical, 1), 1), "%\n",
  "EUR: ", round(tail(historical$EUR_Historical, 1), 1), "%\n",
  "CNY: ", round(tail(historical$CNY_Historical, 1), 1), "%"
)

p <- p +
  annotate("label", x = 2048, y = 30, label = stats_text,
           hjust = 1, vjust = 0, size = 3,
           fill = "lightblue", alpha = 0.9, label.size = 0.5)

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_10_01_dollar_reserves.png"), p, width = 14, height = 8)

cat("\nFigure 10.1 created successfully!\n")
