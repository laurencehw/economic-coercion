# Figure 1.6: CoCom Case Study Timeline
# Chapter 1: Foundations of Economic Statecraft
# Historical timeline of Cold War export control regime

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# CoCom historical events data
cocom_events <- data.frame(
  year = c(1949, 1950, 1951, 1954, 1958, 1962, 1969, 1974, 1979,
           1980, 1982, 1985, 1987, 1989, 1991, 1994, 1996),
  event = c(
    "CoCom established",
    "China Committee (CHINCOM) created",
    "Battle Act passed - aid tied to export controls",
    "CHINCOM restrictions exceed Soviet levels",
    "CHINCOM abolished, China controls relaxed",
    "Cuban Missile Crisis - controls tightened",
    "Detente begins - selective relaxation",
    "Jackson-Vanik Amendment links trade to emigration",
    "Soviet invasion of Afghanistan",
    "Olympic boycott, grain embargo",
    "Pipeline sanctions dispute with Europe",
    "Toshiba-Kongsberg scandal",
    "COCOM list significantly shortened",
    "Fall of Berlin Wall",
    "Soviet Union dissolves",
    "CoCom disbanded",
    "Wassenaar Arrangement established"
  ),
  category = c(
    "Institutional", "Institutional", "Legislative", "Tightening", "Relaxation",
    "Tightening", "Relaxation", "Legislative", "Crisis",
    "Tightening", "Alliance Tension", "Enforcement", "Relaxation",
    "Geopolitical", "Geopolitical", "Institutional", "Institutional"
  ),
  significance = c(3, 2, 2, 2, 2, 2, 2, 2, 3, 2, 3, 2, 2, 3, 3, 3, 3)
)

# Category colors
category_colors <- c(
  "Institutional" = "#1f77b4",
  "Legislative" = "#2ca02c",
  "Tightening" = "#d62728",
  "Relaxation" = "#ff7f0e",
  "Crisis" = "#9467bd",
  "Alliance Tension" = "#e377c2",
  "Enforcement" = "#8c564b",
  "Geopolitical" = "#7f7f7f"
)

# Create alternating y positions for labels
cocom_events <- cocom_events %>%
  mutate(
    y_pos = ifelse(row_number() %% 2 == 0, 1, -1),
    label_y = y_pos * (0.5 + significance * 0.15)
  )

# Create timeline plot
p <- ggplot(cocom_events) +
  # Timeline base
  geom_hline(yintercept = 0, color = "gray30", linewidth = 1) +
  # Event points
  geom_point(
    aes(x = year, y = 0, color = category, size = significance),
    show.legend = TRUE
  ) +
  # Vertical connectors to labels
  geom_segment(
    aes(x = year, xend = year, y = 0, yend = label_y * 0.7, color = category),
    linewidth = 0.5, alpha = 0.7
  ) +
  # Event labels
  geom_label(
    aes(x = year, y = label_y, label = stringr::str_wrap(event, 18), fill = category),
    size = 2.5, color = "white", fontface = "bold",
    label.padding = unit(0.2, "lines"),
    label.r = unit(0.15, "lines")
  ) +
  # Year labels on timeline
  geom_text(
    aes(x = year, y = y_pos * 0.15, label = year),
    size = 2.8, color = "gray30", fontface = "bold"
  ) +
  # Cold War period annotations
  annotate("rect", xmin = 1947, xmax = 1991, ymin = -2.5, ymax = 2.5,
           fill = "gray90", alpha = 0.3) +
  annotate("text", x = 1969, y = 2.3, label = "Cold War Era",
           size = 4, fontface = "italic", color = "gray50") +
  # Styling
  scale_color_manual(values = category_colors, name = "Event Type") +
  scale_fill_manual(values = category_colors, guide = "none") +
  scale_size_continuous(range = c(3, 8), guide = "none") +
  scale_x_continuous(
    breaks = seq(1950, 1995, 5),
    limits = c(1947, 1998),
    expand = expansion(mult = 0.02)
  ) +
  scale_y_continuous(limits = c(-2.5, 2.5)) +
  labs(
    title = "CoCom: Cold War Export Control Regime (1949-1994)",
    subtitle = "Key events in multilateral technology denial to Communist bloc",
    caption = "Source: Mastanduno (1992), CRS Reports, historical archives\nNote: Point size indicates historical significance"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "bottom",
    legend.box = "horizontal"
  ) +
  guides(color = guide_legend(nrow = 2, override.aes = list(size = 4)))

# Save the figure
save_econ_figure(here::here("figures", "fig_01_06_cocom_timeline.png"), plot = p, width = 14, height = 9)

cat("Figure 1.6 created: CoCom Timeline\n")
