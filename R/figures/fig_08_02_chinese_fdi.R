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
last <- fdi_long %>% filter(Year == max(Year))
reg_cols <- c("United States" = lws_colors[["red"]], "Europe" = lws_colors[["text"]])

p1 <- ggplot(fdi_long, aes(x = Year, y = Amount, colour = Region)) +
  annotate("segment", x = 2018, xend = 2018, y = 0, yend = 40, linetype = "dashed", colour = lws_colors[["ref"]]) +
  annotate("text", x = 2018.2, y = 34, label = "CFIUS reform\n(FIRRMA), 2018", lineheight = 0.9, hjust = 0, colour = lws_colors[["text"]]) +
  geom_line(linewidth = 0.9) +
  geom_point(size = 1.5) +
  geom_text(data = last, aes(label = paste0(Region, " $", round(Amount, 1), "B")), hjust = -0.1, size = book_text_size, show.legend = FALSE) +
  annotate("text", x = us_peak_year - 0.3, y = us_peak + 2, hjust = 1, label = paste0("U.S. peak $", us_peak, "B"), colour = lws_colors[["red"]], size = book_text_size) +
  annotate("text", x = eu_peak_year + 0.3, y = eu_peak + 4, hjust = 0, label = paste0("Europe peak $", eu_peak, "B"), colour = lws_colors[["text"]], size = book_text_size) +
  scale_colour_manual(values = reg_cols, guide = "none") +
  scale_y_continuous(labels = scales::dollar_format(suffix = "B"), limits = c(0, 55), expand = c(0, 0)) +
  scale_x_continuous(breaks = seq(2008, 2024, 4), limits = c(2008, 2030)) +
  labs(x = NULL, y = "Annual flows (billions of US dollars)") +
  book_source("Source: Rhodium Group, AEI China Investment Tracker and Eurostat. Includes mergers and acquisitions and greenfield investment.") +
  theme_econ_textbook()

save_econ_figure(here("figures", "fig_08_02_chinese_fdi.png"), p1, width = 6, height = 3.8)

cat("\nFigure 8.2 Summary Stats:\n")
cat(sprintf("USA Peak: $%sB (%d) -> Current: $%sB (Decline: %.1f%%)\n", us_peak, us_peak_year, us_current, us_decline * 100))
cat(sprintf("Europe Peak: $%sB (%d) -> Current: $%sB (Decline: %.1f%%)\n", eu_peak, eu_peak_year, eu_current, eu_decline * 100))
