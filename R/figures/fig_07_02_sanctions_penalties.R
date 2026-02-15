# Figure 7.2: Major OFAC Sanctions Penalties by Institution
# Purpose: Visualize largest financial penalties for sanctions violations
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)
library(scales)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Major OFAC sanctions penalties data
penalties_data <- tibble(
  Institution = c("BNP Paribas", "HSBC", "Standard Chartered",
                  "UniCredit", "Commerzbank", "ING Bank",
                  "Credit Suisse", "Barclays", "Deutsche Bank"),
  Country = c("France", "UK", "UK", "Italy", "Germany",
              "Netherlands", "Switzerland", "UK", "Germany"),
  Penalty_Billions = c(8.9, 1.9, 1.1, 1.3, 1.45, 0.619, 0.536, 0.298, 0.258),
  Year = c(2014, 2012, 2019, 2019, 2015, 2012, 2009, 2010, 2015),
  Violation_Type = c("Sudan, Cuba, Iran", "Drug cartels, Iran",
                     "Iran, Myanmar", "Iran, Libya", "Iran, Sudan",
                     "Cuba", "Iran", "Cuba", "Iran, Syria")
)

# Sort by penalty amount
penalties_data <- penalties_data %>%
  mutate(
    Institution = fct_reorder(Institution, Penalty_Billions),
    Penalty_Label = ifelse(Penalty_Billions >= 1,
                           paste0("$", round(Penalty_Billions, 1), "B"),
                           paste0("$", round(Penalty_Billions * 1000), "M"))
  )

# Summary statistics
total_penalties <- sum(penalties_data$Penalty_Billions)

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# --- Panel A: Horizontal Bar Chart of Penalties ---
p1 <- ggplot(penalties_data, aes(x = Penalty_Billions, y = Institution)) +
  # Bars colored by country
  geom_col(aes(fill = Country), alpha = 0.9, color = "black", linewidth = 0.3, width = 0.75) +

  # Add penalty amount labels
  geom_text(aes(label = Penalty_Label),
            hjust = -0.1, fontface = "bold", size = 4) +

  # Add year labels inside bars
  geom_text(aes(label = Year, x = 0.1),
            hjust = 0, size = 3.2, color = "white", fontface = "bold") +

  # BNP Paribas annotation
  annotate("segment", x = 8.9, xend = 8.9, y = 9.7, yend = 10.3,
           color = "#d62728", linewidth = 0.8) +
  annotate("label", x = 7, y = 10.3,
           label = "Largest ever:\nPleaded guilty to\ncriminal charges",
           size = 3, fill = "lightyellow", label.size = 0.3) +

  scale_fill_manual(values = c(
    "France" = "#1f77b4",
    "UK" = "#7f7f7f",
    "Italy" = "#2ca02c",
    "Germany" = "#ff7f0e",
    "Netherlands" = "#ff7f0e",
    "Switzerland" = "#d62728"
  ), name = "Bank\nHeadquarters") +

  scale_x_continuous(expand = expansion(mult = c(0, 0.15)),
                     labels = function(x) paste0("$", x, "B"),
                     breaks = seq(0, 10, 2)) +

  labs(
    title = "Largest OFAC Sanctions Penalties",
    subtitle = "Financial institutions face billions in penalties for sanctions violations",
    x = "Penalty Amount (Billions USD)",
    y = NULL
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.major.y = element_blank()
  )

# --- Panel B: Timeline of Major Penalties ---
timeline_data <- penalties_data %>%
  arrange(Year) %>%
  group_by(Year) %>%
  summarize(
    Total = sum(Penalty_Billions),
    Count = n(),
    .groups = "drop"
  )

p2 <- ggplot(timeline_data, aes(x = Year, y = Total)) +
  geom_col(fill = "#d62728", alpha = 0.8, width = 0.7) +
  geom_text(aes(label = paste0("$", round(Total, 1), "B\n(", Count, " cases)")),
            vjust = -0.3, size = 3, fontface = "bold") +

  # Key policy annotations
  annotate("segment", x = 2010, xend = 2010, y = 0, yend = 3,
           linetype = "dashed", color = "gray40") +
  annotate("text", x = 2010, y = 3.3, label = "Post-2008\nenforcement surge",
           size = 2.8, color = "gray40") +

  scale_x_continuous(breaks = seq(2009, 2019, 2)) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.25)),
                     labels = function(x) paste0("$", x, "B")) +

  labs(
    title = "Penalties by Year",
    subtitle = "Total enforcement actions",
    x = "Year",
    y = "Total Penalties"
  ) +
  theme_econ_textbook()

# --- Panel C: Violations by Sanctioned Country ---
violation_summary <- tibble(
  Sanctioned_Country = c("Iran", "Cuba", "Sudan", "Libya", "Myanmar", "Syria", "Other"),
  Cases = c(7, 3, 2, 1, 1, 1, 1),
  Total_Penalties = c(12.5, 1.4, 1.2, 0.3, 0.2, 0.1, 0.8)
)

violation_summary <- violation_summary %>%
  mutate(Sanctioned_Country = fct_reorder(Sanctioned_Country, Total_Penalties))

p3 <- ggplot(violation_summary, aes(x = Total_Penalties, y = Sanctioned_Country)) +
  geom_col(fill = "#1f77b4", alpha = 0.85, width = 0.7) +
  geom_text(aes(label = paste0("$", round(Total_Penalties, 1), "B")),
            hjust = -0.1, fontface = "bold", size = 3.5) +

  scale_x_continuous(expand = expansion(mult = c(0, 0.2)),
                     labels = function(x) paste0("$", x, "B")) +

  labs(
    title = "By Sanctioned Country",
    subtitle = "Iran dominates violations",
    x = "Total Penalties",
    y = NULL
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# ============================================================================
# 3. COMPOSE AND SAVE
# ============================================================================

# Combine plots
combined <- p1 / (p2 + p3) +
  plot_layout(heights = c(1.5, 1)) +
  plot_annotation(
    title = "Figure 7.2: Major OFAC Sanctions Penalties by Institution",
    subtitle = paste0("Financial institutions paid over $", round(total_penalties, 1),
                      " billion in sanctions penalties (2009-2019)"),
    caption = paste0(
      "Source: U.S. Treasury Office of Foreign Assets Control (OFAC), Department of Justice.\n",
      "Note: Penalties include settlements with OFAC, DOJ, and state regulators. BNP Paribas penalty\n",
      "included guilty plea to criminal charges and temporary dollar-clearing suspension."
    ),
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  )

# Save
save_econ_figure(here("figures", "fig_07_02_sanctions_programs.png"), combined, width = 12, height = 11)

# Print summary
cat("\nFigure 7.2 Summary:\n")
cat(sprintf("  Total penalties: $%.1f billion\n", total_penalties))
cat(sprintf("  Largest penalty: BNP Paribas ($8.9B, 2014)\n"))
cat(sprintf("  Most common violation: Iran sanctions\n"))
