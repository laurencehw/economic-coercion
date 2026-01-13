# Figure 7.5: Sanctions Cascade Effect Diagram
# Chapter 7: Financial Statecraft
# Shows how primary sanctions trigger secondary and tertiary effects

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(ggforce)

# Define the cascade structure
cascade <- data.frame(
  level = c(
    rep("Primary", 4),
    rep("Secondary", 5),
    rep("Tertiary", 4),
    rep("Systemic", 3)
  ),
  effect = c(
    # Primary
    "Asset freeze", "SWIFT exclusion", "Trade embargo", "Visa bans",
    # Secondary
    "Third-country firms\navoid transactions", "Banks de-risk\nentire regions",
    "Supply chain\nreconfigurations", "Insurance/shipping\nwithdrawals", "Correspondent\nbanking cuts",
    # Tertiary
    "Alternative\npayment systems", "Currency\nhedging costs", "Humanitarian\nimpacts", "Black market\nemergence",
    # Systemic
    "De-dollarization\npressure", "Financial system\nbifurcation", "Sanctions fatigue"
  ),
  x = c(
    # Primary (spread across x=1)
    0.7, 1.0, 1.3, 1.6,
    # Secondary (spread across x=2)
    0.6, 0.9, 1.2, 1.5, 1.8,
    # Tertiary (spread across x=3)
    0.7, 1.0, 1.3, 1.6,
    # Systemic (spread across x=4)
    0.85, 1.15, 1.45
  ),
  level_num = c(rep(1, 4), rep(2, 5), rep(3, 4), rep(4, 3))
)

# Level colors
level_colors <- c(
  "Primary" = "#d62728",
  "Secondary" = "#ff7f0e",
  "Tertiary" = "#ffbb78",
  "Systemic" = "#9467bd"
)

# Create the cascade diagram
p <- ggplot() +
  # Stage backgrounds
  annotate("rect", xmin = 0.5, xmax = 1.5, ymin = 0.4, ymax = 2.0,
           fill = level_colors["Primary"], alpha = 0.15) +
  annotate("rect", xmin = 1.5, xmax = 2.5, ymin = 0.4, ymax = 2.0,
           fill = level_colors["Secondary"], alpha = 0.15) +
  annotate("rect", xmin = 2.5, xmax = 3.5, ymin = 0.4, ymax = 2.0,
           fill = level_colors["Tertiary"], alpha = 0.15) +
  annotate("rect", xmin = 3.5, xmax = 4.5, ymin = 0.4, ymax = 2.0,
           fill = level_colors["Systemic"], alpha = 0.15) +
  # Stage labels
  annotate("text", x = 1.0, y = 1.9, label = "PRIMARY\nSanctions",
           fontface = "bold", size = 4, color = level_colors["Primary"]) +
  annotate("text", x = 2.0, y = 1.9, label = "SECONDARY\nEffects",
           fontface = "bold", size = 4, color = level_colors["Secondary"]) +
  annotate("text", x = 3.0, y = 1.9, label = "TERTIARY\nConsequences",
           fontface = "bold", size = 4, color = level_colors["Tertiary"]) +
  annotate("text", x = 4.0, y = 1.9, label = "SYSTEMIC\nResponses",
           fontface = "bold", size = 4, color = level_colors["Systemic"]) +
  # Flow arrows
  geom_curve(
    data = data.frame(x = c(1.3, 2.3, 3.3), xend = c(1.7, 2.7, 3.7), y = 1.15, yend = 1.15),
    aes(x = x, xend = xend, y = y, yend = yend),
    arrow = arrow(length = unit(0.3, "cm"), type = "closed"),
    color = "gray40", linewidth = 1.5, curvature = 0
  ) +
  # Effect boxes
  geom_label(
    data = cascade,
    aes(x = level_num, y = x, label = effect, fill = level),
    color = "white", fontface = "bold", size = 3,
    label.padding = unit(0.3, "lines")
  ) +
  scale_fill_manual(values = level_colors, guide = "none") +
  scale_x_continuous(limits = c(0.3, 4.7)) +
  scale_y_continuous(limits = c(0.3, 2.1)) +
  labs(
    title = "The Sanctions Cascade: From Direct Impact to Systemic Response",
    subtitle = "How targeted measures propagate through the global financial system",
    caption = "Source: Author's analysis\nNote: Based on observed effects of comprehensive sanctions programs (Iran, Russia)"
  ) +
  coord_flip() +
  theme_void() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5, margin = margin(b = 5)),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray40", margin = margin(b = 15)),
    plot.caption = element_text(size = 9, hjust = 0, color = "gray50", margin = margin(t = 15)),
    plot.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(15, 15, 15, 15)
  )

# Save the figure
save_econ_figure("figures/fig_07_05_sanctions_cascade.png", plot = p, width = 14, height = 8)

cat("Figure 7.5 created: Sanctions Cascade Diagram\n")
