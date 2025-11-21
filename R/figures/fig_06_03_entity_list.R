# Figure 6.3: U.S. Entity List Additions
# Purpose: Visualize the escalation of technology export controls
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)
library(scales)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. LOAD AND PREPARE DATA
# ============================================================================

# Load data
entity_data <- read_csv(here("data", "sources", "entity_list_additions.csv"))

# Pivot for stacked area chart (Left Panel)
# Columns: Year, Semiconductors, Surveillance, Aerospace_Defense, Universities_Research, AI_Computing, Other
entity_long <- entity_data %>%
  select(-Total) %>%
  pivot_longer(
    cols = -Year,
    names_to = "Sector",
    values_to = "Count"
  ) %>%
  mutate(
    Sector = case_when(
      Sector == "Semiconductors" ~ "Semiconductors",
      Sector == "Surveillance" ~ "Surveillance",
      Sector == "Aerospace_Defense" ~ "Aerospace/Defense",
      Sector == "Universities_Research" ~ "Universities/Research",
      Sector == "AI_Computing" ~ "AI/Computing",
      Sector == "Other" ~ "Other"
    ),
    # Set factor levels for stacking order
    Sector = factor(Sector, levels = c("Other", "AI/Computing", "Universities/Research", 
                                       "Aerospace/Defense", "Surveillance", "Semiconductors"))
  )

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# --- Panel A: Cumulative Additions by Sector (Stacked Area) ---
p1 <- ggplot(entity_long, aes(x = Year, y = Count, fill = Sector)) + 
  geom_area(alpha = 0.85, color = "white", size = 0.2) + 
  
  # Custom colors
  scale_fill_manual(values = c(
    "Semiconductors" = "#1f77b4",      # Blue
    "Surveillance" = "#ff7f0e",        # Orange
    "Aerospace/Defense" = "#2ca02c",   # Green
    "Universities/Research" = "#d62728", # Red
    "AI/Computing" = "#9467bd",        # Purple
    "Other" = "#7f7f7f"                # Gray
  )) + 
  
  scale_x_continuous(breaks = seq(2015, 2024, 1), expand = c(0, 0)) + 
  scale_y_continuous(expand = c(0, 0), limits = c(0, 300)) + 
  
  labs(
    title = "Additions by Sector",
    subtitle = "Annual count of Chinese entities added",
    x = NULL,
    y = "Number of Entities Added",
    fill = NULL
  ) + 
  theme_econ_textbook() + 
  theme(legend.position = "right")

# --- Panel B: Total Annual Additions (Bar) ---
p2 <- ggplot(entity_data, aes(x = Year, y = Total)) + 
  geom_col(fill = "#d62728", alpha = 0.8, width = 0.7) + 
  
  # Add labels
  geom_text(aes(label = Total), vjust = -0.5, fontface = "bold", size = 3.5) + 
  
  # Huawei Ban Annotation
  annotate("segment", x = 2019, xend = 2019, y = 135, yend = 200, 
           linetype = "dashed", color = "gray40") + 
  annotate("label", x = 2019, y = 220, label = "Huawei\nBan", 
           size = 3, color = "gray30", fill = "white", label.size = 0.2) + 
  
  scale_x_continuous(breaks = seq(2015, 2024, 1)) + 
  scale_y_continuous(limits = c(0, 300), expand = c(0, 0)) + 
  
  labs(
    title = "Total Annual Additions",
    subtitle = "Acceleration of export controls since 2018",
    x = NULL,
    y = "Total Entities"
  ) + 
  theme_econ_textbook()

# ============================================================================
# 3. COMPOSE AND SAVE
# ============================================================================

# Combine plots
final_plot <- (p1 / p2) + 
  plot_layout(heights = c(1.5, 1)) + 
  plot_annotation(
    title = "Figure 6.3: U.S. Entity List Additions (2015-2024)",
    subtitle = "Escalating technology export controls targeting Chinese entities",
    caption = "Source: U.S. Bureau of Industry and Security (BIS), Federal Register.\nNote: Data represents Chinese entities added to the Entity List each year.",
    theme = theme(
      plot.title = element_text(face = "bold", size = 16),
      plot.subtitle = element_text(color = "gray30", size = 12),
      plot.caption = element_text(color = "gray50", size = 10)
    )
  )

# Save
save_econ_figure(here("figures", "fig_06_03_entity_list.png"), final_plot, width = 10, height = 10)

# Print summary
cat("\nFigure 6.3 Summary:\n")
cat(sprintf("2015 Total: %d -> 2024 Total: %d\n", 
            entity_data$Total[1], tail(entity_data$Total, 1)))
cat("Cumulative Total:", sum(entity_data$Total), "\n")
