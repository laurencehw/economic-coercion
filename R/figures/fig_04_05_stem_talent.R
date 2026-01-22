# Figure 4.5: STEM PhD Talent Flows
# Chapter 4: High Technology Competition
# Shows where international STEM talent studies vs. stays/returns

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# Load data
talent <- read.csv(here::here("data", "sources", "stem_talent_flows.csv"), stringsAsFactors = FALSE)

# Filter to key years for comparison
talent_compare <- talent %>%
  filter(year %in% c(2010, 2019, 2023)) %>%
  mutate(year = factor(year))

# Country colors
country_colors <- c(
  "China" = "#d62728",
  "India" = "#e377c2",
  "South Korea" = "#8c564b",
  "Taiwan" = "#aec7e8",
  "Iran" = "#ff7f0e"
)

# Panel 1: Stay rates over time
p1 <- ggplot(talent_compare, aes(x = origin_country, y = stay_rate_pct, fill = year)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  geom_text(
    aes(label = paste0(stay_rate_pct, "%")),
    position = position_dodge(width = 0.8),
    vjust = -0.5, size = 3
  ) +
  scale_fill_manual(
    values = c("2010" = "#1f77b4", "2019" = "#ff7f0e", "2023" = "#2ca02c"),
    name = "Year"
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "US Stay Rates for Foreign STEM PhDs",
    subtitle = "Percentage remaining in US 5 years after graduation",
    x = NULL,
    y = "Stay Rate (%)"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank())

# Panel 2: Volume of graduates
talent_volume <- talent %>%
  filter(origin_country == "China") %>%
  mutate(
    stayed = phd_graduates_us * stay_rate_pct / 100,
    returned = phd_graduates_us * return_country_pct / 100
  )

p2 <- ggplot(talent_volume) +
  geom_area(aes(x = year, y = phd_graduates_us), fill = "#c7c7c7", alpha = 0.5) +
  geom_area(aes(x = year, y = stayed), fill = "#1f77b4", alpha = 0.7) +
  geom_line(aes(x = year, y = phd_graduates_us), color = "gray40", linewidth = 1) +
  geom_line(aes(x = year, y = stayed), color = "#1f77b4", linewidth = 1.2) +
  geom_point(aes(x = year, y = stayed), color = "#1f77b4", size = 3) +
  annotate("text", x = 2021, y = 5800, label = "Total Chinese\nSTEM PhDs",
           size = 3.5, color = "gray40") +
  annotate("text", x = 2021, y = 3200, label = "Stayed in US",
           size = 3.5, color = "#1f77b4") +
  scale_x_continuous(breaks = seq(2010, 2023, 2)) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Chinese STEM PhD Production in US Universities",
    subtitle = "Declining stay rate = growing talent for Chinese R&D",
    x = "Year",
    y = "Number of PhDs"
  ) +
  theme_econ_textbook()

# Panel 3: 2023 snapshot by country
snapshot_2023 <- talent %>%
  filter(year == 2023) %>%
  select(origin_country, stay_rate_pct, return_country_pct, third_country_pct) %>%
  pivot_longer(cols = -origin_country, names_to = "destination", values_to = "pct") %>%
  mutate(
    destination = case_when(
      destination == "stay_rate_pct" ~ "Stay in US",
      destination == "return_country_pct" ~ "Return Home",
      destination == "third_country_pct" ~ "Third Country"
    ),
    destination = factor(destination, levels = c("Stay in US", "Return Home", "Third Country"))
  )

p3 <- ggplot(snapshot_2023, aes(x = origin_country, y = pct, fill = destination)) +
  geom_col(width = 0.7) +
  geom_text(
    aes(label = ifelse(pct >= 10, paste0(pct, "%"), "")),
    position = position_stack(vjust = 0.5),
    color = "white", fontface = "bold", size = 3
  ) +
  scale_fill_manual(
    values = c("Stay in US" = "#1f77b4", "Return Home" = "#d62728", "Third Country" = "#ff7f0e"),
    name = "Destination"
  ) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Where Do Foreign STEM PhDs Go? (2023)",
    subtitle = "Post-graduation destination by country of origin",
    x = NULL,
    y = "Share (%)",
    caption = "Source: NSF Survey of Earned Doctorates, Science & Engineering Indicators"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank())

# Combine plots
library(patchwork)
combined <- (p1 + p2) / p3 + plot_layout(heights = c(1, 1))

# Save the figure
save_econ_figure(here::here("figures", "fig_04_05_stem_talent.png"), plot = combined, width = 13, height = 11)

cat("Figure 4.5 created: STEM Talent Flows\n")
