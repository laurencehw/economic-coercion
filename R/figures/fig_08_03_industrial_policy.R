# Figure 8.3: Industrial Policy Spending Comparison - U.S. vs China
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

p1 <- ggplot(label_data, aes(x = Country, y = Amount, fill = Program)) +
  geom_col(color = "white", linewidth = 0.5, width = 0.7) +
  geom_text(aes(y = midpoint, label = ifelse(Amount > 40,
                                              paste0("$", round(Amount), "B\n", Program),
                                              "")),
            color = "white", fontface = "bold", size = 3.5, lineheight = 0.9) +
  geom_text(data = totals, aes(x = Country, y = Total, label = paste0("Total: $", round(Total), "B")),
            inherit.aes = FALSE, vjust = -0.5, fontface = "bold", size = 4) +
  scale_fill_manual(values = c(
    "CHIPS Act" = "#1f77b4",
    "IRA (Clean Energy)" = "#2ca02c",
    "Infrastructure" = "#ff7f0e",
    "Big Fund I+II+III" = "#1f77b4",
    "Made in China 2025" = "#9467bd",
    "New Infrastructure" = "#ff7f0e",
    "EV Subsidies" = "#d62728",
    "Solar Subsidies" = "#2ca02c"
  )) +
  scale_y_continuous(labels = scales::dollar_format(suffix = "B"), expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Major Industrial Policy Programs",
    subtitle = "Total Committed Spending by Country",
    x = NULL,
    y = "Total Spending (Billions USD)"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "none")

# ============================================================================
# 3. PANEL B: ANNUAL SPENDING OVER TIME
# ============================================================================

# Create annual spending data
years <- 2014:2032

# Calculate annual spending based on program timelines
annual_data <- tibble(Year = years) %>%
  mutate(
    # USA programs (CHIPS 2022-2027, IRA 2022-2032, Infrastructure 2021-2026)
    USA = case_when(
      Year >= 2022 & Year <= 2027 ~ 52.7/6,  # CHIPS
      TRUE ~ 0
    ) + case_when(
      Year >= 2022 & Year <= 2032 ~ 369/11,  # IRA
      TRUE ~ 0
    ) + case_when(
      Year >= 2021 & Year <= 2026 ~ 550/6,   # Infrastructure
      TRUE ~ 0
    ),
    # China programs (Big Fund 2014-2029, MIC2025 2015-2025, New Infra 2020-2025, etc.)
    China = case_when(
      Year >= 2014 & Year <= 2029 ~ 98.2/16,  # Big Fund
      TRUE ~ 0
    ) + case_when(
      Year >= 2015 & Year <= 2025 ~ 300/11,   # MIC2025
      TRUE ~ 0
    ) + case_when(
      Year >= 2020 & Year <= 2025 ~ 411/6,    # New Infrastructure
      TRUE ~ 0
    ) + case_when(
      Year >= 2015 & Year <= 2028 ~ 58.5/14,  # EV Subsidies
      TRUE ~ 0
    ) + case_when(
      Year >= 2011 & Year <= 2024 ~ 42.3/14,  # Solar
      TRUE ~ 0
    )
  ) %>%
  pivot_longer(cols = c(USA, China), names_to = "Country", values_to = "Spending")

p2 <- ggplot(annual_data, aes(x = Year, y = Spending, color = Country, fill = Country)) +
  geom_area(alpha = 0.2, position = "identity") +
  geom_line(linewidth = 1.5) +
  geom_point(size = 2) +
  geom_vline(xintercept = 2022, linetype = "dashed", color = "gray40", linewidth = 1) +
  annotate("label", x = 2022, y = max(annual_data$Spending) * 0.95,
           label = "CHIPS & IRA\nPassed", size = 3, fill = "lightyellow",
           label.size = 0.5) +
  scale_color_manual(values = c("USA" = "#1f77b4", "China" = "#d62728")) +
  scale_fill_manual(values = c("USA" = "#1f77b4", "China" = "#d62728")) +
  scale_y_continuous(labels = scales::dollar_format(suffix = "B")) +
  labs(
    title = "Annual Industrial Policy Spending",
    subtitle = "Estimated annual disbursements over time",
    x = "Year",
    y = "Annual Spending (Billions USD)",
    color = "Country",
    fill = "Country"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "bottom")

# ============================================================================
# 4. COMBINE PANELS
# ============================================================================

combined <- p1 + p2 +
  plot_layout(widths = c(1, 1.5)) +
  plot_annotation(
    title = "Figure 8.3: Industrial Policy Spending Comparison",
    subtitle = "U.S. vs. China major government programs in strategic sectors",
    caption = "Sources: CHIPS and Science Act (2022), Inflation Reduction Act (2022), Infrastructure Investment and Jobs Act (2021),\nChina National IC Industry Investment Fund, Made in China 2025, Chinese government announcements.",
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  )

# ============================================================================
# 5. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_08_03_industrial_policy.png"), combined, width = 14, height = 7)

cat("\nFigure 8.3 created successfully!\n")
