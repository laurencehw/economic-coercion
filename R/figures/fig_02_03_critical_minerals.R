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
# One panel: grouped horizontal bars, sorted by processing share. (The scatter of
# processing against mining in the earlier dashboard restated these same bars.)
# ============================================================================

minerals_long <- minerals_long %>%
  mutate(Mineral = fct_reorder(Mineral, ifelse(Activity == "Processing", Share_Pct, 0), .fun = max),
         Activity = factor(Activity, levels = c("Mining", "Processing")))

combined_plot <- ggplot(minerals_long, aes(x = Share_Pct, y = Mineral, fill = Activity)) +
  geom_col(position = position_dodge(width = 0.75), width = 0.7) +
  geom_text(aes(label = paste0(round(Share_Pct), "%")),
            position = position_dodge(width = 0.75), hjust = -0.2, colour = lws_colors[["ink"]]) +
  geom_vline(xintercept = 50, colour = lws_colors[["ref"]], linewidth = 0.4, linetype = "22") +
  scale_x_continuous(labels = label_percent(scale = 1), breaks = seq(0, 100, 25),
                     limits = c(0, 108), expand = c(0, 0)) +
  scale_fill_manual(values = c("Processing" = lws_colors[["red"]], "Mining" = lws_colors[["fade"]]),
                    breaks = c("Processing", "Mining")) +
  labs(x = "China's share of global capacity", y = NULL) +
  book_source("Sources: U.S. Geological Survey; International Energy Agency. Processing is refining or manufacturing capacity.") +
  theme_book_h() +
  guides(fill = guide_legend(reverse = FALSE))

# ============================================================================
# SAVE
# ============================================================================

save_econ_figure(
  filename = here::here("figures", "fig_02_03_critical_minerals.png"),
  plot = combined_plot, width = 6, height = 4.2
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
