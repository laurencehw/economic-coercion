# Figure 6.5: US-China Trade War Escalation Ladder
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

# Colors by action type
action_colors <- c(
  "Tariff" = "#ff7f0e",
  "Export Control" = "#d62728",
  "Industrial Policy" = "#2ca02c",
  "Agreement" = "#1f77b4",
  "Designation" = "#9467bd",
  "Pause" = "#7f7f7f"
)

# Create the escalation ladder
p <- ggplot(trade_war, aes(x = date, y = y_offset)) +
  # Baseline
  geom_hline(yintercept = 0, color = "gray30", linewidth = 1) +
  # US/Allied actions (above)
  geom_step(
    data = trade_war %>% filter(side == "US/Allies"),
    aes(group = 1), color = "#1f77b4", linewidth = 1.2, direction = "hv"
  ) +
  # China actions (below)
  geom_step(
    data = trade_war %>% filter(side == "China"),
    aes(group = 1), color = "#d62728", linewidth = 1.2, direction = "hv"
  ) +
  # Points for events
  geom_point(aes(color = action_type), size = 3) +
  # Labels for key events
  geom_text(
    data = trade_war %>% filter(escalation_level >= 6 | action_type == "Export Control"),
    aes(label = stringr::str_wrap(event, 15),
        vjust = ifelse(y_offset > 0, -0.5, 1.5)),
    size = 2.5, check_overlap = TRUE
  ) +
  # Annotations for sides
  annotate("text", x = as.Date("2018-03-01"), y = 9,
           label = "US/Allied Actions", color = "#1f77b4", fontface = "bold", hjust = 0) +
  annotate("text", x = as.Date("2018-03-01"), y = -9,
           label = "Chinese Actions", color = "#d62728", fontface = "bold", hjust = 0) +
  # Phase annotations
  annotate("rect", xmin = as.Date("2018-01-01"), xmax = as.Date("2020-01-15"),
           ymin = -10.5, ymax = 10.5, fill = "#ffe0cc", alpha = 0.2) +
  annotate("rect", xmin = as.Date("2022-08-01"), xmax = as.Date("2024-12-01"),
           ymin = -10.5, ymax = 10.5, fill = "#ffcccc", alpha = 0.2) +
  annotate("text", x = as.Date("2019-01-01"), y = -10,
           label = "Tariff War Phase", size = 3.5, color = "gray50") +
  annotate("text", x = as.Date("2023-06-01"), y = -10,
           label = "Tech War Phase", size = 3.5, color = "gray50") +
  # Styling
  scale_color_manual(values = action_colors, name = "Action Type") +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  scale_y_continuous(
    breaks = c(-10, -5, 0, 5, 10),
    labels = c("10", "5", "0", "5", "10"),
    limits = c(-11, 11)
  ) +
  labs(
    title = "US-China Economic Conflict Escalation (2018-2024)",
    subtitle = "Tit-for-tat escalation from tariffs to technology controls",
    x = NULL,
    y = "Escalation Level",
    caption = "Source: USTR, MOFCOM, BIS Federal Register announcements\nNote: Escalation level is author's assessment (1-10 scale)"
  ) +
  theme_econ_textbook() +
  theme(legend.position = "bottom") +
  guides(color = guide_legend(nrow = 1))

# Save the figure
save_econ_figure(here::here("figures", "fig_06_05_trade_war_escalation.png"), plot = p, width = 14, height = 9)

cat("Figure 6.5 created: Trade War Escalation Ladder\n")
