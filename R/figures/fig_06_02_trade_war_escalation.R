# Figure 6.2: US-China Trade War Escalation Ladder
# Chapter 6: Trade Controls
# Stepped visualization of tit-for-tat measures 2018-2024

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(lubridate)

# Load data
trade_war <- read.csv(here::here("data", "sources", "trade_war_timeline.csv"), stringsAsFactors = FALSE)
trade_war$date <- as.Date(trade_war$date)

# Assign sides and create escalation visualization
trade_war <- trade_war %>%
  mutate(
    side = ifelse(actor == "USA" | actor == "Allies", "US/Allies",
                  ifelse(actor == "China", "China", "Both")),
    y_offset = case_when(
      side == "US/Allies" ~ escalation_level,
      side == "China" ~ -escalation_level,
      TRUE ~ 0
    ),
    action_short = case_when(
      action_type == "Tariff" ~ paste0("Tariff: $", value_billions, "B"),
      action_type == "Export Control" ~ "Export Control",
      action_type == "Industrial Policy" ~ "Industrial Policy",
      action_type == "Designation" ~ "Designation",
      TRUE ~ action_type
    )
  )

library(ggrepel)
side_cols <- c("US/Allies" = lws_colors[["blue"]], "China" = lws_colors[["red"]], "Both" = lws_colors[["text"]])
key_events <- c("List 3 tariffs imposed", "Huawei Entity List", "Phase One agreement", "CHIPS Act signed",
                "October 7 semiconductor rules", "China gallium germanium controls", "EV tariffs 100%",
                "China retaliates - Round 6", "Truce at G20")
labs_df <- trade_war %>% filter(event %in% key_events) %>%
  mutate(label = sub("China retaliates - Round 6", "China retaliation, round 6", event))

p <- ggplot(trade_war, aes(x = date, y = y_offset)) +
  annotate("rect", xmin = as.Date("2018-01-01"), xmax = as.Date("2020-01-15"), ymin = -Inf, ymax = Inf, fill = "#F2F2F2") +
  annotate("text", x = as.Date("2018-02-01"), y = 11, label = "Tariff phase", hjust = 0, colour = lws_colors[["text"]]) +
  annotate("text", x = as.Date("2022-08-01"), y = 11, label = "Technology controls", hjust = 0, colour = lws_colors[["text"]]) +
  geom_hline(yintercept = 0, colour = lws_colors[["ink"]], linewidth = 0.4) +
  geom_step(data = trade_war %>% filter(side == "US/Allies"), aes(group = 1), colour = lws_colors[["blue"]], linewidth = 0.7, direction = "hv") +
  geom_step(data = trade_war %>% filter(side == "China"), aes(group = 1), colour = lws_colors[["red"]], linewidth = 0.7, direction = "hv") +
  geom_point(aes(colour = side), size = 1.8) +
  geom_label_repel(data = labs_df, aes(label = label, colour = side), size = book_text_size, seed = 3, fill = "white", label.size = 0, label.padding = 0.12,
                  box.padding = 0.5, force = 3, min.segment.length = 0.1, segment.colour = lws_colors[["fade"]], max.overlaps = 20,
                  show.legend = FALSE, lineheight = 0.9) +
  annotate("text", x = as.Date("2018-02-01"), y = 9.7, label = "U.S. and allied actions", hjust = 0, colour = lws_colors[["blue"]], fontface = "bold", size = book_text_size) +
  annotate("text", x = as.Date("2018-02-01"), y = -10, label = "Chinese actions", hjust = 0, colour = lws_colors[["red"]], fontface = "bold", size = book_text_size) +
  scale_colour_manual(values = side_cols, guide = "none") +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y", expand = expansion(mult = c(0.01, 0.03))) +
  scale_y_continuous(breaks = c(-10, -5, 0, 5, 10), labels = c("10", "5", "0", "5", "10"), limits = c(-11, 11)) +
  labs(x = NULL, y = "Escalation level (author's 1-10 judgment)") +
  book_source("Source: USTR, MOFCOM and BIS Federal Register announcements. Dates and tariff rates are sourced; the escalation level is the author's ordinal assessment, not a measurement.") +
  theme_econ_textbook()

save_econ_figure(here::here("figures", "fig_06_02_trade_war_escalation.png"), plot = p, width = 6, height = 4.6)

cat("Figure 6.2 created: Trade War Escalation Ladder\n")
