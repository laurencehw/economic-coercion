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

# One highlight: state-linked coercive operations (red triangles); everything else in ink circles.
# Marker size is not used: the vertical position already carries the damage estimate.
cyber_data <- cyber_data %>% filter(damage_billions > 0)  # the DNC hack has no damage estimate and cannot sit on a log axis

p <- ggplot(cyber_data, aes(x = year, y = damage_billions)) +
  geom_point(aes(colour = coercion_label, shape = coercion_label), size = 2.4, alpha = 0.9) +
  geom_text_repel(
    data = cyber_data %>% filter(damage_billions >= 1),
    aes(label = incident_name),
    size = book_text_size, colour = lws_colors[["ink"]],
    box.padding = 0.4, point.padding = 0.25, max.overlaps = 20,
    segment.colour = lws_colors[["fade"]], seed = 7
  ) +
  scale_colour_manual(values = c("State-linked coercion" = lws_colors[["red"]], "Criminal/Espionage" = lws_colors[["text"]]), name = NULL) +
  scale_shape_manual(values = c("State-linked coercion" = 17, "Criminal/Espionage" = 16), name = NULL) +
  scale_y_log10(labels = function(x) paste0("$", x, "B"), breaks = c(0.001, 0.01, 0.1, 1, 10, 100)) +
  scale_x_continuous(breaks = seq(2010, 2024, 2), limits = c(2009.5, 2024.5)) +
  labs(x = NULL, y = "Estimated damage (log scale)") +
  book_source("Source: CSIS Significant Cyber Incidents and industry reports. Damage estimates differ widely by method. Incidents of $1 billion or more are labelled; the 2016 DNC hack has no damage estimate and is omitted.") +
  theme_econ_textbook() +
  theme(legend.position = "top")

save_econ_figure(here::here("figures", "fig_05_03_cyber_incidents.png"), plot = p, width = 6, height = 4.4)

cat("Figure 5.3 created: Cyber-Economic Incidents Timeline\n")
