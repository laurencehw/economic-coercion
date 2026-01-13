# Figure 9.5: Historical Economic Coercion Outcomes
# Chapter 9: Historical Cases
# Scatter plot of economic cost vs political success across historical cases

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(ggrepel)

# Historical cases data
historical_cases <- data.frame(
  case = c(
    "Cuba (1960-present)", "Iran (1979-2015)", "Russia (2014-)",
    "South Africa (1985-1994)", "Iraq (1990-2003)", "North Korea (2006-)",
    "Libya (2011)", "Myanmar (1988-2016)", "Venezuela (2017-)",
    "Japan rare earths (2010)", "Soviet grain (1980)", "Iran nuclear (2012)",
    "Russia SWIFT (2022)", "Huawei (2019-)", "ZTE (2018)"
  ),
  target_gdp_impact = c(
    -4, -8, -12, -3, -48, -15, -25, -5, -25, -0.5, -2, -15, -8, -20, -30
  ),
  sender_cost = c(
    2, 1, 3, 0.5, 0.5, 0.1, 0.2, 0.1, 0.5, 0.2, 1.5, 1, 2, 5, 0.5
  ),
  success_score = c(
    15, 40, 25, 85, 35, 20, 90, 50, 20, 80, 30, 75, 40, 30, 95
  ),
  objective = c(
    "Regime Change", "Regime Change", "Policy Change",
    "Policy Change", "Policy Change", "Denuclearization",
    "Regime Change", "Democratization", "Regime Change",
    "Policy Change", "Policy Change", "Policy Change",
    "Policy Change", "Capability Denial", "Policy Change"
  ),
  duration_years = c(
    64, 36, 10, 9, 13, 18, 1, 28, 7, 0.3, 1, 3, 2, 5, 0.5
  ),
  multilateral = c(
    "Partial", "Full", "Full", "Full", "Full", "Full",
    "Full", "Partial", "Partial", "Unilateral", "Partial", "Full",
    "Full", "Partial", "Unilateral"
  )
)

# Objective colors
objective_colors <- c(
  "Regime Change" = "#d62728",
  "Policy Change" = "#1f77b4",
  "Denuclearization" = "#9467bd",
  "Democratization" = "#2ca02c",
  "Capability Denial" = "#ff7f0e"
)

# Multilateral shapes
multilateral_shapes <- c(
  "Full" = 16,
  "Partial" = 17,
  "Unilateral" = 15
)

# Create scatter plot
p <- ggplot(historical_cases, aes(x = -target_gdp_impact, y = success_score)) +
  # Quadrant backgrounds
  annotate("rect", xmin = 0, xmax = 25, ymin = 50, ymax = 100,
           fill = "#ccffcc", alpha = 0.3) +
  annotate("rect", xmin = 25, xmax = 50, ymin = 0, ymax = 50,
           fill = "#ffcccc", alpha = 0.3) +
  annotate("text", x = 12.5, y = 95, label = "High ROI\n(Success at Low Cost)",
           color = "#2ca02c", size = 3.5, fontface = "bold") +
  annotate("text", x = 37.5, y = 5, label = "Low ROI\n(Failure Despite High Cost)",
           color = "#d62728", size = 3.5, fontface = "bold") +
  # Points
  geom_point(aes(color = objective, shape = multilateral, size = duration_years),
             alpha = 0.8) +
  # Labels
  geom_text_repel(
    aes(label = case),
    size = 3, max.overlaps = 15,
    box.padding = 0.5, point.padding = 0.3
  ) +
  # Trend line
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed",
              color = "gray50", linewidth = 0.8) +
  # Scales
  scale_color_manual(values = objective_colors, name = "Objective") +
  scale_shape_manual(values = multilateral_shapes, name = "Coordination") +
  scale_size_continuous(range = c(3, 12), name = "Duration\n(Years)", breaks = c(1, 10, 30, 60)) +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Economic Coercion: Cost vs. Success",
    subtitle = "Historical cases plotted by target economic damage and policy success achieved",
    x = "Target GDP Impact (% decline)",
    y = "Success Score (%)",
    caption = "Source: Author's compilation based on Hufbauer et al., PIIE Sanctions Database\nNote: Success score is author's assessment combining policy change achieved and durability"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "right") +
  guides(
    color = guide_legend(order = 1),
    shape = guide_legend(order = 2),
    size = guide_legend(order = 3)
  )

# Save the figure
save_econ_figure("figures/fig_09_05_historical_outcomes.png", plot = p, width = 13, height = 10)

cat("Figure 9.5 created: Historical Outcomes Scatter\n")
