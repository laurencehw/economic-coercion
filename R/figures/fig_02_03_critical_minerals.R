# Figure 2.3: China's Dominance in Critical Minerals
# Author: Laurence Wilse-Samson
# Description: China's share of global mining and processing for critical minerals

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

minerals_data <- read_csv(here::here("data", "sources", "critical_minerals_data.csv"))

# Prepare data for plotting
minerals_long <- minerals_data %>%
  select(Mineral, China_Processing_Share, China_Mining_Share) %>%
  pivot_longer(
    cols = c(China_Processing_Share, China_Mining_Share),
    names_to = "Activity",
    values_to = "Share"
  ) %>%
  mutate(
    Activity = case_when(
      Activity == "China_Processing_Share" ~ "Processing",
      Activity == "China_Mining_Share" ~ "Mining"
    ),
    # Convert to percentage
    Share_Pct = Share * 100,
    # Reorder minerals by processing share for better visualization
    Mineral = fct_reorder(Mineral, Share, .fun = max)
  )

# ============================================================================
# MAIN PLOT: GROUPED HORIZONTAL BARS
# ============================================================================

main_plot <- ggplot(minerals_long, aes(x = Share_Pct, y = Mineral, fill = Activity)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.7, alpha = 0.9) +
  scale_x_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 20),
    limits = c(0, 100),
    expand = c(0, 0)
  ) +
  scale_fill_manual(
    values = c("Processing" = econ_colors["China"],
               "Mining" = econ_colors["USA"]),
    labels = c("Processing" = "Processing Share",
               "Mining" = "Mining Share")
  ) +
  labs(
    title = "China's Dominance in Critical Minerals",
    subtitle = "China's share of global mining and processing capacity by mineral",
    x = "Share of Global Capacity (%)",
    y = NULL,
    fill = "Activity"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "bottom",
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_text(face = "bold", size = 11)
  ) +
  # Add vertical line at 50% for reference
  geom_vline(xintercept = 50, linetype = "dashed", color = "gray50", alpha = 0.5) +
  annotate(
    "text",
    x = 52,
    y = 11,
    label = "Majority control",
    angle = 90,
    size = 3,
    color = "gray50",
    vjust = -0.5
  )

# ============================================================================
# SUPPLEMENTARY PLOT: PROCESSING VS MINING SCATTER
# ============================================================================

scatter_plot <- ggplot(minerals_data, aes(x = China_Mining_Share * 100, y = China_Processing_Share * 100)) +
  geom_point(size = 4, alpha = 0.7, color = econ_colors["China"]) +
  geom_text(
    aes(label = Mineral),
    size = 3,
    vjust = -0.8,
    color = "gray30",
    fontface = "bold"
  ) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray50", alpha = 0.7) +
  scale_x_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 20),
    limits = c(0, 100)
  ) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 100, 20),
    limits = c(0, 100)
  ) +
  labs(
    title = "Processing Dominance Exceeds Mining Share",
    subtitle = "Points above the diagonal indicate downstream concentration",
    x = "China Mining Share (%)",
    y = "China Processing Share (%)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.minor = element_blank()
  ) +
  annotate(
    "text",
    x = 70,
    y = 30,
    label = "Equal\nshares",
    angle = 45,
    size = 3,
    color = "gray50",
    fontface = "italic"
  ) +
  annotate(
    "text",
    x = 20,
    y = 70,
    label = "Processing\ndominance",
    size = 3.5,
    color = econ_colors["China"],
    fontface = "bold"
  )

# ============================================================================
# STRATEGIC USE ANNOTATIONS
# ============================================================================

# Create a table of strategic uses
strategic_table <- minerals_data %>%
  arrange(desc(China_Processing_Share)) %>%
  select(Mineral, Strategic_Use) %>%
  mutate(
    Processing_Share = paste0(round(minerals_data$China_Processing_Share * 100), "%"),
    Mineral_Label = paste0(Mineral, " (", Processing_Share, ")")
  )

# Create text summary for caption
strategic_text <- "Key Strategic Applications:\n"
strategic_text <- paste0(strategic_text,
  "Gallium (95%): Semiconductors, LEDs | ",
  "Manganese (95%): Steel, batteries | ",
  "Rare Earths (85%): EVs, wind turbines, military\n",
  "Tungsten (85%): Military, drilling | ",
  "Graphite (80%): Battery anodes | ",
  "Solar Polysilicon (80%): Solar panels")

# ============================================================================
# COMBINE PANELS
# ============================================================================

combined_plot <- (main_plot / scatter_plot) +
  plot_annotation(
    caption = paste0(
      "Source: U.S. Geological Survey, International Energy Agency\n",
      "Note: Processing shares represent China's share of global refining/manufacturing capacity"
    ),
    theme = theme_econ_textbook()
  ) +
  plot_layout(heights = c(2, 1))

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================

print(combined_plot)

# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_02_03_critical_minerals.png"),
  plot = combined_plot,
  width = 10,
  height = 12,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 2.3 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_02_03_critical_minerals.png\n")
cat("          figures/fig_02_03_critical_minerals.pdf\n")
cat("\n")
cat("Key insights:\n")
cat("  - China controls 95% of gallium and manganese processing\n")
cat("  - Processing dominance exceeds mining share for most minerals\n")
cat("  - Strategic concentration in EV, renewable, and military sectors\n")
cat("  - Cobalt shows extreme processing concentration (80%) despite minimal mining (2%)\n")
cat("========================================\n")
cat("\n")

# ============================================================================
# BONUS: CREATE SIMPLE COMPARISON TABLE
# ============================================================================

cat("\nCritical Minerals Summary Table:\n")
cat("================================\n")
minerals_summary <- minerals_data %>%
  arrange(desc(China_Processing_Share)) %>%
  mutate(
    Processing = paste0(round(China_Processing_Share * 100), "%"),
    Mining = paste0(round(China_Mining_Share * 100), "%")
  ) %>%
  select(Mineral, Processing, Mining, Strategic_Use)

print(minerals_summary, n = Inf)
cat("\n")
