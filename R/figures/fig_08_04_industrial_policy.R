# Figure 8.4: Industrial Policy Spending Comparison - U.S. vs China
# Purpose: Compare major government industrial policy programs
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# data/sources/industrial_policy_spending.csv: announced or estimated programme totals (hand-compiled from the
# statutes, CBO scores and the Chinese programme announcements; not disbursements). The three Big Fund phases
# are one line in the chart. Panel B of earlier versions (each total spread evenly over assumed years) was
# cut: the years were not sourced and did not match the CSV.
df <- read.csv(here("data", "sources", "industrial_policy_spending.csv"), stringsAsFactors = FALSE,
               encoding = "UTF-8")

all_programs <- df %>%
  mutate(Program = case_when(
    grepl("^China Big Fund", Program) ~ "Big Fund I+II+III",
    Program == "Inflation Reduction Act" ~ "IRA (Clean Energy)",
    Program == "Infrastructure Investment" ~ "Infrastructure",
    TRUE ~ Program)) %>%
  group_by(Country, Program) %>%
  summarise(Amount = sum(Total_Spending_Billions), .groups = "drop") %>%
  mutate(Country = factor(Country, levels = c("USA", "China")))

# Totals quoted in Chapter 8 must be reproduced by the extract.
stopifnot(
  all.equal(all_programs$Amount[all_programs$Program == "CHIPS Act"], 52.7),
  all.equal(all_programs$Amount[all_programs$Program == "IRA (Clean Energy)"], 369),
  all.equal(all_programs$Amount[all_programs$Program == "Big Fund I+II+III"], 98.2),
  nrow(all_programs) == 8
)

totals <- all_programs %>%
  group_by(Country) %>%
  summarize(Total = sum(Amount), .groups = "drop")

# ============================================================================
# 2. COMMITMENTS BY PROGRAMME, SORTED WITHIN COUNTRY
# ============================================================================

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
  labs(x = NULL, y = "Announced or estimated total (billions of US dollars)") +
  theme_book_h() +
  theme(strip.text.y = element_text(angle = 0, hjust = 0, face = "bold", colour = lws_colors[["ink"]])) +
  book_source("Sources: CHIPS and Science Act (2022), Inflation Reduction Act (2022; as originally scored), Infrastructure Investment and Jobs Act (2021), China National IC Industry Investment Fund and Chinese government announcements, as compiled in data/sources/industrial_policy_spending.csv. Totals are announced or estimated commitments over programmes of different lengths, not disbursements.")

save_econ_figure(here("figures", "fig_08_04_industrial_policy.png"), p1, width = 6, height = 4.3)

cat("\nFigure 8.4 created successfully!\n")
