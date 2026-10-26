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

cols <- c("USA" = lws_colors[["red"]], "Canada" = "#4D4D4D", "Argentina" = "#7A7A7A", "Australia" = "#9E9E9E", "EU" = "#BDBDBD", "Others" = "#DCDCDC")

p1 <- ggplot(df_long, aes(x = Year, y = Imports, fill = Country)) +
  geom_col(width = 0.75, colour = "white", linewidth = 0.2) +
  geom_text(data = df, aes(x = Year, y = Total, label = Total), inherit.aes = FALSE, vjust = -0.5,
            colour = lws_colors[["ink"]], size = book_text_size) +
  annotate("segment", x = 1979.5, xend = 1979.5, y = 0, yend = 48, linetype = "dashed", colour = lws_colors[["ref"]]) +
  annotate("text", x = 1979.4, y = 50, label = "1980 U.S. grain embargo", hjust = 1, colour = lws_colors[["text"]]) +
  scale_fill_manual(values = cols, breaks = rev(levels(df_long$Country)), name = NULL) +
  scale_x_continuous(breaks = 1975:1985) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(title = "A. Soviet grain imports by source", x = NULL, y = "Million metric tons") +
  theme_econ_textbook() + theme(legend.position = "top", legend.justification = "left") +
  guides(fill = guide_legend(nrow = 1))

df_comparison <- df_shares %>%
  select(Year, USA, Non_US) %>%
  pivot_longer(cols = c(USA, Non_US), names_to = "Source", values_to = "Imports") %>%
  mutate(Source = ifelse(Source == "Non_US", "Non-U.S. sources", "U.S."))
end_lab <- df_comparison %>% filter(Year == max(Year))

p2 <- ggplot(df_comparison, aes(x = Year, y = Imports, colour = Source)) +
  annotate("rect", xmin = 1979.5, xmax = 1981.5, ymin = -Inf, ymax = Inf, fill = "#F2F2F2") +
  geom_line(linewidth = 0.9) + geom_point(size = 1.4) +
  geom_text(data = end_lab, aes(label = Source), hjust = -0.1, size = book_text_size, show.legend = FALSE) +
  scale_colour_manual(values = c("U.S." = lws_colors[["red"]], "Non-U.S. sources" = lws_colors[["text"]]), guide = "none") +
  scale_x_continuous(breaks = 1975:1985, limits = c(1975, 1988.5)) +
  labs(title = "B. U.S. against all other suppliers (shading: embargo years in the data)", x = NULL, y = "Million metric tons") +
  theme_econ_textbook()

combined <- p1 / p2 + plot_layout(heights = c(1.2, 1)) +
  plot_annotation(
    caption = paste(strwrap("Sources: USDA Foreign Agricultural Service and FAO trade statistics. The embargo was announced in January 1980 after the Soviet invasion of Afghanistan.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here("figures", "fig_09_01_soviet_grain.png"), combined, width = 6, height = 5.8)

cat("\nFigure 9.1 created successfully!\n")
