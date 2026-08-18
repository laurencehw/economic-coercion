# Figure 7.1: Foreign Holdings of U.S. Treasury Securities
# Author: Laurence Wilse-Samson
# Description: China's peak and decline, Japan's stability, Europe's rise

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

treasury_data <- read_csv(here::here("data", "sources", "us_treasury_holdings.csv"))

# Calculate aggregated "Others" and total
treasury_data <- treasury_data %>%
  mutate(
    Top5_Others = Brazil + Belgium + Taiwan + Switzerland + Saudi_Arabia + Others,
    Total_Foreign = China + Japan + UK + Ireland + Luxembourg + Top5_Others
  )

# ============================================================================
# PANEL A: STACKED AREA CHART OF HOLDINGS
# ============================================================================

# Prepare data for stacked area
treasury_stack <- treasury_data %>%
  select(Year, China, Japan, UK, Ireland, Luxembourg, Top5_Others) %>%
  pivot_longer(
    cols = -Year,
    names_to = "Country",
    values_to = "Holdings"
  ) %>%
  mutate(
    Country = factor(Country, levels = c("China", "Japan", "UK", "Ireland", "Luxembourg", "Top5_Others")),
    Country_Label = recode(Country,
                          "China" = "China",
                          "Japan" = "Japan",
                          "UK" = "United Kingdom",
                          "Ireland" = "Ireland",
                          "Luxembourg" = "Luxembourg",
                          "Top5_Others" = "Others")
  )

holder_colors <- c(
  "China" = econ_colors[["China"]],
  "Japan" = econ_colors[["Japan"]],
  "UK" = econ_colors[["UK"]],
  "Ireland" = "#ff7f0e",      # Orange
  "Luxembourg" = "#8c564b",    # Brown (was #9467bd, identical to Japan)
  "Top5_Others" = "#c7c7c7"   # Light gray (was #7f7f7f, identical to the UK)
)

panel_a <- ggplot(treasury_stack, aes(x = Year, y = Holdings, fill = Country)) +
  geom_area(alpha = 0.8, position = "stack") +
  scale_fill_manual(
    values = holder_colors,
    labels = c("China", "Japan", "United Kingdom", "Ireland", "Luxembourg", "Others")
  ) +
  scale_y_continuous(
    labels = label_dollar(suffix = "B"),
    breaks = seq(0, 8000, 1000),
    limits = c(0, 8000),
    expand = c(0, 0)
  ) +
  scale_x_continuous(
    breaks = seq(2000, 2025, 5)
  ) +
  labs(
    title = "Foreign Holdings of U.S. Treasury Securities",
    subtitle = "Total foreign holdings grew from $702B (2000) to $7.8T (2025)",
    x = "Year",
    y = "Holdings (Billions USD)",
    fill = "Country/Region"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  ) +
  # Mark China's peak
  annotate(
    "segment",
    x = 2014,
    xend = 2014,
    y = 0,
    yend = 5200,
    linetype = "dotted",
    color = "gray30",
    linewidth = 1
  ) +
  annotate(
    "text",
    x = 2014,
    y = 5500,
    label = "China\npeak\n$1,269B",
    size = 3,
    color = econ_colors[["China"]],
    fontface = "bold"
  )

# ============================================================================
# PANEL B: CHINA VS JAPAN COMPARISON
# ============================================================================

china_japan <- treasury_data %>%
  select(Year, China, Japan, UK) %>%
  rename(`United Kingdom` = UK) %>%
  pivot_longer(
    cols = c(China, Japan, `United Kingdom`),
    names_to = "Country",
    values_to = "Holdings"
  )

panel_b <- ggplot(china_japan, aes(x = Year, y = Holdings, color = Country, fill = Country)) +
  geom_area(alpha = 0.2, position = "identity") +
  geom_line(linewidth = 1.5) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_color_manual(
    values = c("China" = econ_colors[["China"]],
               "Japan" = econ_colors[["Japan"]],
               "United Kingdom" = econ_colors[["UK"]])
  ) +
  scale_fill_manual(
    values = c("China" = econ_colors[["China"]],
               "Japan" = econ_colors[["Japan"]],
               "United Kingdom" = econ_colors[["UK"]])
  ) +
  scale_y_continuous(
    labels = label_dollar(suffix = "B"),
    breaks = seq(0, 1400, 200),
    limits = c(0, 1400)
  ) +
  scale_x_continuous(
    breaks = seq(2000, 2025, 5),
    limits = c(2000, 2029)
  ) +
  labs(
    title = "China Slips to Third",
    subtitle = "The UK overtook China in March 2025",
    x = "Year",
    y = "Holdings (Billions USD)",
    color = "Country",
    fill = "Country"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  ) +
  # Annotate latest-year values
  annotate(
    "text",
    x = 2025,
    y = treasury_data$Japan[treasury_data$Year == 2025],
    label = paste0("$", format(round(treasury_data$Japan[treasury_data$Year == 2025]), big.mark = ","), "B"),
    size = 3,
    color = econ_colors[["Japan"]],
    fontface = "bold",
    hjust = 0
  ) +
  annotate(
    "text",
    x = 2025,
    y = treasury_data$China[treasury_data$Year == 2025],
    label = paste0("$", format(round(treasury_data$China[treasury_data$Year == 2025]), big.mark = ","), "B"),
    size = 3,
    color = econ_colors[["China"]],
    fontface = "bold",
    hjust = 0
  )

# ============================================================================
# PANEL C: CHINA'S DECLINE TRAJECTORY
# ============================================================================

china_timeline <- treasury_data %>%
  select(Year, China) %>%
  mutate(
    Milestone = case_when(
      Year == 2014 ~ "Peak: $1,269B",
      Year == 2016 ~ "Trump elected",
      Year == 2018 ~ "Trade war begins",
      Year == 2020 ~ "COVID-19",
      Year == 2022 ~ "Ukraine invasion",
      TRUE ~ NA_character_
    ),
    Change_from_Peak = (China / max(China) - 1) * 100
  )

panel_c <- ggplot(china_timeline, aes(x = Year, y = China)) +
  geom_area(fill = econ_colors[["China"]], alpha = 0.3) +
  geom_line(color = econ_colors[["China"]], linewidth = 1.5) +
  geom_point(size = 3, color = econ_colors[["China"]]) +
  geom_hline(
    yintercept = max(china_timeline$China),
    linetype = "dashed",
    color = econ_colors[["China"]],
    linewidth = 0.8,
    alpha = 0.5
  ) +
  scale_y_continuous(
    labels = label_dollar(suffix = "B"),
    breaks = seq(0, 1400, 200),
    limits = c(0, 1400)
  ) +
  scale_x_continuous(
    breaks = seq(2000, 2025, 5)
  ) +
  labs(
    title = "China's Holdings: Rise and Decline",
    subtitle = "Down 46% from the 2014 peak amid geopolitical tensions",
    x = "Year",
    y = "China Holdings (Billions USD)"
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.minor = element_blank()
  ) +
  # Add milestone annotations
  annotate(
    "segment",
    x = 2018,
    xend = 2018,
    y = 0,
    yend = treasury_data$China[treasury_data$Year == 2018] - 50,
    linetype = "dotted",
    color = "gray30"
  ) +
  annotate(
    "text",
    x = 2018,
    y = 1350,
    label = "Trade\nWar",
    size = 2.5,
    color = "gray30",
    fontface = "italic"
  ) +
  annotate(
    "segment",
    x = 2022,
    xend = 2022,
    y = 0,
    yend = treasury_data$China[treasury_data$Year == 2022] - 50,
    linetype = "dotted",
    color = "gray30"
  ) +
  annotate(
    "text",
    x = 2022,
    y = 1350,
    label = "Ukraine\nInvasion",
    size = 2.5,
    color = "gray30",
    fontface = "italic"
  )

# ============================================================================
# PANEL D: TOP 10 HOLDERS RANKING (2025)
# ============================================================================

top10_2025 <- treasury_data %>%
  filter(Year == 2025) %>%
  select(-Year, -Top5_Others, -Total_Foreign) %>%
  pivot_longer(
    cols = everything(),
    names_to = "Country",
    values_to = "Holdings"
  ) %>%
  arrange(desc(Holdings)) %>%
  head(10) %>%
  mutate(
    Country_Label = recode(Country,
                          "China" = "China",
                          "Japan" = "Japan",
                          "UK" = "United Kingdom",
                          "Ireland" = "Ireland (tax haven)",
                          "Luxembourg" = "Luxembourg (tax haven)",
                          "Switzerland" = "Switzerland",
                          "Belgium" = "Belgium",
                          "Taiwan" = "Taiwan",
                          "Brazil" = "Brazil",
                          "Saudi_Arabia" = "Saudi Arabia",
                          "Others" = "Others"),
    Country_Label = fct_reorder(Country_Label, Holdings)
  )

panel_d <- ggplot(top10_2025, aes(x = Holdings, y = Country_Label)) +
  geom_col(fill = econ_colors[["USA"]], alpha = 0.8, width = 0.75) +
  geom_text(
    aes(label = paste0("$", round(Holdings), "B")),
    hjust = -0.1,
    size = 3,
    fontface = "bold",
    color = econ_colors[["USA"]]
  ) +
  scale_x_continuous(
    labels = label_dollar(suffix = "B"),
    breaks = seq(0, 1200, 200),
    limits = c(0, 1250),
    expand = c(0, 0)
  ) +
  labs(
    title = "Top 10 Foreign Holders (2025)",
    subtitle = "Japan #1, United Kingdom #2, China #3; European financial centres growing",
    x = "Holdings (Billions USD)",
    y = NULL
  ) +
  theme_econ_textbook() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_text(face = "bold", size = 10)
  )

# ============================================================================
# COMBINE PANELS
# ============================================================================

combined_plot <- (panel_a / (panel_b | panel_c) / panel_d) +
  plot_annotation(
    title = "Foreign Holdings of U.S. Treasury Securities (2000-2025)",
    subtitle = "China's strategic reduction from $1,269B peak (2014) to $684B (2025); Japan remains largest holder at $1,128B",
    caption = paste0(
      "Source: U.S. Treasury TIC (Treasury International Capital) data, Federal Reserve\n",
      "Note: Holdings of marketable U.S. Treasury securities by foreign official and private investors. China reduced holdings 46% from peak.\n",
      "European financial centers (Ireland, Luxembourg, Belgium, UK) collectively hold $1,844B, reflecting offshore dollar recycling."
    ),
    theme = theme_econ_textbook()
  ) +
  plot_layout(heights = c(1, 0.8, 0.7))

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================

print(combined_plot)

# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_07_01_treasury_holdings.png"),
  plot = combined_plot,
  width = 14,
  height = 14,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 7.1 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_07_01_treasury_holdings.png\n")
cat("          figures/fig_07_01_treasury_holdings.pdf\n")
cat("\n")
cat("Key Findings:\n")
cat("-------------\n")
china_peak <- max(treasury_data$China)
china_peak_year <- treasury_data$Year[which.max(treasury_data$China)]
china_current <- treasury_data$China[treasury_data$Year == 2025]
japan_current <- treasury_data$Japan[treasury_data$Year == 2025]
uk_current <- treasury_data$UK[treasury_data$Year == 2025]
total_current <- treasury_data$Total_Foreign[treasury_data$Year == 2025]

cat(sprintf("  China peak: $%.0fB in %d\n", china_peak, china_peak_year))
cat(sprintf("  China 2025: $%.0fB (down %.1f%% from peak)\n",
            china_current, ((china_current / china_peak) - 1) * 100))
cat(sprintf("  Japan 2025: $%.0fB (largest holder)\n", japan_current))
cat(sprintf("  UK 2025: $%.0fB (2nd largest)\n", uk_current))
cat(sprintf("  Total foreign holdings 2025: $%.0fB\n", total_current))
cat("\n")
cat("Trends:\n")
cat("  - China reduced holdings by $493B since 2014 peak\n")
cat("  - Japan holdings relatively stable ($882B-$1,261B range)\n")
cat("  - UK holdings grew 18x from $43B (2000) to $771B (2025)\n")
cat("  - European tax havens (Ireland, Luxembourg) grew significantly\n")
cat("  - Total foreign holdings tripled from $2.5T (2008) to $7.8T (2025)\n")
cat("========================================\n")
cat("\n")
