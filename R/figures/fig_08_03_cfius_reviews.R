# Figure 8.3: CFIUS Reviews Over Time
# Chapter 8: Investment Screening and Industrial Policy
# Shows growth in investment screening activity

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# Load data
cfius <- read.csv(here::here("data", "sources", "cfius_reviews.csv"), stringsAsFactors = FALSE)

# Reshape for stacked area
library(patchwork)
library(ggplot2)

# A. covered transactions by filing type (stacked bars: notices below, declarations above)
filings <- cfius %>% select(year, Notices = notices, Declarations = declarations) %>%
  pivot_longer(-year, names_to = "type", values_to = "n") %>%
  mutate(type = factor(type, levels = c("Declarations", "Notices")))

p1 <- ggplot(filings, aes(x = year, y = n, fill = type)) +
  geom_col(width = 0.7) +
  geom_text(data = cfius, aes(x = year, y = covered_transactions, label = covered_transactions), inherit.aes = FALSE,
            vjust = -0.5, colour = lws_colors[["ink"]], size = book_text_size) +
  annotate("segment", x = 2018, xend = 2018, y = 0, yend = 430, linetype = "dashed", colour = lws_colors[["ref"]]) +
  annotate("text", x = 2017.8, y = 430, label = "FIRRMA enacted, 2018", hjust = 1, colour = lws_colors[["text"]]) +
  scale_fill_manual(values = c("Notices" = lws_colors[["text"]], "Declarations" = lws_colors[["fade"]]), breaks = c("Notices", "Declarations"), name = NULL) +
  scale_x_continuous(breaks = seq(2010, 2024, 2)) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.12))) +
  labs(title = "A. Covered transactions by filing type", x = NULL, y = "Number of filings") +
  theme_econ_textbook() + theme(legend.position = "top", legend.justification = "left")

# B. outcomes (two series, direct end labels)
outc <- cfius %>% select(year, Withdrawals = withdrawals, `Mitigation measures` = mitigation_measures_conditions) %>%
  pivot_longer(-year, names_to = "k", values_to = "n")
outc_last <- outc %>% filter(year == max(year))
p2 <- ggplot(outc, aes(x = year, y = n, colour = k)) +
  geom_line(linewidth = 0.9) + geom_point(size = 1.2) +
  scale_colour_manual(values = c("Withdrawals" = lws_colors[["text"]], "Mitigation measures" = lws_colors[["red"]]), name = NULL) +
  scale_x_continuous(breaks = seq(2010, 2024, 4)) +
  scale_y_continuous(limits = c(0, 100), expand = c(0, 0)) +
  labs(title = "B. Enforcement outcomes", x = NULL, y = "Number of cases") +
  theme_econ_textbook() + theme(legend.position = "top", legend.justification = "left", legend.text = element_text(size = 7.5))

# C. China-related share
p3 <- ggplot(cfius, aes(x = year, y = china_related_pct)) +
  geom_line(colour = lws_colors[["red"]], linewidth = 0.9) +
  geom_point(colour = lws_colors[["red"]], size = 1.2) +
  scale_x_continuous(breaks = seq(2010, 2024, 4)) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, 40), expand = c(0, 0)) +
  labs(title = "C. China-related share of reviews", x = NULL, y = "Share of reviews (%)") +
  theme_econ_textbook()

combined <- p1 / (p2 | p3) + plot_layout(heights = c(1.3, 1)) +
  plot_annotation(
    caption = paste(strwrap("Source: CFIUS Annual Reports to Congress; the China-related share is the author's estimate. FIRRMA = Foreign Investment Risk Review Modernization Act. Withdrawn notices are not necessarily abandoned deals.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here::here("figures", "fig_08_03_cfius_reviews.png"), plot = combined, width = 6, height = 6)

cat("Figure 8.3 created: CFIUS Reviews\n")
