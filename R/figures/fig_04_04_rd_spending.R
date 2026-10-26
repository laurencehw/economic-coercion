# Figure 4.3: Global R&D Spending by Country (1990-2024)
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
# One panel: R&D spending by economy, end-labelled. (The share-of-global and growth-index
# panels of the earlier dashboard restate these series and are dropped.)
# ============================================================================

line_cols <- c("USA" = lws_colors[["blue"]], "China" = lws_colors[["red"]], "EU" = lws_colors[["green"]],
               "Japan" = lws_colors[["purple"]], "South_Korea" = lws_colors[["fade"]])
line_labs <- c("USA" = "United States", "China" = "China", "EU" = "EU", "Japan" = "Japan", "South_Korea" = "South Korea")
end_pts <- rd_long %>% filter(Year == max(Year))

combined_plot <- ggplot(rd_long, aes(x = Year, y = RD_Spending, colour = Country)) +
  geom_line(linewidth = 0.9) +
  geom_text(data = end_pts, aes(label = line_labs[as.character(Country)]), hjust = 0, nudge_x = 0.6, size = book_text_size) +
  scale_colour_manual(values = line_cols, guide = "none") +
  scale_y_continuous(labels = label_dollar(suffix = "B"), breaks = seq(0, 1000, 250), limits = c(0, 1050)) +
  scale_x_continuous(breaks = seq(1990, 2020, 10), limits = c(1990, 2032)) +
  labs(x = NULL, y = "Billions of US dollars (PPP)") +
  book_source("Sources: OECD Main Science and Technology Indicators; NSF Science and Engineering Indicators; Chinese National Bureau of Statistics. Gross domestic expenditure on R&D, current PPP dollars; 2024 estimated. At market exchange rates the U.S.-China gap is roughly twice as wide.") +
  theme_econ_textbook()

save_econ_figure(
  filename = here::here("figures", "fig_04_04_rd_spending.png"),
  plot = combined_plot, width = 6, height = 3.8
)

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
