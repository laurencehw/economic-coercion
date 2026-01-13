# Figure 10.5: Energy Transition Creates New Dependencies
# Chapter 10: Future of Economic Coercion
# Shows how clean energy creates new strategic vulnerabilities

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(forcats)

# New dependency landscape
new_deps <- data.frame(
  material = c(
    "Lithium", "Cobalt", "Nickel", "Rare Earths",
    "Graphite", "Copper", "Manganese", "Silicon (Solar)"
  ),
  current_demand_kt = c(85, 140, 2500, 180, 1100, 25000, 14000, 500),
  projected_2040_kt = c(500, 280, 6000, 450, 2800, 45000, 28000, 1500),
  growth_multiple = c(5.9, 2.0, 2.4, 2.5, 2.5, 1.8, 2.0, 3.0),
  china_processing_share = c(65, 72, 35, 90, 70, 40, 55, 95),
  top_producer = c(
    "Australia", "DRC", "Indonesia", "China",
    "China", "Chile", "South Africa", "China"
  ),
  application = c(
    "Batteries", "Batteries", "Batteries", "Motors/Turbines",
    "Batteries", "Wiring/EVs", "Batteries", "Solar Panels"
  )
)

# Application colors
app_colors <- c(
  "Batteries" = "#ff7f0e",
  "Motors/Turbines" = "#1f77b4",
  "Wiring/EVs" = "#2ca02c",
  "Solar Panels" = "#9467bd"
)

# Panel 1: Demand growth
new_deps <- new_deps %>%
  mutate(material = fct_reorder(material, growth_multiple))

p1 <- ggplot(new_deps, aes(x = material, y = growth_multiple, fill = application)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(growth_multiple, "x")), hjust = -0.1, size = 4, fontface = "bold") +
  coord_flip() +
  scale_fill_manual(values = app_colors, name = "Primary Use") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Critical Mineral Demand Growth (2024-2040)",
    subtitle = "Projected increase driven by energy transition",
    x = NULL,
    y = "Growth Multiple"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Panel 2: China processing dominance
p2 <- ggplot(new_deps, aes(x = reorder(material, -china_processing_share),
                           y = china_processing_share, fill = application)) +
  geom_col(width = 0.7) +
  geom_hline(yintercept = 50, linetype = "dashed", color = "gray40") +
  geom_text(aes(label = paste0(china_processing_share, "%")), vjust = -0.3, size = 3.5) +
  annotate("text", x = 7.5, y = 53, label = "Concentration threshold",
           size = 3, color = "gray40") +
  scale_fill_manual(values = app_colors, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = "China's Processing Dominance",
    subtitle = "Share of global refining/processing capacity",
    x = NULL,
    y = "China Processing Share (%)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.x = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Panel 3: Old vs New dependencies comparison
dep_comparison <- data.frame(
  era = c(rep("Fossil Fuel Era", 4), rep("Clean Energy Era", 4)),
  dependency = c(
    "Oil (Middle East)", "Natural Gas (Russia)", "Coal", "Uranium",
    "Lithium", "Rare Earths", "Cobalt", "Solar Manufacturing"
  ),
  concentration = c(
    65, 40, 25, 30,
    75, 90, 70, 95
  ),
  china_exposure = c(
    15, 10, 20, 5,
    65, 90, 72, 95
  )
)

dep_comparison <- dep_comparison %>%
  mutate(dependency = fct_reorder(dependency, concentration))

p3 <- ggplot(dep_comparison, aes(x = dependency, y = concentration)) +
  geom_col(aes(fill = era), width = 0.6) +
  geom_point(aes(y = china_exposure), color = "#d62728", size = 4, shape = 18) +
  coord_flip() +
  facet_wrap(~era, scales = "free_y") +
  scale_fill_manual(
    values = c("Fossil Fuel Era" = "#7f7f7f", "Clean Energy Era" = "#2ca02c"),
    guide = "none"
  ) +
  labs(
    title = "Changing Dependencies: Fossil Fuels vs Clean Energy",
    subtitle = "Supply concentration (bars) and China exposure (red diamonds)",
    x = NULL,
    y = "Supply Concentration (%)",
    caption = "Source: IEA Critical Minerals Report, BloombergNEF, author calculations\nNote: Red diamonds show China's control over supply chain"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Combine
library(patchwork)
combined <- (p1 + p2) / p3 + plot_layout(heights = c(1, 1))

# Save the figure
save_econ_figure("figures/fig_10_05_new_dependencies.png", plot = combined, width = 14, height = 12)

cat("Figure 10.5 created: New Dependencies\n")
