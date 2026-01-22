# Figure 10.6: Future Scenarios 2x2 Matrix
# Purpose: 2x2 quadrant plot of future economic relationship scenarios
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)
library(scales)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Define the four scenarios
scenarios <- tibble(
  Scenario = c("Managed Competition", "Economic Cold War",
               "Crisis Fragmentation", "Renewed Integration"),
  Quadrant = c("A", "B", "C", "D"),
  Integration = c(0.7, 0.2, 0.3, 0.8),   # X-axis: higher = more integrated
  Competition = c(0.3, 0.8, 0.9, 0.2),   # Y-axis: higher = more intense
  Probability = c(40, 25, 20, 15),
  Color = c("#2ca02c", "#d62728", "#ff7f0e", "#1f77b4"),
  Description = c(
    "Strategic competition\nwith guardrails;\ntargeted decoupling only",
    "Comprehensive decoupling;\ntechnology blocs form;\nlimited trade continues",
    "Crisis-driven rapid\nfragmentation;\nhigh volatility",
    "De-escalation;\nrules-based framework;\nexpanded cooperation"
  ),
  Key_Features = c(
    "- Tech restrictions on critical sectors\n- Trade continues in non-sensitive areas\n- Crisis communication channels",
    "- Full tech decoupling\n- Parallel financial systems\n- Bloc-based trade rules",
    "- Taiwan scenario trigger\n- Emergency restrictions\n- Supply chain chaos",
    "- New WTO-style framework\n- Joint climate initiatives\n- Reduced tariffs"
  )
)

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# --- Main Panel: 2x2 Matrix ---
p1 <- ggplot(scenarios, aes(x = Integration, y = Competition)) +
  # Quadrant backgrounds
  annotate("rect", xmin = 0, xmax = 0.5, ymin = 0.5, ymax = 1,
           fill = "#d62728", alpha = 0.15) +  # B: Cold War
  annotate("rect", xmin = 0, xmax = 0.5, ymin = 0, ymax = 0.5,
           fill = "#ff7f0e", alpha = 0.15) +  # C: Crisis

  annotate("rect", xmin = 0.5, xmax = 1, ymin = 0.5, ymax = 1,
           fill = "#2ca02c", alpha = 0.15) +  # A: Managed

  annotate("rect", xmin = 0.5, xmax = 1, ymin = 0, ymax = 0.5,
           fill = "#1f77b4", alpha = 0.15) +  # D: Renewed

  # Axis lines (crossing at center)
  geom_hline(yintercept = 0.5, color = "gray30", linewidth = 1) +
  geom_vline(xintercept = 0.5, color = "gray30", linewidth = 1) +

  # Scenario bubbles (sized by probability)
  geom_point(aes(size = Probability, fill = Scenario),
             shape = 21, color = "black", stroke = 1.5, alpha = 0.9) +

  # Scenario labels with probability
  geom_label(aes(label = paste0(Scenario, "\n(", Probability, "%)"), fill = Scenario),
             color = "white", fontface = "bold", size = 3.5,
             label.padding = unit(0.4, "lines"), label.size = 0.5,
             nudge_y = c(0.08, 0.08, -0.08, -0.08)) +

  # Quadrant labels
  annotate("text", x = 0.25, y = 0.95, label = "B",
           size = 8, fontface = "bold", color = "#d62728", alpha = 0.5) +
  annotate("text", x = 0.75, y = 0.95, label = "A",
           size = 8, fontface = "bold", color = "#2ca02c", alpha = 0.5) +
  annotate("text", x = 0.25, y = 0.05, label = "C",
           size = 8, fontface = "bold", color = "#ff7f0e", alpha = 0.5) +
  annotate("text", x = 0.75, y = 0.05, label = "D",
           size = 8, fontface = "bold", color = "#1f77b4", alpha = 0.5) +

  # Axis labels
  annotate("text", x = 0.5, y = -0.08, label = "INTEGRATION LEVEL",
           fontface = "bold", size = 4) +
  annotate("text", x = 0.05, y = 0.15, label = "Fragmented",
           angle = 90, size = 3.5, color = "gray40") +
  annotate("text", x = 0.95, y = 0.15, label = "Integrated",
           angle = 90, size = 3.5, color = "gray40") +
  annotate("text", x = -0.08, y = 0.5, label = "COMPETITION\nINTENSITY",
           fontface = "bold", size = 4, angle = 90) +
  annotate("text", x = 0.15, y = 0.05, label = "Managed",
           size = 3.5, color = "gray40") +
  annotate("text", x = 0.15, y = 0.95, label = "Intense",
           size = 3.5, color = "gray40") +

  scale_fill_manual(values = c(
    "Managed Competition" = "#2ca02c",
    "Economic Cold War" = "#d62728",
    "Crisis Fragmentation" = "#ff7f0e",
    "Renewed Integration" = "#1f77b4"
  ), guide = "none") +
  scale_size_continuous(range = c(15, 35), guide = "none") +
  scale_x_continuous(limits = c(-0.1, 1.1), expand = c(0, 0)) +
  scale_y_continuous(limits = c(-0.1, 1.1), expand = c(0, 0)) +
  coord_fixed() +

  labs(
    title = "Future Scenarios: US-China Economic Relations (2025-2035)",
    subtitle = "Four pathways based on integration level and competition intensity"
  ) +
  theme_void() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5, margin = margin(b = 5)),
    plot.subtitle = element_text(size = 11, hjust = 0.5, color = "gray30", margin = margin(b = 15)),
    plot.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(20, 20, 10, 20)
  )

# --- Panel B: Probability Distribution ---
scenarios_bar <- scenarios %>%
  mutate(Scenario = factor(Scenario, levels = c("Managed Competition", "Economic Cold War",
                                                 "Crisis Fragmentation", "Renewed Integration")))

p2 <- ggplot(scenarios_bar, aes(x = Scenario, y = Probability, fill = Scenario)) +
  geom_col(width = 0.7, alpha = 0.9, color = "black", linewidth = 0.5) +
  geom_text(aes(label = paste0(Probability, "%")), vjust = -0.3,
            fontface = "bold", size = 4) +

  scale_fill_manual(values = c(
    "Managed Competition" = "#2ca02c",
    "Economic Cold War" = "#d62728",
    "Crisis Fragmentation" = "#ff7f0e",
    "Renewed Integration" = "#1f77b4"
  ), guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15)),
                     labels = function(x) paste0(x, "%")) +

  labs(
    title = "Scenario Probability Assessment",
    subtitle = "Author's estimate for 2025-2035 timeframe",
    x = NULL,
    y = "Probability (%)"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text.x = element_text(angle = 20, hjust = 1),
    panel.grid.major.x = element_blank()
  )

# --- Panel C: Scenario Descriptions ---
desc_data <- scenarios %>%
  select(Quadrant, Scenario, Description, Probability) %>%
  mutate(
    x = c(1, 2, 1, 2),
    y = c(2, 2, 1, 1)
  )

p3 <- ggplot(desc_data, aes(x = x, y = y)) +
  geom_tile(aes(fill = Scenario), color = "white", linewidth = 2,
            width = 0.95, height = 0.95, alpha = 0.3) +
  geom_text(aes(label = paste0(Quadrant, ": ", Scenario, "\n\n", Description)),
            size = 3, lineheight = 1.1) +

  scale_fill_manual(values = c(
    "Managed Competition" = "#2ca02c",
    "Economic Cold War" = "#d62728",
    "Crisis Fragmentation" = "#ff7f0e",
    "Renewed Integration" = "#1f77b4"
  ), guide = "none") +
  scale_x_continuous(limits = c(0.4, 2.6)) +
  scale_y_continuous(limits = c(0.4, 2.6)) +

  labs(
    title = "Scenario Descriptions",
    subtitle = "Key characteristics of each pathway"
  ) +
  theme_void() +
  theme(
    plot.title = element_text(size = 12, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5, color = "gray30"),
    plot.background = element_rect(fill = "white", color = NA)
  )

# ============================================================================
# 3. COMPOSE AND SAVE
# ============================================================================

# Combine plots
combined <- p1 / (p2 + p3) +
  plot_layout(heights = c(1.5, 1)) +
  plot_annotation(
    title = "Figure 10.6: Future Scenarios 2x2 Matrix",
    subtitle = "Four potential pathways for US-China economic relations based on integration and competition dynamics",
    caption = paste0(
      "Source: Author's scenario analysis based on historical patterns, policy trends, and expert assessments.\n",
      "Note: Probabilities are subjective estimates for illustrative purposes.\n",
      "Scenario characteristics may evolve with changing geopolitical circumstances."
    ),
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  )

# Save
save_econ_figure(here("figures", "fig_10_06_scenario_matrix.png"), combined, width = 12, height = 13)

# Print summary
cat("\nFigure 10.6 Summary:\n")
cat("  Scenario A - Managed Competition: 40% probability\n")
cat("  Scenario B - Economic Cold War: 25% probability\n")
cat("  Scenario C - Crisis Fragmentation: 20% probability\n")
cat("  Scenario D - Renewed Integration: 15% probability\n")
cat("  Most likely outcome: Managed Competition with targeted decoupling\n")
