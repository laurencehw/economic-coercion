# Figure 8.4: Industrial Policy Spending Comparison - U.S. vs China
# Purpose: Compare major government industrial policy programs
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
df <- read_csv(here("data", "sources", "industrial_policy_spending.csv"))

# Create program-level data for visualization
programs_usa <- tibble(
  Country = "USA",
  Program = c("CHIPS Act", "IRA (Clean Energy)", "Infrastructure"),
  Amount = c(52.7, 369, 550),
  Category = c("Semiconductors", "Clean Energy", "Infrastructure")
)

programs_china <- tibble(
  Country = "China",
  Program = c("Big Fund I+II+III", "Made in China 2025", "New Infrastructure",
              "EV Subsidies", "Solar Subsidies"),
  Amount = c(98.2, 300, 411, 58.5, 42.3),
  Category = c("Semiconductors", "Advanced Manufacturing", "Infrastructure",
               "Electric Vehicles", "Clean Energy")
)

all_programs <- bind_rows(programs_usa, programs_china) %>%
  mutate(
    Country = factor(Country, levels = c("USA", "China")),
    Program = fct_reorder(Program, Amount)
  )

# Calculate totals
totals <- all_programs %>%
  group_by(Country) %>%
  summarize(Total = sum(Amount), .groups = "drop")

# ============================================================================
# 2. PANEL A: STACKED BAR BY PROGRAM
# ============================================================================

# Prepare cumulative positions for labels
label_data <- all_programs %>%
  group_by(Country) %>%
  arrange(Country, desc(Amount)) %>%
  mutate(
    cumsum = cumsum(Amount),
    midpoint = cumsum - Amount/2
  ) %>%
  ungroup()

# Panel A: commitments by programme, sorted bars within country (replaces stacked bars)
prog <- all_programs %>% mutate(key = paste(Country, Program, sep = "___"),
                                key = fct_reorder(key, Amount))
strip_lab <- setNames(paste0(totals$Country, " (total $", round(totals$Total), "B)"), totals$Country)

p1 <- ggplot(prog, aes(x = key, y = Amount, fill = Country)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0("$", round(Amount, 1), "B")), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_x_discrete(labels = function(x) sub("^.*___", "", x)) +
  scale_fill_manual(values = c("USA" = lws_colors[["fade"]], "China" = lws_colors[["red"]]), guide = "none") +
  scale_y_continuous(labels = scales::dollar_format(suffix = "B"), expand = expansion(mult = c(0, 0.2))) +
  facet_grid(Country ~ ., scales = "free_y", space = "free_y", labeller = labeller(Country = strip_lab)) +
  coord_flip() +
  labs(title = "A. Committed spending by programme", x = NULL, y = "Committed spending (billions of US dollars)") +
  theme_book_h() +
  theme(strip.text.y = element_text(angle = 0, hjust = 0, face = "bold", colour = lws_colors[["ink"]]))

# Panel B: STYLIZED. Each programme's committed total is spread evenly over its stated years;
# these are not reported annual disbursements.
years <- 2014:2032
spread <- function(total, from, to) ifelse(years >= from & years <= to, total / (to - from + 1), 0)
annual_data <- tibble(
  Year = years,
  USA = spread(52.7, 2022, 2027) + spread(369, 2022, 2032) + spread(550, 2021, 2026),
  China = spread(98.2, 2014, 2029) + spread(300, 2015, 2025) + spread(411, 2020, 2025) + spread(58.5, 2015, 2028) + spread(42.3, 2011, 2024)
) %>% pivot_longer(c(USA, China), names_to = "Country", values_to = "Spending")
ann_last <- annual_data %>% filter(Year == max(Year))

p2 <- ggplot(annual_data, aes(x = Year, y = Spending, colour = Country)) +
  geom_line(linewidth = 0.9) +
  geom_vline(xintercept = 2022, linetype = "dashed", colour = lws_colors[["ref"]]) +
  annotate("text", x = 2021.8, y = max(annual_data$Spending) * 1.04, label = "CHIPS and IRA passed, 2022", hjust = 1, colour = lws_colors[["text"]]) +
  annotate("text", x = 2031.5, y = 40, label = "USA", hjust = 1, colour = lws_colors[["text"]], size = book_text_size) +
  annotate("text", x = 2031.5, y = 9, label = "China", hjust = 1, colour = lws_colors[["red"]], size = book_text_size) +
  scale_colour_manual(values = c("USA" = lws_colors[["text"]], "China" = lws_colors[["red"]]), guide = "none") +
  scale_y_continuous(labels = scales::dollar_format(suffix = "B"), limits = c(0, 150)) +
  labs(title = "B. Committed totals spread evenly over programme years", x = NULL, y = "Implied per year (billions of US dollars)") +
  theme_econ_textbook()

combined <- p1 / p2 + plot_layout(heights = c(1.2, 1)) +
  plot_annotation(
    caption = paste(strwrap("Sources: CHIPS and Science Act (2022), Inflation Reduction Act (2022), Infrastructure Investment and Jobs Act (2021), China National IC Industry Investment Fund and government announcements. Panel B is the author's illustration (stylized, not data): each programme's announced total divided evenly across its stated years, not reported disbursements.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here("figures", "fig_08_04_industrial_policy.png"), combined, width = 6, height = 6.4)

cat("\nFigure 8.4 created successfully!\n")
