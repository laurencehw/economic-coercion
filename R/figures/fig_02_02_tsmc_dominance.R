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
# DEFINE MANUFACTURER COLORS (house hues; TSMC is the highlight)
# ============================================================================

manufacturer_colors <- c(
  "TSMC" = lws_colors[["red"]],
  "Samsung" = lws_colors[["blue"]],
  "Intel" = lws_colors[["green"]],
  "SMIC" = lws_colors[["purple"]],
  "Others" = lws_colors[["fade"]]
)

# ============================================================================
# One panel: market share by technology node (the two other panels of the
# earlier dashboard restated TSMC's row and the 3-7nm columns of this one)
# ============================================================================

tsmc_long <- tsmc_long %>%
  mutate(Manufacturer = fct_rev(Manufacturer),
         Node_label = recode(as.character(Technology_Node), "65nm_and_larger" = "65nm\nand larger"),
         Node_label = factor(Node_label, levels = recode(levels(Technology_Node), "65nm_and_larger" = "65nm\nand larger")))

combined_plot <- ggplot(tsmc_long, aes(x = Node_label, y = Market_Share, fill = Manufacturer)) +
  geom_col(position = "stack", width = 0.7) +
  geom_text(
    data = tsmc_long %>% filter(Market_Share >= 8),
    position = position_stack(vjust = 0.5),
    aes(label = paste0(Market_Share, "%"), group = Manufacturer, colour = Manufacturer == "Others"), size = book_text_size, show.legend = FALSE
  ) +
  scale_colour_manual(values = c("TRUE" = lws_colors[["ink"]], "FALSE" = "white")) +
  scale_fill_manual(values = manufacturer_colors, breaks = c("TSMC", "Samsung", "Intel", "SMIC", "Others")) +
  scale_y_continuous(labels = label_percent(scale = 1), breaks = seq(0, 100, 25), expand = c(0, 0)) +
  labs(x = "Technology node (more advanced at left)", y = "Share of foundry revenue",
       ) +
  book_source("Sources: TechInsights; Semiconductor Industry Association; Gartner. Intel is foundry services only; SMIC is limited by U.S. export controls.") +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank())

save_econ_figure(
  filename = here::here("figures", "fig_02_02_tsmc_dominance.png"),
  plot = combined_plot, width = 6, height = 3.8
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
