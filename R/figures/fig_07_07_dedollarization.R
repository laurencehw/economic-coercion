# Figure 7.7: De-dollarization Trends
# Chapter 7: Financial Statecraft
# Shows shifts away from dollar in global trade and reserves

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)

# De-dollarization indicators
dedollar_data <- data.frame(
  year = rep(2015:2024, 4),
  indicator = rep(c("Global Reserves", "SWIFT Payments", "Oil Trade", "BRICS Trade"), each = 10),
  dollar_share = c(
    # Global reserves (IMF COFER)
    65.7, 65.4, 64.7, 62.7, 61.8, 60.5, 59.5, 59.0, 58.4, 57.8,
    # SWIFT payments
    45.3, 42.5, 40.8, 40.1, 42.2, 41.5, 40.5, 42.0, 47.5, 48.0,
    # Oil trade (estimated)
    92, 90, 88, 85, 82, 80, 78, 75, 72, 70,
    # BRICS bilateral trade
    75, 72, 68, 62, 55, 48, 42, 38, 32, 28
  )
)

# Alternative currency growth
alt_currencies <- data.frame(
  year = rep(2018:2024, 3),
  currency = rep(c("Chinese Yuan (CNY)", "Euro (EUR)", "Other"), each = 7),
  reserve_share = c(
    # Yuan
    1.8, 1.9, 2.2, 2.4, 2.7, 2.6, 2.3,
    # Euro
    20.5, 20.3, 20.6, 21.0, 20.5, 20.0, 19.8,
    # Other (JPY, GBP, etc.)
    12.0, 12.5, 13.0, 13.5, 14.0, 14.5, 15.0
  )
)

# Colors
indicator_colors <- c(
  "Global Reserves" = "#1f77b4",
  "SWIFT Payments" = "#2ca02c",
  "Oil Trade" = "#ff7f0e",
  "BRICS Trade" = "#d62728"
)

currency_colors <- c(
  "Chinese Yuan (CNY)" = "#d62728",
  "Euro (EUR)" = "#2ca02c",
  "Other" = "#ff7f0e"
)

# Panel 1: Dollar share decline across metrics
p1 <- ggplot(dedollar_data, aes(x = year, y = dollar_share, color = indicator)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2.5) +
  # Annotations
  annotate("rect", xmin = 2022, xmax = 2024.5, ymin = 25, ymax = 100,
           fill = "#ffcccc", alpha = 0.2) +
  annotate("text", x = 2023.2, y = 97, label = "Post-Russia\nSanctions Era",
           size = 3, color = "gray40") +
  scale_color_manual(values = indicator_colors, name = "Metric") +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(25, 100)) +
  labs(
    title = "Dollar Share in Global Finance and Trade",
    subtitle = "Multiple metrics show gradual decline, with acceleration in some areas",
    x = "Year",
    y = "US Dollar Share (%)"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "right")

# Panel 2: Alternative currency reserves growth
p2 <- ggplot(alt_currencies, aes(x = year, y = reserve_share, fill = currency)) +
  geom_area(alpha = 0.8, color = "white", linewidth = 0.3) +
  scale_fill_manual(values = currency_colors, name = "Currency") +
  scale_y_continuous(labels = function(x) paste0(x, "%"), expand = expansion(mult = c(0, 0.05))) +
  labs(
    title = "Non-Dollar Reserve Currency Shares",
    subtitle = "Gradual diversification toward yuan and other currencies",
    x = "Year",
    y = "Share of Global Reserves (%)"
  ) +
  theme_econ_textbook()

# Panel 3: Key de-dollarization initiatives
initiatives <- data.frame(
  initiative = c("CIPS", "mBridge\n(CBDC)", "BRICS\nSettlement", "Yuan Oil\nContracts", "Gold\nAccumulation"),
  year_launched = c(2015, 2021, 2023, 2018, 2022),
  significance = c(7, 6, 5, 6, 8),
  status = c("Operational", "Pilot", "Announced", "Operational", "Ongoing")
)

p3 <- ggplot(initiatives, aes(x = reorder(initiative, -significance), y = significance, fill = status)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = year_launched), vjust = -0.5, size = 4, fontface = "bold") +
  scale_fill_manual(
    values = c("Operational" = "#2ca02c", "Pilot" = "#ff7f0e", "Announced" = "#1f77b4", "Ongoing" = "#9467bd"),
    name = "Status"
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Key De-dollarization Initiatives",
    subtitle = "Year launched and relative significance (author's assessment)",
    x = NULL,
    y = "Significance Score",
    caption = "Source: IMF COFER, SWIFT RMB Tracker, industry estimates\nNote: CIPS = Cross-Border Interbank Payment System; mBridge = Multiple CBDC Bridge"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.x = element_blank(),
    legend.position = "bottom"
  )

# Combine
library(patchwork)
combined <- p1 / (p2 + p3) + plot_layout(heights = c(1, 1))

# Save the figure
save_econ_figure("figures/fig_07_07_dedollarization.png", plot = combined, width = 13, height = 12)

cat("Figure 7.7 created: De-dollarization Trends\n")
