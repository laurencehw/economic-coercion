# Figure 6.7: Section 301 Tariffs by Sector (Treemap)
# Chapter 6: Trade Controls
# Visualizes affected industries under US-China tariffs

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(forcats)

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

# Totals by list (these match the published list values: $34B, $16B, $200B, $112B)
list_totals <- section_301 %>%
  group_by(list) %>%
  summarise(total = sum(value_billions), rate = first(tariff_rate), .groups = "drop")

# Treemap replaced by sorted horizontal bars, one block per list; list totals sit in the strip labels.
strip_lab <- setNames(paste0(list_totals$list, ": $", list_totals$total, "B at ", list_totals$rate, "%"), list_totals$list)

bars <- section_301 %>%
  mutate(is_other = sector == "Other",
         key = paste(list, sector, sep = "___"),
         key = fct_reorder(key, ifelse(is_other, -1, value_billions)))

combined <- ggplot(bars, aes(x = key, y = value_billions, fill = list)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0("$", value_billions, "B")), hjust = -0.15, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_x_discrete(labels = function(x) sub("^.*___", "", x)) +
  scale_fill_manual(values = c("List 1" = lws_colors[["fade"]], "List 2" = lws_colors[["fade"]],
                               "List 3" = lws_colors[["red"]], "List 4A" = lws_colors[["fade"]]), guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  facet_grid(list ~ ., scales = "free_y", space = "free_y", labeller = labeller(list = strip_lab)) +
  coord_flip() +
  labs(x = NULL, y = "Value of affected imports (billions of US dollars)") +
  book_source("Source: USTR and Peterson Institute for International Economics for list totals and tariff rates. Author's illustration (stylized, not data): the split of each list into sectors is approximate and could not be traced to a source table. List 4B ($160B) was announced but suspended.") +
  theme_book_h() +
  theme(strip.text.y = element_text(angle = 0, hjust = 0, face = "bold", colour = lws_colors[["ink"]]))

save_econ_figure(here::here("figures", "fig_06_07_section_301.png"), plot = combined, width = 6, height = 6.4)

cat("Figure 6.7 created: Section 301 Tariffs by sector (bars)\n")
