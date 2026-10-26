# Figure 4.2: AI Development Indicators - USA vs China
# Author: Laurence Wilse-Samson
# Description: Comprehensive view of AI research race - quantity vs quality

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

# Multi-indicator snapshot
ai_indicators <- read_csv(here::here("data", "sources", "ai_development_indicators.csv"))

# ============================================================================
# PANEL D: MULTI-INDICATOR RADAR/COMPARISON
# ============================================================================

# Prepare indicator data for comparison
indicators_comp <- ai_indicators %>%
  # Normalize some indicators as percentages
  mutate(
    USA_Pct = case_when(
      Indicator == "Top_AI_Conferences_Share" ~ USA,
      TRUE ~ (USA / Global_Total) * 100
    ),
    China_Pct = case_when(
      Indicator == "Top_AI_Conferences_Share" ~ China,
      TRUE ~ (China / Global_Total) * 100
    ),
    # Clean labels
    Indicator_Label = case_when(
      Indicator == "AI_Publications_2024" ~ "Publications",
      Indicator == "Top_AI_Conferences_Share" ~ "Top Conferences",
      Indicator == "AI_Patents_Filed_2024" ~ "Patents",
      Indicator == "AI_Startups" ~ "Startups",
      Indicator == "AI_Venture_Capital_2024_Billions" ~ "VC Funding",
      Indicator == "Supercomputer_Performance_Exaflops" ~ "Supercomputers",
      Indicator == "AI_Chip_Design_Companies" ~ "Chip Companies",
      Indicator == "AI_Researchers_Thousands" ~ "Researchers",
      Indicator == "AI_Ethics_Regulations_Score" ~ "Ethics/Regulation",
      Indicator == "Government_AI_Spending_Billions" ~ "Gov't Spending",
      TRUE ~ Indicator
    )
  ) %>%
  select(Indicator_Label, USA_Pct, China_Pct) %>%
  pivot_longer(
    cols = c(USA_Pct, China_Pct),
    names_to = "Country",
    values_to = "Percentage"
  ) %>%
  mutate(
    Country = recode(Country, "USA_Pct" = "USA", "China_Pct" = "China"),
    Indicator_Label = fct_reorder(Indicator_Label, Percentage, .fun = max)
  )

# One panel: dumbbell of the U.S. and Chinese share of each 2024 indicator, sorted by
# China's lead. (The three time-series panels of the earlier dashboard are not discussed
# in the chapter and are dropped from this figure.)
ind_order <- indicators_comp %>% filter(Country == "China") %>% arrange(Percentage) %>% pull(Indicator_Label) %>% as.character()
indicators_comp <- indicators_comp %>% mutate(Indicator_Label = factor(as.character(Indicator_Label), levels = ind_order))
wide <- indicators_comp %>% pivot_wider(names_from = Country, values_from = Percentage)

combined_plot <- ggplot() +
  geom_segment(data = wide, aes(x = USA, xend = China, y = Indicator_Label, yend = Indicator_Label),
               colour = lws_colors[["fade"]], linewidth = 0.8) +
  geom_point(data = indicators_comp, aes(x = Percentage, y = Indicator_Label, colour = Country), size = 2.6) +
  scale_colour_manual(values = c("USA" = lws_colors[["blue"]], "China" = lws_colors[["red"]]),
                      breaks = c("China", "USA")) +
  scale_x_continuous(labels = label_percent(scale = 1), breaks = seq(0, 70, 10), limits = c(0, 70)) +
  labs(x = "Share of global total, 2024", y = NULL) +
  book_source("Sources: Stanford AI Index Report 2024; Scopus; Web of Science; arXiv. Shares are of the global total for each indicator; conference share is the top-10 AI conferences.") +
  theme_book_h()

save_econ_figure(
  filename = here::here("figures", "fig_04_02_ai_development.png"),
  plot = combined_plot, width = 6, height = 3.9
)

cat("Figure 4.2 created\n")
