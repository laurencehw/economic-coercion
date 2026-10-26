# Figure 8.5: Industrial Policy Spending Comparison
# Chapter 8: Investment Screening and Industrial Policy
# Compares US, China, and EU approaches to industrial policy

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(forcats)

# Industrial policy programs
industrial_policy <- data.frame(
  program = c(
    "CHIPS Act", "Inflation Reduction Act", "Infrastructure Act",
    "Big Fund I", "Big Fund II", "Big Fund III",
    "EU Chips Act", "NextGenerationEU", "Green Deal Industrial Plan"
  ),
  country = c(
    "USA", "USA", "USA",
    "China", "China", "China",
    "EU", "EU", "EU"
  ),
  amount_billions = c(
    52, 369, 550,
    21, 29, 47.5,
    43, 800, 270
  ),
  timeframe = c(
    "2022-2027", "2022-2032", "2021-2026",
    "2014-2019", "2019-2024", "2024-2029",
    "2023-2030", "2021-2027", "2023-2030"
  ),
  focus = c(
    "Semiconductors", "Clean Energy", "Infrastructure",
    "Semiconductors", "Semiconductors", "Semiconductors",
    "Semiconductors", "Recovery/Digital", "Green Industry"
  ),
  type = c(
    "Subsidies/Tax Credits", "Tax Credits", "Grants",
    "State Investment", "State Investment", "State Investment",
    "Subsidies", "Grants/Loans", "Subsidies/Loans"
  )
)

# Country colors
country_colors <- c("USA" = lws_colors[["fade"]], "China" = lws_colors[["red"]], "EU" = lws_colors[["text"]])
bloc_lab <- c("USA" = "United States", "China" = "China", "EU" = "European Union")

# One panel: programmes sorted within bloc, announced totals; bloc totals in the strip labels.
bloc_tot <- industrial_policy %>% group_by(country) %>% summarise(total = sum(amount_billions), .groups = "drop")
strip_lab <- setNames(paste0(bloc_lab[bloc_tot$country], " (sum $", bloc_tot$total, "B)"), bloc_tot$country)
ip <- industrial_policy %>%
  mutate(country = factor(country, levels = c("USA", "China", "EU")),
         key = paste(country, program, sep = "___"),
         key = fct_reorder(key, amount_billions))

combined <- ggplot(ip, aes(x = key, y = amount_billions, fill = country)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0("$", amount_billions, "B  ", timeframe)), hjust = -0.08, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_x_discrete(labels = function(x) sub("^.*___", "", x)) +
  scale_fill_manual(values = country_colors, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.75)), labels = function(x) paste0("$", x, "B")) +
  facet_grid(country ~ ., scales = "free_y", space = "free_y", labeller = labeller(country = strip_lab)) +
  coord_flip() +
  labs(x = NULL, y = "Announced funding (billions of US dollars)") +
  book_source("Source: Government announcements, budget documents and PIIE analysis. Amounts are announced totals over each programme's stated years; actual spending may differ. The totals add programmes of different length and scope and are not like-for-like.") +
  theme_book_h() +
  theme(strip.text.y = element_text(angle = 0, hjust = 0, face = "bold", colour = lws_colors[["ink"]]))

save_econ_figure(here::here("figures", "fig_08_05_industrial_policy_compare.png"), plot = combined, width = 6, height = 5)

cat("Figure 8.5 created: Industrial Policy Comparison\n")
