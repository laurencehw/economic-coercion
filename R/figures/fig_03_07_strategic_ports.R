# Figure 3.6b: Strategic Ports and Maritime Trade Routes
# Purpose: Visualize key global ports and trade corridors
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggrepel)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE GEOGRAPHIC DATA
# ============================================================================

# Load world map
world <- ne_countries(scale = "medium", returnclass = "sf")

# Define major strategic ports
strategic_ports <- tibble(
  Name = c(
    # Top Global Container Ports
    "Shanghai", "Singapore", "Shenzhen", "Ningbo-Zhoushan", "Busan",
    "Hong Kong", "Guangzhou", "Qingdao", "Rotterdam", "Antwerp",
    # Major US Ports
    "Los Angeles", "Long Beach", "New York/NJ", "Savannah", "Houston",
    # Strategic Military/Dual-Use
    "Djibouti", "Gwadar", "Hambantota", "Piraeus", "Haifa",
    # Key Energy Ports
    "Ras Tanura", "Fujairah", "Jamnagar", "Port Hedland", "Durban"
  ),
  Lat = c(
    31.23, 1.35, 22.54, 29.87, 35.18,
    22.3, 23.13, 36.07, 51.92, 51.22,
    33.74, 33.77, 40.67, 32.08, 29.76,
    11.59, 25.12, 6.12, 37.94, 32.82,
    26.65, 25.12, 22.47, -20.31, -29.87
  ),
  Lon = c(
    121.47, 103.82, 114.07, 121.55, 129.04,
    114.17, 113.26, 120.38, 4.48, 4.42,
    -118.24, -118.19, -74.04, -81.09, -95.36,
    43.15, 62.33, 81.12, 23.65, 34.99,
    50.15, 56.35, 70.07, 118.58, 31.03
  ),
  Type = c(
    "Container", "Container", "Container", "Container", "Container",
    "Container", "Container", "Container", "Container", "Container",
    "Container", "Container", "Container", "Container", "Container",
    "Strategic", "Strategic", "Strategic", "Strategic", "Strategic",
    "Energy", "Energy", "Energy", "Bulk", "Bulk"
  ),
  Volume_TEU = c(
    47.0, 38.0, 29.0, 33.0, 23.0,
    17.0, 24.0, 25.0, 15.0, 12.0,
    10.0, 9.0, 8.0, 6.0, 4.0,
    1.0, 0.5, 0.3, 6.0, 2.0,
    NA, NA, NA, NA, NA
  ),
  Owner_Influence = c(
    "China", "Singapore", "China", "China", "South Korea",
    "China", "China", "China", "Netherlands", "Belgium",
    "USA", "USA", "USA", "USA", "USA",
    "China", "Pakistan/China", "Sri Lanka/China", "China", "Israel",
    "Saudi Arabia", "UAE", "India", "Australia", "South Africa"
  )
)

# Define major shipping lanes
shipping_lanes <- tibble(
  Route = c(
    "Asia-Europe", "Trans-Pacific", "Asia-Middle East",
    "Suez Route", "Panama Route", "Cape Route"
  ),
  Start_Lon = c(121, 121, 121, 32.5, -80, 114),
  Start_Lat = c(31, 31, 31, 31, 9, 22),
  End_Lon = c(4.5, -118, 50, 4.5, -118, 18),
  End_Lat = c(52, 34, 27, 52, 34, -34),
  Traffic = c("Very High", "Very High", "High", "High", "Medium", "Medium")
)

# ============================================================================
# 2. CREATE VISUALIZATION
# ============================================================================

p <- ggplot(data = world) +
  # Base map
  geom_sf(fill = "#e8e8e8", color = "white", linewidth = 0.2) +

  # Shipping lanes (simplified)
  geom_curve(data = shipping_lanes,
             aes(x = Start_Lon, y = Start_Lat, xend = End_Lon, yend = End_Lat,
                 color = Traffic),
             curvature = 0.2, linewidth = 1.5, alpha = 0.5,
             arrow = arrow(length = unit(0.2, "cm"), type = "closed")) +

  # Port points
  geom_point(data = strategic_ports,
             aes(x = Lon, y = Lat, fill = Type,
                 size = ifelse(is.na(Volume_TEU), 5, Volume_TEU)),
             shape = 21, color = "black", stroke = 0.5, alpha = 0.85) +

  # Chinese-influenced ports highlighted
  geom_point(data = strategic_ports %>% filter(Owner_Influence == "China"),
             aes(x = Lon, y = Lat),
             shape = 1, size = 8, color = "#d62728", stroke = 1.5) +

  # Port labels for top ports
  geom_label_repel(
    data = strategic_ports %>%
      filter(Type == "Container" & (Volume_TEU > 20 | Name %in% c("Rotterdam", "Los Angeles"))),
    aes(x = Lon, y = Lat, label = paste0(Name, "\n", round(Volume_TEU), "M TEU")),
    size = 2.5, fontface = "bold",
    box.padding = 0.5, point.padding = 0.3,
    segment.color = "gray50", min.segment.length = 0,
    fill = "white", alpha = 0.9, lineheight = 0.85
  ) +

  # Strategic port labels
  geom_label_repel(
    data = strategic_ports %>% filter(Type == "Strategic"),
    aes(x = Lon, y = Lat, label = Name),
    size = 2.3, fontface = "bold", color = "#9467bd",
    box.padding = 0.4, point.padding = 0.3,
    segment.color = "#9467bd", min.segment.length = 0,
    fill = "white", alpha = 0.9
  ) +

  # Scales
  scale_fill_manual(
    values = c("Container" = "#1f77b4", "Strategic" = "#9467bd",
               "Energy" = "#ff7f0e", "Bulk" = "#2ca02c"),
    name = "Port Type"
  ) +
  scale_color_manual(
    values = c("Very High" = "#d62728", "High" = "#ff7f0e", "Medium" = "#2ca02c"),
    name = "Shipping Traffic"
  ) +
  scale_size_continuous(
    range = c(3, 12),
    name = "Volume (M TEU)",
    breaks = c(10, 20, 30, 40)
  ) +

  # Map settings
  coord_sf(xlim = c(-130, 145), ylim = c(-45, 65), expand = FALSE) +

  # Labels
  labs(
    title = "Strategic Ports and Maritime Trade Routes",
    subtitle = "Key global ports by type and volume; Chinese-influenced ports circled in red",
    caption = paste0(
      "Sources: Lloyd's List Top 100 Ports 2024, UNCTAD Review of Maritime Transport.\n",
      "TEU = Twenty-foot Equivalent Units (container measure). ",
      "Red circles indicate significant Chinese ownership or operational control."
    ),
    x = NULL, y = NULL
  ) +

  # Theme
  theme_econ_textbook() +
  theme(
    panel.background = element_rect(fill = "#c9e4f3"),
    panel.grid.major = element_line(color = "white", linewidth = 0.3),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "bottom",
    legend.box = "horizontal"
  ) +
  guides(
    fill = guide_legend(order = 1, nrow = 1, override.aes = list(size = 5)),
    color = guide_legend(order = 2, nrow = 1),
    size = guide_legend(order = 3, nrow = 1)
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_03_07_strategic_ports.png"), p, width = 14, height = 8)

cat("\nFigure 3.7 Strategic Ports map created successfully!\n")
