# Figure 8.4: CFIUS Reviews Over Time
# Chapter 8: Investment Screening and Industrial Policy
# Shows growth in investment screening activity

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)

# Load data
cfius <- read.csv("data/sources/cfius_reviews.csv", stringsAsFactors = FALSE)

# Reshape for stacked area
cfius_long <- cfius %>%
  select(year, declarations, notices, withdrawals, mitigation_agreements) %>%
  pivot_longer(cols = -year, names_to = "metric", values_to = "count") %>%
  mutate(
    metric = case_when(
      metric == "declarations" ~ "Short-Form Declarations",
      metric == "notices" ~ "Full Notices",
      metric == "withdrawals" ~ "Withdrawals (abandoned)",
      metric == "mitigation_agreements" ~ "Mitigation Required"
    ),
    metric = factor(metric, levels = c("Full Notices", "Short-Form Declarations",
                                        "Withdrawals (abandoned)", "Mitigation Required"))
  )

# Colors
metric_colors <- c(
  "Full Notices" = "#1f77b4",
  "Short-Form Declarations" = "#2ca02c",
  "Withdrawals (abandoned)" = "#d62728",
  "Mitigation Required" = "#ff7f0e"
)

# Panel 1: Activity over time
p1 <- ggplot(cfius_long %>% filter(metric %in% c("Full Notices", "Short-Form Declarations")),
             aes(x = year, y = count, fill = metric)) +
  geom_area(alpha = 0.8, color = "white", linewidth = 0.3) +
  geom_vline(xintercept = 2018, linetype = "dashed", color = "gray40") +
  annotate("text", x = 2018.2, y = 450, label = "FIRRMA\nEnacted",
           hjust = 0, size = 3.5, color = "gray40") +
  scale_fill_manual(values = metric_colors, name = "Filing Type") +
  scale_x_continuous(breaks = seq(2010, 2024, 2)) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.05))) +
  labs(
    title = "CFIUS Review Activity (2010-2024)",
    subtitle = "Investment screening filings increased significantly after FIRRMA (2018)",
    x = "Year",
    y = "Number of Filings"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "right")

# Panel 2: Outcomes
p2 <- ggplot(cfius, aes(x = year)) +
  geom_col(aes(y = withdrawals), fill = "#d62728", alpha = 0.7, width = 0.4,
           position = position_nudge(x = -0.2)) +
  geom_col(aes(y = mitigation_agreements), fill = "#ff7f0e", alpha = 0.7, width = 0.4,
           position = position_nudge(x = 0.2)) +
  scale_x_continuous(breaks = seq(2010, 2024, 2)) +
  labs(
    title = "CFIUS Enforcement Outcomes",
    subtitle = "Withdrawals (red) and mitigation agreements (orange) by year",
    x = "Year",
    y = "Number of Cases"
  ) +
  theme_econ_textbook()

# Panel 3: China-related percentage
p3 <- ggplot(cfius, aes(x = year, y = china_related_pct)) +
  geom_line(color = "#d62728", linewidth = 1.2) +
  geom_point(color = "#d62728", size = 3) +
  geom_area(fill = "#d62728", alpha = 0.2) +
  scale_x_continuous(breaks = seq(2010, 2024, 2)) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, 50)) +
  labs(
    title = "China-Related CFIUS Cases",
    subtitle = "Estimated share of reviews involving Chinese investors",
    x = "Year",
    y = "Share of Reviews (%)",
    caption = "Source: CFIUS Annual Reports to Congress, author estimates\nNote: FIRRMA = Foreign Investment Risk Review Modernization Act"
  ) +
  theme_econ_textbook()

# Combine
library(patchwork)
combined <- p1 / (p2 + p3) + plot_layout(heights = c(1.2, 1))

# Save the figure
save_econ_figure("figures/fig_08_04_cfius_reviews.png", plot = combined, width = 13, height = 11)

cat("Figure 8.4 created: CFIUS Reviews\n")
