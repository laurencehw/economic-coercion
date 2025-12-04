# Figure 8.1: Belt and Road Initiative Infrastructure
# Purpose: Visualize key BRI infrastructure investments globally
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

# Define key BRI infrastructure projects
bri_projects <- tibble(
  name = c(
    # Major Ports
    "Piraeus", "Gwadar", "Hambantota", "Djibouti", "Colombo",
    "Mombasa", "Dar es Salaam", "Tema", "Walvis Bay",
    # Rail Projects
    "China-Europe Rail (Duisburg)", "Kenya SGR (Nairobi)",
    "China-Laos Rail", "Jakarta-Bandung HSR",
    # Energy/Industrial
    "CPEC (Islamabad)", "Kyaukpyu (Myanmar)",
    # Strategic Locations
    "Port Sudan", "Sihanoukville", "Chittagong"
  ),
  lat = c(
    37.94, 25.12, 6.12, 11.59, 6.93,
    -4.04, -6.82, 5.63, -22.96,
    51.43, -1.29,
    19.86, -6.91,
    33.69, 19.42,
    19.62, 10.63, 22.33
  ),
  lon = c(
    23.65, 62.33, 81.12, 43.15, 79.85,
    39.67, 39.28, -0.02, 14.51,
    6.76, 36.82,
    102.13, 107.61,
    73.06, 93.55,
    37.22, 103.50, 91.83
  ),
  type = c(
    "Port", "Port", "Port", "Port", "Port",
    "Port", "Port", "Port", "Port",
    "Rail", "Rail",
    "Rail", "Rail",
    "Corridor", "Port",
    "Port", "Port", "Port"
  ),
  investment_usd_bn = c(
    0.6, 1.6, 1.5, 0.6, 1.4,
    0.5, 0.3, 0.4, 0.3,
    NA, 3.8,
    6.0, 7.3,
    62, 1.3,
    0.4, 0.3, 0.5
  ),
  status = c(
    "Operational", "Operational", "Operational", "Operational", "Operational",
    "Operational", "Construction", "Operational", "Construction",
    "Operational", "Operational",
    "Operational", "Operational",
    "Ongoing", "Construction",
    "Planning", "Operational", "Construction"
  )
)

# Create sf object
bri_sf <- st_as_sf(bri_projects, coords = c("lon", "lat"), crs = 4326)

# Define simplified BRI corridors as lines
corridors <- tribble(
  ~name, ~start_lon, ~start_lat, ~end_lon, ~end_lat,
  "Maritime Silk Road", 121.47, 31.23, 23.65, 37.94,
  "China-Pakistan Corridor", 75.5, 35, 62.33, 25.12,
  "China-Europe Rail", 116.4, 39.9, 6.76, 51.43,
  "China-Indochina", 108.2, 22.8, 100.5, 13.75,
  "East Africa Route", 79.85, 6.93, -4.04, 39.67
)

corridor_lines <- corridors %>%
  rowwise() %>%
  mutate(
    geometry = st_sfc(
      st_linestring(matrix(c(start_lon, end_lon, start_lat, end_lat), ncol = 2)),
      crs = 4326
    )
  ) %>%
  ungroup() %>%
  st_as_sf()

# ============================================================================
# 2. CREATE TMAP VISUALIZATION
# ============================================================================

tmap_mode("plot")

# Color palettes
type_colors <- c(
  "Port" = "#1f77b4",
  "Rail" = "#d62728",
  "Corridor" = "#ff7f0e"
)

status_colors <- c(
  "Operational" = "#2ca02c",
  "Construction" = "#ff7f0e",
  "Ongoing" = "#9467bd",
  "Planning" = "#7f7f7f"
)

# Create the map
map <- tm_shape(world, bbox = c(-20, -35, 145, 60)) +
  tm_polygons(
    fill = "#e8e8e8",
    col = "white",
    lwd = 0.2
  ) +

  # Highlight China
  tm_shape(world %>% filter(sovereignt == "China")) +
  tm_polygons(
    fill = "#ffcccc",
    col = "white",
    lwd = 0.3
  ) +

  # BRI Corridors (simplified routes)
  tm_shape(corridor_lines) +
  tm_lines(
    col = "#d62728",
    lwd = 2,
    lty = "dashed"
  ) +

  # BRI Projects
  tm_shape(bri_sf) +
  tm_symbols(
    size = "investment_usd_bn",
    size.scale = tm_scale_continuous(values.scale = 0.15, ticks = c(1, 5, 30, 60)),
    size.legend = tm_legend(title = "Investment\n(USD billion)"),
    fill = "type",
    fill.scale = tm_scale_categorical(values = type_colors),
    fill.legend = tm_legend(title = "Project Type"),
    col = "status",
    col.scale = tm_scale_categorical(values = status_colors),
    col.legend = tm_legend(title = "Status"),
    shape = 21,
    lwd = 1.5
  ) +

  # Labels for major projects
  tm_shape(bri_sf %>% filter(investment_usd_bn > 1 | name %in% c("Piraeus", "Gwadar", "Hambantota", "Djibouti"))) +
  tm_text(
    text = "name",
    size = 0.45,
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
    breaks = c(0, 2000, 4000)
  ) +

  tm_compass(
    position = c("right", "top"),
    size = 1.2
  ) +

  # Layout
  tm_title("Belt and Road Initiative: Key Infrastructure Investments") +

  tm_layout(
    main.title.size = 1.0,
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
    "Source: AidData, CSIS Reconnecting Asia, Green Finance & Development Center (2024)\nDashed lines show simplified corridor routes",
    position = c("left", "bottom"),
    size = 0.45
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

tmap_save(
  map,
  filename = here("figures", "fig_08_01_bri_infrastructure.png"),
  width = 14,
  height = 8,
  dpi = 300
)

tmap_save(
  map,
  filename = here("figures", "fig_08_01_bri_infrastructure.pdf"),
  width = 14,
  height = 8
)

cat("\nFigure 8.1: Belt and Road Initiative map created successfully!\n")
