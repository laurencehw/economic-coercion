# Figure 10.3: AI Development Indicators - USA vs China vs EU
# Purpose: Multi-dimensional comparison of AI capabilities
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)
library(ggradar)  # For radar charts - install if needed

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Read the data
df <- read_csv(here("data", "sources", "ai_development_indicators.csv"))

# Prepare data for radar chart (normalized shares)
radar_categories <- c("Publications", "Top_Conferences", "Patents", "Startups",
                      "Venture_Capital", "Supercomputers", "Researchers")

# Calculate normalized shares for radar
radar_data <- df %>%
  filter(Indicator %in% c("AI_Publications", "Top_AI_Conferences_Share",
                          "AI_Patents", "AI_Startups", "AI_Venture_Capital",
                          "Top_500_Supercomputers", "AI_Researchers")) %>%
  mutate(
    Total = USA + China + EU,
    USA_Share = USA / Total * 100,
    China_Share = China / Total * 100,
    EU_Share = EU / Total * 100
  ) %>%
  select(Indicator, USA_Share, China_Share, EU_Share)

# ============================================================================
# 2. PANEL A: GROUPED BAR - INVESTMENT AND FUNDING
# ============================================================================

investment_data <- df %>%
  filter(Indicator %in% c("AI_Venture_Capital", "Government_AI_Spending")) %>%
  mutate(
    Category = case_when(
      Indicator == "AI_Venture_Capital" ~ "AI Venture Capital",
      Indicator == "Government_AI_Spending" ~ "Government AI Spending"
    )
  ) %>%
  select(Category, USA, China, EU) %>%
  pivot_longer(cols = c(USA, China, EU), names_to = "Country", values_to = "Amount")

p1 <- ggplot(investment_data, aes(x = Category, y = Amount, fill = Country)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7,
           color = "black", linewidth = 0.3) +
  geom_text(aes(label = paste0("$", round(Amount, 1), "B")),
            position = position_dodge(width = 0.8),
            vjust = -0.5, size = 3.5, fontface = "bold") +
  scale_fill_manual(values = c("USA" = "#1f77b4", "China" = "#d62728", "EU" = "#2ca02c")) +
  scale_y_continuous(labels = scales::dollar_format(suffix = "B"),
                     expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "AI Investment and Government Funding",
    subtitle = "Billions USD (2024)",
    x = NULL,
    y = "Spending (Billions USD)"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "bottom")

# ============================================================================
# 3. PANEL B: RESEARCH OUTPUT COMPARISON
# ============================================================================

research_data <- df %>%
  filter(Indicator %in% c("AI_Publications", "Top_AI_Conferences_Share", "AI_Patents")) %>%
  mutate(
    Category = case_when(
      Indicator == "AI_Publications" ~ "AI Publications (thousands)",
      Indicator == "Top_AI_Conferences_Share" ~ "Top Conference Share (%)",
      Indicator == "AI_Patents" ~ "AI Patents (thousands)"
    ),
    # Normalize for display
    USA_disp = case_when(
      Indicator == "AI_Publications" ~ USA / 1000,
      Indicator == "Top_AI_Conferences_Share" ~ USA,
      Indicator == "AI_Patents" ~ USA / 1000
    ),
    China_disp = case_when(
      Indicator == "AI_Publications" ~ China / 1000,
      Indicator == "Top_AI_Conferences_Share" ~ China,
      Indicator == "AI_Patents" ~ China / 1000
    ),
    EU_disp = case_when(
      Indicator == "AI_Publications" ~ EU / 1000,
      Indicator == "Top_AI_Conferences_Share" ~ EU,
      Indicator == "AI_Patents" ~ EU / 1000
    )
  ) %>%
  select(Category, USA = USA_disp, China = China_disp, EU = EU_disp) %>%
  pivot_longer(cols = c(USA, China, EU), names_to = "Country", values_to = "Value")

p2 <- ggplot(research_data, aes(x = Category, y = Value, fill = Country)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7,
           color = "black", linewidth = 0.3) +
  geom_text(aes(label = round(Value, 0)),
            position = position_dodge(width = 0.8),
            vjust = -0.5, size = 3, fontface = "bold") +
  scale_fill_manual(values = c("USA" = "#1f77b4", "China" = "#d62728", "EU" = "#2ca02c")) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "AI Research Output",
    subtitle = "Publications and patents in thousands, conference share in %",
    x = NULL,
    y = "Value"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "bottom",
    axis.text.x = element_text(size = 9)
  )

# ============================================================================
# 4. PANEL C: TALENT AND INFRASTRUCTURE
# ============================================================================

talent_data <- df %>%
  filter(Indicator %in% c("AI_Researchers", "Top_500_Supercomputers", "AI_Startups")) %>%
  mutate(
    Category = case_when(
      Indicator == "AI_Researchers" ~ "AI Researchers (thousands)",
      Indicator == "Top_500_Supercomputers" ~ "Top 500 Supercomputers",
      Indicator == "AI_Startups" ~ "AI Startups"
    ),
    USA_disp = case_when(
      Indicator == "AI_Researchers" ~ USA / 1000,
      TRUE ~ as.numeric(USA)
    ),
    China_disp = case_when(
      Indicator == "AI_Researchers" ~ China / 1000,
      TRUE ~ as.numeric(China)
    ),
    EU_disp = case_when(
      Indicator == "AI_Researchers" ~ EU / 1000,
      TRUE ~ as.numeric(EU)
    )
  ) %>%
  select(Category, USA = USA_disp, China = China_disp, EU = EU_disp) %>%
  pivot_longer(cols = c(USA, China, EU), names_to = "Country", values_to = "Value")

p3 <- ggplot(talent_data, aes(x = Category, y = Value, fill = Country)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7,
           color = "black", linewidth = 0.3) +
  geom_text(aes(label = round(Value, 0)),
            position = position_dodge(width = 0.8),
            vjust = -0.5, size = 3, fontface = "bold") +
  scale_fill_manual(values = c("USA" = "#1f77b4", "China" = "#d62728", "EU" = "#2ca02c")) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "AI Talent and Infrastructure",
    subtitle = "Researchers in thousands, supercomputers and startups as counts",
    x = NULL,
    y = "Value"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "bottom",
    axis.text.x = element_text(size = 9)
  )

# ============================================================================
# 5. COMBINE PANELS
# ============================================================================

combined <- (p1 | p2) / p3 +
  plot_layout(heights = c(1, 1)) +
  plot_annotation(
    title = "Figure 10.3: AI Development Indicators",
    subtitle = "Multi-dimensional comparison: USA vs China vs EU (2024)",
    caption = paste0(
      "Sources: Stanford AI Index 2024, OECD AI Policy Observatory, Top500 Supercomputer List,\n",
      "CB Insights AI Investment Report, national government announcements."
    ),
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  ) &
  theme(legend.position = "bottom")

# ============================================================================
# 6. SAVE OUTPUT
# ============================================================================

save_econ_figure(here("figures", "fig_10_03_ai_indicators.png"), combined, width = 14, height = 10)

cat("\nFigure 10.3 AI Indicators created successfully!\n")
