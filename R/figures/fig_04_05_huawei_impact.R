# Figure 4.4: Huawei Revenue Impact from Sanctions
# Chapter 4: High Technology Competition
# Shows before/after sanctions effect on Huawei's business

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# Load data
huawei <- read.csv(here::here("data", "sources", "huawei_revenue.csv"), stringsAsFactors = FALSE)

# Reshape for stacked area
huawei_long <- huawei %>%
  select(year, consumer_business, carrier_business, enterprise_business, sanctions_phase) %>%
  pivot_longer(
    cols = c(consumer_business, carrier_business, enterprise_business),
    names_to = "segment",
    values_to = "revenue"
  ) %>%
  mutate(
    segment = case_when(
      segment == "consumer_business" ~ "Consumer (Smartphones)",
      segment == "carrier_business" ~ "Carrier (Telecom Equipment)",
      segment == "enterprise_business" ~ "Enterprise Solutions"
    ),
    segment = factor(segment, levels = c("Consumer (Smartphones)", "Carrier (Telecom Equipment)", "Enterprise Solutions"))
  )

# Segment colours: consumer (the segment most exposed) in red
segment_colors <- c(
  "Consumer (Smartphones)" = lws_colors[["red"]],
  "Carrier (Telecom Equipment)" = lws_colors[["blue"]],
  "Enterprise Solutions" = lws_colors[["fade"]]
)

totals <- huawei %>% select(year, total_revenue_billions)

# One panel: stacked bars by year (ten annual observations). The year-over-year growth panel of the
# earlier dashboard is dropped; growth is implied by the totals printed above the bars.
combined <- ggplot(huawei_long, aes(x = year, y = revenue, fill = segment)) +
  annotate("rect", xmin = 2018.5, xmax = 2024.5, ymin = 0, ymax = 160, fill = "#F2F2F2") +
  geom_col(width = 0.7) +
  geom_text(data = totals, aes(x = year, y = total_revenue_billions, label = paste0("$", round(total_revenue_billions), "B")),
            inherit.aes = FALSE, vjust = -0.5, colour = lws_colors[["ink"]], size = book_text_size) +
  annotate("text", x = 2018.6, y = 158, label = "Entity List\n(May 2019)", hjust = 0, vjust = 1, lineheight = 0.9,
           colour = lws_colors[["text"]]) +
  annotate("text", x = 2020.6, y = 158, label = "Entity List and expanded\nforeign direct product rule (2020)", hjust = 0, vjust = 1,
           lineheight = 0.9, colour = lws_colors[["text"]]) +
  scale_fill_manual(values = segment_colors, name = NULL) +
  scale_x_continuous(breaks = 2015:2024) +
  scale_y_continuous(labels = function(x) paste0("$", x, "B"), limits = c(0, 160), expand = c(0, 0)) +
  labs(x = NULL, y = "Revenue, billions of US dollars") +
  book_source("Source: Compiled estimates; segment series not reconciled to Huawei annual-report classifications. Shading marks the period of U.S. restrictions.") +
  theme_econ_textbook()

save_econ_figure(here::here("figures", "fig_04_05_huawei_impact.png"), plot = combined, width = 6, height = 4)

cat("Figure 4.5 created: Huawei Sanctions Impact\n")
