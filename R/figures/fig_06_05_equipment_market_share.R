# Figure 6.5: Semiconductor Manufacturing Equipment Market Share
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

# Semiconductor manufacturing equipment market shares, 2023: AUTHOR'S ILLUSTRATION (stylized, not data).
# The shares are approximate, rounded values compiled from industry estimates; they were NOT recomputed from company
# filings or from a SEMI/VLSI Research table (those are paywalled), so treat them as orders of magnitude.
# The one published aggregate they can be checked against: Counterpoint Technology Market Research reports combined
# 2023 revenue of the five largest wafer-fab-equipment makers at $93.5 billion (EE Asia, 2024). Only the statement
# that ASML is the sole supplier of EUV lithography is a sourced fact in panel B.
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
# 2. TWO PANELS: A. company shares (trilateral firms highlighted); B. leader share by equipment type.
# The donut of the earlier version repeated panel A and is dropped; the chokepoint heat-tile is now bars.
# ============================================================================

equipment_data <- equipment_data %>%
  mutate(grp = ifelse(Country == "Various", "Other firms", "Firms in the U.S., Japan or Netherlands"),
         Company = factor(Company, levels = rev(c("ASML", "Applied Materials", "Tokyo Electron", "Lam Research", "KLA", "Others"))))
grp_cols <- c("Firms in the U.S., Japan or Netherlands" = lws_colors[["blue"]], "Other firms" = lws_colors[["fade"]])

p1 <- ggplot(equipment_data, aes(x = Market_Share, y = Company, fill = grp)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(Market_Share, "%  ", Country)), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = grp_cols, name = NULL) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.35)), labels = function(x) paste0(x, "%")) +
  labs(title = "A. Approximate share of global equipment sales, 2023",
       x = "Global market share (%)", y = NULL) +
  theme_book_h() + theme(legend.position = "top")

chokepoint_data <- tibble(
  Equipment_Type = c("EUV lithography", "DUV lithography", "Etch systems", "Deposition", "Metrology and inspection"),
  Leader = c("ASML", "ASML", "Lam Research", "Applied Materials", "KLA"),
  Share = c(100, 80, 50, 40, 55),
  lab = c("100%", "over 80%", "50%", "40%", "55%")
) %>% mutate(Equipment_Type = reorder(Equipment_Type, Share))

p3 <- ggplot(chokepoint_data, aes(y = Equipment_Type, x = Share)) +
  geom_col(fill = lws_colors[["blue"]], width = 0.7) +
  geom_text(aes(label = paste0(lab, "  ", Leader)), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_x_continuous(limits = c(0, 150), breaks = seq(0, 100, 25), labels = function(x) paste0(x, "%")) +
  labs(title = "B. Approximate share held by the leading firm, by equipment type", x = "Leader's share of segment (%)", y = NULL) +
  theme_book_h()

combined <- p1 / p3 + plot_layout(heights = c(1.1, 0.9)) +
  plot_annotation(
    caption = paste(strwrap("Author's illustration (stylized, not data): the shares are rounded approximations compiled from industry estimates, not recomputed from company filings. For scale, Counterpoint Technology Market Research puts the five largest wafer-fab-equipment makers' combined 2023 revenue at $93.5 billion. Only the EUV monopoly is a sourced fact: ASML is the sole supplier of EUV lithography, needed for chips below 7 nm. 'Over 80%' for DUV is plotted at 80%.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here("figures", "fig_06_05_equipment_market_share.png"), combined, width = 6, height = 5.8)

cat("\nFigure 6.5 Summary:\n")
cat(sprintf("  US companies market share: %d%%\n", us_share))
cat(sprintf("  Trilateral alliance (US+Japan+Netherlands): %d%%\n", alliance_share))
