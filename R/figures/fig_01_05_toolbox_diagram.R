# Figure 1.5: Economic Statecraft Toolbox
# Chapter 1: Foundations of Economic Statecraft
# Hierarchical diagram showing domains and instruments of economic coercion

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(ggforce)

# Define the toolbox structure
toolbox <- data.frame(
  domain = c(
    rep("Trade", 5),
    rep("Finance", 5),
    rep("Technology", 5),
    rep("Investment", 4)
  ),
  instrument = c(
    # Trade
    "Tariffs", "Quotas", "Export Controls", "Import Bans", "Embargoes",
    # Finance
    "Sanctions", "Asset Freezes", "SWIFT Exclusion", "Secondary Sanctions", "Currency Manipulation",
    # Technology
    "Entity Lists", "Tech Transfer Blocks", "Talent Restrictions", "Standard Setting", "R&D Controls",
    # Investment
    "CFIUS Screening", "Forced Divestment", "FDI Restrictions", "Outbound Investment Review"
  ),
  example = c(
    # Trade examples
    "Section 301 tariffs on China",
    "Steel import quotas",
    "Semiconductor equipment to China",
    "Russian oil import ban",
    "Cuba comprehensive embargo",
    # Finance examples
    "OFAC SDN designations",
    "Russian oligarch assets",
    "Russian banks 2022",
    "Iran-related sanctions",
    "Treasury FX monitoring",
    # Technology examples
    "Huawei, SMIC restrictions",
    "CHIPS Act guardrails",
    "US person rule (chips)",
    "5G/6G standards bodies",
    "Deemed export rules",
    # Investment examples
    "TikTok/ByteDance review",
    "Grindr, StayNTouch",
    "China FDI in tech sector",
    "Executive Order 14105"
  )
)

# Domain colours: four house hues
domain_order <- c("Trade", "Finance", "Technology", "Investment")
domain_colors <- c(
  "Trade" = lws_colors[["blue"]],
  "Finance" = lws_colors[["green"]],
  "Technology" = lws_colors[["red"]],
  "Investment" = lws_colors[["orange"]]
)

toolbox <- toolbox %>%
  mutate(domain_idx = match(domain, domain_order)) %>%
  group_by(domain) %>%
  mutate(instrument_idx = row_number()) %>%
  ungroup() %>%
  mutate(x = domain_idx, y = -instrument_idx * 1.1)

domain_labels <- tibble(domain = domain_order, x = seq_along(domain_order), y = 0.2)

p <- ggplot(toolbox) +
  geom_tile(aes(x = x, y = y), width = 0.94, height = 1.0, fill = "#F5F5F5", colour = NA) +
  geom_tile(aes(x = x - 0.47 + 0.012, y = y, fill = domain), width = 0.024, height = 1.0) +
  geom_tile(data = domain_labels, aes(x = x, y = y, fill = domain), width = 0.94, height = 0.7) +
  geom_text(data = domain_labels, aes(x = x, y = y, label = domain),
            colour = "white", fontface = "bold", size = 3.2) +
  geom_text(aes(x = x - 0.43, y = y + 0.18, label = instrument),
            hjust = 0, fontface = "bold", size = 2.45, colour = lws_colors[["ink"]]) +
  geom_text(aes(x = x - 0.43, y = y - 0.2, label = stringr::str_wrap(example, 24)),
            hjust = 0, vjust = 0.5, size = 2.45, colour = lws_colors[["text"]], lineheight = 0.9) +
  scale_fill_manual(values = domain_colors, guide = "none") +
  labs(caption = "Source: Author's compilation. Examples drawn from US policy actions, 2018-2024.") +
  theme_void(base_size = 9, base_family = lws_family) +
  theme(plot.background = element_rect(fill = "white", colour = NA),
        plot.caption = element_text(hjust = 0, size = 7, colour = lws_colors[["text"]], margin = margin(t = 4)),
        plot.caption.position = "plot",
        plot.margin = margin(4, 6, 6, 6))

save_econ_figure(here::here("figures", "fig_01_05_toolbox_diagram.png"), plot = p, width = 6, height = 4.8)

cat("Figure 1.5 created: Economic Statecraft Toolbox\n")
