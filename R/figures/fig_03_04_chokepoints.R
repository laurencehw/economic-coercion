# Maritime Chokepoints for Energy Transit (Figure 3.4)
# Purpose: Visualize critical straits and canals for global energy trade
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

# Define Chokepoints Data manually
chokepoints <- tibble(
  Name = c("Strait of Hormuz", "Strait of Malacca", "Suez Canal", 
           "Bab el-Mandeb", "Panama Canal", "Turkish Straits", "Danish Straits"),
  Lat = c(26.5667, 4.0, 30.5852, 12.5833, 9.076, 40.7, 55.5),
  Lon = c(56.2500, 100.0, 32.265, 43.3333, -79.68, 28.5, 11.0),
  Volume_Oil = c("21.0 Mb/d", "16.0 Mb/d", "5.5 Mb/d", "6.2 Mb/d", "0.0 Mb/d", "2.4 Mb/d", "3.2 Mb/d"),
  Importance = c("High", "High", "High", "High", "Medium", "Medium", "Medium"),
  Type = c("Strait", "Strait", "Canal", "Strait", "Canal", "Strait", "Strait")
)

# Create sf object for points
chokepoints_sf <- st_as_sf(chokepoints, coords = c("Lon", "Lat"), crs = 4326)

# ============================================================================
# 2. CREATE VISUALIZATION
# ============================================================================

# Create map
p <- ggplot(data = world) +
  # Base map
  geom_sf(fill = "#f0f0f0", color = "white", size = 0.2) +
  
  # Chokepoint markers
  geom_point(data = chokepoints, aes(x = Lon, y = Lat, color = Importance), 
             size = 4, alpha = 0.8) +
  geom_point(data = chokepoints, aes(x = Lon, y = Lat), 
             size = 4, shape = 1, color = "black") + # Outline
  
  # Labels
  geom_label_repel(data = chokepoints, aes(x = Lon, y = Lat, label = Name),
                   box.padding = 0.5, point.padding = 0.5,
                   segment.color = "gray50", size = 3.5, fontface = "bold",
                   min.segment.length = 0) +
  
  # Volume labels (sub-labels)
  geom_text_repel(data = chokepoints, aes(x = Lon, y = Lat, label = Volume_Oil),
                  nudge_y = -3, size = 3, color = "gray30", segment.alpha = 0) +
  
  # Custom colors
  scale_color_manual(values = c("High" = "#d62728", "Medium" = "#ff7f0e")) +
  
  # Map settings
  coord_sf(xlim = c(-100, 140), ylim = c(-20, 70), expand = FALSE) +
  
  labs(
    title = "Strategic Maritime Chokepoints",
    subtitle = "Critical bottlenecks for global energy and trade flows",
    caption = "Source: U.S. Energy Information Administration (EIA), World Oil Transit Chokepoints.",
    x = NULL, y = NULL, color = "Strategic Importance"
  ) +
  theme_econ_textbook() +
  theme(
    panel.background = element_rect(fill = "#e6f3ff"), # Ocean color
    panel.grid.major = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "bottom"
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

# Save
save_econ_figure(here("figures", "fig_03_04_chokepoints.png"), p, width = 12, height = 7)

cat("\nFigure 3.4 Map Created Successfully.\n")
print(chokepoints)