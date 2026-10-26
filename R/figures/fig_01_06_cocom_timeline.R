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

# Category colours: house hues, then ink and grey
category_colors <- c(
  "Institutional" = lws_colors[["blue"]],
  "Legislative" = lws_colors[["purple"]],
  "Tightening" = lws_colors[["red"]],
  "Relaxation" = lws_colors[["green"]],
  "Crisis" = lws_colors[["orange"]],
  "Alliance Tension" = lws_colors[["gold"]],
  "Enforcement" = lws_colors[["ink"]],
  "Geopolitical" = lws_colors[["fade"]]
)

# One row per event, in date order (rows are evenly spaced, not to scale)
cocom_events <- cocom_events %>%
  mutate(row = -row_number(), category = factor(category, levels = names(category_colors)))

p <- ggplot(cocom_events) +
  geom_segment(aes(x = 0.5, xend = 0.5, y = -0.5, yend = min(row) - 0.5),
               colour = lws_colors[["fade"]], linewidth = 0.4) +
  geom_text(aes(x = 0.2, y = row, label = year), hjust = 1, colour = lws_colors[["text"]]) +
  geom_point(aes(x = 0.5, y = row, colour = category, size = factor(significance))) +
  geom_text(aes(x = 0.8, y = row, label = event), hjust = 0, colour = lws_colors[["ink"]]) +
  scale_colour_manual(values = category_colors, name = NULL) +
  scale_size_manual(values = c("2" = 1.6, "3" = 2.8), labels = c("2" = "Notable", "3" = "Major"), name = NULL) +
  scale_x_continuous(limits = c(-0.1, 5.6), expand = c(0, 0)) +
  scale_y_continuous(expand = expansion(add = 0.6)) +
  labs(x = NULL, y = NULL, caption = "Source: Mastanduno (1992); Congressional Research Service reports; historical archives. Rows are evenly spaced, not to scale.") +
  theme_econ_textbook() +
  theme(axis.text = element_blank(), axis.ticks = element_blank(), axis.ticks.x = element_blank(), axis.title = element_blank(),
        panel.grid = element_blank(), panel.grid.major.y = element_blank(), legend.position = "top", legend.box = "vertical",
        legend.spacing.y = unit(0, "pt"), legend.margin = margin(0, 0, 0, 0)) +
  guides(colour = guide_legend(nrow = 2, order = 1, override.aes = list(size = 2.4)),
         size = guide_legend(nrow = 1, order = 2))

save_econ_figure(here::here("figures", "fig_01_06_cocom_timeline.png"), plot = p, width = 6, height = 5)

cat("Figure 1.6 created: CoCom Timeline\n")
