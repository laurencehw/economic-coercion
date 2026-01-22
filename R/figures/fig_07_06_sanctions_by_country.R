# Figure 7.6: US Sanctions Programs by Target Country
# Chapter 7: Financial Statecraft
# Stacked bar showing evolution of sanctions regimes

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# Sanctions designations by country over time
sanctions_data <- data.frame(
  year = rep(c(2010, 2015, 2020, 2024), each = 8),
  country = rep(c("Russia", "Iran", "North Korea", "Syria", "Venezuela",
                  "China", "Cuba", "Other"), 4),
  designations = c(
    # 2010
    20, 450, 180, 50, 10, 5, 150, 200,
    # 2015
    150, 680, 220, 250, 50, 20, 180, 350,
    # 2020
    450, 1200, 320, 350, 180, 280, 200, 580,
    # 2024
    2800, 1350, 380, 420, 220, 450, 210, 720
  )
)

# Calculate totals for annotation
totals <- sanctions_data %>%
  group_by(year) %>%
  summarise(total = sum(designations), .groups = "drop")

# Country colors
country_colors <- c(
  "Russia" = "#d62728",
  "Iran" = "#ff7f0e",
  "North Korea" = "#9467bd",
  "Syria" = "#8c564b",
  "Venezuela" = "#e377c2",
  "China" = "#1f77b4",
  "Cuba" = "#bcbd22",
  "Other" = "#c7c7c7"
)

# Order countries by 2024 values for stacking
country_order <- sanctions_data %>%
  filter(year == 2024) %>%
  arrange(desc(designations)) %>%
  pull(country)

sanctions_data$country <- factor(sanctions_data$country, levels = rev(country_order))

# Create stacked bar chart
p1 <- ggplot(sanctions_data, aes(x = factor(year), y = designations, fill = country)) +
  geom_col(width = 0.7, color = "white", linewidth = 0.3) +
  geom_text(data = totals, aes(x = factor(year), y = total, label = paste0(format(total, big.mark = ","), "\ntotal")),
            inherit.aes = FALSE, vjust = -0.3, size = 3.5, fontface = "bold") +
  scale_fill_manual(values = country_colors, name = "Target Country") +
  scale_y_continuous(labels = scales::comma, expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Growth of US Sanctions Designations by Target",
    subtitle = "Number of entities and individuals under OFAC sanctions programs",
    x = "Year",
    y = "Number of Designations"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.x = element_blank(),
    legend.position = "right"
  )

# Russia detail - post-2022 surge
russia_detail <- data.frame(
  year = 2019:2024,
  individuals = c(220, 280, 350, 1200, 1800, 2100),
  entities = c(180, 220, 280, 900, 1400, 1650),
  vessels = c(10, 15, 20, 150, 350, 450)
) %>%
  pivot_longer(cols = -year, names_to = "type", values_to = "count")

p2 <- ggplot(russia_detail, aes(x = year, y = count, fill = type)) +
  geom_area(alpha = 0.8, color = "white", linewidth = 0.3) +
  geom_vline(xintercept = 2022, linetype = "dashed", color = "gray40") +
  annotate("text", x = 2022.1, y = 3800, label = "Ukraine\nInvasion",
           hjust = 0, size = 3.5, color = "gray40") +
  scale_fill_manual(
    values = c("individuals" = "#d62728", "entities" = "#ff7f0e", "vessels" = "#1f77b4"),
    labels = c("Individuals", "Entities", "Vessels"),
    name = "Type"
  ) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Russia Sanctions Surge (2019-2024)",
    subtitle = "Unprecedented expansion following 2022 invasion of Ukraine",
    x = "Year",
    y = "Cumulative Designations",
    caption = "Source: OFAC SDN List, OpenSanctions database"
  ) +
  theme_econ_textbook()

# Combine
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1.2, 1))

# Save the figure
save_econ_figure(here::here("figures", "fig_07_06_sanctions_by_country.png"), plot = combined, width = 12, height = 11)

cat("Figure 7.6 created: Sanctions by Country\n")
