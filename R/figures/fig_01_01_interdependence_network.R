# Figure 1.1: Weaponized Interdependence Network
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

# Set node attributes: house palette; controller colour for domain nodes
V(g)$color <- case_when(
  V(g)$name == "USA" ~ lws_colors[["blue"]],
  V(g)$name == "China" ~ lws_colors[["red"]],
  V(g)$hub_controller == "USA" ~ "#A3C3DE",
  V(g)$hub_controller == "China" ~ "#EBA3A5",
  V(g)$hub_controller == "Contested" ~ lws_colors[["gold"]],
  TRUE ~ lws_colors[["fade"]]
)

# Create the network visualization (title and note live in the chapter caption)
set.seed(42)
p <- ggraph(g, layout = "fr") +
  geom_edge_link(
    aes(edge_width = weight, edge_colour = relationship),
    arrow = arrow(length = unit(1.6, "mm"), type = "closed"),
    end_cap = circle(3.5, "mm"), start_cap = circle(2.5, "mm")
  ) +
  geom_node_point(
    aes(size = ifelse(type == "actor", 7, 4.5), colour = color),
    show.legend = FALSE
  ) +
  geom_node_text(
    aes(label = name, y = y + ifelse(type == "domain", -0.22, 0.22)), family = lws_family,
    size = book_text_size, colour = lws_colors[["ink"]]
  ) +
  scale_y_continuous(expand = expansion(mult = 0.1)) +
  scale_x_continuous(expand = expansion(mult = 0.06)) +
  scale_colour_identity() +
  scale_size_identity() +
  scale_edge_width(range = c(0.35, 1.1), guide = "none") +
  scale_edge_colour_manual(
    values = c(controls = lws_colors[["ink"]], depends = lws_colors[["fade"]]),
    labels = c(controls = "Controls (hub position)", depends = "Depends on"),
    name = NULL
  ) +
  book_source("Source: Author's analysis based on Farrell and Newman (2019). Node colour: blue = US-controlled, red = China-controlled, gold = contested.") +
  theme_void(base_size = 9, base_family = lws_family) +
  theme(
    legend.position = "top", legend.justification = "left",
    legend.text = element_text(size = 7.5, colour = lws_colors[["text"]]),
    plot.caption = element_text(hjust = 0, size = 7, colour = lws_colors[["text"]], margin = margin(t = 6)),
    plot.caption.position = "plot",
    plot.background = element_rect(fill = "white", colour = NA),
    plot.margin = margin(8, 12, 8, 8)
  )

save_econ_figure(here::here("figures", "fig_01_01_interdependence_network.png"), plot = p, width = 6, height = 4.6)

cat("Figure 1.1 created: Weaponized Interdependence Network\n")
