# Figure 5.4: Cloud Infrastructure Market Share
# Chapter 5: Information, Cyber, and Intelligence
# Shows US vs Chinese dominance in global cloud infrastructure

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)

# Load data
cloud_data <- read.csv("data/sources/cloud_market_share.csv", stringsAsFactors = FALSE)

# Filter to 2024 data for main comparison
cloud_2024 <- cloud_data %>%
  filter(year == 2024, provider != "Others") %>%
  mutate(
    provider_country = case_when(
      headquarters == "USA" ~ "US Providers",
      headquarters == "China" ~ "Chinese Providers",
      TRUE ~ "Other"
    )
  )

# Provider colors
provider_colors <- c(
  "Amazon AWS" = "#FF9900",
  "Microsoft Azure" = "#00A4EF",
  "Google Cloud" = "#4285F4",
  "Alibaba Cloud" = "#FF6A00",
  "Tencent Cloud" = "#20A0FF",
  "Huawei Cloud" = "#CF0A2C",
  "Oracle Cloud" = "#F80000"
)

# Panel 1: Global market share
p1 <- ggplot(cloud_2024, aes(x = reorder(provider, -global_share), y = global_share, fill = provider)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(global_share, "%")), vjust = -0.3, size = 3.5) +
  scale_fill_manual(values = provider_colors, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = "Global Cloud Infrastructure Market Share (2024)",
    x = NULL,
    y = "Market Share (%)"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major.x = element_blank()
  )

# Panel 2: Regional comparison (US vs China markets)
regional_data <- cloud_2024 %>%
  select(provider, us_share, china_share) %>%
  pivot_longer(cols = c(us_share, china_share),
               names_to = "market",
               values_to = "share") %>%
  mutate(
    market = case_when(
      market == "us_share" ~ "US Market",
      market == "china_share" ~ "China Market"
    )
  ) %>%
  filter(share > 0.5)  # Filter out negligible shares

p2 <- ggplot(regional_data, aes(x = reorder(provider, -share), y = share, fill = provider)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(round(share, 1), "%")), vjust = -0.3, size = 3) +
  scale_fill_manual(values = provider_colors, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  facet_wrap(~market, scales = "free_x") +
  labs(
    title = "Cloud Market Share: US vs China Domestic Markets",
    subtitle = "Stark bifurcation between US and Chinese cloud ecosystems",
    x = NULL,
    y = "Market Share (%)"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 9),
    panel.grid.major.x = element_blank()
  )

# Panel 3: Time series of US vs Chinese provider share
time_series <- cloud_data %>%
  filter(provider != "Others") %>%
  mutate(
    provider_origin = ifelse(headquarters == "USA", "US Providers", "Chinese Providers")
  ) %>%
  group_by(year, provider_origin) %>%
  summarise(total_share = sum(global_share), .groups = "drop")

p3 <- ggplot(time_series, aes(x = year, y = total_share, color = provider_origin)) +
  geom_line(linewidth = 1.5) +
  geom_point(size = 3) +
  scale_color_manual(
    values = c("US Providers" = "#1f77b4", "Chinese Providers" = "#d62728"),
    name = NULL
  ) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "US vs Chinese Cloud Provider Global Market Share",
    subtitle = "US providers maintain dominant position despite Chinese growth",
    x = "Year",
    y = "Combined Global Market Share (%)",
    caption = "Source: Synergy Research, Canalys, company reports"
  ) +
  theme_econ_textbook()

# Combine all panels
library(patchwork)
combined <- p1 / p2 / p3 + plot_layout(heights = c(1, 1.2, 1))

# Save the figure
save_econ_figure("figures/fig_05_04_cloud_market.png", plot = combined, width = 11, height = 14)

cat("Figure 5.4 created: Cloud Infrastructure Market Share\n")
