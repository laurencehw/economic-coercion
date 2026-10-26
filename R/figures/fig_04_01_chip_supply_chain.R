# Figure 4.1: Semiconductor Supply Chain Flow (Sankey Diagram)
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

# Region colours (house hues; light fills carry dark labels)
region_colors <- c(
  "USA" = lws_colors[["blue"]],
  "Taiwan" = lws_colors[["gold"]],
  "South Korea" = "#595959",
  "China" = lws_colors[["red"]],
  "Japan" = lws_colors[["purple"]],
  "Netherlands" = "#1F4A37",
  "Europe" = lws_colors[["green"]],
  "Malaysia" = "#9E9E9E",
  "Other" = "#E0E0E0",
  "Mixed" = "#E0E0E0"
)
light_regions <- c("Taiwan", "Other", "Mixed", "Malaysia")
stage_summary <- stage_summary %>% mutate(light = region %in% light_regions)

p <- ggplot(stage_summary, aes(x = factor(stage_order), y = value, fill = region)) +
  geom_col(width = 0.7, colour = "white", linewidth = 0.3) +
  geom_text(
    aes(label = ifelse(value >= 10, paste0(value, "%"), ""), colour = light, group = region),
    position = position_stack(vjust = 0.5), size = book_text_size, show.legend = FALSE
  ) +
  scale_colour_manual(values = c("TRUE" = lws_colors[["ink"]], "FALSE" = "white")) +
  scale_fill_manual(values = region_colors, name = NULL,
                    breaks = c("USA", "Europe", "Netherlands", "Japan", "Taiwan", "South Korea", "China", "Malaysia", "Other")) +
  scale_x_discrete(
    labels = c(
      "1" = "Design software\n(EDA)",
      "2" = "Manufacturing\nequipment",
      "3" = "Chip\ndesign",
      "4" = "Wafer\nfabrication",
      "5" = "Assembly,\ntest and pack"
    )
  ) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), breaks = seq(0, 100, 25), expand = expansion(mult = c(0, 0.08))) +
  annotate("text", x = 1, y = 104, label = "U.S. chokepoint", colour = lws_colors[["text"]]) +
  annotate("text", x = 2, y = 104, label = "Allied chokepoint", colour = lws_colors[["text"]]) +
  annotate("text", x = 4, y = 104, label = "Taiwan risk", colour = lws_colors[["text"]]) +
  labs(x = NULL, y = "Share of global market") +
  book_source("Sources: SIA; BCG; company reports (2023-2024). Leading-edge manufacturing (7nm and below) shows higher Taiwan concentration (about 90%).") +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank(), legend.position = "top")

save_econ_figure(here::here("figures", "fig_04_01_chip_supply_chain.png"), plot = p, width = 6, height = 4.2)

cat("Figure 4.1 created: Semiconductor Supply Chain\n")
