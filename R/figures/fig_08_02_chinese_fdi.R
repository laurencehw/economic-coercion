# Figure 8.2: Chinese FDI in U.S. and Europe
# Purpose: Visualize the rise and fall of Chinese investment flows
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
fdi_data <- read_csv(here("data", "sources", "chinese_fdi_flows.csv"))

# Reshape for plotting
fdi_long <- fdi_data %>%
  pivot_longer(
    cols = c("US_Billions", "Europe_Billions"),
    names_to = "Region",
    values_to = "Amount"
  ) %>%
  mutate(
    Region = case_when(
      Region == "US_Billions" ~ "United States",
      Region == "Europe_Billions" ~ "Europe"
    ),
    # Create label for last point
    label = if_else(Year == max(Year), paste0("$", round(Amount, 1), "B"), NA_character_)
  )

# Calculate peaks and declines for annotations
us_peak <- max(fdi_data$US_Billions)
us_peak_year <- fdi_data$Year[fdi_data$US_Billions == us_peak]
us_current <- fdi_data$US_Billions[fdi_data$Year == 2024]
us_decline <- (us_current / us_peak) - 1

eu_peak <- max(fdi_data$Europe_Billions)
eu_peak_year <- fdi_data$Year[fdi_data$Europe_Billions == eu_peak]
eu_current <- fdi_data$Europe_Billions[fdi_data$Year == 2024]
eu_decline <- (eu_current / eu_peak) - 1

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# Main Line Plot
p1 <- ggplot(fdi_long, aes(x = Year, y = Amount, color = Region)) + 
  # Add vertical line for CFIUS reform
  annotate("segment", x = 2018, xend = 2018, y = 0, yend = 50, 
           linetype = "dashed", color = "gray50", alpha = 0.5) + 
  annotate("text", x = 2018.2, y = 48, label = "CFIUS Reform (FIRRMA)", 
           hjust = 0, size = 3.5, color = "gray40", fontface = "italic") + 
  
  # Lines and points
  geom_line(linewidth = 1.2) + 
  geom_point(size = 3) + 
  
  # Labels for ends of lines
  geom_text(aes(label = label), hjust = -0.2, na.rm = TRUE, fontface = "bold") + 
  
  # Peak annotations
  annotate("text", x = us_peak_year, y = us_peak + 2, 
           label = paste0("U.S. Peak: $", us_peak, "B"), 
           color = econ_colors["USA"], fontface = "bold", size = 3.5) + 
  annotate("text", x = eu_peak_year, y = eu_peak + 2, 
           label = paste0("Europe Peak: $", eu_peak, "B"), 
           color = econ_colors["EU"], fontface = "bold", size = 3.5) + 
  
  # Scales
  scale_color_manual(values = c("United States" = econ_colors["USA"], 
                                "Europe" = econ_colors["EU"])) +
  scale_y_continuous(labels = scales::dollar_format(suffix = "B"), limits = c(0, 55)) + 
  scale_x_continuous(breaks = seq(2008, 2024, 2)) + 
  
  # Labels
  labs(
    title = "Collapse of Chinese Foreign Direct Investment (2008-2024)",
    subtitle = "Annual FDI flows show dramatic decline following increased scrutiny and restrictions",
    x = NULL,
    y = "Annual Flows (Billions USD)",
    color = NULL
  ) + 
  theme_econ_textbook() +
  theme(legend.position = "top")

# ============================================================================
# 3. SAVE OUTPUT
# ============================================================================

# Combine (single panel figure in this case)
final_plot <- p1 +
  add_source_note("Rhodium Group, AEI China Investment Tracker, Eurostat. Note: Includes M&A and greenfield investment.")

# Save
save_econ_figure(here("figures", "fig_08_02_chinese_fdi.png"), final_plot, height = 6)

# Print summary stats to console
cat("\nFigure 8.2 Summary Stats:\n")
cat(sprintf("USA Peak: $%sB (%d) -> Current: $%sB (Decline: %.1f%%)\n", 
            us_peak, us_peak_year, us_current, us_decline * 100))
cat(sprintf("Europe Peak: $%sB (%d) -> Current: $%sB (Decline: %.1f%%)\n", 
            eu_peak, eu_peak_year, eu_current, eu_decline * 100))
