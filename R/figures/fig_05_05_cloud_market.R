# Figure 5.5: Cloud Infrastructure Market Share
# Chapter 5: Information, Cyber, and Intelligence
# Data: data/sources/synergy_cloud_share_2024q4.csv, the Q4 2024 worldwide shares in Synergy Research Group's release
# on the 2024 cloud infrastructure market. Synergy publishes only the named providers' shares; the release does not
# report Huawei Cloud, and no public source gives each provider's share inside China or the United States.
# The earlier version of this figure plotted a table of 2019-2024 shares, including domestic-market panels, whose values
# could not be traced to a source; that table (cloud_market_share.csv) has been retired.

library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)

cloud <- read.csv(here::here("data", "sources", "synergy_cloud_share_2024q4.csv"), stringsAsFactors = FALSE, encoding = "UTF-8")

# Checks against aggregates the release states: the three leaders' shares are 30, 21 and 12 percent, and the named
# providers cannot exceed the whole market.
stopifnot(
  all(cloud$share_pct[cloud$provider %in% c("Amazon", "Microsoft", "Google")] == c(30, 21, 12)),
  sum(cloud$share_pct) <= 100, nrow(cloud) == 8,
  all(cloud$headquarters[cloud$provider %in% c("Alibaba", "Tencent")] == "China")
)
top3 <- sum(cloud$share_pct[cloud$provider %in% c("Amazon", "Microsoft", "Google")])
cn_named <- sum(cloud$share_pct[cloud$headquarters == "China"])

cloud <- cloud %>%
  mutate(origin = ifelse(headquarters == "China", "Chinese provider", "Other provider"),
         provider = reorder(provider, share_pct))
origin_cols <- c("Chinese provider" = lws_colors[["red"]], "Other provider" = lws_colors[["text"]])

p <- ggplot(cloud, aes(x = provider, y = share_pct, fill = origin)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(share_pct, "%")), hjust = -0.15, colour = lws_colors[["ink"]], size = book_text_size) +
  annotate("text", x = 2.2, y = 29, hjust = 1, vjust = 0.5, colour = lws_colors[["ink"]], size = book_text_size, lineheight = 0.95,
           label = sprintf("The three U.S. leaders: %d%%\nChinese providers shown: %d%%\nHuawei Cloud is not reported\nseparately in the release", top3, cn_named)) +
  scale_fill_manual(values = origin_cols, name = NULL) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.12)), labels = function(x) paste0(x, "%")) +
  coord_flip() +
  labs(x = NULL, y = "Share of worldwide cloud infrastructure services revenue, Q4 2024 (%)") +
  book_source("Source: Synergy Research Group, worldwide cloud infrastructure services market share, Q4 2024 (release on the $330 billion 2024 market; read via press-release copies, 28 October 2026). Providers named in the release only; the remaining 24% is spread across other providers. The copies of the release read give no breakdown by country of customer.") +
  theme_book_h() + theme(legend.position = "top", legend.justification = "left")

save_econ_figure(here::here("figures", "fig_05_05_cloud_market.png"), plot = p, width = 6, height = 3.8)

cat("Figure 5.5 created: Cloud Infrastructure Market Share\n")
cat(sprintf("  Named providers sum to %d%%; top three %d%%; Chinese providers shown %d%%\n", sum(cloud$share_pct), top3, cn_named))
