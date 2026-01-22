# Figure 6.7: Semiconductor Manufacturing Equipment Market Share
# Purpose: Show concentration enabling trilateral export control coordination
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

# Semiconductor manufacturing equipment market share data (2023)
equipment_data <- tibble(
  Company = c("ASML", "Applied Materials", "Tokyo Electron",
              "Lam Research", "KLA", "Others"),
  Country = c("Netherlands", "USA", "Japan", "USA", "USA", "Various"),
  Market_Share = c(30, 20, 15, 13, 7, 15),
  Segment = c("Lithography", "Deposition/Etch", "Deposition/Etch",
              "Etch/Deposition", "Inspection", "Various")
)

# Add computed columns
equipment_data <- equipment_data %>%
  mutate(
    Label = paste0(Company, "\n(", Country, ")"),
    # Color by country for alliance grouping
    Alliance = case_when(
      Country %in% c("USA", "Japan", "Netherlands") ~ "Trilateral Alliance",
      TRUE ~ "Other"
    ),
    Company = factor(Company, levels = rev(equipment_data$Company))
  )

# Summary statistics
us_share <- sum(equipment_data$Market_Share[equipment_data$Country == "USA"])
alliance_share <- sum(equipment_data$Market_Share[equipment_data$Country %in% c("USA", "Japan", "Netherlands")])

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# Define colors by country
country_colors <- c(
  "Netherlands" = "#ff7f0e",  # Orange for Netherlands
  "USA" = "#1f77b4",          # Blue for USA
  "Japan" = "#9467bd",        # Purple for Japan
  "Various" = "#7f7f7f"       # Gray for others
)

# --- Panel A: Horizontal Bar Chart ---
p1 <- ggplot(equipment_data, aes(x = Market_Share, y = Company, fill = Country)) +
  geom_col(alpha = 0.9, color = "white", linewidth = 0.5, width = 0.75) +

  # Add percentage labels
  geom_text(aes(label = paste0(Market_Share, "%")),
            hjust = -0.2, fontface = "bold", size = 4) +

  # Add segment labels
  geom_text(aes(label = Segment, x = 1),
            hjust = 0, size = 3, color = "white", fontface = "italic") +

  scale_fill_manual(values = country_colors, name = "Country") +
  scale_x_continuous(expand = expansion(mult = c(0, 0.2)),
                     labels = function(x) paste0(x, "%")) +

  labs(
    title = "Market Share by Company",
    subtitle = "Equipment market concentration (2023)",
    x = "Global Market Share (%)",
    y = NULL
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.major.y = element_blank()
  )

# --- Panel B: Pie Chart showing Alliance Control ---
alliance_summary <- tibble(
  Group = c("USA", "Japan", "Netherlands", "Others"),
  Share = c(40, 15, 30, 15),
  Country_Group = c("USA (40%)", "Japan (15%)", "Netherlands (30%)", "Others (15%)")
)

alliance_summary <- alliance_summary %>%
  mutate(
    ymax = cumsum(Share),
    ymin = lag(ymax, default = 0),
    label_pos = (ymax + ymin) / 2
  )

p2 <- ggplot(alliance_summary, aes(ymax = ymax, ymin = ymin, xmax = 4, xmin = 2, fill = Group)) +
  geom_rect(color = "white", linewidth = 1) +
  geom_text(aes(x = 3.2, y = label_pos, label = Country_Group),
            size = 3.5, fontface = "bold", color = "white") +
  coord_polar(theta = "y") +
  xlim(c(0, 4)) +
  scale_fill_manual(values = c(
    "USA" = "#1f77b4",
    "Japan" = "#9467bd",
    "Netherlands" = "#ff7f0e",
    "Others" = "#7f7f7f"
  ), guide = "none") +

  # Add center annotation
  annotate("text", x = 0, y = 0,
           label = paste0("Trilateral\nAlliance\n", alliance_share, "%"),
           size = 5, fontface = "bold", color = "#2ca02c") +

  labs(
    title = "Trilateral Export Control Coalition",
    subtitle = "US + Japan + Netherlands = 85% of market"
  ) +
  theme_void() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 11, hjust = 0.5, color = "gray30"),
    plot.background = element_rect(fill = "white", color = NA)
  )

# --- Panel C: Chokepoint Summary ---
chokepoint_data <- tibble(
  Equipment_Type = c("EUV Lithography", "DUV Lithography", "Etch Systems",
                     "Deposition", "Metrology/Inspection"),
  Leader = c("ASML (100%)", "ASML (>80%)", "Lam Research (50%)",
             "Applied Materials (40%)", "KLA (55%)"),
  Country = c("Netherlands", "Netherlands", "USA", "USA", "USA"),
  Criticality = c("Extreme", "Very High", "High", "High", "High")
)

chokepoint_data <- chokepoint_data %>%
  mutate(Equipment_Type = factor(Equipment_Type, levels = rev(Equipment_Type)))

p3 <- ggplot(chokepoint_data, aes(y = Equipment_Type, x = 1)) +
  geom_tile(aes(fill = Criticality), color = "white", width = 0.9, height = 0.85) +
  geom_text(aes(label = Leader), size = 3.5, fontface = "bold", color = "white") +
  scale_fill_manual(values = c(
    "Extreme" = "#d62728",
    "Very High" = "#ff7f0e",
    "High" = "#ffbb78"
  ), name = "Chokepoint\nCriticality") +
  scale_x_continuous(expand = c(0, 0)) +
  labs(
    title = "Equipment Chokepoints",
    subtitle = "Market leaders by segment",
    x = NULL,
    y = NULL
  ) +
  theme_econ_textbook() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    panel.grid = element_blank(),
    legend.position = "right"
  )

# ============================================================================
# 3. COMPOSE AND SAVE
# ============================================================================

# Combine plots
combined <- (p1 | p2) / p3 +
  plot_layout(heights = c(1.2, 0.8)) +
  plot_annotation(
    title = "Figure 6.7: Semiconductor Manufacturing Equipment Market Share",
    subtitle = "Semiconductor equipment market concentration enables trilateral export control coordination",
    caption = paste0(
      "Source: SEMI, VLSI Research, company filings (2023).\n",
      "Note: ASML holds monopoly on EUV lithography critical for advanced chips (<7nm).\n",
      "October 2022 US export controls coordinated with Japan (March 2023) and Netherlands (June 2023)."
    ),
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  )

# Save
save_econ_figure(here("figures", "fig_06_07_equipment_market_share.png"), combined, width = 12, height = 10)

# Print summary
cat("\nFigure 6.7 Summary:\n")
cat(sprintf("  US companies market share: %d%%\n", us_share))
cat(sprintf("  Trilateral alliance (US+Japan+Netherlands): %d%%\n", alliance_share))
cat("  ASML EUV monopoly: 100% of advanced lithography\n")
