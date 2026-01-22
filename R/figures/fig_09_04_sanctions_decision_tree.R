# Figure 9.4: Sanctions Success Decision Tree
# Chapter 9: Historical Cases
# Analytical framework for predicting sanctions outcomes

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(ggforce)

# Define decision tree structure
tree_nodes <- data.frame(
  id = 1:15,
  label = c(
    "Economic Coercion\nInitiated",
    "Target\nVulnerable?",
    "Allies\nCoordinated?",
    "Low Success\nProbability",
    "Target Can\nAdapt?",
    "Objective\nModest?",
    "Medium Success\n(35%)",
    "Political Cost\nAcceptable?",
    "Off-Ramp\nAvailable?",
    "High Success\n(65%)",
    "Stalemate\nLikely",
    "Target Regime\nType?",
    "Lower Success\n(20%)",
    "Higher Success\n(50%)",
    "Protracted\nConflict"
  ),
  x = c(1, 2, 3, 3, 4, 5, 5, 6, 7, 7, 6, 4, 4.5, 4.5, 7),
  y = c(5, 5, 6, 4, 6, 7, 5, 6, 7, 5, 4.5, 4, 4.5, 3.5, 3.5),
  type = c(
    "start", "decision", "decision", "outcome", "decision", "decision",
    "outcome", "decision", "decision", "outcome", "outcome", "decision",
    "outcome", "outcome", "outcome"
  ),
  outcome_type = c(
    NA, NA, NA, "negative", NA, NA, "mixed", NA, NA, "positive",
    "mixed", NA, "negative", "mixed", "negative"
  )
)

# Define edges
edges <- data.frame(
  from = c(1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 8, 8, 9, 9, 12, 12),
  to = c(2, 3, 4, 5, 4, NA, 6, 12, 7, 8, 9, 11, 10, 15, 13, 14),
  label = c("", "Yes", "No", "Yes", "No", "", "Yes", "No", "No", "Yes",
            "Yes", "No", "Yes", "No", "Autocracy", "Democracy"),
  x = c(1.5, 2.5, 2.5, 3.5, 3.5, NA, 4.5, 4, 5, 5.5, 6.5, 6.3, 7, 7, 4.25, 4.25),
  y = c(5, 5.5, 4.5, 6, 5, NA, 6.5, 5, 6, 5.5, 6.5, 5.2, 6, 4.5, 4, 3.8),
  xend = c(2, 3, 3, 4, 4, NA, 5, 4, 5, 6, 7, 6, 7, 7, 4.5, 4.5),
  yend = c(5, 6, 4, 6, 4, NA, 7, 4, 5, 6, 7, 4.5, 5, 3.5, 4.5, 3.5)
) %>% filter(!is.na(to))

# Node colors
node_colors <- c(
  "start" = "#1f77b4",
  "decision" = "#ff7f0e",
  "outcome" = "#7f7f7f"
)

outcome_colors <- c(
  "positive" = "#2ca02c",
  "mixed" = "#ffbb78",
  "negative" = "#d62728"
)

# Create the visualization
p <- ggplot() +
  # Edges
  geom_segment(
    data = edges,
    aes(x = x, y = y, xend = xend, yend = yend),
    color = "gray50", linewidth = 0.8,
    arrow = arrow(length = unit(2, "mm"), type = "closed")
  ) +
  # Edge labels
  geom_label(
    data = edges %>% filter(label != ""),
    aes(x = (x + xend)/2, y = (y + yend)/2 + 0.15, label = label),
    size = 2.5, fill = "white", label.padding = unit(0.1, "lines")
  ) +
  # Decision nodes (diamonds via geom_shape would be ideal, using circles for simplicity)
  geom_point(
    data = tree_nodes %>% filter(type == "decision"),
    aes(x = x, y = y),
    shape = 23, size = 18, fill = node_colors["decision"], color = "white"
  ) +
  # Start node
  geom_point(
    data = tree_nodes %>% filter(type == "start"),
    aes(x = x, y = y),
    shape = 21, size = 18, fill = node_colors["start"], color = "white"
  ) +
  # Outcome nodes - colored by outcome type
  geom_point(
    data = tree_nodes %>% filter(type == "outcome"),
    aes(x = x, y = y, fill = outcome_type),
    shape = 22, size = 18, color = "white"
  ) +
  # Node labels
  geom_text(
    data = tree_nodes,
    aes(x = x, y = y, label = label),
    size = 2.5, lineheight = 0.9, fontface = "bold"
  ) +
  # Styling
  scale_fill_manual(
    values = outcome_colors,
    name = "Outcome",
    labels = c("positive" = "Likely Success", "mixed" = "Mixed/Uncertain", "negative" = "Likely Failure"),
    na.value = "gray70"
  ) +
  labs(
    title = "Sanctions Success: A Decision Framework",
    subtitle = "Key factors determining economic coercion outcomes",
    caption = "Source: Author's synthesis based on Hufbauer et al. (2007), Pape (1997), Drezner (1999)\nNote: Success rates are illustrative based on historical patterns"
  ) +
  coord_fixed(ratio = 0.7) +
  theme_void() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5, margin = margin(b = 5)),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray40", margin = margin(b = 15)),
    plot.caption = element_text(size = 9, hjust = 0, color = "gray50", margin = margin(t = 15)),
    plot.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(15, 15, 15, 15),
    legend.position = "bottom"
  )

# Save the figure
save_econ_figure(here::here("figures", "fig_09_04_sanctions_decision_tree.png"), plot = p, width = 12, height = 10)

cat("Figure 9.4 created: Sanctions Decision Tree\n")
