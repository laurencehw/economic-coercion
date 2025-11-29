# Figure 7.4: Russian Foreign Reserves - Frozen Assets 2022
# Purpose: Visualize ~$370B in Russian assets frozen following Ukraine invasion
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Read the data
df <- read_csv(here("data", "sources", "russian_frozen_assets_2022.csv"))

# Summarize by category
category_totals <- df %>%
  group_by(Category) %>%
  summarize(Amount = sum(Amount_Billions_USD), .groups = "drop") %>%
  mutate(
    Category_Label = case_when(
      Category == "Foreign_Reserves" ~ "Foreign Reserves",
      Category == "Oligarch_Assets" ~ "Oligarch Assets",
      Category == "State_Assets" ~ "State Assets",
      TRUE ~ Category
    ),
    Category_Label = fct_reorder(Category_Label, Amount)
  )

# Get foreign reserves by location
reserves_by_location <- df %>%
  filter(Category == "Foreign_Reserves") %>%
  mutate(
    Location_Label = str_replace_all(Location, "_", " "),
    Location_Label = fct_reorder(Location_Label, Amount_Billions_USD)
  )

# Calculate totals
total_frozen <- sum(df$Amount_Billions_USD)
reserves_total <- sum(reserves_by_location$Amount_Billions_USD)

# ============================================================================
# 2. PANEL A: BY CATEGORY
# ============================================================================

category_colors <- c("Foreign Reserves" = "#d62728",
                     "Oligarch Assets" = "#ff7f0e",
                     "State Assets" = "#2ca02c")

p1 <- ggplot(category_totals, aes(x = Amount, y = Category_Label, fill = Category_Label)) +
  geom_col(alpha = 0.85, color = "black", linewidth = 0.5) +
  geom_text(aes(label = paste0("$", round(Amount, 1), "B")),
            hjust = -0.1, fontface = "bold", size = 4) +
  scale_fill_manual(values = category_colors) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.2)),
                     labels = scales::dollar_format(suffix = "B")) +
  labs(
    title = "Assets Frozen by Category",
    x = "Amount Frozen (Billions USD)",
    y = NULL
  ) +
  theme_econ_textbook() +
  theme(legend.position = "none")

# Add statistics annotation
stats_text <- paste0(
  "Total Frozen: $", round(total_frozen, 1), "B\n\n",
  "Foreign Reserves: $", round(reserves_total, 1), "B\n",
  "(~55% of Russia's $630B total)\n\n",
  "Largest holder:\n",
  "Eurozone: $", round(max(reserves_by_location$Amount_Billions_USD), 1), "B"
)

p1 <- p1 +
  annotate("label", x = max(category_totals$Amount) * 0.9,
           y = 1.5, label = stats_text,
           hjust = 1, vjust = 0.5, size = 3,
           fill = "lightyellow", alpha = 0.9, label.size = 0.5,
           family = "mono")

# ============================================================================
# 3. PANEL B: FOREIGN RESERVES BY LOCATION
# ============================================================================

p2 <- ggplot(reserves_by_location, aes(x = Amount_Billions_USD, y = Location_Label)) +
  geom_col(fill = "#1f77b4", alpha = 0.85, color = "black", linewidth = 0.5) +
  geom_text(aes(label = paste0("$", round(Amount_Billions_USD, 1), "B")),
            hjust = -0.1, fontface = "bold", size = 3.5) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.2)),
                     labels = scales::dollar_format(suffix = "B")) +
  labs(
    title = "Foreign Reserves by Location",
    x = "Amount Frozen (Billions USD)",
    y = NULL
  ) +
  theme_econ_textbook()

# ============================================================================
# 4. COMBINE PANELS
# ============================================================================

combined <- p1 + p2 +
  plot_layout(widths = c(1, 1.2)) +
  plot_annotation(
    title = "Figure 7.4: Russian Assets Frozen by Western Sanctions (2022)",
    subtitle = "Unprecedented financial coercion following Ukraine invasion",
    caption = paste0(
      "Sources: European Commission, U.S. Treasury, Bank of Russia, IMF, CSIS estimates.\n",
      "Note: Assets frozen following Russian invasion of Ukraine (Feb 24, 2022). Includes central bank reserves,\n",
      "assets of sanctioned oligarchs, and state-owned entities. Data as of Q4 2022."
    ),
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  )

# ============================================================================
# 5. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_07_04_frozen_assets.png"), combined, width = 14, height = 7)

cat("\nFigure 7.4 created successfully!\n")
cat("Key Statistics:\n")
cat(paste0("  Total assets frozen: $", round(total_frozen, 1), "B\n"))
cat(paste0("  Foreign reserves frozen: $", round(reserves_total, 1), "B\n"))
