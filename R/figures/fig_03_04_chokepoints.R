# Maritime Chokepoints for Energy Transit (Figure 3.4)
# Purpose: Visualize critical straits and canals for global energy trade
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

# Define Chokepoints Data
chokepoints <- tibble(
  name = c("Strait of Hormuz", "Strait of Malacca", "Suez Canal",
           "Bab el-Mandeb", "Panama Canal", "Turkish Straits",
           "Danish Straits", "Cape of Good Hope"),
  lat = c(26.57, 4.0, 30.59, 12.58, 9.08, 40.70, 55.50, -34.35),
  lon = c(56.25, 100.0, 32.27, 43.33, -79.68, 28.50, 11.00, 18.50),
  oil_volume = c(21.0, 16.0, 5.5, 6.2, 1.0, 2.4, 3.2, 6.0),
  importance = c("Critical", "Critical", "Critical", "Critical",
                 "Major", "Major", "Major", "Major"),
  type = c("Strait", "Strait", "Canal", "Strait",
           "Canal", "Strait", "Strait", "Cape")
)

# Create sf object for points
chokepoints_sf <- st_as_sf(chokepoints, coords = c("lon", "lat"), crs = 4326)

# ============================================================================
# 2. CREATE TMAP VISUALIZATION
# ============================================================================

# Set tmap mode to static plotting
tmap_mode("plot")

# Define color palette
importance_colors <- c("Critical" = "#d62728", "Major" = "#ff7f0e")

# Create the map
map <- tm_shape(world, bbox = c(-100, -40, 145, 70)) +
  tm_polygons(
    fill = "#e8e8e8",
    col = "white",
    lwd = 0.3
  ) +

  # Add chokepoint symbols
tm_shape(chokepoints_sf) +
  tm_symbols(
    size = "oil_volume",
    size.scale = tm_scale_continuous(values.scale = 0.8),
    size.legend = tm_legend(title = "Oil Transit\n(million b/d)"),
    fill = "importance",
    fill.scale = tm_scale_categorical(values = importance_colors),
    fill.legend = tm_legend(title = "Strategic\nImportance"),
    col = "black",
    shape = 21,
    lwd = 1
  ) +

  # Add labels
  tm_text(
    text = "name",
    size = 0.7,
    col = "black",
    fontface = "bold",
    ymod = 1.5,
    bg.color = "white",
    bg.alpha = 0.7
  ) +

  # Cartographic elements
  tm_scalebar(
    position = c("left", "bottom"),
    text.size = 0.6,
    breaks = c(0, 2000, 4000)
  ) +

  tm_compass(
    position = c("right", "top"),
    size = 1.5
  ) +

  # Layout
  tm_title("Strategic Maritime Chokepoints") +

  tm_layout(
    main.title.size = 1.2,
    main.title.fontface = "bold",
    bg.color = "#b8d4e8",  # Ocean color
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
    "Source: U.S. Energy Information Administration (EIA)\nWorld Oil Transit Chokepoints, 2023",
    position = c("left", "bottom"),
    size = 0.6
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

# Save as PNG
tmap_save(
  map,
  filename = here("figures", "fig_03_04_chokepoints.png"),
  width = 12,
  height = 7,
  dpi = 300
)

# Save as PDF
tmap_save(
  map,
  filename = here("figures", "fig_03_04_chokepoints.pdf"),
  width = 12,
  height = 7
)

cat("\nFigure 3.4: Maritime Chokepoints map created successfully!\n")
print(chokepoints %>% select(name, oil_volume, importance))
