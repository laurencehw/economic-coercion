# Figure 9.1: Soviet Grain Imports by Source Country (1975-1985)
# Purpose: Show Soviet grain dependency and impact of 1980 U.S. embargo
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Read the data
df <- read_csv(here("data", "sources", "soviet_grain_imports.csv"))

# Reshape for stacked area chart
df_long <- df %>%
  select(Year, USA, Canada, Argentina, Australia, EU, Others) %>%
  pivot_longer(cols = -Year, names_to = "Country", values_to = "Imports") %>%
  mutate(Country = factor(Country, levels = c("Others", "EU", "Australia", "Argentina", "Canada", "USA")))

# Calculate U.S. share
df_shares <- df %>%
  mutate(
    US_Share = (USA / Total) * 100,
    Non_US = Total - USA
  )

# ============================================================================
# 2. PANEL A: STACKED AREA - IMPORTS BY SOURCE
# ============================================================================

country_colors <- c(
  "USA" = "#1f77b4",
  "Canada" = "#ff7f0e",
  "Argentina" = "#2ca02c",
  "Australia" = "#d62728",
  "EU" = "#9467bd",
  "Others" = "#8c564b"
)

p1 <- ggplot(df_long, aes(x = Year, y = Imports, fill = Country)) +
  geom_area(alpha = 0.85, color = "white", linewidth = 0.3) +
  geom_vline(xintercept = 1980, linetype = "dashed", color = "black", linewidth = 1.2) +
  annotate("label", x = 1980, y = 55,
           label = "1980: U.S. Grain Embargo\n(Afghanistan Invasion)",
           size = 3.5, fill = "yellow", alpha = 0.9, fontface = "bold",
           label.size = 0.5) +
  scale_fill_manual(values = country_colors) +
  scale_x_continuous(breaks = 1975:1985) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  labs(
    title = "Soviet Grain Imports by Source Country",
    subtitle = "Million metric tons, 1975-1985",
    x = "Year",
    y = "Grain Imports (million metric tons)",
    fill = "Source Country"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "right")

# ============================================================================
# 3. PANEL B: U.S. VS NON-U.S. COMPARISON
# ============================================================================

df_comparison <- df_shares %>%
  select(Year, USA, Non_US) %>%
  pivot_longer(cols = c(USA, Non_US), names_to = "Source", values_to = "Imports") %>%
  mutate(Source = ifelse(Source == "Non_US", "Non-U.S. Sources", "U.S. Exports"))

p2 <- ggplot(df_comparison, aes(x = Year, y = Imports, color = Source)) +
  geom_line(linewidth = 2) +
  geom_point(size = 4, shape = 21, fill = "white", stroke = 2) +
  geom_vline(xintercept = 1980, linetype = "dashed", color = "black", linewidth = 1) +
  annotate("rect", xmin = 1980, xmax = 1981, ymin = -Inf, ymax = Inf,
           alpha = 0.2, fill = "red") +
  annotate("text", x = 1980.5, y = 5, label = "Embargo\nPeriod",
           size = 3, fontface = "italic", color = "darkred") +
  scale_color_manual(values = c("U.S. Exports" = "#1f77b4", "Non-U.S. Sources" = "#d62728")) +
  scale_x_continuous(breaks = 1975:1985) +
  labs(
    title = "Impact of 1980 U.S. Grain Embargo",
    subtitle = "U.S. exports vs. alternative suppliers to USSR",
    x = "Year",
    y = "Grain Imports (million metric tons)",
    color = "Source"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "bottom")

# Add annotation box for impact statistics
impact_text <- paste0(
  "Embargo Impact:\n",
  "U.S. share dropped: ", round(df_shares$US_Share[df_shares$Year == 1979], 1),
  "% → ", round(df_shares$US_Share[df_shares$Year == 1981], 1), "%\n",
  "Others filled gap: ", round(df_shares$Non_US[df_shares$Year == 1979], 1),
  "M → ", round(df_shares$Non_US[df_shares$Year == 1981], 1), "M tons\n",
  "Lesson: Alternative suppliers available"
)

p2 <- p2 +
  annotate("label", x = 1984, y = max(df_comparison$Imports) * 0.4,
           label = impact_text, hjust = 1, size = 3,
           fill = "lightcoral", alpha = 0.8, label.size = 0.5)

# ============================================================================
# 4. COMBINE PANELS
# ============================================================================

combined <- p1 / p2 +
  plot_annotation(
    title = "Figure 9.1: The 1980 Soviet Grain Embargo",
    subtitle = "A case study in the limits of food as a coercive weapon",
    caption = "Sources: USDA Foreign Agricultural Service, FAO Trade Statistics.\nNote: The embargo was imposed in January 1980 following the Soviet invasion of Afghanistan.",
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  )

# ============================================================================
# 5. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_09_01_soviet_grain.png"), combined, width = 12, height = 10)

cat("\nFigure 9.1 created successfully!\n")
