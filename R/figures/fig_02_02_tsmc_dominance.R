# Figure 2.2: TSMC's Dominance in Advanced Chip Manufacturing
# Author: Laurence Wilse-Samson
# Description: Market share by technology node showing TSMC's commanding position

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

tsmc_data <- read_csv(here::here("data", "sources", "tsmc_market_share.csv"))

# Prepare data for plotting
tsmc_long <- tsmc_data %>%
  pivot_longer(
    cols = -Technology_Node,
    names_to = "Manufacturer",
    values_to = "Market_Share"
  ) %>%
  mutate(
    # Create ordered factor for technology nodes (most advanced first)
    Technology_Node = factor(Technology_Node,
                             levels = c("3nm", "5nm", "7nm", "10nm", "14nm", "28nm", "65nm_and_larger")),
    # Order manufacturers by importance
    Manufacturer = factor(Manufacturer,
                         levels = c("TSMC", "Samsung", "Intel", "SMIC", "Others"))
  )

# ============================================================================
# DEFINE MANUFACTURER COLORS
# ============================================================================

manufacturer_colors <- c(
  "TSMC" = "#d62728",      # Red - Taiwan
  "Samsung" = "#ff7f0e",   # Orange - South Korea
  "Intel" = "#2ca02c",     # Green - USA
  "SMIC" = "#9467bd",      # Purple - China
  "Others" = "#8c564b"     # Brown
)

# ============================================================================
# PANEL A: STACKED BAR CHART BY NODE
# ============================================================================

panel_a <- ggplot(tsmc_long, aes(x = Technology_Node, y = Market_Share, fill = Manufacturer)) +
  geom_col(position = "stack", width = 0.7, alpha = 0.9) +
  geom_text(
    data = tsmc_long %>% filter(Market_Share >= 8),
    aes(label = paste0(Market_Share, "%")),
    position = position_stack(vjust = 0.5),
    color = "white",
    fontface = "bold",
    size = 3.5
  ) +
  scale_fill_manual(values = manufacturer_colors) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 20),
    limits = c(0, 105),
    expand = c(0, 0)
  ) +
  labs(
    title = "Market Share by Technology Node",
    subtitle = "More advanced nodes (left) show greater TSMC dominance",
    x = "Technology Node",
    y = "Market Share (%)",
    fill = "Manufacturer"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 0, hjust = 0.5, face = "bold", size = 10)
  ) +
  # Annotate 100% TSMC dominance at 3nm
  annotate(
    "text",
    x = 1,
    y = 107,
    label = "100% TSMC",
    size = 3.5,
    color = manufacturer_colors["TSMC"],
    fontface = "bold"
  ) +
  # Add arrow showing "More Advanced" direction
  annotate(
    "segment",
    x = 1.5,
    xend = 1,
    y = -8,
    yend = -8,
    arrow = arrow(length = unit(0.3, "cm"), type = "closed"),
    color = "gray30",
    linewidth = 0.8
  ) +
  annotate(
    "text",
    x = 2.5,
    y = -8,
    label = "More Advanced Technology →",
    size = 3,
    color = "gray30",
    fontface = "italic",
    hjust = 0
  )

# ============================================================================
# PANEL B: TSMC DOMINANCE TREND
# ============================================================================

# Calculate TSMC's share at each node for trend visualization
tsmc_trend <- tsmc_data %>%
  mutate(
    Technology_Node = factor(Technology_Node,
                             levels = c("3nm", "5nm", "7nm", "10nm", "14nm", "28nm", "65nm_and_larger")),
    Node_Num = as.numeric(Technology_Node)
  ) %>%
  select(Technology_Node, Node_Num, TSMC)

panel_b <- ggplot(tsmc_trend, aes(x = Technology_Node, y = TSMC)) +
  geom_col(fill = manufacturer_colors["TSMC"], alpha = 0.8, width = 0.7) +
  geom_hline(yintercept = 50, linetype = "dashed", color = "gray50", linewidth = 0.8) +
  geom_text(
    aes(label = paste0(TSMC, "%")),
    vjust = -0.5,
    fontface = "bold",
    size = 3.5,
    color = manufacturer_colors["TSMC"]
  ) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 25),
    limits = c(0, 110),
    expand = c(0, 0)
  ) +
  labs(
    title = "TSMC's Market Share by Node",
    subtitle = "Dominance increases at cutting-edge technology nodes",
    x = "Technology Node",
    y = "TSMC Market Share (%)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 0, hjust = 0.5, face = "bold", size = 10)
  ) +
  annotate(
    "text",
    x = 6,
    y = 52,
    label = "Majority control",
    size = 3,
    color = "gray50",
    fontface = "italic",
    vjust = -0.5
  )

# ============================================================================
# PANEL C: COMPETITIVE LANDSCAPE AT LEADING EDGE
# ============================================================================

# Focus on advanced nodes (3nm, 5nm, 7nm)
advanced_nodes <- tsmc_long %>%
  filter(Technology_Node %in% c("3nm", "5nm", "7nm")) %>%
  filter(Market_Share > 0)

panel_c <- ggplot(advanced_nodes, aes(x = Technology_Node, y = Market_Share, fill = Manufacturer)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.75, alpha = 0.9) +
  geom_text(
    aes(label = paste0(Market_Share, "%")),
    position = position_dodge(width = 0.8),
    vjust = -0.5,
    fontface = "bold",
    size = 3
  ) +
  scale_fill_manual(values = manufacturer_colors) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 25),
    limits = c(0, 110),
    expand = c(0, 0)
  ) +
  labs(
    title = "Leading-Edge Competition (≤7nm)",
    subtitle = "Only TSMC, Samsung, and SMIC compete at advanced nodes",
    x = "Technology Node",
    y = "Market Share (%)",
    fill = "Manufacturer"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "bottom",
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 0, hjust = 0.5, face = "bold", size = 10)
  )

# ============================================================================
# COMBINE PANELS
# ============================================================================

combined_plot <- (panel_a / (panel_b | panel_c)) +
  plot_annotation(
    title = "TSMC's Dominance in Advanced Chip Manufacturing",
    subtitle = "Global foundry market share by technology node (2023-2024)",
    caption = paste0(
      "Source: TechInsights, Semiconductor Industry Association, Gartner\n",
      "Note: Market share based on foundry revenue. Smaller nanometer values indicate more advanced technology.\n",
      "Intel data represents foundry services only (Intel Foundry Services). SMIC limited by U.S. export controls."
    ),
    theme = theme_econ_textbook()
  ) +
  plot_layout(heights = c(2, 1))

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================

print(combined_plot)

# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_02_02_tsmc_dominance.png"),
  plot = combined_plot,
  width = 14,
  height = 12,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 2.2 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_02_02_tsmc_dominance.png\n")
cat("          figures/fig_02_02_tsmc_dominance.pdf\n")
cat("\n")
cat("TSMC Market Share by Technology Node:\n")
cat("--------------------------------------\n")
for (i in 1:nrow(tsmc_data)) {
  node <- tsmc_data$Technology_Node[i]
  tsmc_share <- tsmc_data$TSMC[i]
  samsung_share <- tsmc_data$Samsung[i]
  intel_share <- tsmc_data$Intel[i]
  smic_share <- tsmc_data$SMIC[i]

  cat(sprintf("  %s: TSMC %d%%, Samsung %d%%, Intel %d%%, SMIC %d%%\n",
              node, tsmc_share, samsung_share, intel_share, smic_share))
}
cat("\n")
cat("Key Insights:\n")
cat("  - TSMC has 100% monopoly at 3nm (most advanced)\n")
cat("  - TSMC controls 90% of 5nm market\n")
cat("  - Only 3 companies can manufacture at 7nm or below\n")
cat("  - SMIC (China) limited to 7nm with low yields due to export controls\n")
cat("  - Concentration increases at more advanced nodes\n")
cat("========================================\n")
cat("\n")
