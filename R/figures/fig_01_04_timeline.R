# Figure 1.4: Timeline of Major Economic Coercion Events
# Purpose: Simplified, readable timeline of key events
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE SIMPLIFIED DATA - KEY EVENTS ONLY
# ============================================================================

# Select only the most important milestone events
key_events <- tibble(
  Year = c(1948, 1973, 1990, 2010, 2014, 2018, 2022, 2022),
  Event = c(
    "Berlin Blockade",
    "Arab Oil Embargo",
    "Iraq Sanctions",
    "Iran Financial Sanctions",
    "Russia-Crimea Sanctions",
    "U.S.-China Trade War",
    "Russia SWIFT Cutoff",
    "Semiconductor Controls"
  ),
  Era = c(
    "Cold War", "Cold War", "Post-Cold War",
    "War on Terror", "Great Power Competition",
    "Great Power Competition", "Great Power Competition", "Great Power Competition"
  ),
  y_pos = c(1, -1, 1, -1, 1, -1, 1, -0.5)  # Alternating positions, offset last two
)

# Define era boundaries
eras <- tibble(
  era = c("Cold War", "Post-Cold War", "War on Terror", "Great Power Competition"),
  start = c(1945, 1991, 2001, 2014),
  end = c(1991, 2001, 2014, 2025),
  fill = c("#cce5ff", "#d4edda", "#fff3cd", "#f8d7da")
)

# ============================================================================
# 2. CREATE SIMPLIFIED VISUALIZATION
# ============================================================================

p <- ggplot() +
  # Era backgrounds
  geom_rect(data = eras,
            aes(xmin = start, xmax = end, ymin = -2, ymax = 2, fill = era),
            alpha = 0.4, show.legend = FALSE) +
  scale_fill_manual(values = setNames(eras$fill, eras$era)) +

  # Main timeline axis
  geom_hline(yintercept = 0, color = "black", linewidth = 1.5) +

  # Decade markers

  geom_segment(data = tibble(x = seq(1950, 2020, 10)),
               aes(x = x, xend = x, y = -0.15, yend = 0.15),
               color = "black", linewidth = 1) +
  geom_text(data = tibble(x = seq(1950, 2020, 10)),
            aes(x = x, y = -0.35, label = x),
            size = 4, fontface = "bold") +

  # Event markers on timeline
  geom_point(data = key_events,
             aes(x = Year, y = 0),
             size = 5, color = "#d62728", shape = 16) +

  # Connecting lines
  geom_segment(data = key_events,
               aes(x = Year, xend = Year, y = 0, yend = y_pos * 0.7),
               color = "gray40", linewidth = 0.8, linetype = "solid") +

  # Event labels - large, readable text
  geom_label(data = key_events,
             aes(x = Year, y = y_pos, label = paste0(Year, "\n", Event)),
             size = 3.5, fontface = "bold", lineheight = 0.9,
             fill = "white", label.size = 0.3,
             label.padding = unit(0.3, "lines")) +

  # Era labels at bottom
  geom_text(data = eras,
            aes(x = (start + end) / 2, y = -1.7, label = era),
            size = 4, fontface = "bold", color = "gray30") +

  # Scales and limits
  scale_x_continuous(limits = c(1945, 2026), breaks = seq(1950, 2020, 10)) +
  scale_y_continuous(limits = c(-2, 1.8)) +

  # Labels
  labs(
    title = "Timeline of Major Economic Coercion Events",
    subtitle = "Key milestones in the evolution of economic statecraft (1948-2024)",
    caption = "Source: Author compilation. Events selected for historical significance and impact on economic statecraft.",
    x = NULL, y = NULL
  ) +

  # Clean theme
  theme_econ_textbook(base_size = 14) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5, color = "gray40"),
    plot.caption = element_text(size = 10, hjust = 0),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_01_04_timeline.png"), p, width = 14, height = 6)

cat("\nFigure 1.4 Timeline (simplified) created successfully!\n")
