# Figure 2.5: Friendshoring Investment Flows Map
# Chapter 2: Supply Chains and Critical Infrastructure
# Shows reshoring and friendshoring investment patterns

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Reshoring investment data
reshoring <- data.frame(
  country = c(
    "United States", "Mexico", "India", "Vietnam", "Indonesia",
    "Poland", "Germany", "Japan", "South Korea", "Taiwan",
    "Thailand", "Malaysia", "Philippines", "Morocco", "Brazil"
  ),
  investment_billions = c(
    280, 45, 35, 28, 22,
    18, 42, 38, 32, 25,
    15, 20, 12, 8, 15
  ),
  investment_type = c(
    "Domestic Reshoring", "Nearshoring", "Friendshoring", "Friendshoring", "Friendshoring",
    "Nearshoring", "Domestic Reshoring", "Domestic Reshoring", "Domestic Reshoring", "Critical Partner",
    "Friendshoring", "Friendshoring", "Friendshoring", "Nearshoring", "Nearshoring"
  ),
  sector_focus = c(
    "Semiconductors, EVs", "Manufacturing", "Electronics", "Electronics", "Nickel, Manufacturing",
    "Manufacturing", "Semiconductors", "Semiconductors", "Semiconductors, Batteries", "Semiconductors",
    "Electronics", "Semiconductors", "Electronics", "EVs", "EVs, Mining"
  )
)

# Get world map
world <- ne_countries(scale = "medium", returnclass = "sf")

# Merge data
world_reshoring <- world %>%
  left_join(reshoring, by = c("name" = "country"))

# Investment type colors
type_colors <- c(
  "Domestic Reshoring" = "#1f77b4",
  "Nearshoring" = "#2ca02c",
  "Friendshoring" = "#ff7f0e",
  "Critical Partner" = "#9467bd"
)

# Create map
p1 <- ggplot(world_reshoring) +
  geom_sf(aes(fill = investment_type), color = "white", linewidth = 0.2) +
  scale_fill_manual(
    values = type_colors,
    name = "Investment Type",
    na.value = "#e8e8e8"
  ) +
  coord_sf(crs = "+proj=robin") +
  labs(
    title = "Global Reshoring and Friendshoring Investment (2022-2024)",
    subtitle = "Announced manufacturing investments by type"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "bottom"
  )

# Bar chart of investment amounts
reshoring_sorted <- reshoring %>%
  mutate(country = fct_reorder(country, investment_billions))

p2 <- ggplot(reshoring_sorted, aes(x = country, y = investment_billions, fill = investment_type)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0("$", investment_billions, "B")), hjust = -0.1, size = 3) +
  coord_flip() +
  scale_fill_manual(values = type_colors, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Announced Supply Chain Investments by Country",
    x = NULL,
    y = "Investment (USD Billions)",
    caption = "Source: Reshoring Initiative, PIIE, company announcements (2022-2024)\nNote: Includes semiconductors, EV batteries, critical minerals, and advanced manufacturing"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Combine
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1.2, 1))

# Save the figure
save_econ_figure("figures/fig_02_05_reshoring_map.png", plot = combined, width = 12, height = 13)

cat("Figure 2.5 created: Reshoring Map\n")
