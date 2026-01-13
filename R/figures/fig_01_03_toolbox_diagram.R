# Figure 1.3: Economic Statecraft Toolbox
# Chapter 1: Foundations of Economic Statecraft
# Hierarchical diagram showing domains and instruments of economic coercion

# Load required packages and theme
source("R/setup_theme.R")
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

# Assign colors by domain
domain_colors <- c(
  "Trade" = "#1f77b4",
  "Finance" = "#2ca02c",
  "Technology" = "#d62728",
  "Investment" = "#ff7f0e"
)

# Calculate positions for hierarchical layout
toolbox <- toolbox %>%
  group_by(domain) %>%
  mutate(
    domain_idx = cur_group_id(),
    instrument_idx = row_number(),
    n_instruments = n()
  ) %>%
  ungroup() %>%
  mutate(
    x = domain_idx,
    y = -instrument_idx
  )

# Domain labels positioning
domain_labels <- toolbox %>%
  group_by(domain) %>%
  summarise(
    x = first(domain_idx),
    y = 0.5,
    .groups = "drop"
  )

# Create the diagram
p <- ggplot(toolbox) +
  # Domain header boxes
  geom_tile(
    data = domain_labels,
    aes(x = x, y = y, fill = domain),
    width = 0.9, height = 0.8,
    color = "white", linewidth = 2
  ) +
  geom_text(
    data = domain_labels,
    aes(x = x, y = y, label = domain),
    color = "white", fontface = "bold", size = 5
  ) +
  # Instrument boxes
  geom_tile(
    aes(x = x, y = y, fill = domain),
    width = 0.85, height = 0.85,
    alpha = 0.7, color = "white", linewidth = 1
  ) +
  geom_text(
    aes(x = x, y = y, label = instrument),
    size = 3.5, fontface = "bold", color = "gray10"
  ) +
  geom_text(
    aes(x = x, y = y - 0.28, label = stringr::str_wrap(example, 20)),
    size = 2.3, color = "gray40", lineheight = 0.9
  ) +
  # Connecting lines from domain to instruments
  geom_segment(
    aes(x = x, xend = x, y = 0.1, yend = -0.4),
    color = "gray50", linewidth = 0.5
  ) +
  # Styling
  scale_fill_manual(values = domain_colors, guide = "none") +
  scale_x_continuous(expand = expansion(mult = 0.1)) +
  scale_y_continuous(expand = expansion(mult = 0.05)) +
  labs(
    title = "The Economic Statecraft Toolbox",
    subtitle = "Four domains of economic coercion with key instruments and recent examples",
    caption = "Source: Author's compilation\nNote: Examples drawn from US policy actions 2018-2024"
  ) +
  theme_econ_textbook() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )

# Save the figure
save_econ_figure("figures/fig_01_03_toolbox_diagram.png", plot = p, width = 12, height = 10)

cat("Figure 1.3 created: Economic Statecraft Toolbox\n")
