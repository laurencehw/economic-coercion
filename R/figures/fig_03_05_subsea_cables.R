# Figure 3.5: Global Subsea Cable Infrastructure
# Purpose: Visualize critical undersea telecommunications cables
# Author: Laurence Wilse-Samson
# Framework: tmap

library(here)
library(tidyverse)
library(sf)
library(tmap)
library(rnaturalearth)
library(rnaturalearthdata)

# ============================================================================
# 1. PREPARE GEOGRAPHIC DATA
# ============================================================================

# Load world map
world <- ne_countries(scale = "medium", returnclass = "sf")

# Define major subsea cable landing points
cable_hubs <- tibble(
  name = c(
    # Major Atlantic Hubs
    "New York", "Virginia Beach", "Miami", "London", "Marseille",
    # Pacific Hubs
    "Los Angeles", "Tokyo", "Hong Kong", "Singapore", "Sydney",
    # Strategic Points
    "Djibouti", "Mumbai", "Fortaleza",
    # Other key points
    "Cape Town", "Dubai"
  ),
  lat = c(
    40.7, 36.85, 25.76, 51.5, 43.3,
    33.9, 35.68, 22.3, 1.35, -33.87,
    11.59, 19.07, -3.73,
    -33.92, 25.2
  ),
  lon = c(
    -74.0, -75.98, -80.19, -0.12, 5.37,
    -118.24, 139.75, 114.17, 103.82, 151.21,
    43.15, 72.88, -38.52,
    18.42, 55.27
  ),
  importance = c(
    "Critical", "Critical", "Critical", "Critical", "Critical",
    "Critical", "Critical", "Critical", "Critical", "Critical",
    "Strategic", "Critical", "Major",
    "Major", "Major"
  ),
  cables = c(
    15, 12, 10, 20, 12,
    14, 18, 15, 20, 12,
    8, 10, 6,
    5, 8
  )
)

# Create sf object for cable hubs
cable_hubs_sf <- st_as_sf(cable_hubs, coords = c("lon", "lat"), crs = 4326)

# Define major cable routes as line data
cable_routes <- tribble(
  ~route_name, ~start_lon, ~start_lat, ~end_lon, ~end_lat, ~capacity,
  "Trans-Atlantic (North)", -74, 40.7, -0.12, 51.5, "High",
  "Trans-Atlantic (South)", -38.52, -3.73, 5.37, 43.3, "High",
  "Trans-Pacific (North)", -118.24, 33.9, 139.75, 35.68, "High",
  "Trans-Pacific (South)", -118.24, 33.9, 151.21, -33.87, "Medium",
  "Asia-Europe via Suez", 103.82, 1.35, 43.15, 11.59, "High",
  "Africa Coastal", -0.12, 51.5, 18.42, -33.92, "Medium",
  "Asia-Pacific Backbone", 114.17, 22.3, 103.82, 1.35, "High",
  "India-SE Asia", 72.88, 19.07, 103.82, 1.35, "High"
)

# Create lines from route coordinates
cable_lines <- cable_routes %>%
  rowwise() %>%
  mutate(
    geometry = st_sfc(st_linestring(matrix(c(start_lon, end_lon, start_lat, end_lat), ncol = 2)), crs = 4326)
  ) %>%
  ungroup() %>%
  st_as_sf()

# ============================================================================
# 2. CREATE TMAP VISUALIZATION
# ============================================================================

tmap_mode("plot")

# Color palettes
hub_colors <- c("Critical" = "#d62728", "Strategic" = "#ff7f0e", "Major" = "#2ca02c")
capacity_colors <- c("High" = "#1f77b4", "Medium" = "#9467bd")

# Create the map
map <- tm_shape(world, bbox = c(-140, -55, 165, 70)) +
  tm_polygons(
    fill = "#d4d4d4",
    col = "white",
    lwd = 0.2
  ) +

  # Cable routes
  tm_shape(cable_lines) +
  tm_lines(
    col = "capacity",
    col.scale = tm_scale_categorical(values = capacity_colors),
    col.legend = tm_legend(title = "Cable Capacity"),
    lwd = 2,
    lty = "solid"
  ) +

  # Cable hubs
  tm_shape(cable_hubs_sf) +
  tm_symbols(
    size = "cables",
    size.scale = tm_scale_continuous(values.scale = 0.4),
    size.legend = tm_legend(title = "Number of\nCables"),
    fill = "importance",
    fill.scale = tm_scale_categorical(values = hub_colors),
    fill.legend = tm_legend(title = "Hub\nImportance"),
    col = "black",
    shape = 21,
    lwd = 0.5
  ) +

  # Labels for critical hubs only
  tm_shape(cable_hubs_sf %>% filter(importance == "Critical")) +
  tm_text(
    text = "name",
    size = 0.55,
    col = "black",
    fontface = "bold",
    ymod = 1.2,
    bg.color = "white",
    bg.alpha = 0.7
  ) +

  # Cartographic elements
  tm_scalebar(
    position = c("left", "bottom"),
    text.size = 0.5,
    breaks = c(0, 3000, 6000)
  ) +

  tm_compass(
    position = c("right", "top"),
    size = 1.2
  ) +

  # Layout
  tm_title("Global Subsea Cable Infrastructure") +

  tm_layout(
    main.title.size = 1.2,
    main.title.fontface = "bold",
    bg.color = "#b8d4e8",
    frame = TRUE,
    frame.lwd = 1,
    legend.outside = TRUE,
    legend.outside.position = "right",
    legend.frame = FALSE,
    legend.bg.color = "white",
    legend.bg.alpha = 0.8,
    attr.outside = TRUE
  ) +

  tm_credits(
    "Source: TeleGeography Submarine Cable Map 2024\nNote: >95% of intercontinental data travels via subsea cables",
    position = c("left", "bottom"),
    size = 0.5
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

tmap_save(
  map,
  filename = here("figures", "fig_03_05_subsea_cables.png"),
  width = 14,
  height = 8,
  dpi = 300
)

tmap_save(
  map,
  filename = here("figures", "fig_03_05_subsea_cables.pdf"),
  width = 14,
  height = 8
)

cat("\nFigure 3.5: Subsea Cables map created successfully!\n")
