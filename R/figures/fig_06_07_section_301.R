# Figure 6.7: Section 301 tariff actions on China, 2018-2020
# Chapter 6: Trade Controls
# Data: data/sources/section_301_lists.csv (trade value per list) and
#       data/sources/section_301_rate_steps.csv (rate and effective date), both transcribed from the
#       Office of the U.S. Trade Representative's Federal Register notices; each row carries its
#       citation and document number. The notices give list totals only, so there is no sector split.

library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(patchwork)
library(scales)

lists <- read.csv(here("data", "sources", "section_301_lists.csv"), stringsAsFactors = FALSE, encoding = "UTF-8")
steps <- read.csv(here("data", "sources", "section_301_rate_steps.csv"), stringsAsFactors = FALSE, encoding = "UTF-8") %>%
  mutate(effective_date = as.Date(effective_date))

# Transcription checks against aggregates the notices state: Lists 1-3 are the "$250 billion" action
# (84 FR 43304, 84 FR 45821), Lists 1 and 2 together the "$50 billion" action (83 FR 40823), and the August 2019
# action is "approximately $300 billion" (84 FR 43304, 84 FR 69447).
stopifnot(
  sum(lists$value_billion_usd[lists$list %in% c("List 1", "List 2", "List 3")]) == 250,
  sum(lists$value_billion_usd[lists$list %in% c("List 1", "List 2")]) == 50,
  lists$value_billion_usd[lists$list == "List 4"] == 300,
  all(steps$status %in% c("in force", "suspended")),
  !is.unsorted(steps$effective_date[steps$list == "List 3"])
)

# ----------------------------------------------------------------------------
# Panel A: approximate annual trade value covered by each list
# ----------------------------------------------------------------------------
row_levels <- c("List 4", "List 3", "List 2", "List 1")
pa <- lists %>%
  mutate(row = factor(list, levels = row_levels),
         kind = if_else(list == "List 4", "Announced; only part took effect", "Took effect"),
         lab = paste0("$", value_billion_usd, "B",
                      if_else(is.na(subheadings), "", paste0("  (", comma(subheadings), " tariff subheadings)"))))

p1 <- ggplot(pa, aes(x = value_billion_usd, y = row, fill = kind)) +
  geom_col(width = 0.65) +
  geom_text(aes(label = lab), hjust = 0, nudge_x = 5, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = c("Took effect" = lws_colors[["blue"]], "Announced; only part took effect" = lws_colors[["fade"]]),
                    breaks = c("Took effect", "Announced; only part took effect")) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.42)), labels = label_dollar(suffix = "B"), breaks = seq(0, 300, 100)) +
  labs(title = "A. Approximate annual trade value covered, as stated in the notices",
       x = "Billions of US dollars of imports from China", y = NULL) +
  theme_book_h()

# ----------------------------------------------------------------------------
# Panel B: additional duty rate on each list over time
# ----------------------------------------------------------------------------
end_date <- as.Date("2020-02-29")   # last date covered by the notices read (modification notices through February 2020)
seg <- steps %>%
  filter(status == "in force") %>%
  group_by(list) %>%
  arrange(effective_date, .by_group = TRUE) %>%
  mutate(end = lead(effective_date, default = end_date)) %>%
  ungroup() %>%
  mutate(row = factor(list, levels = c("List 4B", "List 4A", "List 3", "List 2", "List 1")),
         rate_f = factor(paste0(rate_pct, "%"), levels = c("7.5%", "10%", "15%", "25%")),
         wide = as.numeric(end - effective_date) > 75,
         lab_x = if_else(wide, effective_date + (end - effective_date) / 2, end + 8),
         lab_h = if_else(wide, 0.5, 0),
         lab_col = if_else(wide, "white", "ink"))

susp <- steps %>% filter(status == "suspended") %>%
  mutate(row = factor(list, levels = levels(seg$row)))

rate_cols <- c("7.5%" = "#E7A3A5", "10%" = "#D9777A", "15%" = "#CC4F53", "25%" = lws_colors[["red"]])

p2 <- ggplot() +
  geom_segment(data = seg, aes(x = effective_date, xend = end, y = row, yend = row, colour = rate_f),
               linewidth = 7, lineend = "butt") +
  geom_text(data = seg %>% filter(wide), aes(x = lab_x, y = row, label = rate_f), colour = "white",
            size = book_text_size, fontface = "bold") +
  geom_text(data = seg %>% filter(!wide), aes(x = lab_x, y = row, label = rate_f), hjust = 0,
            colour = lws_colors[["ink"]], size = book_text_size, fontface = "bold") +
  geom_point(data = susp, aes(x = effective_date, y = row), shape = 4, size = 2.2, stroke = 0.9,
             colour = lws_colors[["ink"]]) +
  geom_text(data = susp, aes(x = effective_date - 12, y = row,
                             label = "15% scheduled for 15 Dec 2019; suspended 18 Dec 2019, never in force"),
            hjust = 1, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_colour_manual(values = rate_cols, guide = "none") +
  scale_x_date(limits = as.Date(c("2018-06-01", "2020-04-15")), expand = c(0, 0),
               breaks = as.Date(c("2018-07-01", "2019-01-01", "2019-07-01", "2020-01-01")),
               date_labels = "%b %Y") +
  scale_y_discrete(drop = FALSE) +
  labs(title = "B. Additional ad valorem duty in force, by list (effective dates from the notices)",
       x = NULL, y = NULL) +
  theme_book_h() +
  theme(panel.grid.major.y = element_blank())

combined <- p1 / p2 + plot_layout(heights = c(1, 1.25)) +
  plot_annotation(
    caption = paste(strwrap(paste(
      "Source: Office of the U.S. Trade Representative, Federal Register notices 83 FR 28710, 83 FR 40823, 83 FR 47974, 84 FR 20459,",
      "84 FR 43304, 84 FR 45821, 84 FR 69447 and 85 FR 3741 (federalregister.gov, retrieved 28 October 2026).",
      "Values are the approximate annual trade values the notices state; they do not split the $300 billion of List 4 between",
      "Lists 4A and 4B. Rates are those set by the notices through February 2020; later modifications and product exclusions are not shown."),
      105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here("figures", "fig_06_07_section_301.png"), combined, width = 6, height = 5.4)

cat("\nFigure 6.7 summary:\n")
cat(sprintf("  Lists 1-3: $%dB across %s tariff subheadings; List 4 announced at $%dB\n",
            sum(lists$value_billion_usd[1:3]), comma(sum(lists$subheadings[1:3])), lists$value_billion_usd[4]))
