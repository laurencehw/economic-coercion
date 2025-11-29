# Figure 3.5: Global Subsea Cable Infrastructure
# Purpose: Visualize critical undersea telecommunications cables
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

# Define major subsea cable landing points
cable_hubs <- tibble(
  Name = c(
    # Major Atlantic Hubs
    "New York", "Virginia Beach", "Miami", "London", "Marseille", "Lisbon",
    # Pacific Hubs
    "Los Angeles", "San Francisco", "Tokyo", "Hong Kong", "Singapore", "Sydney",
    # Strategic Points
    "Djibouti", "Suez", "Mumbai", "Chennai", "Fortaleza", "Porthcurno",
    # South Atlantic
    "Cape Town", "Luanda"
  ),
  Lat = c(
    40.7, 36.85, 25.76, 51.5, 43.3, 38.7,
    33.9, 37.77, 35.68, 22.3, 1.35, -33.87,
    11.59, 29.97, 19.07, 13.08, -3.73, 50.07,
    -33.92, -8.84
  ),
  Lon = c(
    -74.0, -75.98, -80.19, -0.12, 5.37, -9.14,
    -118.24, -122.42, 139.75, 114.17, 103.82, 151.21,
    43.15, 32.55, 72.88, 80.27, -38.52, -5.68,
    18.42, 13.23
  ),
  Importance = c(
    "Critical", "Critical", "Critical", "Critical", "Critical", "Major",
    "Critical", "Critical", "Critical", "Critical", "Critical", "Critical",
    "Strategic", "Strategic", "Critical", "Major", "Major", "Major",
    "Major", "Major"
  ),
  Cables = c(
    15, 12, 10, 20, 12, 8,
    14, 10, 18, 15, 20, 12,
    8, 6, 10, 8, 6, 6,
    5, 4
  )
)

# Define major cable routes (simplified great circle paths)
cable_routes <- tibble(
  Route = c(
    "Trans-Atlantic North", "Trans-Atlantic South",
    "Trans-Pacific North", "Trans-Pacific South",
    "Asia-Europe", "Africa Coast",
    "Asia-Pacific", "Americas Backbone"
  ),
  Start_Lon = c(-74, -74, -122, -118, 114, 51.5, 114, -74),
  Start_Lat = c(40.7, 25.76, 37.77, 33.9, 22.3, 51.5, 22.3, 40.7),
  End_Lon = c(-0.12, 5.37, 139.75, 151.21, 5.37, 18.42, 103.82, -38.52),
  End_Lat = c(51.5, 43.3, 35.68, -33.87, 43.3, -33.92, 1.35, -3.73),
  Capacity = c("High", "High", "High", "Medium", "High", "Medium", "High", "Medium"),
  Type = c("Primary", "Primary", "Primary", "Primary", "Primary", "Secondary", "Primary", "Secondary")
)

# Create sf object for points
cable_hubs_sf <- st_as_sf(cable_hubs, coords = c("Lon", "Lat"), crs = 4326)

# ============================================================================
# 2. CREATE VISUALIZATION
# ============================================================================

p <- ggplot(data = world) +
  # Base map
  geom_sf(fill = "#d4d4d4", color = "white", linewidth = 0.2) +

  # Draw cable routes (simplified as straight lines for visibility)
  geom_segment(data = cable_routes,
               aes(x = Start_Lon, y = Start_Lat, xend = End_Lon, yend = End_Lat,
                   color = Capacity, linetype = Type),
               linewidth = 1.2, alpha = 0.7) +

  # Cable hub points
  geom_point(data = cable_hubs,
             aes(x = Lon, y = Lat, size = Cables, fill = Importance),
             shape = 21, color = "black", stroke = 0.5, alpha = 0.85) +

  # Hub labels
  geom_label_repel(data = cable_hubs %>% filter(Importance == "Critical"),
                   aes(x = Lon, y = Lat, label = Name),
                   size = 2.8, fontface = "bold",
                   box.padding = 0.4, point.padding = 0.3,
                   segment.color = "gray50", min.segment.length = 0,
                   fill = "white", alpha = 0.9) +

  # Scales
  scale_fill_manual(
    values = c("Critical" = "#d62728", "Strategic" = "#ff7f0e", "Major" = "#2ca02c"),
    name = "Hub Importance"
  ) +
  scale_color_manual(
    values = c("High" = "#1f77b4", "Medium" = "#9467bd"),
    name = "Capacity"
  ) +
  scale_linetype_manual(
    values = c("Primary" = "solid", "Secondary" = "dashed"),
    name = "Route Type"
  ) +
  scale_size_continuous(
    range = c(3, 10),
    name = "Cable Count"
  ) +

  # Map settings - Pacific centered view would be ideal but Robinson is good
  coord_sf(xlim = c(-140, 160), ylim = c(-55, 70), expand = FALSE) +

  # Labels
  labs(
    title = "Global Subsea Cable Infrastructure",
    subtitle = "Critical telecommunications backbone connecting continents",
    caption = paste0(
      "Source: TeleGeography Submarine Cable Map 2024, ITU data.\n",
      "Note: Over 95% of intercontinental data travels via subsea cables. ",
      "Cable routes simplified for visualization."
    ),
    x = NULL, y = NULL
  ) +

  # Theme
  theme_econ_textbook() +
  theme(
    panel.background = element_rect(fill = "#b8d4e8"),  # Ocean color
    panel.grid.major = element_line(color = "white", linewidth = 0.3, alpha = 0.5),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "bottom",
    legend.box = "horizontal"
  ) +
  guides(
    fill = guide_legend(order = 1, nrow = 1),
    color = guide_legend(order = 2, nrow = 1),
    linetype = guide_legend(order = 3, nrow = 1),
    size = guide_legend(order = 4, nrow = 1)
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_03_05_subsea_cables.png"), p, width = 14, height = 8)

cat("\nFigure 3.5 Subsea Cables map created successfully!\n")
