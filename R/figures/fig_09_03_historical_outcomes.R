# Figure 9.3: Historical Economic Coercion Outcomes
# Chapter 9: Historical Cases
# Scatter plot of economic cost vs political success across historical cases

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(ggrepel)

# Historical cases data
historical_cases <- data.frame(
  case = c(
    "Cuba (1960-present)", "Iran (1979-2015)", "Russia (2014-)",
    "South Africa (1985-1994)", "Iraq (1990-2003)", "North Korea (2006-)",
    "Libya (2011)", "Myanmar (1988-2016)", "Venezuela (2017-)",
    "Japan rare earths (2010)", "Soviet grain (1980)", "Iran nuclear (2012)",
    "Russia SWIFT (2022)", "Huawei (2019-)", "ZTE (2018)"
  ),
  target_gdp_impact = c(
    -4, -8, -12, -3, -48, -15, -25, -5, -25, -0.5, -2, -15, -8, -20, -30
  ),
  sender_cost = c(
    2, 1, 3, 0.5, 0.5, 0.1, 0.2, 0.1, 0.5, 0.2, 1.5, 1, 2, 5, 0.5
  ),
  success_score = c(
    15, 40, 25, 85, 35, 20, 90, 50, 20, 80, 30, 75, 40, 30, 95
  ),
  objective = c(
    "Regime Change", "Regime Change", "Policy Change",
    "Policy Change", "Policy Change", "Denuclearization",
    "Regime Change", "Democratization", "Regime Change",
    "Policy Change", "Policy Change", "Policy Change",
    "Policy Change", "Capability Denial", "Policy Change"
  ),
  duration_years = c(
    64, 36, 10, 9, 13, 18, 1, 28, 7, 0.3, 1, 3, 2, 5, 0.5
  ),
  multilateral = c(
    "Partial", "Full", "Full", "Full", "Full", "Full",
    "Full", "Partial", "Partial", "Unilateral", "Partial", "Full",
    "Full", "Partial", "Unilateral"
  )
)

# Objective colors
historical_cases <- historical_cases %>% mutate(is_sa = grepl("^South Africa", case))
shape_vals <- c("Full" = 16, "Partial" = 17, "Unilateral" = 15)

p <- ggplot(historical_cases, aes(x = -target_gdp_impact, y = success_score)) +
  annotate("rect", xmin = 0, xmax = 25, ymin = 50, ymax = 100, fill = "#F2F2F2") +
  annotate("rect", xmin = 25, xmax = 50, ymin = 0, ymax = 50, fill = "#F2F2F2") +
  annotate("text", x = 0.5, y = 99, label = "High return: success at low cost", hjust = 0, vjust = 1, colour = lws_colors[["text"]]) +
  annotate("text", x = 49.5, y = 1, label = "Low return: failure despite high cost", hjust = 1, vjust = 0, colour = lws_colors[["text"]]) +
  geom_point(aes(shape = multilateral, colour = is_sa), size = 2.2) +
  geom_text_repel(aes(label = case, colour = is_sa), size = book_text_size, max.overlaps = 20,
                  box.padding = 0.35, point.padding = 0.2, segment.colour = lws_colors[["fade"]], seed = 11, show.legend = FALSE) +
  scale_colour_manual(values = c("TRUE" = lws_colors[["red"]], "FALSE" = lws_colors[["ink"]]), guide = "none") +
  scale_shape_manual(values = shape_vals, name = NULL) +
  scale_x_continuous(labels = function(x) paste0(x, "%"), limits = c(0, 50)) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, 100)) +
  labs(x = "Estimated target GDP impact (% decline)", y = "Success score (author's judgment, 0-100)") +
  book_source("Source: Author's compilation based on Hufbauer et al. and the PIIE sanctions database. Both axes are the author's rough estimates and judgments, not measurements; the success score combines policy change achieved and durability. Marker shape shows international coordination.") +
  theme_econ_textbook() +
  theme(legend.position = "top", legend.justification = "left")

save_econ_figure(here::here("figures", "fig_09_03_historical_outcomes.png"), plot = p, width = 6, height = 5)

cat("Figure 9.3 created: Historical Outcomes Scatter\n")
