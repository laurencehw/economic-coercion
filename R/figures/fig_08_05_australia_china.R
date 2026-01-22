# Figure 8.5: Australia-China Trade Restrictions Case Study
# Chapter 8: Investment Screening and Industrial Policy
# Shows impact of Chinese economic coercion on Australian exports

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# Load data
australia <- read.csv(here::here("data", "sources", "australia_china_trade.csv"), stringsAsFactors = FALSE)

# Calculate changes and sort
australia <- australia %>%
  mutate(
    change_billions = exports_2021_billions - exports_2019_billions,
    affected = ifelse(pct_change_2019_2021 < -50, "Severely Affected",
                      ifelse(pct_change_2019_2021 < 0, "Moderately Affected", "Unaffected")),
    product = factor(product, levels = product[order(pct_change_2019_2021)])
  )

# Colors
impact_colors <- c(
  "Severely Affected" = "#d62728",
  "Moderately Affected" = "#ff7f0e",
  "Unaffected" = "#2ca02c"
)

# Panel 1: Percentage change
p1 <- ggplot(australia, aes(x = product, y = pct_change_2019_2021, fill = affected)) +
  geom_col(width = 0.7) +
  geom_hline(yintercept = 0, color = "gray40", linewidth = 0.8) +
  geom_text(aes(label = paste0(pct_change_2019_2021, "%"),
                hjust = ifelse(pct_change_2019_2021 > 0, -0.1, 1.1)),
            size = 3) +
  coord_flip() +
  scale_fill_manual(values = impact_colors, name = "Impact Level") +
  scale_y_continuous(labels = function(x) paste0(x, "%"),
                     limits = c(-110, 100)) +
  labs(
    title = "Australian Exports to China: 2019 vs 2021",
    subtitle = "Percentage change during peak trade restrictions",
    x = NULL,
    y = "Change (%)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.y = element_blank(),
    legend.position = "right"
  )

# Panel 2: Absolute values comparison
australia_long <- australia %>%
  select(product, exports_2019_billions, exports_2021_billions, exports_2023_billions) %>%
  pivot_longer(cols = -product, names_to = "year", values_to = "value") %>%
  mutate(
    year = case_when(
      year == "exports_2019_billions" ~ "2019",
      year == "exports_2021_billions" ~ "2021",
      year == "exports_2023_billions" ~ "2023"
    ),
    year = factor(year, levels = c("2019", "2021", "2023"))
  ) %>%
  filter(product %in% c("Iron Ore", "Coal", "Wine", "Barley", "Lobster", "LNG"))

p2 <- ggplot(australia_long, aes(x = product, y = value, fill = year)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  scale_fill_manual(
    values = c("2019" = "#1f77b4", "2021" = "#d62728", "2023" = "#2ca02c"),
    name = "Year"
  ) +
  scale_y_continuous(labels = function(x) paste0("$", x, "B")) +
  labs(
    title = "Key Export Categories: Before, During, and After Restrictions",
    subtitle = "Recovery varies by product as restrictions ease (2023-2024)",
    x = NULL,
    y = "Exports (AUD Billions)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.x = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Panel 3: Timeline annotations
timeline <- data.frame(
  date = as.Date(c("2020-04-19", "2020-05-18", "2020-11-27", "2021-03-26",
                   "2023-08-04", "2023-12-14", "2024-03-28")),
  event = c("Morrison calls for\nCOVID inquiry",
            "Barley tariffs\nimposed (80%)",
            "Wine tariffs\nimposed (200%+)",
            "Strategic Economic\nDialogue suspended",
            "Barley tariffs\nunder review",
            "Barley tariffs\nremoved",
            "Wine tariffs\nremoved"),
  y_pos = c(1, -1, 1, -1, 1, -1, 1)
)

p3 <- ggplot(timeline, aes(x = date, y = 0)) +
  geom_hline(yintercept = 0, color = "gray40", linewidth = 1) +
  geom_point(size = 4, color = "#d62728") +
  geom_segment(aes(xend = date, yend = y_pos * 0.7), color = "gray50") +
  geom_label(aes(y = y_pos * 0.85, label = event), size = 2.5,
             fill = "gray95", label.padding = unit(0.2, "lines")) +
  annotate("rect", xmin = as.Date("2020-04-01"), xmax = as.Date("2023-06-01"),
           ymin = -1.2, ymax = 1.2, fill = "#ffcccc", alpha = 0.2) +
  annotate("text", x = as.Date("2021-09-01"), y = -1.1,
           label = "Coercion Period", color = "gray50", size = 3.5) +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  labs(
    title = "Australia-China Economic Coercion Timeline",
    subtitle = "From political trigger to gradual de-escalation",
    x = NULL,
    y = NULL,
    caption = "Source: Australian Bureau of Statistics, DFAT, news reports\nNote: Iron ore remained untouched due to China's dependence on Australian supply"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid = element_blank()
  )

# Combine
library(patchwork)
combined <- p1 / p2 / p3 + plot_layout(heights = c(1.5, 1, 0.8))

# Save the figure
save_econ_figure(here::here("figures", "fig_08_05_australia_china.png"), plot = combined, width = 12, height = 14)

cat("Figure 8.5 created: Australia-China Trade Restrictions\n")
