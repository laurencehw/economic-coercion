# Figure 1.4: Four Dimensions Analytical Framework for Economic Coercion
# Purpose: Conceptual diagram showing the key analytical dimensions
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(ggforce)  # For geom_circle and shapes

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. DEFINE FRAMEWORK DATA
# ============================================================================

# Define the four quadrants
quadrants <- tibble(
  id = 1:4,
  name = c("DIMENSION 1:\nInstruments & Tools",
           "DIMENSION 2:\nObjectives & Goals",
           "DIMENSION 3:\nTarget Characteristics",
           "DIMENSION 4:\nEffectiveness Factors"),
  x = c(2.5, 7.5, 2.5, 7.5),
  y = c(7, 7, 3, 3),
  color = c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728"),
  items = list(
    c("Trade Controls", "Financial Sanctions", "Investment Restrictions",
      "Technology Export Controls", "Energy Leverage", "Infrastructure Dependencies"),
    c("Policy Change", "Behavior Modification", "Regime Change",
      "Strategic Containment", "Deterrence", "Signaling"),
    c("Economic Interdependence", "Regime Type", "Domestic Politics",
      "Alternative Partners", "Economic Resilience", "International Support"),
    c("Economic Impact", "Political Outcomes", "Multilateral Coordination",
      "Duration & Persistence", "Unintended Consequences", "Costs to Sender")
  )
)

# ============================================================================
# 2. CREATE VISUALIZATION (four boxes of text; drawn at the 6 in print width)
# ============================================================================

ink <- lws_colors[["ink"]]; grey_t <- lws_colors[["text"]]
quadrants$y <- c(7.5, 7.5, 2.5, 2.5)
quadrants$name <- gsub("DIMENSION", "Dimension", quadrants$name)
quadrants$name <- sub(":\n", ".\n", quadrants$name)

items_df <- quadrants %>%
  select(id, x, y, items) %>% unnest(items) %>%
  group_by(id) %>% mutate(k = row_number(), iy = y + 1.0 - (k - 1) * 0.5) %>% ungroup()

p <- ggplot() +
  xlim(0, 10) + ylim(0, 10) +
  geom_rect(data = quadrants, aes(xmin = x - 2.25, xmax = x + 2.25, ymin = y - 2.05, ymax = y + 2),
            fill = "#F7F7F7", colour = lws_colors[["fade"]], linewidth = 0.4) +
  geom_rect(data = quadrants, aes(xmin = x - 2.25, xmax = x + 2.25, ymin = y + 1.3, ymax = y + 2),
            fill = ink, colour = ink) +
  geom_text(data = quadrants, aes(x = x, y = y + 1.65, label = name),
            colour = "white", fontface = "bold", lineheight = 0.9) +
  geom_text(data = items_df, aes(x = x - 1.9, y = iy - 0.15, label = items), hjust = 0, colour = ink) +
  annotate("rect", xmin = 4.0, xmax = 6.0, ymin = 4.55, ymax = 5.45, fill = "white", colour = ink, linewidth = 0.6) +
  annotate("text", x = 5, y = 5, label = "Integrated\nanalysis", fontface = "bold", lineheight = 0.95, colour = ink) +
  annotate("segment", x = 4.75, xend = 5.25, y = 8.7, yend = 8.7, colour = grey_t, linewidth = 0.4,
           arrow = arrow(length = unit(1.5, "mm"), ends = "both", type = "closed")) +
  annotate("text", x = 5, y = 7.2, label = "Selection", colour = grey_t, fontface = "italic", angle = 90) +
  annotate("segment", x = 4.75, xend = 5.25, y = 3.7, yend = 3.7, colour = grey_t, linewidth = 0.4,
           arrow = arrow(length = unit(1.5, "mm"), ends = "both", type = "closed")) +
  annotate("text", x = 5, y = 2.2, label = "Evaluation", colour = grey_t, fontface = "italic", angle = 90) +
  annotate("segment", x = 2.5, xend = 2.5, y = 5.3, yend = 4.7, colour = grey_t, linewidth = 0.4,
           arrow = arrow(length = unit(1.5, "mm"), ends = "both", type = "closed")) +
  annotate("text", x = 2.8, y = 5, label = "Analysis", colour = grey_t, fontface = "italic", hjust = 0) +
  annotate("segment", x = 7.5, xend = 7.5, y = 5.3, yend = 4.7, colour = grey_t, linewidth = 0.4,
           arrow = arrow(length = unit(1.5, "mm"), ends = "both", type = "closed")) +
  annotate("text", x = 7.2, y = 5, label = "Assessment", colour = grey_t, fontface = "italic", hjust = 1) +
  labs(caption = "Source: Author's framework.") +
  theme_void(base_size = 9, base_family = lws_family) +
  theme(plot.background = element_rect(fill = "white", colour = NA),
        plot.caption = element_text(hjust = 0, size = 7, colour = grey_t),
        plot.caption.position = "plot",
        plot.margin = margin(4, 8, 6, 8))

save_econ_figure(here("figures", "fig_01_04_framework.png"), p, width = 6, height = 4.4)

cat("\nFigure 1.4 Framework created successfully!\n")
