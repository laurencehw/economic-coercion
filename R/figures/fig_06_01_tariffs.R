# Figure 6.1: U.S. Tariffs on Chinese Goods (2015-2024)
# Author: Laurence Wilse-Samson
# Description: Trade war impact - dramatic increase in tariff rates

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

tariff_data <- read_csv(here::here("data", "sources", "us_china_tariffs.csv"))

# Add period categorization
tariff_data <- tariff_data %>%
  mutate(
    Period = case_when(
      Year < 2018 ~ "Pre-Trade War",
      Year >= 2018 & Year < 2021 ~ "Trump Tariffs",
      Year >= 2021 ~ "Biden (Maintained)"
    ),
    Period = factor(Period, levels = c("Pre-Trade War", "Trump Tariffs", "Biden (Maintained)"))
  )

# ============================================================================
# PANELS: A. average rate; B. value of goods covered. One highlight colour for the tariff years.
# The timeline panel of the earlier dashboard repeated the same steps as text and is dropped.
# ============================================================================

tariff_data <- tariff_data %>% mutate(era = ifelse(Year < 2018, "Before 2018", "Section 301 tariffs in force"))
era_cols <- c("Before 2018" = lws_colors[["fade"]], "Section 301 tariffs in force" = lws_colors[["red"]])

panel_a <- ggplot(tariff_data, aes(x = Year, y = Average_Tariff_Rate, fill = era)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(Average_Tariff_Rate, "%")), vjust = -0.5,
            colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = era_cols, name = NULL) +
  scale_y_continuous(labels = label_percent(scale = 1), limits = c(0, 25), breaks = seq(0, 25, 5), expand = c(0, 0)) +
  scale_x_continuous(breaks = 2015:2024) +
  labs(title = "A. Average tariff rate on Chinese imports", x = NULL, y = "Average tariff rate") +
  theme_econ_textbook() +
  theme(legend.position = "top")

panel_b <- ggplot(tariff_data, aes(x = Year, y = Total_Goods_Under_Tariffs_Billions, fill = era)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = ifelse(Total_Goods_Under_Tariffs_Billions > 0, paste0("$", Total_Goods_Under_Tariffs_Billions, "B"), "")),
            vjust = -0.5, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = era_cols, guide = "none") +
  scale_y_continuous(labels = label_dollar(suffix = "B"), limits = c(0, 700), breaks = seq(0, 600, 200), expand = c(0, 0)) +
  scale_x_continuous(breaks = 2015:2024) +
  labs(title = "B. Value of Chinese goods covered by Section 301 tariffs", x = NULL, y = "Goods covered (billions of US dollars)") +
  theme_econ_textbook()

combined_plot <- (panel_a / panel_b) +
  plot_annotation(
    caption = paste(strwrap("Source: U.S. International Trade Commission, Peterson Institute for International Economics and USTR. Average tariff rate on Chinese imports; Chinese retaliatory tariffs on U.S. goods are not shown.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================


# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_06_01_us_china_tariffs.png"),
  plot = combined_plot,
  width = 6,
  height = 6.4,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 6.1 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_06_01_us_china_tariffs.png\n")
cat("          figures/fig_06_01_us_china_tariffs.pdf\n")
cat("\n")
cat("Tariff Rate Changes:\n")
cat("--------------------\n")
pre_war <- tariff_data$Average_Tariff_Rate[tariff_data$Year == 2017]
current <- tariff_data$Average_Tariff_Rate[tariff_data$Year == 2024]
cat(sprintf("  2017 (Pre-trade war):  %.1f%%\n", pre_war))
cat(sprintf("  2024 (Current):        %.1f%%\n", current))
cat(sprintf("  Absolute increase:     %.1f percentage points\n", current - pre_war))
cat(sprintf("  Relative increase:     %.0f%%\n", ((current / pre_war) - 1) * 100))
cat("\n")
cat("Goods Affected:\n")
cat(sprintf("  2017: $%.0fB\n", tariff_data$Total_Goods_Under_Tariffs_Billions[tariff_data$Year == 2017]))
cat(sprintf("  2024: $%.0fB\n", tariff_data$Total_Goods_Under_Tariffs_Billions[tariff_data$Year == 2024]))
cat("\n")
cat("Key Insights:\n")
cat("  - Tariff rates increased 6-fold from 2017 to 2024\n")
cat("  - $570B in annual Chinese imports now subject to tariffs\n")
cat("  - Bipartisan policy: tariffs maintained across administrations\n")
cat("  - Most goods face 7.5%-25% tariffs (vs. 3.1% pre-2018)\n")
cat("  - Represents fundamental shift in U.S.-China trade policy\n")
cat("========================================\n")
cat("\n")
