# Figure 6.6: Section 301 Tariffs by Sector (Treemap)
# Chapter 6: Trade Controls
# Visualizes affected industries under US-China tariffs

# Load required packages and theme
source("R/setup_theme.R")
library(dplyr)
library(tidyr)
library(treemapify)

# Section 301 tariff data by sector
section_301 <- data.frame(
  list = c(rep("List 1", 6), rep("List 2", 5), rep("List 3", 7), rep("List 4A", 5)),
  sector = c(
    # List 1 ($34B at 25%)
    "Industrial Machinery", "Electrical Equipment", "Vehicles", "Aircraft Parts", "Medical Devices", "Other",
    # List 2 ($16B at 25%)
    "Semiconductors", "Chemicals", "Plastics", "Railway Equipment", "Other",
    # List 3 ($200B at 25%)
    "Electronics", "Furniture", "Textiles", "Food Products", "Leather Goods", "Machinery Parts", "Other",
    # List 4A ($112B at 7.5%)
    "Consumer Electronics", "Apparel", "Footwear", "Toys", "Other"
  ),
  value_billions = c(
    # List 1
    12, 8, 5, 4, 3, 2,
    # List 2
    6, 4, 3, 2, 1,
    # List 3
    60, 35, 30, 25, 20, 15, 15,
    # List 4A
    40, 30, 20, 12, 10
  ),
  tariff_rate = c(
    rep(25, 11),
    rep(25, 7),
    rep(7.5, 5)
  ),
  effective_date = c(
    rep("July 2018", 6),
    rep("Aug 2018", 5),
    rep("May 2019", 7),
    rep("Sep 2019", 5)
  )
)

# Calculate totals by list
list_totals <- section_301 %>%
  group_by(list) %>%
  summarise(total = sum(value_billions), rate = first(tariff_rate), .groups = "drop")

# Create treemap
p1 <- ggplot(section_301, aes(area = value_billions, fill = list, subgroup = list, label = sector)) +
  geom_treemap(color = "white", linewidth = 2) +
  geom_treemap_subgroup_border(color = "gray30", linewidth = 3) +
  geom_treemap_text(
    aes(label = paste0(sector, "\n$", value_billions, "B")),
    color = "white", place = "centre", grow = FALSE, reflow = TRUE,
    size = 10
  ) +
  geom_treemap_subgroup_text(
    place = "bottomleft", color = "white", alpha = 0.7,
    fontface = "bold", size = 14
  ) +
  scale_fill_manual(
    values = c("List 1" = "#1f77b4", "List 2" = "#ff7f0e",
               "List 3" = "#d62728", "List 4A" = "#2ca02c"),
    name = "Tariff List"
  ) +
  labs(
    title = "Section 301 Tariffs: Affected Imports by Sector",
    subtitle = "US tariffs on Chinese goods by list and product category (as of 2024)"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "right")

# Summary bar chart
p2 <- ggplot(list_totals, aes(x = list, y = total, fill = list)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0("$", total, "B\n(", rate, "% tariff)")),
            vjust = -0.2, size = 4, fontface = "bold") +
  scale_fill_manual(
    values = c("List 1" = "#1f77b4", "List 2" = "#ff7f0e",
               "List 3" = "#d62728", "List 4A" = "#2ca02c"),
    guide = "none"
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.2))) +
  labs(
    title = "Total Value by Tariff List",
    x = NULL,
    y = "Value of Affected Imports ($ Billions)",
    caption = "Source: USTR, Peterson Institute for International Economics\nNote: List 4B ($160B) was announced but suspended during Phase One negotiations"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank())

# Combine
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(2, 1))

# Save the figure
save_econ_figure("figures/fig_06_06_section_301.png", plot = combined, width = 12, height = 12)

cat("Figure 6.6 created: Section 301 Tariffs Treemap\n")
