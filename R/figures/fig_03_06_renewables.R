# Figure 3.6: Renewable Energy Manufacturing - China's Dominance
# Author: Laurence Wilse-Samson
# Description: China's overwhelming share of clean energy technology production

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

renewables_data <- read_csv(here::here("data", "sources", "renewable_energy_manufacturing.csv"))

# Clean technology names for display
renewables_data <- renewables_data %>%
  mutate(
    Technology_Label = case_when(
      Technology == "Solar_Panels" ~ "Solar Panels",
      Technology == "Wind_Turbines" ~ "Wind Turbines",
      Technology == "EV_Batteries" ~ "EV Batteries",
      Technology == "Solar_Polysilicon" ~ "Solar Polysilicon",
      Technology == "Lithium_Refining" ~ "Lithium Refining",
      Technology == "Rare_Earth_Magnets" ~ "Rare Earth Magnets",
      Technology == "Inverters" ~ "Inverters",
      TRUE ~ Technology
    )
  )

# Prepare long format for plotting
renewables_long <- renewables_data %>%
  mutate(
    Technology_Label = fct_reorder(Technology_Label, China)
  ) %>%
  pivot_longer(
    cols = c(China, Europe, USA, Rest_of_Asia, Others),
    names_to = "Region",
    values_to = "Share"
  ) %>%
  mutate(
    Region = factor(Region, levels = c("China", "Europe", "USA", "Rest_of_Asia", "Others"))
  )

# ============================================================================
# DEFINE REGION COLORS
# ============================================================================

region_colors <- c(
  "China" = econ_colors["China"],
  "Europe" = econ_colors["EU"],
  "USA" = econ_colors["USA"],
  "Rest_of_Asia" = "#ff7f0e",  # Orange
  "Others" = "#7f7f7f"         # Gray
)

# ============================================================================
# PANEL A: STACKED HORIZONTAL BARS
# ============================================================================

panel_a <- ggplot(renewables_long, aes(x = Share, y = Technology_Label, fill = Region)) +
  geom_col(position = "stack", width = 0.75, color = "black", linewidth = 0.3) +
  geom_text(
    data = renewables_long %>% filter(Share >= 10),
    aes(label = paste0(Share, "%")),
    position = position_stack(vjust = 0.5),
    color = "white",
    fontface = "bold",
    size = 3.5
  ) +
  scale_fill_manual(values = region_colors) +
  scale_x_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 20),
    limits = c(0, 105),
    expand = c(0, 0)
  ) +
  labs(
    title = "Global Manufacturing Share by Technology",
    subtitle = "China dominates across all clean energy technologies",
    x = "Global Manufacturing Share (%)",
    y = NULL,
    fill = "Region"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "bottom",
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_text(face = "bold", size = 11)
  ) +
  # Add 50% reference line
  geom_vline(xintercept = 50, linetype = "dashed", color = "gray50", alpha = 0.7) +
  annotate(
    "text",
    x = 52,
    y = 7.5,
    label = "Majority\ncontrol",
    angle = 90,
    size = 2.5,
    color = "gray50",
    vjust = -0.5
  )

# ============================================================================
# PANEL B: CHINA'S SHARE BY TECHNOLOGY (RANKED)
# ============================================================================

china_share <- renewables_data %>%
  select(Technology_Label, China) %>%
  arrange(desc(China))

panel_b <- ggplot(china_share, aes(x = China, y = reorder(Technology_Label, China))) +
  geom_col(fill = region_colors["China"], alpha = 0.85, width = 0.75) +
  geom_text(
    aes(label = paste0(China, "%")),
    hjust = -0.2,
    fontface = "bold",
    size = 3.5,
    color = region_colors["China"]
  ) +
  scale_x_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 20),
    limits = c(0, 105),
    expand = c(0, 0)
  ) +
  labs(
    title = "China's Manufacturing Share (Ranked)",
    subtitle = "Average: 73% across all technologies",
    x = "China's Share (%)",
    y = NULL
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_text(face = "bold", size = 11)
  ) +
  # Add average line
  geom_vline(
    xintercept = mean(china_share$China),
    linetype = "dashed",
    color = region_colors["China"],
    linewidth = 1,
    alpha = 0.7
  ) +
  annotate(
    "text",
    x = mean(china_share$China),
    y = 7.5,
    label = paste0("Average: ", round(mean(china_share$China)), "%"),
    angle = 90,
    vjust = -0.5,
    size = 3,
    color = region_colors["China"],
    fontface = "bold"
  )

# ============================================================================
# PANEL C: CONCENTRATION INDEX (CHINA VS REST OF WORLD)
# ============================================================================

concentration_data <- renewables_data %>%
  mutate(
    Rest_of_World = Europe + USA + Rest_of_Asia + Others,
    Technology_Label = fct_reorder(Technology_Label, China)
  ) %>%
  select(Technology_Label, China, Rest_of_World) %>%
  pivot_longer(
    cols = c(China, Rest_of_World),
    names_to = "Group",
    values_to = "Share"
  ) %>%
  mutate(
    Group = factor(Group, levels = c("China", "Rest_of_World"))
  )

panel_c <- ggplot(concentration_data, aes(x = Technology_Label, y = Share, fill = Group)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.75, alpha = 0.85) +
  geom_hline(yintercept = 50, linetype = "dashed", color = "gray50", linewidth = 0.8) +
  scale_fill_manual(
    values = c("China" = region_colors["China"], "Rest_of_World" = "#7f7f7f"),
    labels = c("China" = "China", "Rest_of_World" = "Rest of World")
  ) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 25),
    limits = c(0, 100),
    expand = c(0, 0)
  ) +
  labs(
    title = "China vs. Rest of World",
    subtitle = "China exceeds rest of world combined in 5 of 7 technologies",
    x = NULL,
    y = "Manufacturing Share (%)",
    fill = NULL
  ) +
  coord_flip() +
  theme_econ_textbook() +
  theme(
    legend.position = "top",
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_text(face = "bold", size = 10)
  ) +
  annotate(
    "text",
    x = 7.5,
    y = 52,
    label = "Majority",
    angle = 0,
    size = 2.5,
    color = "gray50",
    hjust = 0
  )

# ============================================================================
# PANEL D: STRATEGIC IMPLICATIONS SUMMARY
# ============================================================================

# Create summary data
strategic_summary <- renewables_data %>%
  arrange(desc(China)) %>%
  mutate(
    Criticality = case_when(
      China >= 80 ~ "Critical Dependency",
      China >= 60 ~ "High Dependency",
      China >= 40 ~ "Moderate Dependency",
      TRUE ~ "Low Dependency"
    ),
    Criticality = factor(Criticality, levels = c("Critical Dependency", "High Dependency",
                                                  "Moderate Dependency", "Low Dependency"))
  )

crit_colors <- c(
  "Critical Dependency" = "#d62728",
  "High Dependency" = "#ff7f0e",
  "Moderate Dependency" = "#ffbb78",
  "Low Dependency" = "#98df8a"
)

panel_d <- ggplot(strategic_summary, aes(x = "", y = 1, fill = Criticality)) +
  geom_tile(aes(y = as.numeric(factor(Technology_Label))), height = 0.8, color = "white", linewidth = 2) +
  geom_text(
    aes(y = as.numeric(factor(Technology_Label)), label = paste0(Technology_Label, "\n", China, "%")),
    size = 3,
    fontface = "bold",
    color = "white"
  ) +
  scale_fill_manual(values = crit_colors) +
  labs(
    title = "Strategic Dependency Assessment",
    subtitle = "4 of 7 technologies show critical dependency on China",
    fill = "Dependency Level"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "bottom"
  )

# ============================================================================
# COMBINE PANELS
# ============================================================================

combined_plot <- ((panel_a / panel_b) | (panel_c / panel_d)) +
  plot_annotation(
    title = "Renewable Energy Manufacturing: China's Strategic Dominance",
    subtitle = "Global market share of clean energy technology production (2023-2024)",
    caption = paste0(
      "Source: International Energy Agency (IEA), BloombergNEF, industry reports\n",
      "Note: Market share based on manufacturing capacity and production volume. China's 73% average share across 7 key technologies creates\n",
      "strategic dependencies for global energy transition. Critical technologies (≥80% share): Solar panels, solar polysilicon, rare earth magnets."
    ),
    theme = theme_econ_textbook()
  ) +
  plot_layout(widths = c(1.2, 1))

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================

print(combined_plot)

# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_03_06_renewable_manufacturing.png"),
  plot = combined_plot,
  width = 16,
  height = 12,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 3.6 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_03_06_renewable_manufacturing.png\n")
cat("          figures/fig_03_06_renewable_manufacturing.pdf\n")
cat("\n")
cat("China's Manufacturing Dominance:\n")
cat("--------------------------------\n")
for (i in 1:nrow(renewables_data)) {
  tech <- renewables_data$Technology_Label[i]
  share <- renewables_data$China[i]
  cat(sprintf("  %s: %d%%\n", tech, share))
}
cat("\n")
cat("Summary Statistics:\n")
cat(sprintf("  Average China share: %.0f%%\n", mean(renewables_data$China)))
cat(sprintf("  Highest: Rare Earth Magnets (%d%%)\n", max(renewables_data$China)))
cat(sprintf("  Lowest: Lithium Refining (%d%%)\n", min(renewables_data$China)))
cat("\n")
cat("Strategic Assessment:\n")
cat("  - 4 of 7 technologies: Critical dependency (≥80%)\n")
cat("  - 3 of 7 technologies: High dependency (60-79%)\n")
cat("  - China controls >60% in ALL clean energy technologies\n")
cat("  - Average 73% share creates systemic supply chain risk\n")
cat("========================================\n")
cat("\n")
