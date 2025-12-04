# Figure 9.3: Sanctions Success Rates by Type
# Purpose: Analyze effectiveness of different sanction types
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
success_data <- read_csv(here("data", "sources", "sanctions_success_rates.csv"))

# Prepare data for stacked bar chart (Left Panel)
# Need to pivot longer
success_long <- success_data %>%
  select(Sanction_Type, Success_Rate, Partial_Success, Failure) %>%
  pivot_longer(
    cols = c("Success_Rate", "Partial_Success", "Failure"),
    names_to = "Outcome",
    values_to = "Percentage"
  ) %>%
  mutate(
    Outcome = case_when(
      Outcome == "Success_Rate" ~ "Success",
      Outcome == "Partial_Success" ~ "Partial Success",
      Outcome == "Failure" ~ "Failure"
    ),
    # Order levels for stacking: Success, Partial, Failure
    Outcome = factor(Outcome, levels = c("Failure", "Partial Success", "Success")),
    # Simplify labels
    Sanction_Type_Short = str_remove_all(Sanction_Type, " Sanctions| Controls| Restrictions")
  )

# Calculate combined success for scatter plot (Right Panel)
success_scatter <- success_data %>%
  mutate(
    Combined_Success = Success_Rate + (Partial_Success * 0.5),
    Sanction_Type_Short = str_remove_all(Sanction_Type, " Sanctions| Controls| Restrictions")
  )

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# --- Panel A: Success Rates by Type (Stacked Bar) ---
p1 <- ggplot(success_long, aes(x = Percentage, y = reorder(Sanction_Type, Percentage), fill = Outcome)) +
  geom_col(width = 0.7, color = "white", size = 0.2) +
  
  # Add labels inside bars
  geom_text(aes(label = ifelse(Percentage > 5, paste0(Percentage, "%"), "")),
            position = position_stack(vjust = 0.5),
            color = "white", fontface = "bold", size = 3) +
  
  # Custom colors
  scale_fill_manual(values = c(
    "Success" = "#2ca02c",          # Green
    "Partial Success" = "#ff7f0e",  # Orange
    "Failure" = "#d62728"           # Red
  )) +
  
  scale_x_continuous(expand = c(0, 0), limits = c(0, 100)) +
  
  labs(
    title = "Outcomes by Sanction Type",
    subtitle = "Percentage of cases (1945-2020)",
    x = "Percentage of Cases",
    y = NULL,
    fill = NULL
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "top",
    panel.grid.major.y = element_blank()
  )

# --- Panel B: Effectiveness vs. Duration (Scatter) ---
p2 <- ggplot(success_scatter, aes(x = Avg_Duration_Years, y = Combined_Success)) +
  # Add bubbles
  geom_point(aes(size = Total_Cases, fill = Combined_Success), shape = 21, color = "black", alpha = 0.8) +
  
  # Add text labels
  geom_text(aes(label = Sanction_Type_Short), vjust = -1.5, fontface = "bold", size = 3.5) +
  
  # Scales
  scale_size_continuous(range = c(5, 15), name = "Number of Cases") +
  scale_fill_gradientn(colors = c("#d73027", "#fdae61", "#a6d96a", "#1a9850")) +
  scale_x_continuous(limits = c(3, 7), breaks = 3:7) +
  scale_y_continuous(limits = c(25, 65)) +
  
  labs(
    title = "Effectiveness vs. Duration",
    subtitle = "Shorter sanctions tend to be more effective",
    x = "Average Duration (Years)",
    y = "Success Rate (Weighted*)",
    caption = "*Weighted Success = Success + (0.5 × Partial)"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "none")

# ============================================================================
# 3. COMPOSE AND SAVE
# ============================================================================

# Combine plots
final_plot <- p1 + p2 + 
  plot_layout(widths = c(1, 1.2)) +
  plot_annotation(
    title = "Figure 9.3: Economic Sanctions Effectiveness (1945-2020)",
    subtitle = "Analysis of 712 historical cases reveals trade-offs between sanction types and duration",
    theme = theme(
      plot.title = element_text(face = "bold", size = 16),
      plot.subtitle = element_text(color = "gray30", size = 12)
    )
  )

# Add source note
final_plot <- final_plot +
  plot_annotation(caption = "Source: Hufbauer et al. Sanctions Database, Peterson Institute for International Economics.")

# Save
save_econ_figure(here("figures", "fig_09_03_sanctions_success.png"), final_plot, width = 12, height = 6)

# Print summary
cat("\nFigure 9.3 Summary:\n")
print(success_data %>% select(Sanction_Type, Success_Rate, Avg_Duration_Years))
