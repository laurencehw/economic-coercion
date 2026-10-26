# Figure 2.4: Supply Chain Risk Matrix
# Chapter 2: Supply Chains and Critical Infrastructure
# Plots concentration vs criticality for key inputs

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
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
    92, 100, 90, 20, 70, 80,
    86, 70, 75, 98, 60, 73,
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

# Category colours (house hues)
category_colors <- c(
  "Semiconductors" = lws_colors[["blue"]],
  "Materials" = lws_colors[["orange"]],
  "Pharmaceuticals" = lws_colors[["green"]],
  "Telecommunications" = lws_colors[["purple"]],
  "Energy" = lws_colors[["red"]]
)

# Risk matrix: the critical-risk quadrant is the only shaded zone
p <- ggplot(supply_risks, aes(x = concentration, y = criticality)) +
  annotate("rect", xmin = 70, xmax = 105, ymin = 70, ymax = 105, fill = lws_colors[["red"]], alpha = 0.08) +
  annotate("text", x = 104, y = 104, label = "Critical-risk quadrant", hjust = 1, vjust = 1,
           colour = lws_colors[["red"]]) +
  geom_hline(yintercept = 70, colour = lws_colors[["ref"]], linewidth = 0.4, linetype = "22") +
  geom_vline(xintercept = 70, colour = lws_colors[["ref"]], linewidth = 0.4, linetype = "22") +
  geom_point(aes(colour = category), size = 2.2) +
  geom_text_repel(aes(label = input), max.overlaps = 20, box.padding = 0.35, point.padding = 0.2,
                  segment.colour = lws_colors[["fade"]], segment.size = 0.3, seed = 7) +
  scale_colour_manual(values = category_colors, name = NULL) +
  scale_x_continuous(labels = function(x) paste0(x, "%"), limits = c(15, 105), breaks = seq(20, 100, 20)) +
  scale_y_continuous(limits = c(55, 105), breaks = seq(60, 100, 10)) +
  labs(x = "Supply concentration (top producer's share)", y = "Strategic criticality (author's ordinal score, 0 to 100)") +
  book_source("Sources: Author's assessment (criticality); concentration from USGS Mineral Commodity Summaries 2025, IEA, TrendForce and FDA facility data. API is on the FDA registered-facility basis (China about 20%).") +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_line(colour = lws_colors[["grid"]], linewidth = 0.4))

save_econ_figure(here::here("figures", "fig_02_04_supply_chain_risk.png"), plot = p, width = 6, height = 4.4)

cat("Figure 2.4 created: Supply Chain Risk Matrix\n")
