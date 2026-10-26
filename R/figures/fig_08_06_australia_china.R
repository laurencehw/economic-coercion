# Figure 8.6: Australia-China Trade Restrictions Case Study
# Chapter 8: Investment Screening and Industrial Policy
# Shows impact of Chinese economic coercion on Australian exports

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# Load data
australia <- read.csv(here::here("data", "sources", "australia_china_trade.csv"), stringsAsFactors = FALSE)

# Calculate changes and sort
australia <- australia %>%
  mutate(
    change_billions = exports_2021_billions - exports_2019_billions,
    affected = ifelse(pct_change_2019_2021 < -50, "Severely Affected",
                      ifelse(pct_change_2019_2021 < 0, "Moderately Affected", "Unaffected")),
    product = factor(product, levels = product[order(pct_change_2019_2021)])
  )

# Colors
aus <- australia %>%
  mutate(grp = ifelse(pct_change_2019_2021 < -50, "Fell by more than half", ifelse(pct_change_2019_2021 < 0, "Fell by less than half", "Rose")),
         grp = factor(grp, levels = c("Fell by more than half", "Fell by less than half", "Rose")))
impact_colors <- c("Fell by more than half" = lws_colors[["red"]], "Fell by less than half" = lws_colors[["fade"]], "Rose" = lws_colors[["ink"]])

p1 <- ggplot(aus, aes(x = product, y = pct_change_2019_2021, fill = grp)) +
  geom_col(width = 0.7) +
  geom_hline(yintercept = 0, colour = lws_colors[["ink"]], linewidth = 0.4) +
  geom_text(aes(label = paste0(pct_change_2019_2021, "%"), hjust = ifelse(pct_change_2019_2021 > 0, -0.1, 1.1)),
            colour = lws_colors[["ink"]], size = book_text_size) +
  coord_flip() +
  scale_fill_manual(values = impact_colors, name = NULL) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(-125, 110)) +
  labs(title = "A. Change in Australian exports to China, 2019 to 2021", x = NULL, y = "Change (%)") +
  theme_book_h() + theme(legend.position = "top")

key_levels <- australia %>%
  select(product, `2019` = exports_2019_billions, `2021` = exports_2021_billions, `2023` = exports_2023_billions) %>%
  pivot_longer(-product, names_to = "year", values_to = "value") %>%
  filter(product %in% c("Iron Ore", "Coal", "Wine", "Barley", "Lobster", "LNG")) %>%
  mutate(product = factor(product, levels = c("Iron Ore", "Coal", "LNG", "Barley", "Wine", "Lobster")))

p2 <- ggplot(key_levels, aes(x = year, y = value, fill = year)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = ifelse(value >= 1, round(value), round(value, 2))), vjust = -0.4, colour = lws_colors[["ink"]], size = book_text_size) +
  facet_wrap(~product, scales = "free_y", nrow = 2) +
  scale_fill_manual(values = c("2019" = lws_colors[["fade"]], "2021" = lws_colors[["red"]], "2023" = lws_colors[["ink"]]), guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.2))) +
  labs(title = "B. Selected exports in 2019, 2021 and 2023 (billions; each panel has its own scale)", x = NULL, y = NULL) +
  theme_econ_textbook() +
  theme(strip.text = element_text(face = "bold", colour = lws_colors[["ink"]]), axis.text.y = element_blank(), panel.grid.major.y = element_blank())

library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1.4, 1)) +
  plot_annotation(
    caption = paste(strwrap("Source: Australian Bureau of Statistics, DFAT and news reports. Iron ore, which China could not readily replace, was left untouched. Values are as recorded in the source table (stated in Australian dollars).", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here::here("figures", "fig_08_06_australia_china.png"), plot = combined, width = 6, height = 6.6)

cat("Figure 8.6 created: Australia-China Trade Restrictions\n")
