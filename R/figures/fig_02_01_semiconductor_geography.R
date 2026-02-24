# Figure 2.1: Semiconductor Supply Chain Geography
# Purpose: Visualize critical semiconductor manufacturing and equipment locations
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

# Define key semiconductor locations
semi_locations <- tibble(
  name = c(
    # Leading-edge fabs
    "TSMC Hsinchu", "TSMC Tainan", "Samsung Pyeongtaek",
    "Intel Oregon", "Intel Arizona",
    # Equipment makers
    "ASML Veldhoven", "Tokyo Electron", "Applied Materials",
    # Memory
    "SK Hynix Icheon", "Micron Boise",
    # Materials
    "Shin-Etsu Gunma", "SUMCO Saga",
    # Chinese efforts
    "SMIC Shanghai", "YMTC Wuhan",
    # Expansion projects
    "TSMC Arizona", "Samsung Taylor TX", "Intel Ohio"
  ),
  lat = c(
    24.80, 23.00, 37.08,
    45.52, 33.42,
    51.42, 35.68, 37.35,
    37.27, 43.62,
    36.39, 33.26,
    31.23, 30.58,
    33.42, 30.57, 40.10
  ),
  lon = c(
    120.97, 120.23, 127.08,
    -122.68, -111.94,
    5.47, 139.75, -121.95,
    127.43, -116.20,
    139.06, 130.30,
    121.47, 114.27,
    -111.94, -97.40, -82.99
  ),
  type = c(
    "Leading Fab", "Leading Fab", "Leading Fab",
    "Leading Fab", "Leading Fab",
    "Equipment", "Equipment", "Equipment",
    "Memory", "Memory",
    "Materials", "Materials",
    "China Fab", "China Fab",
    "Expansion", "Expansion", "Expansion"
  ),
  company = c(
    "TSMC", "TSMC", "Samsung",
    "Intel", "Intel",
    "ASML", "TEL", "AMAT",
    "SK Hynix", "Micron",
    "Shin-Etsu", "SUMCO",
    "SMIC", "YMTC",
    "TSMC", "Samsung", "Intel"
  ),
  node_nm = c(
    3, 3, 3,
    7, 7,
    NA, NA, NA,
    NA, NA,
    NA, NA,
    14, 128,
    4, 4, 5
  ),
  chokepoint = c(
    TRUE, TRUE, TRUE,
    FALSE, FALSE,
    TRUE, TRUE, TRUE,
    FALSE, FALSE,
    TRUE, TRUE,
    FALSE, FALSE,
    FALSE, FALSE, FALSE
  )
)

# Create sf object
semi_sf <- st_as_sf(semi_locations, coords = c("lon", "lat"), crs = 4326)

# Focus labels on the most strategic chokepoints to keep text readable in book layout.
label_points <- semi_sf %>%
  filter(name %in% c(
    "TSMC Hsinchu",
    "Samsung Pyeongtaek",
    "ASML Veldhoven",
    "Tokyo Electron",
    "SMIC Shanghai"
  )) %>%
  mutate(
    label = c("TSMC", "Samsung", "ASML", "TEL", "SMIC")
  )

# ============================================================================
# 2. CREATE TMAP VISUALIZATION
# ============================================================================

tmap_mode("plot")

# Color palettes
type_colors <- c(
  "Leading Fab" = "#d62728",
  "Equipment" = "#1f77b4",
  "Memory" = "#2ca02c",
  "Materials" = "#9467bd",
  "China Fab" = "#ff7f0e",
  "Expansion" = "#17becf"
)

# Create the map - focus on key regions where chokepoints are concentrated.
map <- tm_shape(world, bbox = c(-130, 18, 145, 60)) +
  tm_polygons(
    fill = "#e8e8e8",
    col = "white",
    lwd = 0.2
  ) +

  # Highlight key countries
  tm_shape(world %>% filter(sovereignt %in% c("Taiwan", "South Korea", "Japan", "Netherlands"))) +
  tm_polygons(
    fill = "#ffe6e6",
    col = "white",
    lwd = 0.3
  ) +

  # Semiconductor locations
  tm_shape(semi_sf) +
  tm_symbols(
    size = 0.9,
    fill = "type",
    fill.scale = tm_scale_categorical(values = type_colors),
    fill.legend = tm_legend(title = "Facility Type"),
    col = "black",
    shape = 21,
    lwd = 0.5
  ) +

  # Highlight chokepoints with ring
  tm_shape(semi_sf %>% filter(chokepoint == TRUE)) +
  tm_symbols(
    size = 1.5,
    fill = NA,
    col = "#d62728",
    shape = 1,
    lwd = 1.8
  ) +

  # Labels for a small set of strategic nodes.
  tm_shape(label_points) +
  tm_text(
    text = "label",
    size = 0.7,
    col = "black",
    fontface = "bold",
    xmod = 0.35,
    ymod = 0.9,
    bg.color = "white",
    bg.alpha = 0.85
  ) +

  # Layout
  tm_title("Semiconductor Supply Chain: Critical Chokepoints") +

  tm_layout(
    main.title.size = 1.2,
    main.title.fontface = "bold",
    bg.color = "#d4e8f7",
    frame = TRUE,
    frame.lwd = 1,
    legend.outside = FALSE,
    legend.position = c("left", "top"),
    legend.frame = TRUE,
    legend.bg.color = "white",
    legend.bg.alpha = 0.9,
    legend.title.size = 0.9,
    legend.text.size = 0.8,
    attr.outside = TRUE,
    attr.position = c("left", "bottom"),
    inner.margins = c(0.04, 0.02, 0.06, 0.02)
  ) +

  tm_credits(
    "Source: SIA, TechInsights, Company Reports (2024)  |  Red rings indicate critical chokepoints",
    position = c("left", "bottom"),
    size = 0.62
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

tmap_save(
  map,
  filename = here("figures", "fig_02_01_semiconductor_geography.png"),
  width = 15,
  height = 6,
  dpi = 300
)

tmap_save(
  map,
  filename = here("figures", "fig_02_01_semiconductor_geography.pdf"),
  width = 15,
  height = 6
)

cat("\nFigure 2.1: Semiconductor Geography map created successfully!\n")
