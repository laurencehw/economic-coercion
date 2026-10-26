# Figure 5.5: Cloud Infrastructure Market Share
# Chapter 5: Information, Cyber, and Intelligence
# Shows US vs Chinese dominance in global cloud infrastructure

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)

# Load data
cloud_data <- read.csv(here::here("data", "sources", "cloud_market_share.csv"), stringsAsFactors = FALSE)

# Filter to 2024 data for main comparison
cloud_2024 <- cloud_data %>%
  filter(year == 2024, provider != "Others")

# One highlight colour: Chinese providers in red, U.S. and other providers in ink-grey
cn <- c("Alibaba Cloud", "Tencent Cloud", "Huawei Cloud")
origin_cols <- c("Chinese provider" = lws_colors[["red"]], "Other provider" = lws_colors[["text"]])
cloud_2024 <- cloud_2024 %>% mutate(origin = ifelse(provider %in% cn, "Chinese provider", "Other provider"))

p1 <- ggplot(cloud_2024, aes(x = reorder(provider, global_share), y = global_share, fill = origin)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(global_share, "%")), hjust = -0.15, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = origin_cols, name = NULL) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  coord_flip() +
  labs(title = "A. Global market share, 2024", x = NULL, y = "Market share (%)") +
  theme_book_h() + theme(legend.position = "top")

regional_data <- cloud_2024 %>%
  select(provider, origin, us_share, china_share) %>%
  pivot_longer(cols = c(us_share, china_share), names_to = "market", values_to = "share") %>%
  mutate(market = ifelse(market == "us_share", "U.S. market", "China market")) %>%
  filter(share > 0.5) %>%
  mutate(provider_m = paste(provider, market, sep = "___"),
         provider_m = reorder(provider_m, share))

p2 <- ggplot(regional_data, aes(x = provider_m, y = share, fill = origin)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(round(share, 1), "%")), hjust = -0.15, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = origin_cols, guide = "none") +
  scale_x_discrete(labels = function(x) sub("___.*$", "", x)) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.3))) +
  facet_wrap(~market, scales = "free_y") +
  coord_flip() +
  labs(title = "B. Domestic market shares, 2024", x = NULL, y = "Market share (%)") +
  theme_book_h()

library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1.1, 1)) +
  plot_annotation(caption = paste(strwrap("Source: Synergy Research, Canalys and company reports, 2024. Shares of providers shown; 'Others' omitted, so shares do not sum to 100.", 105), collapse = "\n"),
                  theme = theme_econ_textbook())

save_econ_figure(here::here("figures", "fig_05_05_cloud_market.png"), plot = combined, width = 6, height = 6.2)

cat("Figure 5.5 created: Cloud Infrastructure Market Share\n")
