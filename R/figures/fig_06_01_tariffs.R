# Figure 6.1: U.S. Tariffs on Chinese Goods (2015-2024)
# Author: Laurence Wilse-Samson
# Description: Trade war impact - dramatic increase in tariff rates

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

tariff_data <- read_csv(here::here("data", "sources", "us_china_tariffs.csv"))

# Add period categorization
tariff_data <- tariff_data %>%
  mutate(
    Period = case_when(
      Year < 2018 ~ "Pre-Trade War",
      Year >= 2018 & Year < 2021 ~ "Trump Tariffs",
      Year >= 2021 ~ "Biden (Maintained)"
    ),
    Period = factor(Period, levels = c("Pre-Trade War", "Trump Tariffs", "Biden (Maintained)"))
  )

# ============================================================================
# PANEL A: AVERAGE TARIFF RATE
# ============================================================================

panel_a <- ggplot(tariff_data, aes(x = Year, y = Average_Tariff_Rate, fill = Period)) +
  geom_col(width = 0.8, alpha = 0.9, color = "black", linewidth = 0.5) +
  geom_text(
    aes(label = paste0(Average_Tariff_Rate, "%")),
    vjust = -0.5,
    fontface = "bold",
    size = 3.5
  ) +
  scale_fill_manual(
    values = c("Pre-Trade War" = "#2ca02c",
               "Trump Tariffs" = "#d62728",
               "Biden (Maintained)" = "#ff7f0e")
  ) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 25, 5),
    limits = c(0, 25),
    expand = c(0, 0)
  ) +
  scale_x_continuous(
    breaks = seq(2015, 2024, 1)
  ) +
  labs(
    title = "Average Tariff Rate on Chinese Imports",
    subtitle = "6-fold increase from pre-trade war levels, maintained across administrations",
    x = "Year",
    y = "Average Tariff Rate (%)",
    fill = "Period"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "top",
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()
  ) +
  # Mark trade war beginning
  annotate(
    "segment",
    x = 2018,
    xend = 2018,
    y = 0,
    yend = 21,
    linetype = "dotted",
    color = "gray30",
    linewidth = 1
  ) +
  annotate(
    "text",
    x = 2018,
    y = 22,
    label = "Trade War\nBegins",
    size = 3,
    fontface = "bold",
    color = "gray20"
  ) +
  # Mark Biden administration
  annotate(
    "segment",
    x = 2021,
    xend = 2021,
    y = 0,
    yend = 18,
    linetype = "dotted",
    color = "gray30",
    linewidth = 1
  ) +
  annotate(
    "text",
    x = 2021,
    y = 22,
    label = "Biden\nContinues",
    size = 3,
    fontface = "bold",
    color = "gray20"
  )

# ============================================================================
# PANEL B: CUMULATIVE GOODS UNDER TARIFFS
# ============================================================================

panel_b <- ggplot(tariff_data, aes(x = Year, y = Total_Goods_Under_Tariffs_Billions)) +
  geom_area(fill = econ_colors["USA"], alpha = 0.4) +
  geom_line(color = econ_colors["USA"], linewidth = 1.5) +
  geom_point(size = 3, color = econ_colors["USA"]) +
  geom_text(
    aes(label = ifelse(Total_Goods_Under_Tariffs_Billions > 0,
                       paste0("$", Total_Goods_Under_Tariffs_Billions, "B"),
                       "")),
    vjust = -1,
    fontface = "bold",
    size = 3,
    color = econ_colors["USA"]
  ) +
  scale_y_continuous(
    labels = label_dollar(suffix = "B"),
    breaks = seq(0, 600, 100),
    limits = c(0, 650),
    expand = c(0, 0)
  ) +
  scale_x_continuous(
    breaks = seq(2015, 2024, 1)
  ) +
  labs(
    title = "Value of Chinese Goods Under Section 301 Tariffs",
    subtitle = "Rapid escalation in 2018-2019, then stabilization",
    x = "Year",
    y = "Goods Under Tariffs (Billions USD)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()
  )

# ============================================================================
# PANEL C: TARIFF ESCALATION TIMELINE
# ============================================================================

# Create timeline data
timeline_data <- tibble(
  Date = c("2017", "2018-Q1", "2018-Q2", "2018-Q3", "2019-Q1", "2019-Q3", "2021-Q1", "2023-Q3", "2024-Q3"),
  Event = c(
    "Pre-Trade War\nNormal rates (3.1%)",
    "Investigation\nSection 301 initiated",
    "First Wave\n$50B tariffs (25%)",
    "Second Wave\n$200B tariffs (10%→25%)",
    "Third Wave\n$300B proposed",
    "Partial Deal\nSome tariffs suspended",
    "Biden Review\nMaintains tariffs",
    "Expansion\nEVs, solar, batteries",
    "Current\n$570B under tariffs"
  ),
  Rate = c(3.1, 3.1, 12.4, 19.3, 19.3, 19.3, 19.3, 19.5, 19.8),
  Y_Position = c(1, 2, 3, 4, 5, 6, 7, 8, 9),
  Color = c("Pre-Trade War", "Trump Tariffs", "Trump Tariffs", "Trump Tariffs",
            "Trump Tariffs", "Trump Tariffs", "Biden (Maintained)", "Biden (Maintained)",
            "Biden (Maintained)")
)

panel_c <- ggplot(timeline_data, aes(x = Rate, y = Y_Position, color = Color)) +
  geom_segment(aes(x = 0, xend = Rate, y = Y_Position, yend = Y_Position),
               linewidth = 2, alpha = 0.7) +
  geom_point(size = 5) +
  geom_text(
    aes(label = Event),
    hjust = 0,
    nudge_x = 1,
    size = 3,
    fontface = "bold"
  ) +
  geom_text(
    aes(label = paste0(Rate, "%")),
    hjust = 1,
    nudge_x = -0.5,
    size = 3,
    color = "white",
    fontface = "bold"
  ) +
  scale_color_manual(
    values = c("Pre-Trade War" = "#2ca02c",
               "Trump Tariffs" = "#d62728",
               "Biden (Maintained)" = "#ff7f0e")
  ) +
  scale_x_continuous(
    labels = label_percent(scale = 1),
    limits = c(0, 30)
  ) +
  labs(
    title = "Tariff Escalation Timeline",
    subtitle = "Step-by-step increase in trade barriers",
    x = "Average Tariff Rate (%)",
    y = NULL,
    color = "Period"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "none",
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank()
  )

# ============================================================================
# COMBINE PANELS
# ============================================================================

combined_plot <- (panel_a / panel_b / panel_c) +
  plot_annotation(
    title = "U.S. Tariffs on Chinese Goods (2015-2024)",
    subtitle = "The trade war's lasting impact: A 6-fold increase in tariff rates affecting $570B in annual trade",
    caption = paste0(
      "Source: U.S. International Trade Commission (USITC), Peterson Institute for International Economics, USTR\n",
      "Note: Average tariff rate on Chinese imports. Section 301 tariffs imposed 2018-2019 under Trump, maintained and selectively expanded under Biden.\n",
      "Does not include Chinese retaliatory tariffs on U.S. goods (also ~$100B+ in value)."
    ),
    theme = theme_econ_textbook()
  ) +
  plot_layout(heights = c(1, 0.8, 1.2))

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================

print(combined_plot)

# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_06_01_us_china_tariffs.png"),
  plot = combined_plot,
  width = 14,
  height = 14,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 6.1 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_06_01_us_china_tariffs.png\n")
cat("          figures/fig_06_01_us_china_tariffs.pdf\n")
cat("\n")
cat("Tariff Rate Changes:\n")
cat("--------------------\n")
pre_war <- tariff_data$Average_Tariff_Rate[tariff_data$Year == 2017]
current <- tariff_data$Average_Tariff_Rate[tariff_data$Year == 2024]
cat(sprintf("  2017 (Pre-trade war):  %.1f%%\n", pre_war))
cat(sprintf("  2024 (Current):        %.1f%%\n", current))
cat(sprintf("  Absolute increase:     %.1f percentage points\n", current - pre_war))
cat(sprintf("  Relative increase:     %.0f%%\n", ((current / pre_war) - 1) * 100))
cat("\n")
cat("Goods Affected:\n")
cat(sprintf("  2017: $%.0fB\n", tariff_data$Total_Goods_Under_Tariffs_Billions[tariff_data$Year == 2017]))
cat(sprintf("  2024: $%.0fB\n", tariff_data$Total_Goods_Under_Tariffs_Billions[tariff_data$Year == 2024]))
cat("\n")
cat("Key Insights:\n")
cat("  - Tariff rates increased 6-fold from 2017 to 2024\n")
cat("  - $570B in annual Chinese imports now subject to tariffs\n")
cat("  - Bipartisan policy: tariffs maintained across administrations\n")
cat("  - Most goods face 7.5%-25% tariffs (vs. 3.1% pre-2018)\n")
cat("  - Represents fundamental shift in U.S.-China trade policy\n")
cat("========================================\n")
cat("\n")
