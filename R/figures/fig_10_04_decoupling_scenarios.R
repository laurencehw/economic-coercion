# Figure 10.4: Decoupling Scenarios
# Chapter 10: Future of Economic Coercion
# Multi-path scenario diagram showing possible futures

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# Define scenario characteristics
scenarios <- data.frame(
  scenario = c(
    "Managed Competition",
    "Selective Decoupling",
    "Cold War 2.0",
    "Hot Decoupling"
  ),
  tech_integration = c(75, 50, 20, 5),
  trade_volume = c(85, 65, 40, 15),
  financial_links = c(90, 70, 35, 10),
  conflict_risk = c(20, 35, 60, 90),
  probability = c(25, 45, 20, 10),
  description = c(
    "Competition with guardrails;\nlimited tech restrictions",
    "Strategic sectors separated;\nbroad trade continues",
    "Comprehensive decoupling;\nbloc formation",
    "Active economic warfare;\ncrisis escalation"
  )
)

# Scenario colors
scenario_colors <- c(
  "Managed Competition" = "#2ca02c",
  "Selective Decoupling" = "#1f77b4",
  "Cold War 2.0" = "#ff7f0e",
  "Hot Decoupling" = "#d62728"
)

# Panel 1: Probability distribution
scenarios$scenario <- factor(scenarios$scenario,
                             levels = c("Managed Competition", "Selective Decoupling",
                                       "Cold War 2.0", "Hot Decoupling"))

p1 <- ggplot(scenarios, aes(x = scenario, y = probability, fill = scenario)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0(probability, "%")), vjust = -0.3, size = 4, fontface = "bold") +
  scale_fill_manual(values = scenario_colors, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Scenario Probability Assessment",
    subtitle = "Author's estimate of likelihood over 2025-2035 timeframe",
    x = NULL,
    y = "Probability (%)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.x = element_blank(),
    axis.text.x = element_text(angle = 20, hjust = 1)
  )

# Panel 2: Radar chart data (as parallel coordinates)
scenarios_long <- scenarios %>%
  select(scenario, tech_integration, trade_volume, financial_links, conflict_risk) %>%
  pivot_longer(cols = -scenario, names_to = "dimension", values_to = "value") %>%
  mutate(
    dimension = case_when(
      dimension == "tech_integration" ~ "Tech\nIntegration",
      dimension == "trade_volume" ~ "Trade\nVolume",
      dimension == "financial_links" ~ "Financial\nLinks",
      dimension == "conflict_risk" ~ "Conflict\nRisk"
    ),
    dimension = factor(dimension, levels = c("Tech\nIntegration", "Trade\nVolume",
                                              "Financial\nLinks", "Conflict\nRisk"))
  )

p2 <- ggplot(scenarios_long, aes(x = dimension, y = value, color = scenario, group = scenario)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 4) +
  scale_color_manual(values = scenario_colors, name = "Scenario") +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Scenario Characteristics",
    subtitle = "How key dimensions vary across scenarios",
    x = NULL,
    y = "Level (%)"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "right")

# Panel 3: Timeline / pathway diagram
pathway_data <- data.frame(
  year = rep(c(2024, 2027, 2030, 2035), 4),
  scenario = rep(c("Managed Competition", "Selective Decoupling",
                   "Cold War 2.0", "Hot Decoupling"), each = 4),
  integration_index = c(
    # Managed Competition
    100, 90, 85, 80,
    # Selective Decoupling
    100, 75, 60, 55,
    # Cold War 2.0
    100, 60, 40, 30,
    # Hot Decoupling
    100, 50, 25, 10
  )
)

p3 <- ggplot(pathway_data, aes(x = year, y = integration_index, color = scenario)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  annotate("text", x = 2024, y = 105, label = "Today", size = 3.5, fontface = "bold") +
  scale_color_manual(values = scenario_colors, name = "Scenario") +
  scale_x_continuous(breaks = c(2024, 2027, 2030, 2035)) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, 110)) +
  labs(
    title = "Economic Integration Pathways (2024-2035)",
    subtitle = "Projected US-China integration index under each scenario",
    x = "Year",
    y = "Integration Index (2024 = 100)",
    caption = "Source: Author's scenario analysis\nNote: Integration index combines trade, investment, and technology linkages"
  ) +
  theme_econ_textbook()

# Combine
library(patchwork)
combined <- p1 / p2 / p3 + plot_layout(heights = c(0.8, 1, 1))

# Save the figure
save_econ_figure(here::here("figures", "fig_10_04_decoupling_scenarios.png"), plot = combined, width = 12, height = 13)

cat("Figure 10.4 created: Decoupling Scenarios\n")
