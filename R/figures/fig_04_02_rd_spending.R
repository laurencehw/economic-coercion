# Figure 4.1: Global R&D Spending by Country (1990-2024)
# Author: Laurence Wilse-Samson
# Description: China's dramatic rise in R&D investment approaching U.S. levels

# Load custom theme and packages
source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

# ============================================================================
# LOAD DATA
# ============================================================================

rd_data <- read_csv(here::here("data", "sources", "rd_spending.csv"))

# Calculate global totals and shares
rd_data <- rd_data %>%
  mutate(
    Global_Total = USA + China + EU + Japan + South_Korea + Rest_of_World,
    USA_Share = (USA / Global_Total) * 100,
    China_Share = (China / Global_Total) * 100,
    EU_Share = (EU / Global_Total) * 100
  )

# Prepare data for plotting
rd_long <- rd_data %>%
  select(Year, USA, China, EU, Japan, South_Korea) %>%
  pivot_longer(
    cols = -Year,
    names_to = "Country",
    values_to = "RD_Spending"
  ) %>%
  mutate(
    Country = factor(Country, levels = c("USA", "China", "EU", "Japan", "South_Korea"))
  )

# ============================================================================
# PANEL A: ABSOLUTE R&D SPENDING
# ============================================================================

panel_a <- ggplot(rd_long, aes(x = Year, y = RD_Spending, color = Country, linetype = Country)) +
  geom_line(linewidth = 1.3) +
  geom_point(size = 2, alpha = 0.6) +
  scale_color_manual(
    values = c(
      "USA" = econ_colors[["USA"]],
      "China" = econ_colors[["China"]],
      "EU" = econ_colors[["EU"]],
      "Japan" = econ_colors[["Japan"]],
      "South Korea" = econ_colors[["South Korea"]]
    )
  ) +
  scale_linetype_manual(
    values = c("USA" = "solid", "China" = "solid", "EU" = "solid",
               "Japan" = "dashed", "South Korea" = "dotted")
  ) +
  scale_y_continuous(
    labels = label_dollar(suffix = "B"),
    breaks = seq(0, 1200, 200),
    limits = c(0, 1200)
  ) +
  scale_x_continuous(
    breaks = seq(1990, 2024, 5),
    limits = c(1988, 2026)
  ) +
  labs(
    title = "Absolute R&D Spending",
    subtitle = "China's ascent from minimal investment to within reach of U.S. levels",
    x = "Year",
    y = "R&D Spending (Billions USD, PPP)",
    color = "Country/Region",
    linetype = "Country/Region"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  ) +
  # Annotate China surpassing EU
  annotate(
    "text",
    x = 2016,
    y = 360,
    label = "China\nsurpasses EU",
    size = 3,
    color = econ_colors[["China"]],
    fontface = "bold"
  ) +
  annotate(
    "segment",
    x = 2016,
    xend = 2016,
    y = 320,
    yend = 340,
    arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
    color = econ_colors[["China"]],
    linewidth = 0.6
  ) +
  # Annotate 2024 values
  annotate(
    "text",
    x = 2026,
    y = rd_data$USA[rd_data$Year == 2024],
    label = paste0("$", rd_data$USA[rd_data$Year == 2024], "B"),
    size = 3,
    color = econ_colors[["USA"]],
    fontface = "bold",
    hjust = 0
  ) +
  annotate(
    "text",
    x = 2026,
    y = rd_data$China[rd_data$Year == 2024],
    label = paste0("$", rd_data$China[rd_data$Year == 2024], "B"),
    size = 3,
    color = econ_colors[["China"]],
    fontface = "bold",
    hjust = 0
  )

# ============================================================================
# PANEL B: GLOBAL SHARE OF R&D
# ============================================================================

share_long <- rd_data %>%
  select(Year, USA_Share, China_Share, EU_Share) %>%
  pivot_longer(
    cols = -Year,
    names_to = "Country",
    values_to = "Share"
  ) %>%
  mutate(
    Country = recode(Country,
                    "USA_Share" = "USA",
                    "China_Share" = "China",
                    "EU_Share" = "EU")
  )

panel_b <- ggplot(share_long, aes(x = Year, y = Share, color = Country, fill = Country)) +
  geom_area(alpha = 0.3, position = "identity") +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1.5, alpha = 0.7) +
  scale_color_manual(
    values = c("USA" = econ_colors[["USA"]],
               "China" = econ_colors[["China"]],
               "EU" = econ_colors[["EU"]])
  ) +
  scale_fill_manual(
    values = c("USA" = econ_colors[["USA"]],
               "China" = econ_colors[["China"]],
               "EU" = econ_colors[["EU"]])
  ) +
  scale_y_continuous(
    labels = label_percent(scale = 1),
    breaks = seq(0, 40, 10),
    limits = c(0, 40)
  ) +
  scale_x_continuous(
    breaks = seq(1990, 2024, 5)
  ) +
  labs(
    title = "Share of Global R&D Spending",
    subtitle = "U.S. share declining as China's rises dramatically",
    x = "Year",
    y = "Share of Global R&D (%)",
    color = "Country/Region",
    fill = "Country/Region"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  )

# ============================================================================
# PANEL C: GROWTH COMPARISON (1990 = 100)
# ============================================================================

# Calculate indexed growth (1990 = 100)
rd_growth <- rd_long %>%
  group_by(Country) %>%
  mutate(
    Base_Value = RD_Spending[Year == 1990],
    Growth_Index = (RD_Spending / Base_Value) * 100
  ) %>%
  ungroup()

panel_c <- ggplot(rd_growth, aes(x = Year, y = Growth_Index, color = Country)) +
  geom_line(linewidth = 1.3) +
  geom_point(size = 2, alpha = 0.6) +
  geom_hline(yintercept = 100, linetype = "dashed", color = "gray50", linewidth = 0.8) +
  scale_color_manual(
    values = c(
      "USA" = econ_colors[["USA"]],
      "China" = econ_colors[["China"]],
      "EU" = econ_colors[["EU"]],
      "Japan" = econ_colors[["Japan"]],
      "South Korea" = econ_colors[["South Korea"]]
    )
  ) +
  scale_y_continuous(
    labels = label_number(),
    breaks = seq(0, 9000, 1500)
  ) +
  scale_x_continuous(
    breaks = seq(1990, 2024, 5)
  ) +
  labs(
    title = "R&D Spending Growth Index (1990 = 100)",
    subtitle = paste0("China's ",
                    format(round(100 * (rd_data$China[rd_data$Year == 2024] /
                                        rd_data$China[rd_data$Year == 1990] - 1)),
                           big.mark = ","),
                    "% growth far outpaces all competitors"),
    x = "Year",
    y = "Index (1990 = 100)",
    color = "Country/Region"
  ) +
  theme_econ_textbook() +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank()
  ) +
  # Annotate China's extreme growth
  annotate(
    "text",
    x = 2010,
    y = 7000,
    label = paste0("China: ",
                   format(round(100 * (rd_data$China[rd_data$Year == 2024] /
                                       rd_data$China[rd_data$Year == 1990] - 1)),
                          big.mark = ","), "% growth\n(",
                   rd_data$China[rd_data$Year == 1990], "B → ",
                   rd_data$China[rd_data$Year == 2024], "B)"),
    size = 3.5,
    color = econ_colors[["China"]],
    fontface = "bold"
  )

# ============================================================================
# COMBINE PANELS
# ============================================================================

combined_plot <- (panel_a / (panel_b | panel_c)) +
  plot_annotation(
    title = "Global R&D Spending by Country (1990-2024)",
    subtitle = "China's rapid rise from minimal investment to challenging U.S. technological leadership",
    caption = paste0(
      "Source: OECD Main Science and Technology Indicators, NSF Science & Engineering Indicators, Chinese National Bureau of Statistics\n",
      "Note: Gross domestic expenditure on R&D (GERD) in current purchasing-power-parity billions USD, OECD MSTI basis; 2024 estimated.\nAt market exchange rates the U.S.-China gap is roughly twice as wide. Includes government, higher education, business, and non-profit R&D."
    ),
    theme = theme_econ_textbook()
  ) +
  plot_layout(heights = c(2, 1))

# ============================================================================
# DISPLAY AND SAVE
# ============================================================================

print(combined_plot)

# Save figure
save_econ_figure(
  filename = here::here("figures", "fig_04_02_rd_spending.png"),
  plot = combined_plot,
  width = 14,
  height = 12,
  dpi = 300
)

cat("\n")
cat("========================================\n")
cat("Figure 4.1 created successfully!\n")
cat("========================================\n")
cat("Location: figures/fig_04_02_rd_spending.png\n")
cat("          figures/fig_04_02_rd_spending.pdf\n")
cat("\n")
cat("R&D Spending Comparison:\n")
cat("------------------------\n")
cat(sprintf("1990: USA $%dB, China $%dB, EU $%dB\n",
            rd_data$USA[rd_data$Year == 1990],
            rd_data$China[rd_data$Year == 1990],
            rd_data$EU[rd_data$Year == 1990]))
cat(sprintf("2024: USA $%dB, China $%dB, EU $%dB\n",
            rd_data$USA[rd_data$Year == 2024],
            rd_data$China[rd_data$Year == 2024],
            rd_data$EU[rd_data$Year == 2024]))
cat("\n")
cat("Growth Rates (1990-2024):\n")
cat(sprintf("  USA:   %.0f%%\n", ((rd_data$USA[rd_data$Year == 2024] / rd_data$USA[rd_data$Year == 1990]) - 1) * 100))
cat(sprintf("  China: %.0f%%\n", ((rd_data$China[rd_data$Year == 2024] / rd_data$China[rd_data$Year == 1990]) - 1) * 100))
cat(sprintf("  EU:    %.0f%%\n", ((rd_data$EU[rd_data$Year == 2024] / rd_data$EU[rd_data$Year == 1990]) - 1) * 100))
cat("\n")
cat("Global Share 2024:\n")
cat(sprintf("  USA:   %.1f%%\n", rd_data$USA_Share[rd_data$Year == 2024]))
cat(sprintf("  China: %.1f%%\n", rd_data$China_Share[rd_data$Year == 2024]))
cat(sprintf("  EU:    %.1f%%\n", rd_data$EU_Share[rd_data$Year == 2024]))
cat("\n")
cat("Key Insights:\n")
cat(sprintf("  - China's R&D spending grew %.0f%% from 1990 to 2024\n", 100*(rd_data$China[rd_data$Year==2024]/rd_data$China[rd_data$Year==1990]-1)))
cat("  - China surpassed EU in R&D spending around 2016\n")
cat(sprintf("  - China's 2024 spending ($%dB) is %.0f%% of U.S. level ($%dB)\n", rd_data$China[rd_data$Year==2024], 100*rd_data$China[rd_data$Year==2024]/rd_data$USA[rd_data$Year==2024], rd_data$USA[rd_data$Year==2024]))
cat("  - U.S. global share declined from 37.9% (1990) to 28.8% (2024)\n")
cat("  - China's global share rose from 2.0% (1990) to 23.8% (2024)\n")
cat("========================================\n")
cat("\n")
