# Figure 1.4: Timeline of Major Economic Coercion Events (1948-2024)
# Purpose: Visual timeline showing the evolution of economic coercion tools
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Read the data
df <- read_csv(here("data", "sources", "economic_coercion_timeline.csv"))

# Define category colors
category_colors <- c(
  "Trade/Infrastructure" = "#1f77b4",
  "Trade Sanctions" = "#ff7f0e",
  "Energy" = "#2ca02c",
  "Comprehensive" = "#d62728",
  "Extraterritorial" = "#9467bd",
  "Financial" = "#8c564b",
  "Financial/Trade" = "#e377c2",
  "Sectoral" = "#7f7f7f",
  "Tariffs" = "#bcbd22",
  "Investment Screening" = "#17becf",
  "Technology" = "#ff9896",
  "Financial/Oil" = "#c5b0d5",
  "Strategic Resources" = "#c49c94",
  "Investment" = "#f7b6d2"
)

# Add y-position for alternating layout
df <- df %>%
  mutate(
    row_num = row_number(),
    y_pos = ifelse(row_num %% 2 == 1, 1, -1) * ((row_num + 1) %/% 2) * 0.8,
    Color = category_colors[Category]
  )

# Define eras
eras <- tibble(
  start = c(1948, 1990, 2001, 2014),
  end = c(1990, 2001, 2014, 2025),
  label = c("Cold War Era", "Post-Cold War", "War on Terror", "Great Power Competition"),
  fill = c("#e8f4f8", "#f0f8e8", "#fff4e6", "#ffe6e6")
)

# ============================================================================
# 2. CREATE VISUALIZATION
# ============================================================================

# Calculate y range
y_range <- max(abs(df$y_pos)) + 2

p <- ggplot() +
  # Era backgrounds
  geom_rect(data = eras,
            aes(xmin = start, xmax = end, ymin = -y_range, ymax = y_range, fill = label),
            alpha = 0.3) +
  scale_fill_manual(values = setNames(eras$fill, eras$label), name = "Historical Era") +

  # Main timeline axis
  geom_hline(yintercept = 0, color = "black", linewidth = 2, alpha = 0.5) +

  # Decade markers
  geom_segment(data = tibble(x = seq(1950, 2020, 10)),
               aes(x = x, xend = x, y = -0.3, yend = 0.3),
               color = "black", linewidth = 1, alpha = 0.6) +
  geom_text(data = tibble(x = seq(1950, 2020, 10)),
            aes(x = x, y = -0.6, label = x),
            fontface = "bold", size = 3.5) +

  # Connecting lines from axis to events
  geom_segment(data = df,
               aes(x = Year, xend = Year, y = 0, yend = y_pos * 0.8),
               linetype = "dashed", color = "gray50", alpha = 0.5) +

  # Event points on timeline
  geom_point(data = df,
             aes(x = Year, y = 0, color = Category),
             size = 4, shape = 21, fill = "white", stroke = 2) +

  # Event labels

  geom_label(data = df,
             aes(x = Year, y = y_pos, label = paste0(Year, ": ", Event), fill = Category),
             size = 2.5, fontface = "bold", alpha = 0.8, color = "white",
             label.size = 0.5, label.padding = unit(0.2, "lines")) +

  # Color scales
  scale_color_manual(values = category_colors, name = "Category") +

  # Axes
  scale_x_continuous(limits = c(1945, 2028), breaks = seq(1950, 2020, 10)) +
  scale_y_continuous(limits = c(-y_range, y_range + 2)) +

  # Era labels at bottom
  geom_label(data = eras,
             aes(x = (start + end) / 2, y = -y_range + 0.5, label = label),
             fill = eras$fill, color = "black", fontface = "bold",
             size = 3.5, label.size = 0.5) +

  # Title
  labs(
    title = "Figure 1.4: Timeline of Major Economic Coercion Events (1948-2024)",
    subtitle = "The evolution of economic statecraft tools and targets",
    caption = "Source: Author compilation from historical records, government documents, and academic literature.",
    x = NULL,
    y = NULL
  ) +

  # Theme
  theme_void() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, color = "gray30", hjust = 0.5),
    plot.caption = element_text(size = 9, color = "gray50", hjust = 0),
    legend.position = "bottom",
    legend.box = "horizontal",
    plot.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(15, 15, 15, 15)
  ) +
  guides(
    fill = "none",
    color = guide_legend(nrow = 2, override.aes = list(size = 4))
  )

# Add key insights box
insights <- paste0(
  "Key Trends:\n",
  "• Financial sanctions increasingly dominant post-2001\n",
  "• Technology controls emerge as major tool (2018+)\n",
  "• Shift from comprehensive to targeted measures\n",
  "• Great power competition drives new instruments"
)

p <- p +
  annotate("label", x = 2020, y = y_range - 1, label = insights,
           hjust = 1, vjust = 1, size = 3,
           fill = "lightyellow", alpha = 0.9, label.size = 0.5)

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_01_04_timeline.png"), p, width = 16, height = 12)

cat("\nFigure 1.4 Timeline created successfully!\n")
