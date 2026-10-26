# Figure 1.2: U.S.-China goods trade, 1990-2025
# Two stacked panels: A. exports and imports; B. two-way total.
# (The trade-balance panel of the earlier dashboard is dropped: it is exports minus imports, panel A.)

source(here::here("R", "setup_theme.R"))
library(tidyverse)
library(patchwork)
library(scales)

trade_data <- read_csv(here::here("data", "sources", "us_china_trade.csv"), show_col_types = FALSE)

xs <- scale_x_continuous(breaks = seq(1990, 2025, 5), limits = c(1990, 2031), expand = c(0, 0))
last <- trade_data %>% filter(Year == max(Year))

panel_a <- ggplot(trade_data, aes(x = Year)) +
  geom_line(aes(y = US_Imports_from_China), colour = lws_colors[["red"]], linewidth = 0.8) +
  geom_line(aes(y = US_Exports_to_China), colour = lws_colors[["blue"]], linewidth = 0.8) +
  geom_ref_vline(2018) +
  annotate("text", x = 2017.5, y = 20, label = "Trade war begins (2018)", hjust = 1, colour = lws_colors[["text"]]) +
  annotate("text", x = 2025.6, y = last$US_Imports_from_China, label = "U.S. imports\nfrom China", hjust = 0,
           colour = lws_colors[["red"]], lineheight = 0.9) +
  annotate("text", x = 2025.6, y = last$US_Exports_to_China, label = "U.S. exports\nto China", hjust = 0,
           colour = lws_colors[["blue"]], lineheight = 0.9) +
  scale_y_continuous(labels = label_dollar(suffix = "B"), limits = c(0, 600), breaks = seq(0, 600, 200)) +
  xs + coord_cartesian(clip = "off") +
  labs(title = "A. U.S. exports to and imports from China", x = NULL, y = "Billions of US dollars") +
  theme_econ_textbook() + theme(plot.margin = margin(4, 8, 2, 4))

peak <- trade_data %>% slice_max(Total_Trade, n = 1)
panel_b <- ggplot(trade_data, aes(x = Year, y = Total_Trade)) +
  geom_line(colour = lws_colors[["ink"]], linewidth = 0.9) +
  geom_ref_vline(2001) +
  annotate("text", x = 2001.6, y = 640, label = "China joins WTO (2001)", hjust = 0, colour = lws_colors[["text"]]) +
  annotate("text", x = peak$Year, y = peak$Total_Trade + 45,
           label = paste0("Record: $", round(peak$Total_Trade), "B (", peak$Year, ")"), colour = lws_colors[["ink"]]) +
  scale_y_continuous(labels = label_dollar(suffix = "B"), limits = c(0, 750), breaks = seq(0, 700, 200)) +
  xs +
  labs(title = "B. Two-way goods trade", x = NULL, y = "Billions of US dollars") +
  theme_econ_textbook() + theme(plot.margin = margin(4, 8, 2, 4))

combined_plot <- panel_a / panel_b +
  plot_annotation(
    caption = "Sources: U.S. Census Bureau, Foreign Trade Statistics (goods only, nominal, not seasonally adjusted).",
    theme = theme_econ_textbook()
  )

save_econ_figure(
  filename = here::here("figures", "fig_01_02_us_china_trade.png"),
  plot = combined_plot, width = 6, height = 5.4
)
cat("Figure 1.2 created\n")
