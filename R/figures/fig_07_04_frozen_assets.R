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

p1 <- ggplot(category_totals, aes(x = Amount, y = Category_Label, fill = Category_Label)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0("$", round(Amount, 1), "B")), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = c("Foreign Reserves" = lws_colors[["red"]], "Oligarch Assets" = lws_colors[["fade"]], "State Assets" = lws_colors[["fade"]]), guide = "none") +
  scale_x_continuous(expand = expansion(mult = c(0, 0.2)), labels = scales::dollar_format(suffix = "B")) +
  labs(title = paste0("A. Assets frozen by category (total $", round(total_frozen, 1), "B)"), x = "Amount frozen (billions of US dollars)", y = NULL) +
  theme_book_h()

p2 <- ggplot(reserves_by_location, aes(x = Amount_Billions_USD, y = Location_Label)) +
  geom_col(fill = lws_colors[["red"]], width = 0.7) +
  geom_text(aes(label = paste0("$", round(Amount_Billions_USD, 1), "B")), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.2)), labels = scales::dollar_format(suffix = "B")) +
  labs(title = paste0("B. Frozen central bank reserves by location ($", round(reserves_total, 1), "B)"), x = "Amount frozen (billions of US dollars)", y = NULL) +
  theme_book_h()

combined <- p1 / p2 + plot_layout(heights = c(0.55, 1)) +
  plot_annotation(
    caption = paste(strwrap("Sources: European Commission, U.S. Treasury, Bank of Russia, IMF and CSIS estimates; data as of Q4 2022. Includes central bank reserves, assets of sanctioned oligarchs and state-owned entities, frozen after the invasion of Ukraine on 24 February 2022.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here("figures", "fig_07_04_russian_frozen_assets.png"), combined, width = 6, height = 5.4)

cat("\nFigure 7.4 created successfully!\n")
cat(paste0("  Total assets frozen: $", round(total_frozen, 1), "B\n"))
cat(paste0("  Foreign reserves frozen: $", round(reserves_total, 1), "B\n"))
