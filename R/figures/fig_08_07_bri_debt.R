# Figure 8.7: Belt and Road Debt Exposure Map
# Chapter 8: Investment Screening and Industrial Policy
# Shows BRI debt-to-GDP ratios by recipient country

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(forcats)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# BRI debt data with ISO A3 codes for robust country matching
bri_debt <- data.frame(
  country = c(
    "Pakistan", "Sri Lanka", "Laos", "Zambia", "Kenya",
    "Ethiopia", "Malaysia", "Indonesia", "Bangladesh", "Cambodia",
    "Myanmar", "Kazakhstan", "Uzbekistan", "Tajikistan", "Kyrgyzstan",
    "Mongolia", "Ecuador", "Venezuela", "Argentina", "Egypt",
    "Djibouti", "Maldives", "Angola", "Nigeria", "Tanzania"
  ),
  iso_a3 = c(
    "PAK", "LKA", "LAO", "ZMB", "KEN",
    "ETH", "MYS", "IDN", "BGD", "KHM",
    "MMR", "KAZ", "UZB", "TJK", "KGZ",
    "MNG", "ECU", "VEN", "ARG", "EGY",
    "DJI", "MDV", "AGO", "NGA", "TZA"
  ),
  bri_debt_billions = c(
    27.4, 7.4, 5.9, 6.6, 9.8,
    7.9, 10.2, 8.5, 6.2, 4.1,
    3.8, 8.2, 4.5, 3.1, 2.8,
    4.2, 5.8, 3.2, 2.1, 7.8,
    1.4, 1.3, 22.5, 4.8, 2.2
  ),
  gdp_billions = c(
    376, 84, 15, 29, 113,
    126, 407, 1319, 460, 27,
    59, 220, 80, 11, 10,
    17, 107, 92, 632, 476,
    3.5, 6, 94, 440, 75
  ),
  debt_to_gdp = c(
    7.3, 8.8, 39.3, 22.8, 8.7,
    6.3, 2.5, 0.6, 1.3, 15.2,
    6.4, 3.7, 5.6, 28.2, 28.0,
    24.7, 5.4, 3.5, 0.3, 1.6,
    40.0, 21.7, 23.9, 1.1, 2.9
  ),
  risk_status = c(
    "Distressed", "Distressed", "Distressed", "Distressed", "Elevated",
    "Elevated", "Manageable", "Low", "Manageable", "Elevated",
    "Elevated", "Manageable", "Manageable", "Distressed", "Distressed",
    "Elevated", "Elevated", "Distressed", "Manageable", "Manageable",
    "Distressed", "Distressed", "Distressed", "Manageable", "Manageable"
  )
)

# Get world map
world <- ne_countries(scale = "medium", returnclass = "sf")

# Merge data using ISO A3 codes for robust country matching
world_bri <- world %>%
  left_join(bri_debt, by = c("iso_a3" = "iso_a3"))

# Risk colors
risk_colors <- c(
  "Distressed" = "#d62728",
  "Elevated" = "#ff7f0e",
  "Manageable" = "#ffbb78",
  "Low" = "#2ca02c"
)

# Create map
p1 <- ggplot(world_bri) +
  geom_sf(aes(fill = risk_status), color = "white", linewidth = 0.2) +
  scale_fill_manual(
    values = risk_colors,
    name = "Debt Risk Status",
    na.value = "#e8e8e8"
  ) +
  coord_sf(crs = "+proj=robin") +
  labs(
    title = "Belt and Road Initiative: Debt Risk Exposure",
    subtitle = "Chinese lending as share of recipient GDP and debt sustainability status"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "bottom"
  )

# Top debtors bar chart
top_debtors <- bri_debt %>%
  arrange(desc(debt_to_gdp)) %>%
  head(12) %>%
  mutate(country = fct_reorder(country, debt_to_gdp))

p2 <- ggplot(top_debtors, aes(x = country, y = debt_to_gdp, fill = risk_status)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(round(debt_to_gdp, 1), "%")), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_fill_manual(values = risk_colors, name = "Risk Status") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "BRI Debt as Share of GDP (Top 12)",
    subtitle = "Countries with highest Chinese debt exposure",
    x = NULL,
    y = "BRI Debt / GDP (%)",
    caption = "Source: AidData, World Bank, IMF estimates\nNote: Some countries have restructured debt since 2022; current exposure may differ"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Combine
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1.3, 1))

# Save the figure
save_econ_figure(here::here("figures", "fig_08_07_bri_debt.png"), plot = combined, width = 12, height = 13)

cat("Figure 8.7 created: BRI Debt Map\n")
