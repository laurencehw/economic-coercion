# Figure 1.3: Timeline of Major Economic Coercion Events
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
  y_pos = c(1, -1, 1, -1.5, 1, -2.2, 2, -3),   # label level: staggered so labels do not collide
  hj = c(0, 0, 1, 1, 1, 1, 1, 1)           # label extends right (0) or left (1) of its stem
)

# Era boundaries (alternating light grey bands)
eras <- tibble(
  era = c("Cold War", "Post-Cold War", "War on Terror", "Great Power Competition"),
  start = c(1945, 1991, 2001, 2014),
  end = c(1991, 2001, 2014, 2025)
) %>% mutate(shade = c("a", "b", "a", "b"))

p <- ggplot() +
  geom_rect(data = eras, aes(xmin = start, xmax = end, ymin = -3.6, ymax = 3.0, fill = shade),
            show.legend = FALSE) +
  scale_fill_manual(values = c(a = "#F2F2F2", b = "#FFFFFF")) +
  geom_text(data = eras %>% mutate(lx = c(start[1] + 0.8, start[2] + 0.8, start[3] + 0.8, end[4] - 0.8),
                                    ly = c(2.85, 2.85, 2.35, 2.85), hj = c(0, 0, 0, 1)),
            aes(x = lx, y = ly, label = era, hjust = hj),
            vjust = 1, colour = lws_colors[["text"]], fontface = "italic") +
  geom_hline(yintercept = 0, colour = lws_colors[["ink"]], linewidth = 0.6) +
  geom_segment(data = key_events, aes(x = Year, xend = Year, y = 0, yend = y_pos),
               colour = lws_colors[["fade"]], linewidth = 0.4) +
  geom_point(data = key_events, aes(x = Year, y = 0), size = 2, colour = lws_colors[["red"]]) +
  geom_text(data = key_events,
            aes(x = Year + ifelse(hj == 0, 0.8, -0.8), y = y_pos, label = paste0(Year, "  ", Event), hjust = hj),
            colour = lws_colors[["ink"]]) +
  scale_x_continuous(limits = c(1945, 2025), breaks = seq(1950, 2020, 10), expand = c(0, 0)) +
  scale_y_continuous(limits = c(-3.6, 3.0), expand = c(0, 0)) +
  labs(x = NULL, y = NULL,
       caption = "Source: Author's compilation. Events selected for historical significance and impact on economic statecraft.") +
  theme_econ_textbook() +
  theme(axis.text.y = element_blank(), panel.grid = element_blank(),
        axis.ticks.x = element_line(colour = lws_colors[["ref"]], linewidth = 0.3))

save_econ_figure(here("figures", "fig_01_03_timeline.png"), p, width = 6, height = 3.2)

cat("\nFigure 1.3 Timeline created\n")
