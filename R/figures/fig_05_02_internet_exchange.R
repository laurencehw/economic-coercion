# Figure 5.2: Internet Exchange Point Concentration
# Chapter 5: Information, Cyber, and Intelligence
# Shows global IXP traffic concentration - key infrastructure chokepoints

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(forcats)

# Load data
ixp_data <- read.csv("data/sources/internet_exchange_points.csv", stringsAsFactors = FALSE)

# Prepare data - top 15 by traffic
top_ixps <- ixp_data %>%
  arrange(desc(peak_traffic_tbps)) %>%
  head(15) %>%
  mutate(
    label = paste0(ixp_name, " (", city, ")"),
    label = fct_reorder(label, peak_traffic_tbps)
  )

# Assign region colors
region_colors <- c(
  "Europe" = "#2ca02c",
  "North America" = "#1f77b4",
  "Latin America" = "#c5b0d5",
  "Asia" = "#d62728",
  "Africa" = "#ff9896"
)

# Create the bar chart
p1 <- ggplot(top_ixps, aes(x = label, y = peak_traffic_tbps, fill = region)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(peak_traffic_tbps, " Tbps")),
            hjust = -0.1, size = 3.5, color = "gray30") +
  scale_fill_manual(values = region_colors, name = "Region") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  coord_flip() +
  labs(
    title = "Top Internet Exchange Points by Peak Traffic",
    subtitle = "Global internet infrastructure concentration (2024)",
    x = NULL,
    y = "Peak Traffic (Terabits per second)",
    caption = "Source: PeeringDB, IXP operator reports"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.y = element_blank(),
    legend.position = "right"
  )

# Create regional summary pie/bar
regional_summary <- ixp_data %>%
  group_by(region) %>%
  summarise(
    total_traffic = sum(peak_traffic_tbps),
    num_ixps = n(),
    .groups = "drop"
  ) %>%
  mutate(
    share = total_traffic / sum(total_traffic) * 100,
    region = fct_reorder(region, total_traffic)
  )

p2 <- ggplot(regional_summary, aes(x = region, y = share, fill = region)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0(round(share, 1), "%")),
            hjust = -0.1, size = 4, color = "gray30") +
  scale_fill_manual(values = region_colors, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  coord_flip() +
  labs(
    title = "IXP Traffic Share by Region",
    subtitle = "Percentage of global exchange traffic",
    x = NULL,
    y = "Share of Global Traffic (%)"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Combine plots
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(2, 1))

# Save the figure
save_econ_figure("figures/fig_05_02_internet_exchange.png", plot = combined, width = 11, height = 10)

cat("Figure 5.2 created: Internet Exchange Point Concentration\n")
