# Figure 6.3: U.S. Entity List Additions
# Purpose: Visualize the escalation of technology export controls
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)
library(scales)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. LOAD AND PREPARE DATA
# ============================================================================

# Load data
entity_data <- read_csv(here("data", "sources", "entity_list_additions.csv"))

# Pivot for stacked area chart (Left Panel)
# Columns: Year, Semiconductors, Surveillance, Aerospace_Defense, Universities_Research, AI_Computing, Other
entity_long <- entity_data %>%
  select(-Total) %>%
  pivot_longer(
    cols = -Year,
    names_to = "Sector",
    values_to = "Count"
  ) %>%
  mutate(
    Sector = case_when(
      Sector == "Semiconductors" ~ "Semiconductors",
      Sector == "Surveillance" ~ "Surveillance",
      Sector == "Aerospace_Defense" ~ "Aerospace/Defense",
      Sector == "Universities_Research" ~ "Universities/Research",
      Sector == "AI_Computing" ~ "AI/Computing",
      Sector == "Other" ~ "Other"
    ),
    # Set factor levels for stacking order
    Sector = factor(Sector, levels = c("Other", "AI/Computing", "Universities/Research", 
                                       "Aerospace/Defense", "Surveillance", "Semiconductors"))
  )

# ============================================================================
# 2. ONE PANEL: annual additions by sector, stacked, totals printed above each bar.
# Semiconductors carry the single highlight colour; other sectors are graded greys.
# ============================================================================

sector_fill <- c(
  "Semiconductors" = lws_colors[["red"]],
  "AI/Computing" = "#4D4D4D", "Surveillance" = "#7A7A7A", "Aerospace/Defense" = "#9E9E9E",
  "Universities/Research" = "#BDBDBD", "Other" = "#DCDCDC"
)
entity_long <- entity_long %>%
  mutate(Sector = factor(Sector, levels = c("Other", "Universities/Research", "Aerospace/Defense", "Surveillance", "AI/Computing", "Semiconductors")))

final_plot <- ggplot(entity_long, aes(x = Year, y = Count, fill = Sector)) +
  geom_col(width = 0.75, colour = "white", linewidth = 0.2) +
  geom_text(data = entity_data, aes(x = Year, y = Total, label = Total), inherit.aes = FALSE,
            vjust = -0.5, colour = lws_colors[["ink"]], size = book_text_size) +
  annotate("segment", x = 2019, xend = 2019, y = 190, yend = 250, linetype = "dashed", colour = lws_colors[["text"]]) +
  annotate("text", x = 2019, y = 262, label = "Huawei added\n(May 2019)", lineheight = 0.9, colour = lws_colors[["text"]]) +
  scale_fill_manual(values = sector_fill, breaks = rev(levels(entity_long$Sector)), name = NULL) +
  scale_x_continuous(breaks = 2015:2024) +
  scale_y_continuous(limits = c(0, 300), expand = c(0, 0)) +
  labs(x = NULL, y = "Chinese entities added per year") +
  book_source("Source: U.S. Bureau of Industry and Security, Federal Register. Annual additions of Chinese entities to the Entity List; sector assignment as coded in the dataset.") +
  theme_econ_textbook() +
  theme(legend.position = "top", legend.text = element_text(size = 7.5)) +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE))

save_econ_figure(here("figures", "fig_06_03_entity_list.png"), final_plot, width = 6, height = 4.4)

cat("\nFigure 6.3 Summary:\n")
cat(sprintf("2015 Total: %d -> 2024 Total: %d\n", entity_data$Total[1], tail(entity_data$Total, 1)))
cat("Cumulative Total:", sum(entity_data$Total), "\n")
