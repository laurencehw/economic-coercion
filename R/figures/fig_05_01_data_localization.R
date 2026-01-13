# Figure 5.1: Data Localization Requirements by Country
# Chapter 5: Information, Cyber, and Intelligence
# Shows the global landscape of data sovereignty laws

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Load data
data_laws <- read.csv("data/sources/data_localization_laws.csv", stringsAsFactors = FALSE)

# Get world map data
world <- ne_countries(scale = "medium", returnclass = "sf")

# Create stringency score mapping
stringency_levels <- c("Low" = 1, "Medium" = 2, "High" = 3)
data_laws$stringency_score <- stringency_levels[data_laws$stringency]

# Aggregate by country (take highest stringency if multiple laws)
country_stringency <- data_laws %>%
  group_by(country) %>%
  summarise(
    max_stringency = max(stringency_score, na.rm = TRUE),
    stringency_label = case_when(
      max_stringency == 3 ~ "High",
      max_stringency == 2 ~ "Medium",
      max_stringency == 1 ~ "Low",
      TRUE ~ "None"
    ),
    num_laws = n(),
    .groups = "drop"
  )

# Map country names to match world data
country_mapping <- c(
  "USA" = "United States of America",
  "UK" = "United Kingdom",
  "South Korea" = "Republic of Korea",
  "Russia" = "Russia",
  "UAE" = "United Arab Emirates"
)

country_stringency$country_mapped <- ifelse(
  country_stringency$country %in% names(country_mapping),
  country_mapping[country_stringency$country],
  country_stringency$country
)

# Merge with world data
world_data <- world %>%
  left_join(country_stringency, by = c("name" = "country_mapped"))

# Set factor levels for proper legend ordering
world_data$stringency_label <- factor(
  world_data$stringency_label,
  levels = c("High", "Medium", "Low", "None")
)

# Define color palette
stringency_colors <- c(
  "High" = "#d62728",
  "Medium" = "#ff7f0e",
  "Low" = "#2ca02c",
  "None" = "#e0e0e0"
)

# Create the map
p <- ggplot(world_data) +
  geom_sf(aes(fill = stringency_label), color = "white", linewidth = 0.2) +
  scale_fill_manual(
    values = stringency_colors,
    name = "Data Localization\nStringency",
    na.value = "#e0e0e0"
  ) +
  coord_sf(crs = "+proj=robin") +
  labs(
    title = "Data Localization Requirements by Country",
    subtitle = "Stringency of data sovereignty and cross-border transfer restrictions (2024)",
    caption = "Source: DLA Piper Global Data Protection Laws, national legislation analysis\nNote: High = mandatory local storage; Medium = partial requirements; Low = few restrictions"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "right"
  )

# Save the figure
save_econ_figure("figures/fig_05_01_data_localization.png", plot = p, width = 12, height = 7)

cat("Figure 5.1 created: Data Localization Requirements Map\n")
