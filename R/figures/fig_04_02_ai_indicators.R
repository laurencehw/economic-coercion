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

# Time series data
ai_pubs <- read_csv(here::here("data", "sources", "ai_publications.csv"))

# Multi-indicator snapshot
ai_indicators <- read_csv(here::here("data", "sources", "ai_development_indicators.csv"))

# ============================================================================
# PANEL A: AI PUBLICATIONS OVER TIME
# ============================================================================

pubs_long <- ai_pubs %>%
  select(Year, USA_Publications, China_Publications, EU_Publications) %>%
  pivot_longer(
    cols = -Year,
    names_to = "Country",
    values_to = "Publications"
  ) %>%
  mutate(
    Country = recode(Country,
                    "USA_Publications" = "USA",
                    "China_Publications" = "China",
                    "EU_Publications" = "EU")
  )

panel_a <- ggplot(pubs_long, aes(x = Year, y = Publications, color = Country, linetype = Country)) +
  geom_line(linewidth = 1.5) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_color_manual(
    values = c("USA" = econ_colors["USA"],
               "China" = econ_colors["China"],
               "EU" = econ_colors["EU"])
  ) +
  scale_linetype_manual(
    values = c("USA" = "solid", "China" = "solid", "EU" = "dashed")
  ) +
  scale_y_continuous(
    labels = label_comma(),
    breaks = seq(0, 150000, 30000)
  ) +
  scale_x_continuous(
    breaks = seq(2010, 2024, 2)
  ) +
  labs(
    title = "AI Research Publications (2010-2024)",
    subtitle = "China surpassed USA in volume in 2016",
    x = "Year",
    y = "Number of AI/ML Publications",
    color = "Country",
    linetype = "Country"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  ) +
  # Mark crossover point
  annotate(
    "segment",
    x = 2016,
    xend = 2016,
    y = 0,
    yend = 18000,
    linetype = "dotted",
    color = "gray30",
    linewidth = 1
  ) +
  annotate(
    "text",
    x = 2016,
    y = 120000,
    label = "China\nsurpasses\nUSA",
    size = 3,
    color = econ_colors["China"],
    fontface = "bold"
  ) +
  # 2024 values
  annotate(
    "text",
    x = 2025,
    y = ai_pubs$China_Publications[ai_pubs$Year == 2024],
    label = "138K",
    size = 3,
    color = econ_colors["China"],
    fontface = "bold",
    hjust = 0
  ) +
  annotate(
    "text",
    x = 2025,
    y = ai_pubs$USA_Publications[ai_pubs$Year == 2024],
    label = "70K",
    size = 3,
    color = econ_colors["USA"],
    fontface = "bold",
    hjust = 0
  )

# ============================================================================
# PANEL B: TOP-TIER CONFERENCE SHARE (QUALITY METRIC)
# ============================================================================

quality_long <- ai_pubs %>%
  select(Year, USA_Top10_Share, China_Top10_Share) %>%
  pivot_longer(
    cols = -Year,
    names_to = "Country",
    values_to = "Share"
  ) %>%
  mutate(
    Country = recode(Country,
                    "USA_Top10_Share" = "USA",
                    "China_Top10_Share" = "China")
  )

panel_b <- ggplot(quality_long, aes(x = Year, y = Share, color = Country, fill = Country)) +
  geom_area(alpha = 0.2, position = "identity") +
  geom_line(linewidth = 1.5) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_color_manual(
    values = c("USA" = econ_colors["USA"],
               "China" = econ_colors["China"])
  ) +
  scale_fill_manual(
    values = c("USA" = econ_colors["USA"],
               "China" = econ_colors["China"])
  ) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 50, 10),
    limits = c(0, 50)
  ) +
  scale_x_continuous(
    breaks = seq(2010, 2024, 2)
  ) +
  labs(
    title = "Share of Top-10 AI Conference Publications",
    subtitle = "Quality metric: USA leads in elite venues (NeurIPS, ICML, CVPR)",
    x = "Year",
    y = "Share of Top-Tier Publications (%)",
    color = "Country",
    fill = "Country"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  ) +
  # Annotate crossover in 2020
  annotate(
    "segment",
    x = 2020,
    xend = 2020,
    y = 0,
    yend = 32,
    linetype = "dotted",
    color = "gray30",
    linewidth = 1
  ) +
  annotate(
    "text",
    x = 2020,
    y = 38,
    label = "China catches\nUSA in quality",
    size = 3,
    color = econ_colors["China"],
    fontface = "bold"
  )

# ============================================================================
# PANEL C: CITATIONS (IMPACT METRIC)
# ============================================================================

citations_long <- ai_pubs %>%
  select(Year, USA_Citations, China_Citations) %>%
  pivot_longer(
    cols = -Year,
    names_to = "Country",
    values_to = "Citations"
  ) %>%
  mutate(
    Country = recode(Country,
                    "USA_Citations" = "USA",
                    "China_Citations" = "China")
  )

panel_c <- ggplot(citations_long, aes(x = Year, y = Citations, color = Country)) +
  geom_line(linewidth = 1.5) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_color_manual(
    values = c("USA" = econ_colors["USA"],
               "China" = econ_colors["China"])
  ) +
  scale_y_continuous(
    labels = label_comma(scale = 1/1000, suffix = "K"),
    breaks = seq(0, 1600000, 400000)
  ) +
  scale_x_continuous(
    breaks = seq(2010, 2024, 2)
  ) +
  labs(
    title = "Total AI Research Citations",
    subtitle = "China surpassed USA in cumulative impact in 2022",
    x = "Year",
    y = "Total Citations (Thousands)",
    color = "Country"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  ) +
  # Mark crossover
  annotate(
    "segment",
    x = 2022,
    xend = 2022,
    y = 0,
    yend = 1000000,
    linetype = "dotted",
    color = "gray30",
    linewidth = 1
  ) +
  annotate(
    "text",
    x = 2022,
    y = 1500000,
    label = "China\nsurpasses",
    size = 3,
    color = econ_colors["China"],
    fontface = "bold"
  )

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

panel_d <- ggplot(indicators_comp, aes(x = Percentage, y = Indicator_Label, fill = Country)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.75, alpha = 0.85) +
  geom_vline(xintercept = 50, linetype = "dashed", color = "gray50", linewidth = 0.8) +
  scale_fill_manual(
    values = c("USA" = econ_colors["USA"],
               "China" = econ_colors["China"])
  ) +
  scale_x_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 70, 10),
    limits = c(0, 75)
  ) +
  labs(
    title = "2024 AI Development Indicators",
    subtitle = "Global share across 10 key metrics",
    x = "Share of Global Total (%)",
    y = NULL,
    fill = "Country"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "top",
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.y = element_text(face = "bold", size = 10)
  ) +
  annotate(
    "text",
    x = 52,
    y = 10.5,
    label = "Majority",
    angle = 90,
    size = 2.5,
    color = "gray50",
    vjust = -0.5
  )

# ============================================================================
# COMBINE PANELS
# ============================================================================

combined_plot <- ((panel_a / panel_b / panel_c) | panel_d) +
  plot_annotation(
    title = "The AI Research Race: USA vs China (2010-2024)",
    subtitle = "China leads in quantity and total researchers; USA maintains quality edge in top-tier venues and venture capital",
    caption = paste0(
      "Source: arXiv.org, Scopus, Web of Science, Stanford AI Index Report 2024, OpenAI Research Trends\n",
      "Note: Publications include conference papers, journal articles, and preprints in AI/ML fields. Top-10 conferences: NeurIPS, ICML, CVPR, ICLR, ACL, EMNLP, etc.\n",
      "China now publishes 2x USA volume but USA maintains slight edge in elite venues and dominates VC funding (61% global share)."
    ),
    theme = theme_econ_textbook()
  ) +
  plot_layout(widths = c(1.2, 1))

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================

print(combined_plot)

# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_04_02_ai_development.png"),
  plot = combined_plot,
  width = 16,
  height = 14,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 4.2 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_04_02_ai_development.png\n")
cat("          figures/fig_04_02_ai_development.pdf\n")
cat("\n")
cat("AI Research Trends (2010-2024):\n")
cat("--------------------------------\n")
cat(sprintf("Publications:\n"))
cat(sprintf("  2010: USA %s, China %s\n",
            comma(ai_pubs$USA_Publications[ai_pubs$Year == 2010]),
            comma(ai_pubs$China_Publications[ai_pubs$Year == 2010])))
cat(sprintf("  2024: USA %s, China %s\n",
            comma(ai_pubs$USA_Publications[ai_pubs$Year == 2024]),
            comma(ai_pubs$China_Publications[ai_pubs$Year == 2024])))
cat(sprintf("  China now publishes %.1fx USA volume\n",
            ai_pubs$China_Publications[ai_pubs$Year == 2024] /
            ai_pubs$USA_Publications[ai_pubs$Year == 2024]))
cat("\n")
cat("Top-Tier Conference Share (2024):\n")
cat(sprintf("  USA: %d%%\n", ai_pubs$USA_Top10_Share[ai_pubs$Year == 2024]))
cat(sprintf("  China: %d%%\n", ai_pubs$China_Top10_Share[ai_pubs$Year == 2024]))
cat("\n")
cat("Citations (2024):\n")
cat(sprintf("  USA: %s\n", comma(ai_pubs$USA_Citations[ai_pubs$Year == 2024])))
cat(sprintf("  China: %s (surpassed USA in 2022)\n",
            comma(ai_pubs$China_Citations[ai_pubs$Year == 2024])))
cat("\n")
cat("Key Insights:\n")
cat("  - China surpassed USA in publication volume in 2016\n")
cat("  - China surpassed USA in total citations in 2022\n")
cat("  - China caught up to USA in top-tier conference share in 2020\n")
cat("  - USA maintains venture capital advantage (61% global share)\n")
cat("  - China leads in total researchers (320K vs USA 185K)\n")
cat("========================================\n")
cat("\n")
