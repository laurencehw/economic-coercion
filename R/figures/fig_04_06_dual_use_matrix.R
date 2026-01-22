# Figure 4.6: Dual-Use Technology Matrix
# Chapter 4: High Technology Competition
# Shows technologies with both commercial and military applications

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# Define dual-use technology matrix
dual_use <- data.frame(
  technology = c(
    "Advanced Semiconductors",
    "Artificial Intelligence",
    "Quantum Computing",
    "Biotechnology",
    "Hypersonics",
    "Space Technology",
    "Autonomous Systems",
    "Advanced Materials",
    "5G/6G Networks",
    "Cyber Capabilities"
  ),
  commercial_intensity = c(10, 10, 6, 9, 3, 7, 8, 7, 10, 6),
  military_intensity = c(10, 10, 9, 7, 10, 9, 10, 8, 7, 10),
  us_lead = c(8, 8, 7, 8, 6, 9, 7, 7, 6, 9),
  china_lead = c(5, 7, 5, 6, 8, 6, 7, 6, 8, 8),
  commercial_example = c(
    "Consumer electronics, EVs",
    "Recommendation systems",
    "Drug discovery",
    "Gene therapy, vaccines",
    "High-speed transport",
    "Satellites, GPS",
    "Self-driving cars",
    "Lightweight structures",
    "Mobile connectivity",
    "Fraud detection"
  ),
  military_example = c(
    "Guided weapons, radar",
    "Autonomous targeting",
    "Code breaking",
    "Bioweapons defense",
    "Missile systems",
    "Reconnaissance, ASAT",
    "Drones, UUVs",
    "Stealth, armor",
    "Secure comms, EW",
    "Offensive operations"
  ),
  control_status = c(
    "Heavy restrictions",
    "Emerging controls",
    "Emerging controls",
    "Biosecurity focus",
    "Strict controls",
    "ITAR controlled",
    "Mixed regime",
    "Selective controls",
    "Standards battle",
    "Intelligence focus"
  )
)

# Calculate dual-use score (product of intensities)
dual_use <- dual_use %>%
  mutate(
    dual_use_score = commercial_intensity * military_intensity / 10,
    category = case_when(
      dual_use_score >= 8 ~ "Critical Dual-Use",
      dual_use_score >= 5 ~ "Significant Dual-Use",
      TRUE ~ "Moderate Dual-Use"
    )
  )

# Category colors
category_colors <- c(
  "Critical Dual-Use" = "#d62728",
  "Significant Dual-Use" = "#ff7f0e",
  "Moderate Dual-Use" = "#2ca02c"
)

# Create scatter plot
p1 <- ggplot(dual_use, aes(x = commercial_intensity, y = military_intensity)) +
  # Quadrant backgrounds
  annotate("rect", xmin = 7, xmax = 10.5, ymin = 7, ymax = 10.5,
           fill = "#ffcccc", alpha = 0.3) +
  annotate("text", x = 8.75, y = 10.2, label = "CRITICAL\nDUAL-USE",
           color = "#d62728", fontface = "bold", size = 3.5) +
  # Points
  geom_point(aes(size = dual_use_score, color = category), alpha = 0.8) +
  geom_text(aes(label = technology), vjust = -1, size = 3, check_overlap = FALSE) +
  # Styling
  scale_color_manual(values = category_colors, name = "Category") +
  scale_size_continuous(range = c(4, 15), name = "Dual-Use\nScore", guide = "none") +
  scale_x_continuous(limits = c(2, 11), breaks = seq(2, 10, 2)) +
  scale_y_continuous(limits = c(2, 11), breaks = seq(2, 10, 2)) +
  labs(
    title = "Dual-Use Technology Assessment Matrix",
    subtitle = "Commercial vs. military application intensity (scale 1-10)",
    x = "Commercial Application Intensity",
    y = "Military Application Intensity"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "right")

# US vs China leadership comparison
leadership <- dual_use %>%
  select(technology, us_lead, china_lead) %>%
  pivot_longer(cols = c(us_lead, china_lead), names_to = "country", values_to = "score") %>%
  mutate(
    country = ifelse(country == "us_lead", "United States", "China"),
    technology = factor(technology, levels = rev(dual_use$technology[order(dual_use$dual_use_score)]))
  )

p2 <- ggplot(leadership, aes(x = technology, y = score, fill = country)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6) +
  coord_flip() +
  scale_fill_manual(
    values = c("United States" = "#1f77b4", "China" = "#d62728"),
    name = NULL
  ) +
  scale_y_continuous(limits = c(0, 10), breaks = seq(0, 10, 2)) +
  labs(
    title = "Technology Leadership Assessment",
    subtitle = "Relative capability (scale 1-10)",
    x = NULL,
    y = "Leadership Score",
    caption = "Source: Author's assessment based on industry reports, government assessments\nNote: Scores reflect current (2024) relative capabilities"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.y = element_blank(),
    legend.position = "bottom"
  )

# Combine plots
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1.2, 1))

# Save the figure
save_econ_figure(here::here("figures", "fig_04_06_dual_use_matrix.png"), plot = combined, width = 12, height = 12)

cat("Figure 4.6 created: Dual-Use Technology Matrix\n")
