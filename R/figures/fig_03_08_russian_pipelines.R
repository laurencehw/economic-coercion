# Figure 3.8: Russian Energy Pipeline Infrastructure
# Purpose: Visualize Russian oil and gas pipelines to Europe and Asia
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

# Filter to Eurasia
eurasia <- world %>%
  filter(continent %in% c("Europe", "Asia") | sovereignt == "Russia")

# Define key pipeline nodes
pipeline_nodes <- tibble(
  name = c(
    # Russian Origins
    "Yamal", "Urengoy",
    # European Terminals
    "Lubmin", "Baumgarten", "Waidhaus",
    # Transit Points
    "Sudzha", "Velke Kapusany",
    # Turkey Route
    "Anapa", "Istanbul",
    # Asian Destinations
    "Blagoveshchensk", "Vladivostok"
  ),
  lat = c(
    67.5, 66.0,
    54.14, 48.35, 49.65,
    51.2, 48.65,
    44.89, 41.01,
    50.27, 43.13
  ),
  lon = c(
    75.5, 76.6,
    13.67, 16.93, 12.19,
    35.3, 22.08,
    37.32, 28.98,
    127.52, 131.91
  ),
  type = c(
    "Source", "Source",
    "Terminal", "Terminal", "Terminal",
    "Transit", "Transit",
    "Transit", "Terminal",
    "Transit", "Terminal"
  )
)

# Create sf object for nodes
nodes_sf <- st_as_sf(pipeline_nodes, coords = c("lon", "lat"), crs = 4326)

# Define major pipeline routes
pipelines <- tribble(
  ~name, ~start_lon, ~start_lat, ~end_lon, ~end_lat, ~fuel, ~status, ~capacity,
  # Nord Stream (to Germany via Baltic)
  "Nord Stream 1/2", 76, 66, 13.67, 54.14, "Gas", "Damaged", 110,
  # Yamal-Europe (via Belarus/Poland)
  "Yamal-Europe", 75.5, 67.5, 12.19, 49.65, "Gas", "Reduced", 33,
  # Brotherhood (via Ukraine)
  "Brotherhood", 76, 66, 16.93, 48.35, "Gas", "Reduced", 100,
  # TurkStream
  "TurkStream", 37.32, 44.89, 28.98, 41.01, "Gas", "Operational", 31.5,
  # Power of Siberia (to China)
  "Power of Siberia", 127.52, 50.27, 116.4, 39.9, "Gas", "Operational", 38,
  # ESPO Oil Pipeline
  "ESPO Pipeline", 76, 66, 131.91, 43.13, "Oil", "Operational", NA
)

# Create line geometries
pipeline_lines <- pipelines %>%
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
status_colors <- c(
  "Operational" = "#2ca02c",
  "Reduced" = "#ff7f0e",
  "Damaged" = "#d62728"
)

node_colors <- c(
  "Source" = "#d62728",
  "Transit" = "#ff7f0e",
  "Terminal" = "#1f77b4"
)

# Create the map
map <- tm_shape(eurasia, bbox = c(-10, 35, 145, 75)) +
  tm_polygons(
    fill = "#e8e8e8",
    col = "white",
    lwd = 0.3
  ) +

  # Highlight Russia
  tm_shape(eurasia %>% filter(sovereignt == "Russia")) +
  tm_polygons(
    fill = "#ffcccc",
    col = "white",
    lwd = 0.3
  ) +

  # Pipeline routes
  tm_shape(pipeline_lines) +
  tm_lines(
    col = "status",
    col.scale = tm_scale_categorical(values = status_colors),
    col.legend = tm_legend(title = "Pipeline Status"),
    lwd = "capacity",
    lwd.scale = tm_scale_continuous(values.scale = 0.08, ticks = c(30, 60, 100)),
    lwd.legend = tm_legend(title = "Capacity\n(bcm/year)"),
    lty = "fuel",
    lty.scale = tm_scale_categorical(values = c("Gas" = "solid", "Oil" = "dashed")),
    lty.legend = tm_legend(title = "Fuel Type")
  ) +

  # Pipeline nodes
  tm_shape(nodes_sf) +
  tm_symbols(
    size = 0.8,
    fill = "type",
    fill.scale = tm_scale_categorical(values = node_colors),
    fill.legend = tm_legend(title = "Node Type"),
    col = "black",
    shape = 21,
    lwd = 0.5
  ) +

  # Node labels
  tm_shape(nodes_sf %>% filter(type %in% c("Source", "Terminal"))) +
  tm_text(
    text = "name",
    size = 0.5,
    col = "black",
    fontface = "bold",
    ymod = 1.0,
    bg.color = "white",
    bg.alpha = 0.7
  ) +

  # Cartographic elements
  tm_scalebar(
    position = c("left", "bottom"),
    text.size = 0.5,
    breaks = c(0, 1000, 2000)
  ) +

  tm_compass(
    position = c("right", "top"),
    size = 1.2
  ) +

  # Layout
  tm_title("Russian Energy Pipeline Infrastructure") +

  tm_layout(
    main.title.size = 1.1,
    main.title.fontface = "bold",
    bg.color = "#d4e8f7",
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
    "Source: Gazprom, Transneft, IEA (2024)\nNord Stream damaged Sept. 2022; Ukraine transit reduced since Feb. 2022",
    position = c("left", "bottom"),
    size = 0.45
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

tmap_save(
  map,
  filename = here("figures", "fig_03_08_russian_pipelines.png"),
  width = 14,
  height = 8,
  dpi = 300
)

tmap_save(
  map,
  filename = here("figures", "fig_03_08_russian_pipelines.pdf"),
  width = 14,
  height = 8
)

cat("\nFigure 3.8: Russian Pipelines map created successfully!\n")
