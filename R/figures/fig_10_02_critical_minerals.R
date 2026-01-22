# Figure 10.2: Critical Mineral Processing Concentration
# Purpose: Show China's dominance in critical mineral processing
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

# Critical mineral processing share by country (2023 estimates)
minerals_data <- tibble(
  Mineral = rep(c("Lithium", "Cobalt", "Rare Earths", "Graphite", "Nickel"), each = 5),
  Country = rep(c("China", "DRC", "Australia", "Chile", "Others"), 5),
  Processing_Share = c(
    # Lithium processing
    65, 0, 5, 20, 10,
    # Cobalt processing (refining)
    73, 3, 0, 0, 24,
    # Rare Earths processing
    87, 0, 0, 0, 13,
    # Graphite processing
    80, 0, 0, 0, 20,
    # Nickel processing
    35, 0, 5, 0, 60
  ),
  Mining_Share = c(
    # Lithium mining
    13, 0, 47, 30, 10,
    # Cobalt mining
    3, 70, 3, 0, 24,
    # Rare Earths mining
    60, 0, 8, 0, 32,
    # Graphite mining
    65, 0, 0, 0, 35,
    # Nickel mining
    5, 0, 6, 0, 89  # Indonesia dominant in Others
  )
)

# Filter for main chart (processing)
processing_data <- minerals_data %>%
  filter(Country %in% c("China", "DRC", "Australia", "Chile", "Others")) %>%
  mutate(
    Mineral = factor(Mineral, levels = c("Rare Earths", "Graphite", "Cobalt", "Lithium", "Nickel")),
    Country = factor(Country, levels = c("China", "Chile", "Australia", "DRC", "Others"))
  )

# Summary statistics
china_processing <- minerals_data %>%
  filter(Country == "China") %>%
  summarize(avg_share = mean(Processing_Share)) %>%
  pull(avg_share)

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# Country colors
country_colors <- c(
  "China" = "#d62728",
  "DRC" = "#ff7f0e",
  "Australia" = "#17becf",
  "Chile" = "#2ca02c",
  "Others" = "#7f7f7f"
)

# --- Panel A: Grouped Bar Chart - Processing Share ---
p1 <- ggplot(processing_data, aes(x = Mineral, y = Processing_Share, fill = Country)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7,
           alpha = 0.9, color = "white", linewidth = 0.3) +

  # Add value labels for China
  geom_text(data = processing_data %>% filter(Country == "China"),
            aes(label = paste0(Processing_Share, "%")),
            position = position_dodge(width = 0.8),
            vjust = -0.5, size = 3.5, fontface = "bold", color = "#d62728") +

  # China dominance annotation
  annotate("rect", xmin = 2.5, xmax = 4.5, ymin = 75, ymax = 92,
           fill = "#d62728", alpha = 0.1) +
  annotate("text", x = 3.5, y = 83,
           label = "China controls\n>70% processing",
           size = 3.5, color = "#d62728", fontface = "bold") +

  scale_fill_manual(values = country_colors, name = "Country") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)),
                     labels = function(x) paste0(x, "%"),
                     breaks = seq(0, 100, 20)) +

  labs(
    title = "Critical Mineral Processing Share by Country",
    subtitle = "China dominates refining and processing across key energy transition minerals",
    x = NULL,
    y = "Share of Global Processing (%)"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "bottom",
    panel.grid.major.x = element_blank()
  ) +
  guides(fill = guide_legend(nrow = 1))

# --- Panel B: Mining vs Processing Comparison (China) ---
china_comparison <- minerals_data %>%
  filter(Country == "China") %>%
  select(Mineral, Processing_Share, Mining_Share) %>%
  pivot_longer(cols = c(Processing_Share, Mining_Share),
               names_to = "Stage", values_to = "Share") %>%
  mutate(
    Stage = ifelse(Stage == "Processing_Share", "Processing", "Mining"),
    Mineral = factor(Mineral, levels = c("Rare Earths", "Graphite", "Cobalt", "Lithium", "Nickel"))
  )

p2 <- ggplot(china_comparison, aes(x = Mineral, y = Share, fill = Stage)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6,
           alpha = 0.85, color = "black", linewidth = 0.3) +

  # Add labels
  geom_text(aes(label = paste0(Share, "%")),
            position = position_dodge(width = 0.7),
            vjust = -0.3, size = 3, fontface = "bold") +

  # Value-add annotation
  annotate("segment", x = 2, xend = 2, y = 73, yend = 3,
           arrow = arrow(length = unit(0.2, "cm"), ends = "both"),
           color = "#d62728", linewidth = 0.8) +
  annotate("text", x = 2.3, y = 40, label = "70 pp\ngap",
           size = 3, color = "#d62728", fontface = "bold") +

  scale_fill_manual(values = c("Mining" = "#1f77b4", "Processing" = "#d62728"),
                    name = "Value Chain Stage") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15)),
                     labels = function(x) paste0(x, "%")) +

  labs(
    title = "China: Mining vs Processing Share",
    subtitle = "Processing dominance exceeds mining share - capturing value-added",
    x = NULL,
    y = "China's Global Share (%)"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "bottom",
    panel.grid.major.x = element_blank()
  )

# --- Panel C: Strategic Vulnerability Scorecard ---
vulnerability_data <- tibble(
  Mineral = c("Rare Earths", "Graphite", "Cobalt", "Lithium", "Nickel"),
  China_Processing = c(87, 80, 73, 65, 35),
  EV_Importance = c("High", "Critical", "Critical", "Critical", "High"),
  Supply_Risk = c("Extreme", "Very High", "High", "Moderate", "Low"),
  Risk_Score = c(5, 4, 4, 3, 2)
)

vulnerability_data <- vulnerability_data %>%
  mutate(Mineral = factor(Mineral, levels = c("Rare Earths", "Graphite", "Cobalt", "Lithium", "Nickel")))

p3 <- ggplot(vulnerability_data, aes(y = Mineral)) +
  # China processing bars
  geom_col(aes(x = China_Processing), fill = "#d62728", alpha = 0.8, width = 0.6) +

  # Risk level indicator
  geom_point(aes(x = 95, color = Supply_Risk, size = Risk_Score),
             shape = 18) +

  # Labels
  geom_text(aes(x = China_Processing + 2, label = paste0(China_Processing, "%")),
            hjust = 0, size = 3.5, fontface = "bold") +

  scale_color_manual(values = c(
    "Extreme" = "#d62728",
    "Very High" = "#ff7f0e",
    "High" = "#ffbb78",
    "Moderate" = "#2ca02c",
    "Low" = "#1f77b4"
  ), name = "Supply Risk") +
  scale_size_continuous(range = c(4, 10), guide = "none") +
  scale_x_continuous(limits = c(0, 105), labels = function(x) paste0(x, "%")) +

  labs(
    title = "Strategic Vulnerability Assessment",
    subtitle = "China processing share and supply risk rating",
    x = "China's Processing Share (%)",
    y = NULL
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.major.y = element_blank()
  )

# ============================================================================
# 3. COMPOSE AND SAVE
# ============================================================================

# Combine plots
combined <- p1 / (p2 + p3) +
  plot_layout(heights = c(1.2, 1)) +
  plot_annotation(
    title = "Figure 10.2: Critical Mineral Processing Concentration",
    subtitle = paste0("China controls ~", round(china_processing),
                      "% of critical mineral processing on average, creating strategic vulnerability"),
    caption = paste0(
      "Sources: IEA Critical Minerals Report 2023, USGS, Benchmark Mineral Intelligence.\n",
      "Note: Processing includes refining and chemical processing of mined ores.\n",
      "Rare earths processing includes separation and oxide production stages."
    ),
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  )

# Save
save_econ_figure(here("figures", "fig_10_02_critical_minerals.png"), combined, width = 13, height = 12)

# Print summary
cat("\nFigure 10.2 Summary:\n")
cat(sprintf("  Average China processing share: %.0f%%\n", china_processing))
cat("  Highest concentration: Rare Earths (87%)\n")
cat("  Lowest concentration: Nickel (35%)\n")
cat("  Key finding: Processing dominance exceeds mining share\n")
