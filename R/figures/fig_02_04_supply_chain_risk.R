# Figure 2.4: Supply Chain Risk Matrix
# Chapter 2: Supply Chains and Critical Infrastructure
# Plots concentration vs criticality for key inputs

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(ggrepel)

# Supply chain risk assessment
supply_risks <- data.frame(
  input = c(
    "Leading-edge chips", "EUV lithography", "Rare earth magnets",
    "API (pharma)", "5G equipment", "EV batteries",
    "Solar panels", "Advanced packaging", "Memory chips",
    "Gallium", "Germanium", "Cobalt",
    "Natural graphite", "Neon gas", "Semiconductor gases"
  ),
  concentration = c(
    92, 100, 90, 75, 70, 77,
    85, 70, 75, 80, 60, 70,
    70, 50, 60
  ),
  criticality = c(
    95, 100, 80, 85, 75, 85,
    70, 90, 80, 70, 65, 75,
    80, 90, 85
  ),
  dominant_source = c(
    "Taiwan (TSMC)", "Netherlands (ASML)", "China",
    "China/India", "China", "China",
    "China", "Taiwan", "South Korea",
    "China", "China", "DRC/China",
    "China", "Ukraine/China", "Japan/US"
  ),
  category = c(
    "Semiconductors", "Semiconductors", "Materials",
    "Pharmaceuticals", "Telecommunications", "Energy",
    "Energy", "Semiconductors", "Semiconductors",
    "Materials", "Materials", "Materials",
    "Materials", "Materials", "Semiconductors"
  )
)

# Calculate risk score
supply_risks <- supply_risks %>%
  mutate(
    risk_score = (concentration * criticality) / 100,
    risk_level = case_when(
      risk_score >= 80 ~ "Critical",
      risk_score >= 60 ~ "High",
      risk_score >= 40 ~ "Medium",
      TRUE ~ "Low"
    )
  )

# Category colors
category_colors <- c(
  "Semiconductors" = "#1f77b4",
  "Materials" = "#ff7f0e",
  "Pharmaceuticals" = "#2ca02c",
  "Telecommunications" = "#9467bd",
  "Energy" = "#d62728"
)

# Create risk matrix
p <- ggplot(supply_risks, aes(x = concentration, y = criticality)) +
  # Risk zone backgrounds
  annotate("rect", xmin = 70, xmax = 105, ymin = 70, ymax = 105,
           fill = "#d62728", alpha = 0.15) +
  annotate("rect", xmin = 50, xmax = 70, ymin = 70, ymax = 105,
           fill = "#ff7f0e", alpha = 0.15) +
  annotate("rect", xmin = 70, xmax = 105, ymin = 50, ymax = 70,
           fill = "#ff7f0e", alpha = 0.15) +
  annotate("text", x = 87, y = 100, label = "CRITICAL RISK",
           color = "#d62728", fontface = "bold", size = 4) +
  # Points
  geom_point(aes(color = category, size = risk_score), alpha = 0.8) +
  geom_text_repel(
    aes(label = input),
    size = 3, max.overlaps = 15,
    box.padding = 0.4, point.padding = 0.3
  ) +
  # Reference lines
  geom_hline(yintercept = 70, linetype = "dashed", color = "gray50", alpha = 0.5) +
  geom_vline(xintercept = 70, linetype = "dashed", color = "gray50", alpha = 0.5) +
  # Annotations
  annotate("text", x = 52, y = 50, label = "Lower Risk\nQuadrant",
           color = "gray50", size = 3.5) +
  # Styling
  scale_color_manual(values = category_colors, name = "Category") +
  scale_size_continuous(range = c(3, 12), name = "Risk Score", guide = "none") +
  scale_x_continuous(labels = function(x) paste0(x, "%"), limits = c(45, 105)) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(45, 105)) +
  labs(
    title = "Supply Chain Risk Matrix",
    subtitle = "Critical inputs plotted by supply concentration and strategic importance",
    x = "Supply Concentration (Top Producer Share %)",
    y = "Strategic Criticality (%)",
    caption = "Source: Author's assessment based on industry data, government reports\nNote: Bubble size reflects combined risk score (concentration × criticality)"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "right")

# Save the figure
save_econ_figure("figures/fig_02_04_supply_chain_risk.png", plot = p, width = 12, height = 10)

cat("Figure 2.4 created: Supply Chain Risk Matrix\n")
