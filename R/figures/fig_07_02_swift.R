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
# PANEL A: TIME SERIES OF MAJOR CURRENCIES
# ============================================================================

# Define currency colors
currency_colors <- c(
  "USD" = econ_colors[["USA"]],
  "EUR" = econ_colors[["EU"]],
  "GBP" = econ_colors[["UK"]],
  "JPY" = econ_colors[["Japan"]],
  "CNY" = econ_colors[["China"]],
  "Others" = "#8c564b"
)

panel_a <- ggplot(swift_long %>% filter(Currency != "Others"),
                  aes(x = Year, y = Share, color = Currency, linetype = Currency)) +
  geom_line(linewidth = 1.5) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_color_manual(values = currency_colors) +
  scale_linetype_manual(
    values = c("USD" = "solid", "EUR" = "solid", "GBP" = "dashed",
               "JPY" = "dotted", "CNY" = "solid")
  ) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 60, 10),
    limits = c(0, 60)
  ) +
  scale_x_continuous(
    breaks = seq(2010, 2024, 2),
    limits = c(2010, 2027)
  ) +
  labs(
    title = "Currency Share of SWIFT Payments Over Time",
    subtitle = "The dollar's share has risen since 2022, not fallen",
    x = "Year",
    y = "Share of Global Payments by Value (%)",
    color = "Currency",
    linetype = "Currency"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  ) +
  # Annotate latest-year values
  annotate(
    "text",
    x = 2025,
    y = swift_data$USD[swift_data$Year == 2025],
    label = "50.5%",
    size = 3,
    color = currency_colors["USD"],
    fontface = "bold",
    hjust = 0
  ) +
  annotate(
    "text",
    x = 2025,
    y = swift_data$EUR[swift_data$Year == 2025],
    label = "21.9%",
    size = 3,
    color = currency_colors["EUR"],
    fontface = "bold",
    hjust = 0
  ) +
  # Highlight CNY growth
  annotate(
    "segment",
    x = 2010,
    xend = 2025,
    y = swift_data$CNY[swift_data$Year == 2010],
    yend = swift_data$CNY[swift_data$Year == 2025],
    color = currency_colors["CNY"],
    linewidth = 0.8,
    arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
    alpha = 0.3
  ) +
  annotate(
    "text",
    x = 2014.5,
    y = 7.5,
    label = "CNY: 2023 peak,
then retreat",
    size = 3,
    color = currency_colors["CNY"],
    fontface = "italic"
  )

# ============================================================================
# PANEL B: STACKED AREA CHART
# ============================================================================

panel_b <- ggplot(swift_long, aes(x = Year, y = Share, fill = Currency)) +
  geom_area(alpha = 0.8, position = "stack") +
  scale_fill_manual(values = currency_colors) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 20),
    limits = c(0, 100),
    expand = c(0, 0)
  ) +
  scale_x_continuous(
    breaks = seq(2010, 2024, 2)
  ) +
  labs(
    title = "Composition of Global Payment System",
    subtitle = "Relative shares of major currencies in SWIFT transactions",
    x = "Year",
    y = "Share of Global Payments by Value (%)",
    fill = "Currency"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  )

# ============================================================================
# PANEL C: CNY GROWTH TRAJECTORY
# ============================================================================

cny_data <- swift_data %>%
  select(Year, CNY) %>%
  mutate(
    CNY_Index = (CNY / CNY[Year == 2010]) * 100,
    Milestone = case_when(
      Year == 2015 ~ "CIPS Launch",
      Year == 2016 ~ "SDR Inclusion",
      Year == 2021 ~ "Digital Yuan",
      TRUE ~ NA_character_
    )
  )

panel_c <- ggplot(cny_data, aes(x = Year, y = CNY)) +
  geom_area(fill = currency_colors["CNY"], alpha = 0.3) +
  geom_line(color = currency_colors["CNY"], linewidth = 1.5) +
  geom_point(size = 3, color = currency_colors["CNY"]) +
  geom_text(
    aes(label = paste0(CNY, "%")),
    vjust = -1,
    size = 3,
    color = currency_colors["CNY"],
    fontface = "bold"
  ) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 6, 1),
    limits = c(0, 7),
    expand = c(0, 0)
  ) +
  scale_x_continuous(
    breaks = seq(2010, 2024, 2)
  ) +
  labs(
    title = "Chinese Yuan (CNY/RMB) Growth Trajectory",
    subtitle = "A 2023 peak of 4.1%, then retreat to 2.7% by 2025",
    x = "Year",
    y = "CNY Share of Global Payments by Value (%)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.minor = element_blank()
  ) +
  # Add milestone annotations
  annotate(
    "segment",
    x = 2015,
    xend = 2015,
    y = 0,
    yend = cny_data$CNY[cny_data$Year == 2015] - 0.3,
    linetype = "dotted",
    color = "gray30"
  ) +
  annotate(
    "text",
    x = 2015,
    y = 6.5,
    label = "CIPS\nLaunch",
    size = 2.5,
    color = "gray30",
    fontface = "italic"
  ) +
  annotate(
    "segment",
    x = 2016,
    xend = 2016,
    y = 0,
    yend = cny_data$CNY[cny_data$Year == 2016] - 0.3,
    linetype = "dotted",
    color = "gray30"
  ) +
  annotate(
    "text",
    x = 2016,
    y = 5.8,
    label = "SDR\nInclusion",
    size = 2.5,
    color = "gray30",
    fontface = "italic"
  )

# ============================================================================
# PANEL D: 2024 CURRENCY BREAKDOWN
# ============================================================================

latest_data <- swift_data %>%
  filter(Year == 2025) %>%
  select(-Year) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Currency",
    values_to = "Share"
  ) %>%
  mutate(
    Currency = factor(Currency, levels = c("USD", "EUR", "GBP", "JPY", "CNY", "Others")),
    Label = paste0(Currency, "\n", Share, "%")
  )

panel_d <- ggplot(latest_data, aes(x = "", y = Share, fill = Currency)) +
  geom_col(width = 1, color = "white", linewidth = 1.5) +
  coord_polar(theta = "y") +
  scale_fill_manual(values = currency_colors) +
  geom_text(
    aes(label = paste0(Share, "%")),
    position = position_stack(vjust = 0.5),
    color = "white",
    fontface = "bold",
    size = 4
  ) +
  labs(
    title = "2025 Currency Breakdown",
    subtitle = "Share of global payments by value",
    fill = "Currency"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "right"
  )

# ============================================================================
# COMBINE PANELS
# ============================================================================

combined_plot <- ((panel_a / panel_b) | (panel_c / panel_d)) +
  plot_annotation(
    title = "SWIFT Payment Shares by Currency (2010-2025)",
    subtitle = "Dollar dominance has deepened since 2022; the yuan peaked in 2023 and has since receded",
    caption = paste0(
      "Source: SWIFT RMB Tracker, Bank for International Settlements (BIS)\n",
      "Note: Share of global customer and institutional payment value carried over SWIFT, December print of each year. SWIFT = Society for Worldwide Interbank Financial Telecommunication.\n",
      "CNY (Chinese yuan/renminbi) rose from 0.3% (2010) to a 4.1% peak (2023) before easing to 2.7% (2025). CIPS = Cross-Border Interbank Payment System; SDR = Special Drawing Rights."
    ),
    theme = theme_econ_textbook()
  ) +
  plot_layout(widths = c(1.2, 1))

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================

print(combined_plot)

# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_07_02_swift_currencies.png"),
  plot = combined_plot,
  width = 16,
  height = 12,
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
