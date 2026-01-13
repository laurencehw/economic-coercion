# Figure 4.4: Huawei Revenue Impact from Sanctions
# Chapter 4: High Technology Competition
# Shows before/after sanctions effect on Huawei's business

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)

# Load data
huawei <- read.csv("data/sources/huawei_revenue.csv", stringsAsFactors = FALSE)

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

# Segment colors
segment_colors <- c(
  "Consumer (Smartphones)" = "#d62728",
  "Carrier (Telecom Equipment)" = "#1f77b4",
  "Enterprise Solutions" = "#2ca02c"
)

# Create the main chart
p1 <- ggplot(huawei_long, aes(x = year, y = revenue, fill = segment)) +
  # Sanction phase background
  annotate("rect", xmin = 2018.5, xmax = 2019.5, ymin = 0, ymax = 150,
           fill = "#ffcccc", alpha = 0.3) +
  annotate("rect", xmin = 2019.5, xmax = 2024.5, ymin = 0, ymax = 150,
           fill = "#ffaaaa", alpha = 0.3) +
  # Stacked area
  geom_area(alpha = 0.8, color = "white", linewidth = 0.3) +
  # Key event annotations
  geom_vline(xintercept = 2019, linetype = "dashed", color = "gray40") +
  geom_vline(xintercept = 2020, linetype = "dashed", color = "gray40") +
  annotate("text", x = 2019, y = 145, label = "Entity List\n(May 2019)",
           size = 3, hjust = 0.5, color = "gray30") +
  annotate("text", x = 2020, y = 145, label = "FDPR Expansion\n(2020)",
           size = 3, hjust = 0.5, color = "gray30") +
  # Styling
  scale_fill_manual(values = segment_colors, name = "Business Segment") +
  scale_x_continuous(breaks = 2015:2024) +
  scale_y_continuous(labels = function(x) paste0("$", x, "B"), expand = expansion(mult = c(0, 0.05))) +
  labs(
    title = "Huawei Revenue by Business Segment (2015-2024)",
    subtitle = "Impact of US export controls on China's leading technology company",
    x = "Year",
    y = "Revenue (USD Billions)",
    caption = "Source: Huawei Annual Reports\nNote: Shaded areas indicate sanction periods"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "right")

# Year-over-year growth chart
p2 <- ggplot(huawei, aes(x = year, y = yoy_growth)) +
  geom_hline(yintercept = 0, color = "gray50", linewidth = 0.5) +
  geom_col(aes(fill = yoy_growth > 0), width = 0.6, show.legend = FALSE) +
  geom_text(aes(label = paste0(yoy_growth, "%"),
                vjust = ifelse(yoy_growth > 0, -0.5, 1.5)),
            size = 3.5, color = "gray30") +
  scale_fill_manual(values = c("TRUE" = "#2ca02c", "FALSE" = "#d62728")) +
  scale_x_continuous(breaks = 2015:2024) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Year-over-Year Revenue Growth",
    subtitle = "Sanctions triggered first-ever decline in 2021",
    x = "Year",
    y = "YoY Growth (%)"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank())

# Combine plots
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(2, 1))

# Save the figure
save_econ_figure("figures/fig_04_04_huawei_impact.png", plot = combined, width = 12, height = 11)

cat("Figure 4.4 created: Huawei Sanctions Impact\n")
