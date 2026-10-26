# Figure 10.3: Critical Mineral Processing Concentration
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
    60, 0, 5, 25, 10,
    # Cobalt processing (refining)
    80, 3, 0, 0, 17,
    # Rare Earths processing
    90, 0, 0, 0, 10,
    # Graphite processing
    80, 0, 0, 0, 20,
    # Nickel processing
    65, 0, 5, 0, 30
  ),
  Mining_Share = c(
    # Lithium mining
    13, 0, 47, 30, 10,
    # Cobalt mining
    3, 70, 3, 0, 24,
    # Rare Earths mining
    70, 0, 8, 0, 22,
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
mineral_order <- c("Rare Earths", "Graphite", "Cobalt", "Lithium", "Nickel")
share_cols <- c("China" = lws_colors[["red"]], "DRC" = "#4D4D4D", "Australia" = "#7A7A7A", "Chile" = "#A8A8A8", "Others" = "#D4D4D4")

stage_long <- minerals_data %>%
  pivot_longer(c(Processing_Share, Mining_Share), names_to = "Stage", values_to = "Share") %>%
  mutate(Stage = ifelse(Stage == "Processing_Share", "A. Processing (refining)", "B. Mining"),
         Mineral = factor(Mineral, levels = rev(mineral_order)),
         Country = factor(Country, levels = rev(c("China", "DRC", "Australia", "Chile", "Others"))))

p <- ggplot(stage_long, aes(x = Mineral, y = Share, fill = Country)) +
  geom_col(width = 0.7, colour = "white", linewidth = 0.2) +
  geom_text(data = stage_long %>% filter(Country == "China", Share >= 10), aes(label = paste0(Share, "%")),
            position = position_stack(vjust = 0.5), colour = "white", size = book_text_size, fontface = "bold") +
  coord_flip() +
  facet_wrap(~Stage) +
  scale_fill_manual(values = share_cols, breaks = c("China", "DRC", "Australia", "Chile", "Others"), name = NULL) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), breaks = seq(0, 100, 25), expand = c(0, 0)) +
  labs(x = NULL, y = "Share of global total (%)") +
  book_source("Source: IEA Critical Minerals Report 2023, USGS and Benchmark Mineral Intelligence. Processing is refining and chemical processing of mined ores; rare-earth processing includes separation and oxide production. 'Others' includes Indonesia, the dominant nickel miner. Shares are as compiled for the book.") +
  theme_book_h() +
  theme(legend.position = "top", legend.justification = "left", strip.text = element_text(face = "bold", hjust = 0, colour = lws_colors[["ink"]]), panel.spacing.x = unit(1.2, "lines"))

save_econ_figure(here("figures", "fig_10_03_critical_minerals.png"), p, width = 6, height = 4.2)

cat("\nFigure 10.3 Summary:\n")
cat(sprintf("  Average China processing share: %.0f%%\n", china_processing))
