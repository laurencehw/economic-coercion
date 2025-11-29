# Figure 3.8: Russian Energy Pipeline Infrastructure
# Purpose: Visualize Russian oil and gas pipelines to Europe and Asia
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

# Load world map - focus on Europe and Asia
world <- ne_countries(scale = "medium", returnclass = "sf")

# Define key pipeline nodes (simplified)
pipeline_nodes <- tibble(
  Name = c(
    # Russian Origins
    "Yamal", "Urengoy", "Yamburg", "Sakhalin",
    # Transit/Key Points
    "Sudzha", "Uzhgorod", "Lubmin", "Wilhelmshaven",
    # European Destinations
    "Baumgarten", "Berlin", "Prague", "Waidhaus",
    # Asian Destinations
    "Daqing", "Vladivostok", "Beijing",
    # Turkey Route
    "Anapa", "Istanbul", "Ankara"
  ),
  Lat = c(
    67.5, 66.0, 68.0, 51.0,
    51.2, 48.8, 54.14, 53.52,
    48.35, 52.52, 50.08, 49.65,
    46.58, 43.13, 39.9,
    44.89, 41.01, 39.93
  ),
  Lon = c(
    75.5, 76.6, 75.9, 143.0,
    35.3, 22.4, 13.67, 8.14,
    16.93, 13.4, 14.43, 12.19,
    124.87, 131.91, 116.4,
    37.32, 28.98, 32.87
  ),
  Type = c(
    "Source", "Source", "Source", "Source",
    "Transit", "Transit", "Terminal", "Terminal",
    "Destination", "Destination", "Destination", "Destination",
    "Destination", "Transit", "Destination",
    "Transit", "Transit", "Destination"
  )
)

# Define major pipelines
pipelines <- tibble(
  Pipeline = c(
    # To Europe via Ukraine
    "Brotherhood", "Soyuz",
    # To Europe via Belarus/Poland
    "Yamal-Europe",
    # Nord Stream (now damaged)
    "Nord Stream 1", "Nord Stream 2",
    # TurkStream
    "TurkStream",
    # To Asia
    "Power of Siberia", "ESPO",
    # Blue Stream
    "Blue Stream"
  ),
  Start_Lat = c(66, 66, 66, 67.5, 67.5, 66, 51, 51, 66),
  Start_Lon = c(76, 76, 75, 75, 75, 76, 143, 143, 76),
  Via_Lat = c(51.2, 51.2, 52.5, 60, 60, 44.89, NA, 43.13, NA),
  Via_Lon = c(35.3, 35.3, 24, 25, 25, 37.32, NA, 131.91, NA),
  End_Lat = c(48.35, 50.08, 52.52, 54.14, 54.14, 39.93, 39.9, 46.58, 41.01),
  End_Lon = c(16.93, 14.43, 13.4, 13.67, 13.67, 32.87, 116.4, 124.87, 28.98),
  Type = c(
    "Gas", "Gas", "Gas", "Gas", "Gas", "Gas", "Gas", "Oil", "Gas"
  ),
  Status = c(
    "Reduced", "Reduced", "Reduced", "Damaged", "Never Operational",
    "Operational", "Operational", "Operational", "Operational"
  ),
  Capacity_bcm = c(100, 32, 33, 55, 55, 31.5, 38, NA, 16)
)

# ============================================================================
# 2. CREATE VISUALIZATION
# ============================================================================

# Filter to Europe/Central Asia region
world_focus <- world %>%
  filter(region_wb %in% c("Europe & Central Asia", "East Asia & Pacific", "Middle East & North Africa") |
           sovereignt == "Russia")

p <- ggplot() +
  # Base map
  geom_sf(data = world_focus, fill = "#e8e8e8", color = "white", linewidth = 0.3) +

  # Highlight Russia
  geom_sf(data = world_focus %>% filter(sovereignt == "Russia"),
          fill = "#ffcccc", color = "white", linewidth = 0.3) +

  # Draw pipelines - operational
  geom_segment(data = pipelines %>% filter(Status == "Operational"),
               aes(x = Start_Lon, y = Start_Lat, xend = End_Lon, yend = End_Lat,
                   linetype = Type),
               color = "#2ca02c", linewidth = 2, alpha = 0.8) +

  # Draw pipelines - reduced flow
  geom_segment(data = pipelines %>% filter(Status == "Reduced"),
               aes(x = Start_Lon, y = Start_Lat, xend = End_Lon, yend = End_Lat,
                   linetype = Type),
               color = "#ff7f0e", linewidth = 2, alpha = 0.8) +

  # Draw pipelines - damaged/closed
  geom_segment(data = pipelines %>% filter(Status %in% c("Damaged", "Never Operational")),
               aes(x = Start_Lon, y = Start_Lat, xend = End_Lon, yend = End_Lat,
                   linetype = Type),
               color = "#d62728", linewidth = 2, alpha = 0.6) +

  # Pipeline nodes
  geom_point(data = pipeline_nodes,
             aes(x = Lon, y = Lat, fill = Type),
             shape = 21, size = 4, color = "black", stroke = 0.5) +

  # Node labels
  geom_label_repel(
    data = pipeline_nodes %>% filter(Type %in% c("Source", "Terminal", "Destination")),
    aes(x = Lon, y = Lat, label = Name),
    size = 2.5, fontface = "bold",
    box.padding = 0.4, point.padding = 0.3,
    segment.color = "gray50", min.segment.length = 0,
    fill = "white", alpha = 0.9
  ) +

  # Scales
  scale_fill_manual(
    values = c("Source" = "#d62728", "Transit" = "#ff7f0e",
               "Terminal" = "#1f77b4", "Destination" = "#2ca02c"),
    name = "Node Type"
  ) +
  scale_linetype_manual(
    values = c("Gas" = "solid", "Oil" = "dashed"),
    name = "Pipeline Type"
  ) +

  # Map settings
  coord_sf(xlim = c(-10, 145), ylim = c(35, 75), expand = FALSE) +

  # Add legend for status (manual)
  annotate("segment", x = 0, xend = 8, y = 38, yend = 38,
           color = "#2ca02c", linewidth = 2) +
  annotate("text", x = 10, y = 38, label = "Operational", hjust = 0, size = 3) +
  annotate("segment", x = 25, xend = 33, y = 38, yend = 38,
           color = "#ff7f0e", linewidth = 2) +
  annotate("text", x = 35, y = 38, label = "Reduced Flow", hjust = 0, size = 3) +
  annotate("segment", x = 55, xend = 63, y = 38, yend = 38,
           color = "#d62728", linewidth = 2) +
  annotate("text", x = 65, y = 38, label = "Damaged/Closed", hjust = 0, size = 3) +

  # Labels
  labs(
    title = "Russian Energy Pipeline Infrastructure",
    subtitle = "Oil and gas pipelines to Europe and Asia; status as of 2024",
    caption = paste0(
      "Sources: Gazprom, Transneft, IEA, European Commission.\n",
      "Note: Nord Stream pipelines damaged in September 2022. ",
      "Ukraine transit significantly reduced since February 2022 invasion."
    ),
    x = NULL, y = NULL
  ) +

  # Theme
  theme_econ_textbook() +
  theme(
    panel.background = element_rect(fill = "#d4e8f7"),
    panel.grid.major = element_line(color = "white", linewidth = 0.3),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "bottom",
    legend.box = "horizontal"
  ) +
  guides(
    fill = guide_legend(order = 1, nrow = 1, override.aes = list(size = 5)),
    linetype = guide_legend(order = 2, nrow = 1)
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_03_08_russian_pipelines.png"), p, width = 14, height = 8)

cat("\nFigure 3.8 Russian Pipelines map created successfully!\n")
