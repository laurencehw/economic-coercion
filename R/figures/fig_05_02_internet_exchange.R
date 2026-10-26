# Figure 5.2: Internet Exchange Point Concentration
# Chapter 5: Information, Cyber, and Intelligence
# Shows global IXP traffic concentration - key infrastructure chokepoints

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(forcats)

# Load data
ixp_data <- read.csv(here::here("data", "sources", "internet_exchange_points.csv"), stringsAsFactors = FALSE)

# Prepare data - top 15 by traffic
top_ixps <- ixp_data %>%
  arrange(desc(peak_traffic_tbps)) %>%
  head(15) %>%
  mutate(
    label = paste0(ixp_name, " (", city, ")"),
    label = fct_reorder(label, peak_traffic_tbps)
  )

# One highlight: Europe (the region the chapter singles out); all others in neutral grey
hl <- c("Europe" = lws_colors[["blue"]], "Other regions" = lws_colors[["fade"]])
top_ixps <- top_ixps %>% mutate(grp = ifelse(region == "Europe", "Europe", "Other regions"))

p1 <- ggplot(top_ixps, aes(x = label, y = peak_traffic_tbps, fill = grp)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(peak_traffic_tbps, " Tbps")), hjust = -0.1,
            colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = hl, name = NULL) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.18))) +
  coord_flip() +
  labs(title = "A. Fifteen largest exchange points by peak traffic", x = NULL, y = "Peak traffic, terabits per second") +
  theme_book_h() +
  theme(legend.position = "top")

regional_summary <- ixp_data %>%
  group_by(region) %>%
  summarise(total_traffic = sum(peak_traffic_tbps), .groups = "drop") %>%
  mutate(share = total_traffic / sum(total_traffic) * 100,
         region = fct_reorder(region, total_traffic),
         grp = ifelse(region == "Europe", "Europe", "Other regions"))

p2 <- ggplot(regional_summary, aes(x = region, y = share, fill = grp)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0(round(share, 1), "%")), hjust = -0.1,
            colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = hl, guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.18))) +
  coord_flip() +
  labs(title = "B. Share of global exchange traffic by region", x = NULL, y = "Share of peak traffic (%)") +
  theme_book_h()

library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(2.2, 1)) +
  plot_annotation(caption = book_source("Source: PeeringDB and IXP operator reports, 2024. Shares are of the summed peak traffic of the exchanges in the dataset.")$caption,
                  theme = theme_econ_textbook())

save_econ_figure(here::here("figures", "fig_05_02_internet_exchange.png"), plot = combined, width = 6, height = 6.6)

cat("Figure 5.2 created: Internet Exchange Point Concentration\n")
