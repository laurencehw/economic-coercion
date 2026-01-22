# Figure 1.5: Weaponized Interdependence Network
# Chapter 1: Foundations of Economic Statecraft
# Network diagram showing US and China hub positions across domains

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(igraph)
library(ggraph)

# Define nodes (countries/regions and domains)
nodes <- data.frame(
  name = c(
    # Major actors
    "USA", "China", "EU", "Japan", "Taiwan", "South Korea",
    # Domains/chokepoints
    "Dollar Finance", "SWIFT", "Semiconductors", "Rare Earths",
    "Cloud Infrastructure", "Manufacturing", "5G Standards", "Energy"
  ),
  type = c(
    rep("actor", 6),
    rep("domain", 8)
  ),
  hub_controller = c(
    # Actors
    "USA", "China", "EU", "USA", "USA", "USA",
    # Domains - who controls
    "USA", "USA", "USA", "China", "USA", "China", "Contested", "Contested"
  )
)

# Define edges (dependencies/influence)
edges <- data.frame(
  from = c(
    # US hub positions
    "USA", "USA", "USA", "USA", "USA",
    # China hub positions
    "China", "China", "China",
    # Dependencies
    "EU", "Japan", "South Korea", "Taiwan",
    "EU", "Japan", "South Korea",
    "China", "EU", "Japan",
    # Cross-dependencies
    "USA", "China"
  ),
  to = c(
    # US controls
    "Dollar Finance", "SWIFT", "Semiconductors", "Cloud Infrastructure", "5G Standards",
    # China controls
    "Rare Earths", "Manufacturing", "5G Standards",
    # Actor dependencies on finance
    "Dollar Finance", "Dollar Finance", "Dollar Finance", "Dollar Finance",
    # Dependencies on semiconductors
    "Semiconductors", "Semiconductors", "Semiconductors",
    # Dependencies on rare earths
    "Rare Earths", "Rare Earths", "Rare Earths",
    # Cross-dependencies
    "Rare Earths", "Semiconductors"
  ),
  relationship = c(
    rep("controls", 5),
    rep("controls", 3),
    rep("depends", 4),
    rep("depends", 3),
    rep("depends", 3),
    rep("depends", 2)
  ),
  weight = c(
    rep(3, 8),  # Control relationships
    rep(1, 12)   # Dependency relationships
  )
)

# Create graph object
g <- graph_from_data_frame(edges, directed = TRUE, vertices = nodes)

# Set node attributes
V(g)$size <- ifelse(V(g)$type == "actor", 15, 10)
V(g)$color <- case_when(
  V(g)$name == "USA" ~ "#1f77b4",
  V(g)$name == "China" ~ "#d62728",
  V(g)$hub_controller == "USA" ~ "#aec7e8",
  V(g)$hub_controller == "China" ~ "#ff9896",
  V(g)$hub_controller == "Contested" ~ "#ffbb78",
  TRUE ~ "#c7c7c7"
)

# Create the network visualization
set.seed(42)
p <- ggraph(g, layout = "fr") +
  # Edges
  geom_edge_link(
    aes(
      edge_width = weight,
      edge_alpha = ifelse(relationship == "controls", 0.8, 0.4),
      edge_linetype = ifelse(relationship == "controls", "solid", "dashed")
    ),
    arrow = arrow(length = unit(3, "mm"), type = "closed"),
    end_cap = circle(8, "mm"),
    color = "gray50"
  ) +
  # Nodes
 geom_node_point(
    aes(size = ifelse(type == "actor", 20, 12),
        color = color),
    show.legend = FALSE
  ) +
  geom_node_text(
    aes(label = name),
    size = 3.5,
    repel = TRUE,
    fontface = "bold"
  ) +
  # Manual color scale
  scale_color_identity() +
  scale_edge_width(range = c(0.5, 2), guide = "none") +
  scale_edge_alpha(guide = "none") +
  scale_size_identity() +
  # Labels and theme
  labs(
    title = "Weaponized Interdependence: Network Structure",
    subtitle = "Hub positions and dependencies in the global economic system",
    caption = "Source: Author's analysis based on Farrell and Newman (2019)\nNote: Solid arrows = control; dashed arrows = dependency. Blue nodes = US-controlled; Red = China-controlled; Orange = contested"
  ) +
  theme_void() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5, margin = margin(b = 5)),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray40", margin = margin(b = 15)),
    plot.caption = element_text(size = 9, hjust = 0, color = "gray50", margin = margin(t = 15)),
    plot.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(15, 15, 15, 15)
  )

# Save the figure
save_econ_figure(here::here("figures", "fig_01_05_interdependence_network.png"), plot = p, width = 12, height = 10)

cat("Figure 1.5 created: Weaponized Interdependence Network\n")
