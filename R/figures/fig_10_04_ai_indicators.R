# Figure 10.4: AI development indicators, United States, China and EU
# Reads data/sources/ai_development_indicators.csv (values as compiled for the book).
library(here)
library(tidyverse)
source(here("R", "setup_theme.R"))
source(here("R", "theme_book.R"))

df <- read_csv(here("data", "sources", "ai_development_indicators.csv"), show_col_types = FALSE)

spec <- tribble(
  ~Indicator, ~label, ~scale,
  "AI_Publications_2024", "AI publications (thousands)", 1000,
  "AI_Patents_Filed_2024", "AI patents filed (thousands)", 1000,
  "AI_Researchers_Thousands", "AI researchers (thousands)", 1,
  "AI_Startups", "AI startups (count)", 1,
  "AI_Venture_Capital_2024_Billions", "AI venture capital ($ billions)", 1,
  "Government_AI_Spending_Billions", "Government AI spending ($ billions)", 1,
  "Supercomputer_Performance_Exaflops", "Supercomputer performance (exaflops)", 1,
  "Top_AI_Conferences_Share", "Share of top AI conferences (%)", 1
)

plot_df <- df %>%
  inner_join(spec, by = "Indicator") %>%
  select(label, scale, USA, China, EU) %>%
  pivot_longer(c(USA, China, EU), names_to = "Country", values_to = "Value") %>%
  mutate(Value = Value / scale,
         Country = factor(Country, levels = c("EU", "USA", "China")),
         label = factor(label, levels = spec$label))
stopifnot(nrow(plot_df) == 24)

p <- ggplot(plot_df, aes(x = Country, y = Value, fill = Country)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = scales::label_number(accuracy = 0.1, big.mark = ",", drop0trailing = TRUE)(Value)),
            hjust = -0.15, colour = lws_colors[["ink"]], size = book_text_size) +
  coord_flip() +
  facet_wrap(~label, ncol = 2, scales = "free_x") +
  scale_fill_manual(values = c(China = lws_colors[["red"]], USA = "#7A7A7A", EU = lws_colors[["fade"]]), guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.28))) +
  labs(x = NULL, y = NULL) +
  book_source("Source: Stanford AI Index 2024, OECD AI Policy Observatory, Top500 list and CB Insights, as compiled in data/sources/ai_development_indicators.csv; reference year 2024. Each panel has its own scale. Supercomputer performance is in exaflops, not counts of systems.") +
  theme_book_h() +
  theme(strip.text = element_text(face = "bold", hjust = 0, colour = lws_colors[["ink"]]),
        panel.spacing = unit(1, "lines"))

save_econ_figure(here("figures", "fig_10_04_ai_indicators.png"), p, width = 6, height = 6)
cat("Figure 10.4 created\n")
