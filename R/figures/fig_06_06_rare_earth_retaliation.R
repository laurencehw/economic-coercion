# Figure 6.6: China's Rare Earth and Critical Mineral Export Controls
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

# Panel A timeline: events staggered on three levels; retaliation events in red, others grey.
# Implementation dates (take-effect rows) are plotted as points but not labelled.
china_controls <- china_controls %>%
  mutate(is_ret = category == "Retaliation",
         lab = c("Japan rare-earth cutoff\n(Senkaku dispute)", "Rare-earth export\nquotas tightened", "WTO rules against\nChina's quotas",
                 "Gallium and germanium\ncontrols", "", "Graphite controls\nannounced", "",
                 "Critical minerals\nlist expanded", "Antimony export\ncontrols"),
         lvl = c(1, 2, 3, 1, 0, 2, 0, 3, 4),
         hj = c(1, 1, 0, 1, 1, 1, 1, 1, 1),
         y = ifelse(lvl == 0, 0, lvl * 0.9))
china_controls$tx <- china_controls$date + ifelse(china_controls$hj == 0, 60, -60)

p1 <- ggplot(china_controls, aes(x = date, y = 0)) +
  geom_hline(yintercept = 0, colour = lws_colors[["ink"]], linewidth = 0.4) +
  geom_segment(data = china_controls %>% filter(lvl > 0), aes(xend = date, yend = y, colour = is_ret), linewidth = 0.4) +
  geom_point(aes(colour = is_ret), size = 2.2) +
  geom_text(data = china_controls %>% filter(lvl > 0), aes(x = tx, y = y, label = lab, colour = is_ret, hjust = hj),
            size = book_text_size, lineheight = 0.9, vjust = 0.5) +
  scale_colour_manual(values = c("TRUE" = lws_colors[["red"]], "FALSE" = lws_colors[["text"]]), guide = "none") +
  scale_x_date(limits = as.Date(c("2005-06-01", "2025-06-01")), date_breaks = "2 years", date_labels = "%Y") +
  scale_y_continuous(limits = c(-0.2, 4.2)) +
  labs(title = "A. Chinese export controls on critical minerals (red = retaliation)", x = NULL, y = NULL) +
  theme_econ_textbook() +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank(), panel.grid = element_blank(),
        panel.grid.major.y = element_blank(), panel.grid.major.x = element_blank(), panel.grid.minor = element_blank())

# Panel B: China's share of global supply, with control status
minerals <- data.frame(
  material = c("Rare earths\n(processing)", "Gallium", "Germanium",
               "Graphite\n(battery grade)", "Antimony", "Tungsten", "Cobalt\n(processing)"),
  china_share = c(90, 80, 60, 65, 48, 80, 72),
  controlled = c("Quota, 2010", "July 2023", "July 2023", "Dec 2023", "Aug 2024", "Under review", "Under review")
)
minerals <- minerals %>%
  mutate(status = ifelse(grepl("2023|2024", controlled), "Controlled since 2023-24", "Earlier quota or under review"),
         material = fct_reorder(material, china_share))

p2 <- ggplot(minerals, aes(x = material, y = china_share, fill = status)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(china_share, "%  (", controlled, ")")), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  coord_flip() +
  scale_fill_manual(values = c("Controlled since 2023-24" = lws_colors[["red"]], "Earlier quota or under review" = lws_colors[["fade"]]), name = NULL) +
  scale_y_continuous(limits = c(0, 150), breaks = seq(0, 100, 25), labels = function(x) paste0(x, "%")) +
  labs(title = "B. China's share of global supply", x = NULL, y = "Share of global supply or processing (%)") +
  theme_book_h() + theme(legend.position = "top")

library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1, 1.1)) +
  plot_annotation(
    caption = paste(strwrap("Source: USGS, Benchmark Mineral Intelligence and MOFCOM announcements. The shares in panel B are as compiled for the book and are not reconciled to a single year; rare earths appear at 90% here and 95-97% in the 2010-12 events.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here::here("figures", "fig_06_06_rare_earth_retaliation.png"), plot = combined, width = 6, height = 6.2)

cat("Figure 6.6 created: China's Rare Earth Retaliation\n")
