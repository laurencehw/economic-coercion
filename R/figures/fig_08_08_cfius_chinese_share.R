# Figure 8.8: CFIUS Reviews and Chinese Transaction Share
# Purpose: Dual-axis chart showing total reviews and declining Chinese share post-FIRRMA
# Author: Laurence Wilse-Samson
# Note: Supplements fig_08_04 with focus on Chinese investor trends

library(here)
library(tidyverse)
library(patchwork)
library(scales)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# CFIUS review data with Chinese share (2010-2023)
cfius_data <- tibble(
  Year = 2010:2023,
  Total_Reviews = c(93, 111, 114, 97, 147, 143, 172, 172, 229, 231, 187, 272, 440, 380),
  Chinese_Share_Pct = c(12, 14, 15, 16, 15, 14, 16, 15, 11, 8, 6, 5, 4, 5),
  Notices = c(93, 111, 114, 97, 147, 143, 172, 172, 155, 158, 117, 164, 286, 233),
  Declarations = c(0, 0, 0, 0, 0, 0, 0, 0, 74, 73, 70, 108, 154, 147)
)

# Calculate estimated Chinese transactions
cfius_data <- cfius_data %>%
  mutate(
    Chinese_Estimated = round(Total_Reviews * Chinese_Share_Pct / 100),
    Period = case_when(
      Year < 2018 ~ "Pre-FIRRMA",
      Year == 2018 ~ "FIRRMA Enacted",
      TRUE ~ "Post-FIRRMA"
    )
  )

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# Calculate scaling factor for dual axis
scale_factor <- max(cfius_data$Total_Reviews) / max(cfius_data$Chinese_Share_Pct)

# --- Main Panel: Dual-Axis Line Chart ---
p1 <- ggplot(cfius_data, aes(x = Year)) +
  # Shaded regions for policy periods
  annotate("rect", xmin = 2010, xmax = 2017.5, ymin = 0, ymax = Inf,
           fill = "#2ca02c", alpha = 0.08) +
  annotate("rect", xmin = 2018.5, xmax = 2023, ymin = 0, ymax = Inf,
           fill = "#d62728", alpha = 0.08) +

  # Total reviews (bar)
  geom_col(aes(y = Total_Reviews), fill = "#1f77b4", alpha = 0.6, width = 0.7) +

  # Chinese share (line, scaled)
  geom_line(aes(y = Chinese_Share_Pct * scale_factor),
            color = "#d62728", linewidth = 1.5) +
  geom_point(aes(y = Chinese_Share_Pct * scale_factor),
             color = "#d62728", size = 3) +

  # Add percentage labels for Chinese share
  geom_text(aes(y = Chinese_Share_Pct * scale_factor + 15,
                label = paste0(Chinese_Share_Pct, "%")),
            color = "#d62728", size = 3, fontface = "bold") +

  # FIRRMA annotation
  geom_vline(xintercept = 2018, linetype = "dashed", color = "gray30", linewidth = 1) +
  annotate("label", x = 2018, y = 420,
           label = "FIRRMA\nEnacted\n(Aug 2018)",
           size = 3.5, fill = "lightyellow", label.size = 0.3, fontface = "bold") +

  # Period labels
  annotate("text", x = 2013.5, y = 50, label = "Pre-FIRRMA Era",
           color = "#2ca02c", size = 4, fontface = "bold") +
  annotate("text", x = 2020.5, y = 50, label = "Post-FIRRMA Era",
           color = "#d62728", size = 4, fontface = "bold") +

  # Dual axis
  scale_y_continuous(
    name = "Total CFIUS Reviews",
    limits = c(0, 500),
    expand = c(0, 0),
    sec.axis = sec_axis(~./scale_factor, name = "Chinese Share (%)",
                        labels = function(x) paste0(x, "%"))
  ) +

  scale_x_continuous(breaks = seq(2010, 2023, 2)) +

  labs(
    title = "CFIUS Reviews and Chinese Transaction Share (2010-2023)",
    subtitle = "Total reviews (bars) vs. Chinese-origin share (line) showing post-FIRRMA decline",
    x = "Year"
  ) +
  theme_econ_textbook() +
  theme(
    axis.title.y.left = element_text(color = "#1f77b4"),
    axis.text.y.left = element_text(color = "#1f77b4"),
    axis.title.y.right = element_text(color = "#d62728"),
    axis.text.y.right = element_text(color = "#d62728")
  )

# --- Panel B: Chinese Transactions Trend ---
p2 <- ggplot(cfius_data, aes(x = Year, y = Chinese_Estimated, fill = Period)) +
  geom_col(alpha = 0.85, color = "white", linewidth = 0.3, width = 0.8) +
  geom_text(aes(label = Chinese_Estimated), vjust = -0.3, size = 3, fontface = "bold") +

  # Trend line
  geom_smooth(aes(group = 1), method = "loess", se = FALSE,
              color = "black", linetype = "dashed", linewidth = 0.8) +

  scale_fill_manual(values = c(
    "Pre-FIRRMA" = "#2ca02c",
    "FIRRMA Enacted" = "#ff7f0e",
    "Post-FIRRMA" = "#d62728"
  ), name = "Period") +

  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  scale_x_continuous(breaks = seq(2010, 2023, 2)) +

  labs(
    title = "Estimated Chinese-Origin CFIUS Cases",
    subtitle = "Absolute number of Chinese transactions reviewed",
    x = "Year",
    y = "Estimated Chinese Cases"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "bottom")

# --- Summary Statistics Box ---
pre_firrma_avg <- mean(cfius_data$Chinese_Share_Pct[cfius_data$Year < 2018])
post_firrma_avg <- mean(cfius_data$Chinese_Share_Pct[cfius_data$Year > 2018])
decline_pct <- round((pre_firrma_avg - post_firrma_avg) / pre_firrma_avg * 100)

stats_text <- paste0(
  "Key Findings:\n\n",
  "Pre-FIRRMA Chinese share: ", round(pre_firrma_avg), "%\n",
  "Post-FIRRMA Chinese share: ", round(post_firrma_avg), "%\n",
  "Decline: ", decline_pct, "%\n\n",
  "Peak year: 2013 (16%)\n",
  "Current share: ~5%"
)

# ============================================================================
# 3. COMPOSE AND SAVE
# ============================================================================

# Combine plots
combined <- p1 / p2 +
  plot_layout(heights = c(1.3, 1)) +
  plot_annotation(
    title = "Figure 8.8: CFIUS Reviews and Chinese Transaction Share",
    subtitle = paste0("Chinese share of CFIUS reviews declined ~", decline_pct,
                      "% following FIRRMA implementation"),
    caption = paste0(
      "Source: CFIUS Annual Reports to Congress (2010-2023), author estimates.\n",
      "Note: FIRRMA = Foreign Investment Risk Review Modernization Act of 2018.\n",
      "Chinese share includes transactions from China, Hong Kong, and related entities."
    ),
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  )

# Save
save_econ_figure(here("figures", "fig_08_08_cfius_chinese_share.png"), combined, width = 11, height = 11)

# Print summary
cat("\nFigure 8.8 Summary:\n")
cat(sprintf("  Pre-FIRRMA avg Chinese share: %.1f%%\n", pre_firrma_avg))
cat(sprintf("  Post-FIRRMA avg Chinese share: %.1f%%\n", post_firrma_avg))
cat(sprintf("  Decline in Chinese share: %d%%\n", decline_pct))
cat(sprintf("  2023 Total Reviews: %d\n", tail(cfius_data$Total_Reviews, 1)))
