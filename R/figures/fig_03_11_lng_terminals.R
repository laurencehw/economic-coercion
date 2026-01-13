# Figure 3.11: Global LNG Infrastructure Map
# Chapter 3: Critical Sectors
# Shows LNG export/import terminals globally

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# LNG terminal data
lng_terminals <- data.frame(
  name = c(
    # Export terminals
    "Sabine Pass", "Cameron", "Freeport", "Corpus Christi", "Cove Point",
    "Gorgon", "Wheatstone", "Queensland Curtis", "Yamal", "Sakhalin",
    "Ras Laffan", "Das Island", "Bontang", "Tangguh", "Nigeria LNG",
    # Import terminals
    "South Hook", "Gate", "Zeebrugge", "Dunkirk", "Revithoussa",
    "Dahej", "Ennore", "Incheon", "Sodegaura", "Futtsu",
    "Tianjin", "Guangdong", "Quintero", "Bahia Blanca"
  ),
  country = c(
    "USA", "USA", "USA", "USA", "USA",
    "Australia", "Australia", "Australia", "Russia", "Russia",
    "Qatar", "UAE", "Indonesia", "Indonesia", "Nigeria",
    "UK", "Netherlands", "Belgium", "France", "Greece",
    "India", "India", "South Korea", "Japan", "Japan",
    "China", "China", "Chile", "Argentina"
  ),
  lat = c(
    29.8, 29.8, 28.9, 27.8, 38.4,
    -20.5, -20.8, -23.8, 71.0, 49.2,
    25.9, 24.5, -0.1, -2.8, 4.3,
    51.4, 51.9, 51.3, 51.0, 37.9,
    21.7, 13.1, 37.4, 35.4, 35.2,
    38.9, 22.3, -33.2, -38.8
  ),
  lon = c(
    -93.9, -93.3, -95.4, -97.4, -76.4,
    115.2, 116.0, 151.2, 72.5, 143.0,
    51.6, 52.8, 117.5, 134.3, 7.2,
    -5.0, 4.3, 3.2, 2.4, 23.7,
    72.6, 80.3, 126.6, 139.9, 139.8,
    117.7, 113.7, -71.6, -62.3
  ),
  type = c(
    rep("Export", 15),
    rep("Import", 14)
  ),
  capacity_mtpa = c(
    30, 15, 15, 17, 5,
    15.6, 8.9, 8.5, 16.5, 10.8,
    77, 6, 22, 7.6, 22,
    10.5, 12, 9, 13, 5,
    17.5, 5, 45, 14.5, 18,
    11, 28, 3.4, 7.5
  )
)

# Get world map
world <- ne_countries(scale = "medium", returnclass = "sf")

# Convert terminals to sf
terminals_sf <- st_as_sf(lng_terminals, coords = c("lon", "lat"), crs = 4326)

# Type colors
type_colors <- c(
  "Export" = "#d62728",
  "Import" = "#1f77b4"
)

# Create map
p1 <- ggplot() +
  geom_sf(data = world, fill = "gray95", color = "gray70", linewidth = 0.2) +
  geom_sf(data = terminals_sf, aes(color = type, size = capacity_mtpa), alpha = 0.7) +
  scale_color_manual(values = type_colors, name = "Terminal Type") +
  scale_size_continuous(range = c(2, 10), name = "Capacity\n(MTPA)") +
  coord_sf(crs = "+proj=robin") +
  labs(
    title = "Global LNG Infrastructure",
    subtitle = "Export and import terminal capacity"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "right"
  )

# Export capacity by country
export_by_country <- lng_terminals %>%
  filter(type == "Export") %>%
  group_by(country) %>%
  summarise(total_capacity = sum(capacity_mtpa), .groups = "drop") %>%
  mutate(country = fct_reorder(country, total_capacity))

p2 <- ggplot(export_by_country, aes(x = country, y = total_capacity)) +
  geom_col(fill = "#d62728", width = 0.6) +
  geom_text(aes(label = paste0(round(total_capacity), " MTPA")), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "LNG Export Capacity by Country",
    x = NULL,
    y = "Capacity (Million Tonnes Per Annum)",
    caption = "Source: IGU World LNG Report, GIIGNL\nNote: Qatar's dominant position enables significant market leverage"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Combine
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1.3, 1))

# Save the figure
save_econ_figure("figures/fig_03_11_lng_terminals.png", plot = combined, width = 12, height = 12)

cat("Figure 3.11 created: LNG Terminals Map\n")
