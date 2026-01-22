# Figure 5.3: Major Cyber-Economic Incidents Timeline
# Chapter 5: Information, Cyber, and Intelligence
# Visualizes significant cyber attacks with economic/coercive dimensions

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(scales)
library(ggrepel)

# Load data
cyber_data <- read.csv(here::here("data", "sources", "cyber_economic_incidents.csv"), stringsAsFactors = FALSE)

# Filter to major incidents and add categories
cyber_data <- cyber_data %>%
  mutate(
    damage_billions = estimated_damage_usd / 1e9,
    incident_category = case_when(
      incident_type %in% c("Sabotage", "Destructive") ~ "Sabotage/Destructive",
      incident_type == "Ransomware" ~ "Ransomware",
      incident_type == "Espionage" ~ "Espionage",
      incident_type == "Theft" ~ "Financial Theft",
      TRUE ~ "Other"
    ),
    coercion_label = ifelse(economic_coercion_link == "Yes", "State-linked coercion", "Criminal/Espionage")
  )

# Category colors
category_colors <- c(
  "Sabotage/Destructive" = "#d62728",
  "Ransomware" = "#ff7f0e",
  "Espionage" = "#1f77b4",
  "Financial Theft" = "#2ca02c"
)

# Create timeline visualization
p <- ggplot(cyber_data, aes(x = year, y = damage_billions)) +
  # Add points sized by damage
  geom_point(
    aes(color = incident_category,
        size = damage_billions,
        shape = coercion_label),
    alpha = 0.8
  ) +
  # Add labels for major incidents using ggrepel to avoid overlap
  geom_text_repel(
    data = cyber_data %>% filter(damage_billions > 1),
    aes(label = incident_name),
    size = 3,
    box.padding = 0.5,
    point.padding = 0.3,
    max.overlaps = 15
  ) +
  # Scales
  scale_color_manual(values = category_colors, name = "Incident Type") +
  scale_size_continuous(
    range = c(3, 15),
    name = "Estimated Damage",
    labels = function(x) paste0("$", x, "B"),
    breaks = c(1, 5, 10, 50, 100)
  ) +
  scale_shape_manual(
    values = c("State-linked coercion" = 17, "Criminal/Espionage" = 16),
    name = "Attribution"
  ) +
  scale_y_log10(
    labels = function(x) paste0("$", x, "B"),
    breaks = c(0.01, 0.1, 1, 10, 100)
  ) +
  scale_x_continuous(breaks = seq(2010, 2024, 2)) +
  # Labels
  labs(
    title = "Major Cyber-Economic Incidents (2010-2024)",
    subtitle = "Estimated economic damage by incident type and state attribution",
    x = "Year",
    y = "Estimated Damage (Log Scale)",
    caption = "Source: CSIS Significant Cyber Incidents, industry reports\nNote: Triangles indicate state-linked coercive operations; circles indicate criminal/espionage activity"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    legend.box = "vertical"
  ) +
  guides(
    color = guide_legend(order = 1),
    shape = guide_legend(order = 2),
    size = guide_legend(order = 3)
  )

# Save the figure
save_econ_figure(here::here("figures", "fig_05_03_cyber_incidents.png"), plot = p, width = 12, height = 8)

cat("Figure 5.3 created: Cyber-Economic Incidents Timeline\n")
