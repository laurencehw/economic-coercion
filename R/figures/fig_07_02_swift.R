# Figure 7.2: SWIFT Transaction Volumes by Currency (2010-2024)
# Author: Laurence Wilse-Samson
# Description: U.S. dollar dominance in global payment systems with rising yuan

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

swift_data <- read_csv(here::here("data", "sources", "swift_currency_data.csv"))

# Prepare long format for plotting
swift_long <- swift_data %>%
  pivot_longer(
    cols = -Year,
    names_to = "Currency",
    values_to = "Share"
  ) %>%
  mutate(
    Currency = factor(Currency, levels = c("USD", "EUR", "GBP", "JPY", "CNY", "Others"))
  )

# ============================================================================
# PANELS: A. five currencies over time (USD ink, CNY highlight); B. the yuan alone.
# The stacked area (incl. 'Others'), the repeated yuan area and the 2025 donut are dropped.
# ============================================================================

cur_cols <- c("USD" = lws_colors[["ink"]], "EUR" = "#6E6E6E", "GBP" = "#9A9A9A", "JPY" = "#BDBDBD", "CNY" = lws_colors[["red"]])
cur_lt <- c("USD" = "solid", "EUR" = "solid", "GBP" = "dashed", "JPY" = "dotted", "CNY" = "solid")
sw5 <- swift_long %>% filter(Currency != "Others") %>% mutate(Currency = droplevels(Currency))

panel_a <- ggplot(sw5, aes(x = Year, y = Share, colour = Currency, linetype = Currency)) +
  geom_line(linewidth = 0.9) +
  scale_colour_manual(values = cur_cols, name = NULL) +
  scale_linetype_manual(values = cur_lt, name = NULL) +
  scale_y_continuous(labels = label_percent(scale = 1), breaks = seq(0, 60, 20), limits = c(0, 60), expand = c(0, 0)) +
  scale_x_continuous(breaks = seq(2010, 2025, 5)) +
  labs(title = "A. Currency shares of SWIFT payments by value", x = NULL, y = "Share of payments (%)") +
  theme_econ_textbook() +
  theme(legend.position = "top", legend.justification = "left")

cny <- swift_data %>% select(Year, CNY)
panel_c <- ggplot(cny, aes(x = Year, y = CNY)) +
  geom_line(colour = lws_colors[["red"]], linewidth = 0.9) +
  geom_point(colour = lws_colors[["red"]], size = 1.6) +
  geom_text(data = cny %>% filter(Year %in% c(2010, 2014, 2023, 2025)), aes(label = paste0(CNY, "%")),
            vjust = -1, hjust = c(0.5, 0.5, 0.5, 1), colour = lws_colors[["red"]], size = book_text_size) +
  scale_y_continuous(labels = label_percent(scale = 1), breaks = 0:5, limits = c(0, 5), expand = c(0, 0)) +
  scale_x_continuous(breaks = seq(2010, 2025, 5)) +
  labs(title = "B. The yuan: a 2023 peak, then retreat", x = NULL, y = "Yuan share (%)") +
  theme_econ_textbook()

combined_plot <- (panel_a / panel_c) + plot_layout(heights = c(1.2, 1)) +
  plot_annotation(
    caption = paste(strwrap("Source: SWIFT RMB Tracker and BIS. Share of global payment value carried over SWIFT, December print of each year.", 105), collapse = "\n"),
    theme = theme_econ_textbook())


# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_07_02_swift_currencies.png"),
  plot = combined_plot,
  width = 6,
  height = 5.6,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 7.2 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_07_02_swift_currencies.png\n")
cat("          figures/fig_07_02_swift_currencies.pdf\n")
cat("\n")
cat("Currency Shares 2024:\n")
cat("---------------------\n")
latest <- swift_data %>% filter(Year == 2025)
cat(sprintf("  1. USD: %.1f%%\n", latest$USD))
cat(sprintf("  2. EUR: %.1f%%\n", latest$EUR))
cat(sprintf("  3. GBP: %.1f%%\n", latest$GBP))
cat(sprintf("  4. JPY: %.1f%%\n", latest$JPY))
cat(sprintf("  5. CNY: %.1f%%\n", latest$CNY))
cat(sprintf("  6. Others: %.1f%%\n", latest$Others))
cat("\n")
cat("Changes (2010-2024):\n")
cat("--------------------\n")
first <- swift_data %>% filter(Year == 2010)
cat(sprintf("  USD: %.1f%% → %.1f%% (%.1f pp decline)\n", first$USD, latest$USD, latest$USD - first$USD))
cat(sprintf("  EUR: %.1f%% → %.1f%% (%.1f pp increase)\n", first$EUR, latest$EUR, latest$EUR - first$EUR))
cat(sprintf("  CNY: %.1f%% → %.1f%% (%.0fx growth)\n", first$CNY, latest$CNY, latest$CNY / first$CNY))
cat("\n")
cat("Key Insights:\n")
cat("  - USD maintains ~40% share despite gradual 4.5pp decline\n")
cat("  - EUR gaining ground, now at 37.2% (up from 32.8%)\n")
cat("  - CNY rose from 0.3% (2010) to a 4.1% peak (2023), easing to 2.7% (2025)\n")
cat("  - USD+EUR together control 75% of global payment messages\n")
cat("  - CNY still far behind major currencies despite rapid growth\n")
cat("========================================\n")
cat("\n")
