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
# PANELS: A. China, Japan, UK holdings over time (China highlighted, direct end labels);
# B. top ten individual holders in 2025. The stacked area, the China-only area and the
# repeated China panel of the earlier dashboard are dropped. Source data are biennial before 2024.
# ============================================================================

hold <- treasury_data %>%
  select(Year, China, Japan, UK) %>%
  rename(`United Kingdom` = UK) %>%
  pivot_longer(-Year, names_to = "Country", values_to = "Holdings")
last <- hold %>% filter(Year == max(Year))
line_cols <- c("China" = lws_colors[["red"]], "Japan" = lws_colors[["text"]], "United Kingdom" = "#8C8C8C")

panel_a <- ggplot(hold, aes(x = Year, y = Holdings, colour = Country)) +
  geom_line(linewidth = 0.9) +
  geom_point(size = 1.4) +
  geom_text(data = last %>% mutate(ypos = Holdings + c(-25, 0, 25)[match(Country, c("China", "Japan", "United Kingdom"))]),
            aes(y = ypos, label = paste0(Country, " $", trimws(format(round(Holdings), big.mark = ",")), "B")),
            hjust = -0.08, size = book_text_size, show.legend = FALSE) +
  annotate("text", x = 2014, y = 1269 + 90, label = "China peak\n$1,269B (2014)", size = book_text_size,
           colour = lws_colors[["red"]], lineheight = 0.9) +
  scale_colour_manual(values = line_cols, guide = "none") +
  scale_y_continuous(labels = label_dollar(suffix = "B"), limits = c(0, 1500), breaks = seq(0, 1400, 400), expand = c(0, 0)) +
  scale_x_continuous(breaks = seq(2000, 2025, 5), limits = c(2000, 2037)) +
  labs(title = "A. Holdings of U.S. Treasury securities, 2000-2025", x = NULL, y = "Holdings (billions of US dollars)") +
  theme_econ_textbook()

top10_2025 <- treasury_data %>%
  filter(Year == 2025) %>%
  select(-Year, -Top5_Others, -Total_Foreign, -Others) %>%
  pivot_longer(cols = everything(), names_to = "Country", values_to = "Holdings") %>%
  arrange(desc(Holdings)) %>%
  head(10) %>%
  mutate(Country_Label = recode(Country, "UK" = "United Kingdom", "Ireland" = "Ireland (tax haven)",
                                "Luxembourg" = "Luxembourg (tax haven)", "Saudi_Arabia" = "Saudi Arabia"),
         Country_Label = fct_reorder(Country_Label, Holdings),
         hl = ifelse(Country == "China", "China", "Other holders"))

panel_d <- ggplot(top10_2025, aes(x = Holdings, y = Country_Label, fill = hl)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0("$", trimws(format(round(Holdings), big.mark = ",")), "B")), hjust = -0.1,
            colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = c("China" = lws_colors[["red"]], "Other holders" = lws_colors[["fade"]]), guide = "none") +
  scale_x_continuous(labels = label_dollar(suffix = "B"), breaks = seq(0, 1200, 400), limits = c(0, 1400), expand = c(0, 0)) +
  labs(title = "B. Largest individual holders, 2025", x = "Holdings (billions of US dollars)", y = NULL) +
  theme_book_h()

combined_plot <- (panel_a / panel_d) + plot_layout(heights = c(1, 1.05)) +
  plot_annotation(
    caption = paste(strwrap("Source: U.S. Treasury International Capital (TIC) data and Federal Reserve. Holdings of U.S. Treasury securities by foreign official and private investors. Years are biennial before 2024. The residual 'Others' category is not ranked in panel B.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================


# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_07_01_treasury_holdings.png"),
  plot = combined_plot,
  width = 6,
  height = 6.2,
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
