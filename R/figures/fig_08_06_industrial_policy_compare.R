# Figure 8.6: Industrial Policy Spending Comparison
# Chapter 8: Investment Screening and Industrial Policy
# Compares US, China, and EU approaches to industrial policy

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(forcats)

# Industrial policy programs
industrial_policy <- data.frame(
  program = c(
    "CHIPS Act", "Inflation Reduction Act", "Infrastructure Act",
    "Big Fund I", "Big Fund II", "Made in China 2025",
    "EU Chips Act", "NextGenerationEU", "Green Deal Industrial Plan"
  ),
  country = c(
    "USA", "USA", "USA",
    "China", "China", "China",
    "EU", "EU", "EU"
  ),
  amount_billions = c(
    52, 369, 550,
    22, 29, 300,
    43, 800, 270
  ),
  timeframe = c(
    "2022-2027", "2022-2032", "2021-2026",
    "2014-2019", "2019-2024", "2015-2025",
    "2023-2030", "2021-2027", "2023-2030"
  ),
  focus = c(
    "Semiconductors", "Clean Energy", "Infrastructure",
    "Semiconductors", "Semiconductors", "High-Tech Manufacturing",
    "Semiconductors", "Recovery/Digital", "Green Industry"
  ),
  type = c(
    "Subsidies/Tax Credits", "Tax Credits", "Grants",
    "State Investment", "State Investment", "State Investment",
    "Subsidies", "Grants/Loans", "Subsidies/Loans"
  )
)

# Country colors
country_colors <- c("USA" = "#1f77b4", "China" = "#d62728", "EU" = "#2ca02c")

# Panel 1: Total by country
country_totals <- industrial_policy %>%
  group_by(country) %>%
  summarise(total = sum(amount_billions), .groups = "drop") %>%
  mutate(country = factor(country, levels = c("USA", "China", "EU")))

p1 <- ggplot(country_totals, aes(x = country, y = total, fill = country)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0("$", total, "B")), vjust = -0.3, size = 5, fontface = "bold") +
  scale_fill_manual(values = country_colors, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Total Industrial Policy Spending (Recent Programs)",
    subtitle = "Sum of major programs 2014-2030",
    x = NULL,
    y = "Total Spending (USD Billions)"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank())

# Panel 2: By program
industrial_policy <- industrial_policy %>%
  mutate(program = fct_reorder(program, amount_billions))

p2 <- ggplot(industrial_policy, aes(x = program, y = amount_billions, fill = country)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0("$", amount_billions, "B")), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_fill_manual(values = country_colors, name = "Country") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Major Industrial Policy Programs",
    subtitle = "Announced funding levels by program",
    x = NULL,
    y = "Funding (USD Billions)"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Panel 3: Focus areas radar chart (simplified as grouped bars)
focus_summary <- industrial_policy %>%
  mutate(
    sector = case_when(
      grepl("Semiconductor|Chips", focus) ~ "Semiconductors",
      grepl("Clean|Green", focus) ~ "Clean Energy",
      TRUE ~ "Other"
    )
  ) %>%
  group_by(country, sector) %>%
  summarise(total = sum(amount_billions), .groups = "drop")

p3 <- ggplot(focus_summary, aes(x = sector, y = total, fill = country)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  scale_fill_manual(values = country_colors, name = "Country") +
  labs(
    title = "Spending by Strategic Focus",
    subtitle = "How each bloc prioritizes different sectors",
    x = NULL,
    y = "Funding (USD Billions)",
    caption = "Source: Government announcements, budget documents, PIIE analysis\nNote: Amounts are announced totals; actual spending may differ"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank())

# Combine
library(patchwork)
combined <- (p1 + p3) / p2 + plot_layout(heights = c(1, 1.5))

# Save the figure
save_econ_figure("figures/fig_08_06_industrial_policy_compare.png", plot = combined, width = 13, height = 11)

cat("Figure 8.6 created: Industrial Policy Comparison\n")
