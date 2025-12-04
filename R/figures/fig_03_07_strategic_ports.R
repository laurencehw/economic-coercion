# Figure 3.7: Strategic Ports and Maritime Trade Routes
# Purpose: Visualize key global ports and Chinese port investments
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

world <- ne_countries(scale = "medium", returnclass = "sf")

# Define major strategic ports
strategic_ports <- tibble(
  name = c(
    # Top Global Container Ports
    "Shanghai", "Singapore", "Shenzhen", "Ningbo", "Busan",
    "Hong Kong", "Guangzhou", "Qingdao", "Rotterdam", "Antwerp",
    # Major US Ports
    "Los Angeles", "Long Beach", "New York", "Savannah",
    # Strategic/Chinese-invested ports
    "Piraeus", "Gwadar", "Hambantota", "Djibouti", "Darwin",
    # Key Energy Ports
    "Ras Tanura", "Fujairah", "Port Hedland"
  ),
  lat = c(
    31.23, 1.35, 22.54, 29.87, 35.18,
    22.3, 23.13, 36.07, 51.92, 51.22,
    33.74, 33.77, 40.67, 32.08,
    37.94, 25.12, 6.12, 11.59, -12.46,
    26.65, 25.12, -20.31
  ),
  lon = c(
    121.47, 103.82, 114.07, 121.55, 129.04,
    114.17, 113.26, 120.38, 4.48, 4.42,
    -118.24, -118.19, -74.04, -81.09,
    23.65, 62.33, 81.12, 43.15, 130.84,
    50.15, 56.35, 118.58
  ),
  type = c(
    "Container", "Container", "Container", "Container", "Container",
    "Container", "Container", "Container", "Container", "Container",
    "Container", "Container", "Container", "Container",
    "Strategic", "Strategic", "Strategic", "Strategic", "Strategic",
    "Energy", "Energy", "Bulk"
  ),
  volume_teu = c(
    47, 38, 29, 33, 23,
    17, 24, 25, 15, 12,
    10, 9, 8, 6,
    6, 0.5, 0.3, 1, 0.2,
    NA, NA, NA
  ),
  chinese_investment = c(
    TRUE, FALSE, TRUE, TRUE, FALSE,
    TRUE, TRUE, TRUE, FALSE, FALSE,
    FALSE, FALSE, FALSE, FALSE,
    TRUE, TRUE, TRUE, TRUE, TRUE,
    FALSE, FALSE, FALSE
  )
)

# Create sf object
ports_sf <- st_as_sf(strategic_ports, coords = c("lon", "lat"), crs = 4326)

# ============================================================================
# 2. CREATE TMAP VISUALIZATION
# ============================================================================

tmap_mode("plot")

# Color palettes
type_colors <- c(
  "Container" = "#1f77b4",
  "Strategic" = "#9467bd",
  "Energy" = "#ff7f0e",
  "Bulk" = "#2ca02c"
)

# Create the map
map <- tm_shape(world, bbox = c(-130, -45, 150, 65)) +
  tm_polygons(
    fill = "#e8e8e8",
    col = "white",
    lwd = 0.2
  ) +

  # All ports (base layer)
  tm_shape(ports_sf) +
  tm_symbols(
    size = "volume_teu",
    size.scale = tm_scale_continuous(values.scale = 0.25, ticks = c(10, 25, 40)),
    size.legend = tm_legend(title = "Container Volume\n(million TEU)"),
    fill = "type",
    fill.scale = tm_scale_categorical(values = type_colors),
    fill.legend = tm_legend(title = "Port Type"),
    col = "black",
    shape = 21,
    lwd = 0.5
  ) +

  # Highlight Chinese-invested ports with ring
  tm_shape(ports_sf %>% filter(chinese_investment == TRUE)) +
  tm_symbols(
    size = 1.2,
    fill = NA,
    col = "#d62728",
    shape = 1,
    lwd = 2
  ) +

  # Labels for major ports
  tm_shape(ports_sf %>% filter(volume_teu > 20 | type == "Strategic")) +
  tm_text(
    text = "name",
    size = 0.5,
    col = "black",
    fontface = "bold",
    ymod = 1.3,
    bg.color = "white",
    bg.alpha = 0.7
  ) +

  # Cartographic elements
  tm_scalebar(
    position = c("left", "bottom"),
    text.size = 0.5,
    breaks = c(0, 2500, 5000)
  ) +

  tm_compass(
    position = c("right", "top"),
    size = 1.2
  ) +

  # Layout
  tm_title("Strategic Ports and Chinese Maritime Investment") +

  tm_layout(
    main.title.size = 1.1,
    main.title.fontface = "bold",
    bg.color = "#c9e4f3",
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
    "Source: Lloyd's List Top 100 Ports 2024, UNCTAD\nRed circles: Significant Chinese ownership/investment",
    position = c("left", "bottom"),
    size = 0.5
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

tmap_save(
  map,
  filename = here("figures", "fig_03_07_strategic_ports.png"),
  width = 14,
  height = 8,
  dpi = 300
)

tmap_save(
  map,
  filename = here("figures", "fig_03_07_strategic_ports.pdf"),
  width = 14,
  height = 8
)

cat("\nFigure 3.7: Strategic Ports map created successfully!\n")
