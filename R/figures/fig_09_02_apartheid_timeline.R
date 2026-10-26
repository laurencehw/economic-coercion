# Figure 9.2: Anti-Apartheid Sanctions Timeline
# Purpose: Visualize the evolution of anti-apartheid sanctions 1960-1994
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)
library(scales)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Major events in anti-apartheid sanctions history
events_data <- tibble(
  Year = c(1960, 1962, 1963, 1977, 1985, 1986, 1989, 1990, 1991, 1994),
  Event = c(
    "Sharpeville Massacre\n(69 killed)",
    "UN calls for\nvoluntary sanctions",
    "Voluntary UN\narms embargo",
    "Mandatory UN\narms embargo",
    "Chase Manhattan\nleads bank exit",
    "US CAAA passed\n(over Reagan veto)",
    "De Klerk begins\nreforms",
    "Mandela released\nfrom prison",
    "US lifts most\nsanctions",
    "Democratic elections\n(sanctions end)"
  ),
  Category = c("Trigger", "Multilateral", "Multilateral", "Multilateral",
               "Financial", "US Policy", "SA Response", "SA Response",
               "Sanctions Relief", "Resolution"),
  Importance = c(3, 1, 2, 3, 3, 3, 2, 3, 2, 3)
)

# Economic indicator data for South Africa
economic_data <- tibble(
  Year = 1980:1994,
  GDP_Growth = c(6.6, 5.4, -0.4, -1.8, 5.1, -1.2, 0.0, 2.1, 4.2, 0.3, -0.3, -1.0, -2.1, 1.2, 3.2),
  Rand_USD = c(1.28, 1.14, 0.92, 0.90, 0.69, 0.45, 0.44, 0.49, 0.44, 0.38, 0.39, 0.36, 0.35, 0.31, 0.28),
  FDI_Billions = c(0.8, 0.6, 0.4, 0.3, 0.4, -0.2, -0.5, -0.3, 0.1, 0.2, 0.3, 0.4, 0.6, 1.2, 1.5)
)

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# Event colors by category
events_data <- events_data %>%
  mutate(row = rev(seq_len(n())),
         lab = paste0(Year, ": ", gsub("\n", " ", Event)),
         key = Category %in% c("Financial", "US Policy"),
         right = Year < 1980)

p1 <- ggplot(events_data, aes(x = Year, y = row)) +
  geom_segment(aes(x = 1958, xend = Year, yend = row), colour = lws_colors[["grid"]], linewidth = 0.4) +
  geom_point(aes(colour = key), size = 2.2) +
  geom_text(aes(label = lab, colour = key, hjust = ifelse(right, -0.06, 1.06), x = ifelse(right, Year, Year)),
            size = book_text_size) +
  scale_colour_manual(values = c("TRUE" = lws_colors[["red"]], "FALSE" = lws_colors[["text"]]), guide = "none") +
  scale_x_continuous(limits = c(1958, 1996), breaks = seq(1960, 1995, 5)) +
  labs(title = "A. Sanctions timeline (red: financial and U.S. measures)", x = NULL, y = NULL) +
  theme_econ_textbook() +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(), panel.grid.major.y = element_blank(),
        panel.grid.minor = element_blank())

p2 <- ggplot(economic_data, aes(x = Year, y = GDP_Growth)) +
  geom_col(fill = lws_colors[["fade"]], width = 0.7) +
  geom_col(data = economic_data %>% filter(Year == 1985), fill = lws_colors[["red"]], width = 0.7) +
  geom_hline(yintercept = 0, colour = lws_colors[["ink"]], linewidth = 0.3) +
  annotate("text", x = 1985, y = 6.2, label = "1985: banks\nstop rolling\nover debt", colour = lws_colors[["red"]], size = book_text_size, lineheight = 0.9, vjust = 0) +
  scale_x_continuous(breaks = seq(1980, 1994, 4)) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(-3, 10)) +
  labs(title = "B. South African GDP growth", x = NULL, y = "Real GDP growth (%)") +
  theme_econ_textbook()

p3 <- ggplot(economic_data, aes(x = Year, y = Rand_USD)) +
  geom_line(colour = lws_colors[["ink"]], linewidth = 0.9) +
  geom_point(colour = lws_colors[["ink"]], size = 1.2) +
  geom_vline(xintercept = 1985, colour = lws_colors[["red"]], linetype = "dashed") +
  annotate("text", x = 1985.3, y = 1.2, label = "1985", hjust = 0, colour = lws_colors[["red"]], size = book_text_size) +
  scale_x_continuous(breaks = seq(1980, 1994, 4)) +
  scale_y_continuous(labels = function(x) paste0("$", x), limits = c(0, 1.4), expand = c(0, 0)) +
  labs(title = "C. U.S. dollars per rand", x = NULL, y = "USD per rand, annual average") +
  theme_econ_textbook()

combined <- p1 / (p2 | p3) + plot_layout(heights = c(1.1, 1.1)) +
  plot_annotation(
    caption = paste(strwrap("Sources: UN Security Council resolutions, Hufbauer et al. sanctions database, World Bank, IMF and South African Reserve Bank. CAAA = Comprehensive Anti-Apartheid Act of 1986. Series in panels B and C are compiled in the book's source tables and have not been re-verified against the SARB releases.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here("figures", "fig_09_02_apartheid_timeline.png"), combined, width = 6, height = 6)

cat("\nFigure 9.2 created\n")
