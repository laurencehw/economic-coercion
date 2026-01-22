# Figure 4.3: Semiconductor Supply Chain Flow (Sankey Diagram)
# Chapter 4: High Technology Competition
# Visualizes the global semiconductor value chain and chokepoints

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(ggalluvial)

# Define supply chain stages and flows
# Format: from_stage, to_stage, region, value (market share %)
supply_chain <- data.frame(
  from_stage = c(
    # Design (EDA tools)
    rep("EDA Tools", 3),
    # Design (fabless)
    rep("Chip Design", 5),
    # Manufacturing
    rep("Manufacturing", 5),
    # Packaging/Testing
    rep("ATP", 5),
    # Equipment
    rep("Equipment", 4)
  ),
  to_stage = c(
    # EDA to Design
    "Chip Design", "Chip Design", "Chip Design",
    # Design to Manufacturing
    "Manufacturing", "Manufacturing", "Manufacturing", "Manufacturing", "Manufacturing",
    # Manufacturing to ATP
    "ATP", "ATP", "ATP", "ATP", "ATP",
    # ATP to End Market
    "End Products", "End Products", "End Products", "End Products", "End Products",
    # Equipment to Manufacturing
    "Manufacturing", "Manufacturing", "Manufacturing", "Manufacturing"
  ),
  region = c(
    # EDA (US dominates)
    "USA", "Europe", "Other",
    # Design regions
    "USA", "Taiwan", "China", "Europe", "Other",
    # Manufacturing regions
    "Taiwan", "South Korea", "China", "USA", "Other",
    # ATP regions
    "China", "Taiwan", "Malaysia", "South Korea", "Other",
    # Equipment regions
    "USA", "Netherlands", "Japan", "Other"
  ),
  value = c(
    # EDA market share
    85, 10, 5,
    # Design market share
    50, 20, 15, 10, 5,
    # Manufacturing (leading edge)
    65, 20, 5, 5, 5,
    # ATP market share
    40, 25, 15, 10, 10,
    # Equipment market share
    45, 20, 25, 10
  ),
  control = c(
    rep("US-controlled", 3),
    "US-controlled", "US-aligned", "China", "US-aligned", "Mixed",
    "US-aligned", "US-aligned", "China", "US-controlled", "Mixed",
    "China", "US-aligned", "US-aligned", "US-aligned", "Mixed",
    "US-controlled", "US-aligned", "US-aligned", "Mixed"
  )
)

# Create a cleaner visualization using stacked bars by stage
stage_summary <- supply_chain %>%
  group_by(from_stage, region, control) %>%
  summarise(value = sum(value), .groups = "drop") %>%
  mutate(
    stage_order = case_when(
      from_stage == "EDA Tools" ~ 1,
      from_stage == "Equipment" ~ 2,
      from_stage == "Chip Design" ~ 3,
      from_stage == "Manufacturing" ~ 4,
      from_stage == "ATP" ~ 5
    ),
    stage_label = case_when(
      from_stage == "EDA Tools" ~ "Design Software\n(EDA)",
      from_stage == "Equipment" ~ "Manufacturing\nEquipment",
      from_stage == "Chip Design" ~ "Chip\nDesign",
      from_stage == "Manufacturing" ~ "Wafer\nFabrication",
      from_stage == "ATP" ~ "Assembly\nTest & Pack"
    )
  )

# Region colors
region_colors <- c(
  "USA" = "#1f77b4",
  "Taiwan" = "#aec7e8",
  "South Korea" = "#8c564b",
  "China" = "#d62728",
  "Japan" = "#9467bd",
  "Netherlands" = "#2ca02c",
  "Europe" = "#2ca02c",
  "Malaysia" = "#ffbb78",
  "Other" = "#c7c7c7",
  "Mixed" = "#e7e7e7"
)

# Create the stacked bar chart
p <- ggplot(stage_summary, aes(x = factor(stage_order), y = value, fill = region)) +
  geom_col(width = 0.7, color = "white", linewidth = 0.3) +
  geom_text(
    aes(label = ifelse(value >= 10, paste0(value, "%"), "")),
    position = position_stack(vjust = 0.5),
    color = "white", fontface = "bold", size = 3.5
  ) +
  scale_fill_manual(values = region_colors, name = "Country/Region") +
  scale_x_discrete(
    labels = c(
      "1" = "Design Software\n(EDA)",
      "2" = "Manufacturing\nEquipment",
      "3" = "Chip\nDesign",
      "4" = "Wafer\nFabrication",
      "5" = "Assembly\nTest & Pack"
    )
  ) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), expand = expansion(mult = c(0, 0.05))) +
  # Add chokepoint indicators
  annotate("text", x = 1, y = 105, label = "US Chokepoint", color = "#1f77b4", fontface = "bold", size = 3.5) +
  annotate("text", x = 2, y = 105, label = "Allied Chokepoint", color = "#2ca02c", fontface = "bold", size = 3.5) +
  annotate("text", x = 4, y = 105, label = "Taiwan Risk", color = "#ff7f0e", fontface = "bold", size = 3.5) +
  labs(
    title = "Global Semiconductor Supply Chain: Regional Market Shares",
    subtitle = "Chokepoints in the chip value chain exploitable for economic coercion",
    x = "Supply Chain Stage",
    y = "Market Share (%)",
    caption = "Source: SIA, BCG, company reports (2023-2024)\nNote: Leading-edge manufacturing (7nm and below) shows even higher Taiwan concentration (~90%)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.x = element_blank(),
    legend.position = "right"
  )

# Save the figure
save_econ_figure(here::here("figures", "fig_04_03_chip_supply_chain.png"), plot = p, width = 12, height = 8)

cat("Figure 4.3 created: Semiconductor Supply Chain\n")
