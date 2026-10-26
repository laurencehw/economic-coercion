# Figure 3.4: Renewable Energy Manufacturing - China's Dominance
# Author: Laurence Wilse-Samson
# Description: China's overwhelming share of clean energy technology production

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

renewables_data <- read_csv(here::here("data", "sources", "renewable_energy_manufacturing.csv"))

# Clean technology names for display
renewables_data <- renewables_data %>%
  mutate(
    Technology_Label = case_when(
      Technology == "Solar_Panels" ~ "Solar Panels",
      Technology == "Wind_Turbines" ~ "Wind Turbines",
      Technology == "EV_Batteries" ~ "EV Batteries",
      Technology == "Solar_Polysilicon" ~ "Solar Polysilicon",
      Technology == "Lithium_Refining" ~ "Lithium Refining",
      Technology == "Rare_Earth_Magnets" ~ "Rare Earth Magnets",
      Technology == "Inverters" ~ "Inverters",
      TRUE ~ Technology
    )
  )

# Prepare long format for plotting
renewables_long <- renewables_data %>%
  mutate(
    Technology_Label = fct_reorder(Technology_Label, China)
  ) %>%
  pivot_longer(
    cols = c(China, Europe, USA, Rest_of_Asia, Others),
    names_to = "Region",
    values_to = "Share"
  ) %>%
  mutate(
    Region = factor(Region, levels = c("China", "Europe", "USA", "Rest_of_Asia", "Others"))
  )

# ============================================================================
# Region colours (China is the highlight; other regions in house hues and grey)
# ============================================================================

region_colors <- c(
  "China" = lws_colors[["red"]],
  "Europe" = lws_colors[["green"]],
  "USA" = lws_colors[["blue"]],
  "Rest of Asia" = lws_colors[["gold"]],
  "Others" = lws_colors[["fade"]]
)

# One panel: stacked horizontal bars, sorted by China's share. (The ranked-share,
# China-versus-rest and dependency-summary panels of the earlier dashboard restated this one.)
renewables_long <- renewables_long %>%
  mutate(Region = fct_recode(Region, "Rest of Asia" = "Rest_of_Asia"),
         Region = fct_relevel(Region, "China", "Europe", "USA", "Rest of Asia", "Others"),
         Region = fct_rev(Region))

combined_plot <- ggplot(renewables_long, aes(x = Share, y = Technology_Label, fill = Region)) +
  geom_col(width = 0.7) +
  geom_text(data = renewables_long %>% arrange(Technology_Label, Region) %>% group_by(Technology_Label) %>%
              mutate(mid = 100 - (cumsum(Share) - Share / 2)) %>% ungroup() %>% filter(Share >= 8),
            aes(x = mid, label = paste0(Share, "%")), colour = "white", size = book_text_size) +
  scale_fill_manual(values = region_colors, breaks = c("China", "Europe", "USA", "Rest of Asia", "Others")) +
  scale_x_continuous(labels = label_percent(scale = 1), breaks = seq(0, 100, 25), expand = c(0, 0)) +
  labs(x = "Share of global manufacturing", y = NULL) +
  book_source("Sources: International Energy Agency; BloombergNEF; industry reports. Shares are of manufacturing capacity and production volume, 2023-2024.") +
  theme_book_h()

# ============================================================================
# SAVE
# ============================================================================

save_econ_figure(
  filename = here::here("figures", "fig_03_04_renewable_manufacturing.png"),
  plot = combined_plot, width = 6, height = 3.6
)

cat("\n")
cat("========================================\n")
cat("Figure 3.4 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_03_04_renewable_manufacturing.png\n")
cat("          figures/fig_03_04_renewable_manufacturing.pdf\n")
cat("\n")
cat("China's Manufacturing Dominance:\n")
cat("--------------------------------\n")
for (i in 1:nrow(renewables_data)) {
  tech <- renewables_data$Technology_Label[i]
  share <- renewables_data$China[i]
  cat(sprintf("  %s: %d%%\n", tech, share))
}
cat("\n")
cat("Summary Statistics:\n")
cat(sprintf("  Average China share: %.0f%%\n", mean(renewables_data$China)))
cat(sprintf("  Highest: Rare Earth Magnets (%d%%)\n", max(renewables_data$China)))
cat(sprintf("  Lowest: Lithium Refining (%d%%)\n", min(renewables_data$China)))
cat("\n")
cat("Strategic Assessment:\n")
cat("  - 4 of 7 technologies: Critical dependency (≥80%)\n")
cat("  - 3 of 7 technologies: High dependency (60-79%)\n")
cat("  - China controls >60% in ALL clean energy technologies\n")
cat("  - Average 73% share creates systemic supply chain risk\n")
cat("========================================\n")
cat("\n")
