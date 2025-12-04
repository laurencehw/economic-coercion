# Figure 1.1: Four Dimensions Analytical Framework for Economic Coercion
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
# 2. CREATE VISUALIZATION
# ============================================================================

p <- ggplot() +
  # Set limits

  xlim(0, 10) +
  ylim(0, 10) +

  # Draw quadrant boxes
  geom_rect(data = quadrants,
            aes(xmin = x - 2, xmax = x + 2, ymin = y - 2, ymax = y + 2),
            fill = quadrants$color, alpha = 0.15, color = quadrants$color,
            linewidth = 2, linetype = "solid") +

  # Draw title boxes
  geom_rect(data = quadrants,
            aes(xmin = x - 1.8, xmax = x + 1.8, ymin = y + 1.3, ymax = y + 1.9),
            fill = quadrants$color, alpha = 0.9, color = quadrants$color) +

  # Quadrant titles
  geom_text(data = quadrants,
            aes(x = x, y = y + 1.6, label = name),
            color = "white", fontface = "bold", size = 3.5, lineheight = 0.85) +

  # Central integration box
  annotate("rect", xmin = 4, xmax = 6, ymin = 4.4, ymax = 5.6,
           fill = "lightyellow", color = "black", linewidth = 1.5) +
  annotate("text", x = 5, y = 5.2, label = "INTEGRATED", fontface = "bold", size = 5) +
  annotate("text", x = 5, y = 4.8, label = "ANALYSIS", fontface = "bold", size = 5) +

  # Connecting arrows (horizontal)
  annotate("segment", x = 4, xend = 4.5, y = 8, yend = 8,
           arrow = arrow(length = unit(0.2, "cm"), ends = "both"),
           color = "gray50", linewidth = 1.2) +
  annotate("segment", x = 5.5, xend = 6, y = 8, yend = 8,
           arrow = arrow(length = unit(0.2, "cm"), ends = "both"),
           color = "gray50", linewidth = 1.2) +
  annotate("text", x = 5, y = 8.3, label = "Selection", size = 3, fontface = "italic", color = "gray40") +

  annotate("segment", x = 4, xend = 4.5, y = 2, yend = 2,
           arrow = arrow(length = unit(0.2, "cm"), ends = "both"),
           color = "gray50", linewidth = 1.2) +
  annotate("segment", x = 5.5, xend = 6, y = 2, yend = 2,
           arrow = arrow(length = unit(0.2, "cm"), ends = "both"),
           color = "gray50", linewidth = 1.2) +
  annotate("text", x = 5, y = 2.3, label = "Evaluation", size = 3, fontface = "italic", color = "gray40") +

  # Connecting arrows (vertical)
  annotate("segment", x = 2.5, xend = 2.5, y = 5.2, yend = 4.8,
           arrow = arrow(length = unit(0.2, "cm"), ends = "both"),
           color = "gray50", linewidth = 1.2) +
  annotate("text", x = 1.7, y = 5, label = "Analysis", size = 3, fontface = "italic", color = "gray40", angle = 90) +

  annotate("segment", x = 7.5, xend = 7.5, y = 5.2, yend = 4.8,
           arrow = arrow(length = unit(0.2, "cm"), ends = "both"),
           color = "gray50", linewidth = 1.2) +
  annotate("text", x = 8.3, y = 5, label = "Assessment", size = 3, fontface = "italic", color = "gray40", angle = 270) +

  # Title
  annotate("text", x = 5, y = 9.7,
           label = "Four Dimensions Framework for Analyzing Economic Coercion",
           fontface = "bold", size = 6) +

  # Bottom note
  annotate("label", x = 5, y = 0.5,
           label = paste0(
             "Framework Application: Each case of economic coercion should be analyzed across all four dimensions\n",
             "to understand (1) what tools are used, (2) what objectives are sought, (3) how target characteristics\n",
             "affect outcomes, and (4) how to measure effectiveness."
           ),
           size = 3, fill = "lightgray", alpha = 0.5, label.size = 0) +

  # Theme
  theme_void() +
  theme(
    plot.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(10, 10, 10, 10)
  )

# Add items to each quadrant (manually positioned)
# Dimension 1 items
items_d1 <- c("• Trade Controls", "• Financial Sanctions", "• Investment Restrictions",
              "• Technology Export Controls", "• Energy Leverage", "• Infrastructure Dependencies")
for (i in seq_along(items_d1)) {
  p <- p + annotate("text", x = 2.5, y = 8 - i * 0.38, label = items_d1[i], size = 2.8)
}

# Dimension 2 items
items_d2 <- c("• Policy Change", "• Behavior Modification", "• Regime Change",
              "• Strategic Containment", "• Deterrence", "• Signaling")
for (i in seq_along(items_d2)) {
  p <- p + annotate("text", x = 7.5, y = 8 - i * 0.38, label = items_d2[i], size = 2.8)
}

# Dimension 3 items
items_d3 <- c("• Economic Interdependence", "• Regime Type", "• Domestic Politics",
              "• Alternative Partners", "• Economic Resilience", "• International Support")
for (i in seq_along(items_d3)) {
  p <- p + annotate("text", x = 2.5, y = 4 - i * 0.38, label = items_d3[i], size = 2.8)
}

# Dimension 4 items
items_d4 <- c("• Economic Impact", "• Political Outcomes", "• Multilateral Coordination",
              "• Duration & Persistence", "• Unintended Consequences", "• Costs to Sender")
for (i in seq_along(items_d4)) {
  p <- p + annotate("text", x = 7.5, y = 4 - i * 0.38, label = items_d4[i], size = 2.8)
}

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_01_01_framework.png"), p, width = 14, height = 10)

cat("\nFigure 1.1 Framework created successfully!\n")
