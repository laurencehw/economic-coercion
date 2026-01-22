# Figure 6.4: China's Rare Earth and Critical Mineral Export Controls
# Chapter 6: Trade Controls
# Timeline of Chinese retaliatory export restrictions

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(forcats)

# China export control events
china_controls <- data.frame(
  date = as.Date(c(
    "2010-09-07", "2010-10-18", "2012-03-13",
    "2023-07-03", "2023-08-01", "2023-10-20", "2023-12-21",
    "2024-06-15", "2024-08-15"
  )),
  event = c(
    "Japan rare earth cutoff (Senkaku incident)",
    "Rare earth export quotas tightened",
    "WTO rules against China quotas",
    "Gallium & germanium export controls",
    "Controls take effect",
    "Graphite export controls announced",
    "Graphite controls take effect",
    "Critical minerals expanded list",
    "Antimony export controls"
  ),
  material = c(
    "Rare Earths", "Rare Earths", "Rare Earths",
    "Gallium/Germanium", "Gallium/Germanium", "Graphite", "Graphite",
    "Multiple", "Antimony"
  ),
  china_share = c(97, 97, 95, 80, 80, 65, 65, NA, 48),
  trigger = c(
    "Senkaku/Diaoyu dispute",
    "Resource nationalism",
    "WTO dispute loss",
    "US chip export controls",
    "Implementation",
    "Expanded retaliation",
    "Implementation",
    "Systematic response",
    "Further escalation"
  ),
  category = c(
    "Geopolitical", "Resource Control", "Legal",
    "Retaliation", "Implementation", "Retaliation", "Implementation",
    "Retaliation", "Retaliation"
  )
)

china_controls <- china_controls %>%
  mutate(
    year = as.numeric(format(date, "%Y")),
    y_offset = ifelse(row_number() %% 2 == 0, 0.8, -0.8),
    y_label = ifelse(row_number() %% 2 == 0, 0.95, -0.95)
  )

# Category colors
category_colors <- c(
  "Geopolitical" = "#9467bd",
  "Resource Control" = "#ff7f0e",
  "Legal" = "#2ca02c",
  "Retaliation" = "#d62728",
  "Implementation" = "#1f77b4"
)

# Create timeline
p1 <- ggplot(china_controls, aes(x = date, y = 0)) +
  # Background periods
  annotate("rect", xmin = as.Date("2010-01-01"), xmax = as.Date("2013-01-01"),
           ymin = -1.5, ymax = 1.5, fill = "#ffe0cc", alpha = 0.3) +
  annotate("rect", xmin = as.Date("2023-01-01"), xmax = as.Date("2025-01-01"),
           ymin = -1.5, ymax = 1.5, fill = "#ffcccc", alpha = 0.3) +
  annotate("text", x = as.Date("2011-06-01"), y = 1.3,
           label = "First Wave\n(Japan incident)", size = 3.5, color = "gray40") +
  annotate("text", x = as.Date("2024-01-01"), y = 1.3,
           label = "Second Wave\n(Response to US)", size = 3.5, color = "gray40") +
  # Timeline
  geom_hline(yintercept = 0, color = "gray40", linewidth = 1) +
  geom_point(aes(color = category), size = 5) +
  geom_segment(aes(xend = date, y = 0, yend = y_offset,
                   color = category), linewidth = 0.8) +
  geom_label(aes(y = y_label,
                 label = stringr::str_wrap(event, 20),
                 fill = category),
             size = 2.5, color = "white", fontface = "bold",
             label.padding = unit(0.2, "lines")) +
  # Styling
  scale_color_manual(values = category_colors, name = "Event Type") +
  scale_fill_manual(values = category_colors, guide = "none") +
  scale_x_date(date_breaks = "2 years", date_labels = "%Y") +
  scale_y_continuous(limits = c(-1.5, 1.5)) +
  labs(
    title = "China's Critical Mineral Export Controls Timeline",
    subtitle = "From rare earth leverage (2010) to systematic retaliation (2023-2024)"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    legend.position = "bottom"
  )

# China's market share in critical minerals
minerals <- data.frame(
  material = c("Rare Earths\n(Processing)", "Gallium", "Germanium",
               "Graphite\n(Battery grade)", "Antimony", "Tungsten", "Cobalt\n(Processing)"),
  china_share = c(90, 80, 60, 65, 48, 80, 72),
  controlled = c("Quota (2010)", "July 2023", "July 2023",
                 "Dec 2023", "Aug 2024", "Under review", "Under review")
)

minerals <- minerals %>%
  mutate(
    status = ifelse(grepl("2023|2024", controlled), "Actively Controlled", "Potential"),
    material = fct_reorder(material, china_share)
  )

p2 <- ggplot(minerals, aes(x = material, y = china_share, fill = status)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(china_share, "%")), hjust = -0.1, size = 4, fontface = "bold") +
  geom_text(aes(y = 5, label = controlled), hjust = 0, size = 3, color = "white") +
  coord_flip() +
  scale_fill_manual(
    values = c("Actively Controlled" = "#d62728", "Potential" = "#ff7f0e"),
    name = "Control Status"
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "China's Critical Mineral Dominance",
    subtitle = "Global market share of materials subject to or candidates for export controls",
    x = NULL,
    y = "China's Global Market Share (%)",
    caption = "Source: USGS, Benchmark Mineral Intelligence, MOFCOM announcements"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Combine
library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1, 1))

# Save the figure
save_econ_figure(here::here("figures", "fig_06_04_rare_earth_retaliation.png"), plot = combined, width = 13, height = 11)

cat("Figure 6.4 created: China's Rare Earth Retaliation\n")
