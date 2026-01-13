# Figure 3.9: Energy Transition Dependencies - Sankey Diagram
# Chapter 3: Critical Sectors
# Shows shift from fossil fuel to clean energy dependencies

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(ggalluvial)

# Energy dependency flows
energy_flows <- data.frame(
  era = c(
    rep("Fossil Fuel Era", 8),
    rep("Clean Energy Era", 10)
  ),
  source_region = c(
    # Fossil fuel
    "Middle East", "Middle East", "Russia", "Russia",
    "USA", "Australia", "Various", "Various",
    # Clean energy
    "China", "China", "China", "China", "China",
    "DRC", "Chile", "Australia", "Indonesia", "Various"
  ),
  resource = c(
    # Fossil
    "Oil", "Natural Gas", "Oil", "Natural Gas",
    "LNG", "Coal", "Uranium", "Oil",
    # Clean
    "Solar Panels", "Rare Earths", "Lithium Processing", "Battery Cells", "Graphite",
    "Cobalt Mining", "Lithium Mining", "Lithium Mining", "Nickel", "Copper"
  ),
  application = c(
    rep("Transportation", 2), rep("Electricity", 2),
    "Electricity", "Electricity", "Electricity", "Petrochemicals",
    "Electricity", "EVs/Wind", "EVs", "EVs", "EVs",
    "EVs", "EVs", "EVs", "EVs", "Grid/EVs"
  ),
  value = c(
    # Fossil (relative importance)
    30, 15, 20, 25, 10, 15, 5, 10,
    # Clean (relative importance)
    25, 20, 18, 30, 15, 12, 15, 10, 12, 20
  ),
  stringsAsFactors = FALSE
)

# Create alluvial for fossil era
fossil_data <- energy_flows %>%
  filter(era == "Fossil Fuel Era") %>%
  count(source_region, resource, application, wt = value)

# Create alluvial for clean era
clean_data <- energy_flows %>%
  filter(era == "Clean Energy Era") %>%
  count(source_region, resource, application, wt = value)

# Region colors (distinct colors for each major actor)
region_colors <- c(
  "Middle East" = "#ff7f0e",
  "Russia" = "#9467bd",
  "USA" = "#1f77b4",
  "Australia" = "#17becf",
  "Various" = "#7f7f7f",
  "China" = "#d62728",
  "DRC" = "#e377c2",
  "Chile" = "#2ca02c",
  "Indonesia" = "#bcbd22"
)

# Panel 1: Fossil fuel dependencies
p1 <- ggplot(fossil_data,
             aes(axis1 = source_region, axis2 = resource, axis3 = application, y = n)) +
  geom_alluvium(aes(fill = source_region), width = 1/12, alpha = 0.7) +
  geom_stratum(width = 1/6, fill = "gray90", color = "gray40") +
  geom_text(stat = "stratum", aes(label = after_stat(stratum)), size = 3) +
  scale_fill_manual(values = region_colors, guide = "none") +
  scale_x_discrete(limits = c("Source Region", "Resource", "Application"),
                   expand = expansion(mult = 0.15)) +
  labs(
    title = "Fossil Fuel Era Dependencies",
    subtitle = "Traditional energy supply chain structure"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank()
  )

# Panel 2: Clean energy dependencies
p2 <- ggplot(clean_data,
             aes(axis1 = source_region, axis2 = resource, axis3 = application, y = n)) +
  geom_alluvium(aes(fill = source_region), width = 1/12, alpha = 0.7) +
  geom_stratum(width = 1/6, fill = "gray90", color = "gray40") +
  geom_text(stat = "stratum", aes(label = after_stat(stratum)), size = 2.8) +
  scale_fill_manual(values = region_colors, name = "Source") +
  scale_x_discrete(limits = c("Source Region", "Resource", "Application"),
                   expand = expansion(mult = 0.15)) +
  labs(
    title = "Clean Energy Era Dependencies",
    subtitle = "New supply chains concentrate through China",
    caption = "Source: IEA, BloombergNEF, author analysis\nNote: Flow width represents relative strategic importance"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    legend.position = "right"
  )

# Combine
library(patchwork)
combined <- p1 / p2 +
  plot_annotation(
    title = "Energy Transition: From Oil Dependencies to Mineral Dependencies",
    theme = theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5))
  )

# Save the figure
save_econ_figure("figures/fig_03_09_energy_sankey.png", plot = combined, width = 13, height = 12)

cat("Figure 3.9 created: Energy Transition Sankey\n")
