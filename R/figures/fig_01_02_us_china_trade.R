# Figure 1.2: U.S.-China Trade Flows (1990-2024)
# Author: Laurence Wilse-Samson
# Description: Multi-panel visualization of U.S.-China bilateral trade

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

trade_data <- read_csv(here::here("data", "sources", "us_china_trade.csv"))

# Prepare data for plotting
trade_long <- trade_data %>%
  select(Year, US_Exports_to_China, US_Imports_from_China) %>%
  pivot_longer(
    cols = c(US_Exports_to_China, US_Imports_from_China),
    names_to = "Flow",
    values_to = "Value"
  ) %>%
  mutate(
    Flow = case_when(
      Flow == "US_Exports_to_China" ~ "U.S. Exports to China",
      Flow == "US_Imports_from_China" ~ "U.S. Imports from China"
    )
  )

# ============================================================================
# PANEL A: BILATERAL TRADE FLOWS
# ============================================================================

panel_a <- ggplot(trade_long, aes(x = Year, y = Value, color = Flow, linetype = Flow)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2, alpha = 0.7) +
  scale_y_continuous(
    labels = label_dollar(suffix = "B"),
    breaks = seq(0, 600, 100),
    limits = c(0, 600)
  ) +
  scale_x_continuous(
    breaks = seq(1990, 2024, 5)
  ) +
  scale_color_manual(
    values = c("U.S. Exports to China" = econ_colors["USA"],
               "U.S. Imports from China" = econ_colors["China"])
  ) +
  scale_linetype_manual(
    values = c("U.S. Exports to China" = "solid",
               "U.S. Imports from China" = "dashed")
  ) +
  labs(
    title = "Bilateral Trade Flows",
    subtitle = "U.S. exports to and imports from China",
    x = "Year",
    y = "Trade Value (Billions USD)",
    color = NULL,
    linetype = NULL
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "bottom",
    legend.direction = "vertical",
    panel.grid.minor = element_blank()
  ) +
  annotate(
    "text",
    x = 2018,
    y = 550,
    label = "Trade War\n(2018-2020)",
    size = 3.5,
    color = "gray30",
    fontface = "italic"
  ) +
  annotate(
    "segment",
    x = 2018,
    xend = 2018,
    y = 0,
    yend = 530,
    linetype = "dotted",
    color = "gray50",
    alpha = 0.7
  )

# ============================================================================
# PANEL B: TRADE BALANCE
# ============================================================================

panel_b <- ggplot(trade_data, aes(x = Year, y = Trade_Balance)) +
  geom_area(fill = econ_colors["China"], alpha = 0.3) +
  geom_line(color = econ_colors["China"], linewidth = 1.2) +
  geom_hline(yintercept = 0, linetype = "solid", color = "gray30", linewidth = 0.5) +
  scale_y_continuous(
    labels = label_dollar(suffix = "B"),
    breaks = seq(-450, 0, 50)
  ) +
  scale_x_continuous(
    breaks = seq(1990, 2024, 5)
  ) +
  labs(
    title = "U.S. Trade Deficit with China",
    subtitle = "Negative values indicate U.S. deficit",
    x = "Year",
    y = "Trade Balance (Billions USD)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.minor = element_blank()
  ) +
  annotate(
    "text",
    x = 2018,
    y = -50,
    label = "Peak Deficit:\n$419.2B (2018)",
    size = 3.5,
    color = "gray30",
    fontface = "bold"
  )

# ============================================================================
# PANEL C: TOTAL TRADE VOLUME
# ============================================================================

panel_c <- ggplot(trade_data, aes(x = Year, y = Total_Trade)) +
  geom_col(fill = econ_colors["USA"], alpha = 0.7) +
  scale_y_continuous(
    labels = label_dollar(suffix = "B"),
    breaks = seq(0, 700, 100),
    limits = c(0, 750)
  ) +
  scale_x_continuous(
    breaks = seq(1990, 2024, 5)
  ) +
  labs(
    title = "Total Bilateral Trade",
    subtitle = "Sum of exports and imports",
    x = "Year",
    y = "Total Trade (Billions USD)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.minor = element_blank()
  ) +
  annotate(
    "text",
    x = 2000,
    y = 650,
    label = "China joins WTO (2001)",
    size = 3.5,
    color = "gray30",
    fontface = "italic"
  ) +
  annotate(
    "segment",
    x = 2001,
    xend = 2001,
    y = 0,
    yend = 620,
    linetype = "dotted",
    color = "gray50",
    alpha = 0.7
  )

# ============================================================================
# COMBINE PANELS
# ============================================================================

combined_plot <- (panel_a / panel_b / panel_c) +
  plot_annotation(
    title = "U.S.-China Bilateral Trade Flows (1990-2024)",
    subtitle = "The evolution of the world's most economically significant bilateral relationship",
    caption = "Source: U.S. Census Bureau, Foreign Trade Statistics",
    theme = theme_econ_textbook()
  )

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================

print(combined_plot)

# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_01_02_us_china_trade.png"),
  plot = combined_plot,
  width = 10,
  height = 12,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 1.2 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_01_02_us_china_trade.png\n")
cat("          figures/fig_01_02_us_china_trade.pdf\n")
cat("\n")
cat("Key insights:\n")
cat("  - Peak trade deficit of $419.2B in 2018\n")
cat("  - Trade war impact visible in 2018-2020\n")
cat("  - China WTO accession (2001) marked inflection point\n")
cat("  - Recent decline in bilateral trade volume\n")
cat("========================================\n")
cat("\n")
