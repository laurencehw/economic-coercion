# Figure 3.10: Global Grain Export Concentration
# Chapter 3: Critical Sectors
# Shows who feeds the world and food security vulnerabilities

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(forcats)

# Grain export data (2022-2023 averages)
grain_exports <- data.frame(
  country = c(
    "USA", "Brazil", "Argentina", "Australia", "Canada",
    "Russia", "Ukraine", "France", "India", "Germany"
  ),
  wheat_mt = c(21, 2.5, 12, 27, 26, 45, 18, 37, 8, 9),
  corn_mt = c(55, 47, 38, 0.5, 1.5, 5, 23, 7, 3, 0.5),
  soybeans_mt = c(55, 95, 7, 0.2, 6, 0.1, 0.1, 0.1, 0.1, 0.1),
  rice_mt = c(3, 1, 0.5, 0.5, 0, 0.5, 0, 0.3, 21, 0),
  region = c(
    "Americas", "Americas", "Americas", "Oceania", "Americas",
    "Eurasia", "Eurasia", "Europe", "Asia", "Europe"
  )
)

# Calculate totals and reshape
grain_exports <- grain_exports %>%
  mutate(total = wheat_mt + corn_mt + soybeans_mt + rice_mt)

grain_long <- grain_exports %>%
  select(country, wheat_mt, corn_mt, soybeans_mt, rice_mt, region) %>%
  pivot_longer(cols = c(wheat_mt, corn_mt, soybeans_mt, rice_mt),
               names_to = "crop", values_to = "exports") %>%
  mutate(
    crop = case_when(
      crop == "wheat_mt" ~ "Wheat",
      crop == "corn_mt" ~ "Corn",
      crop == "soybeans_mt" ~ "Soybeans",
      crop == "rice_mt" ~ "Rice"
    )
  )

# Crop colors
crop_colors <- c(
  "Wheat" = "#daa520",  # Golden
  "Corn" = "#ffd700",   # Yellow
  "Soybeans" = "#228b22", # Green
  "Rice" = "#f5f5dc"    # Beige
)

# Region colors
region_colors <- c(
  "Americas" = "#1f77b4",
  "Eurasia" = "#d62728",
  "Europe" = "#2ca02c",
  "Oceania" = "#17becf",
  "Asia" = "#ff7f0e"
)

# Panel 1: Total exports by country
grain_exports_sorted <- grain_exports %>%
  mutate(country = fct_reorder(country, total))

p1 <- ggplot(grain_exports_sorted, aes(x = country, y = total, fill = region)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = paste0(round(total), " MT")), hjust = -0.1, size = 3.5) +
  coord_flip() +
  scale_fill_manual(values = region_colors, name = "Region") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Top Grain Exporters (Total 2022-2023)",
    subtitle = "Combined wheat, corn, soybeans, and rice exports",
    x = NULL,
    y = "Exports (Million Tonnes)"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.y = element_blank())

# Panel 2: Exports by crop type
top_5 <- grain_exports %>%
  arrange(desc(total)) %>%
  head(5) %>%
  pull(country)

grain_top5 <- grain_long %>%
  filter(country %in% top_5)

p2 <- ggplot(grain_top5, aes(x = country, y = exports, fill = crop)) +
  geom_col(position = "dodge", width = 0.7) +
  scale_fill_manual(values = crop_colors, name = "Crop") +
  labs(
    title = "Top 5 Exporters: Crop Composition",
    subtitle = "Specialization patterns reveal vulnerabilities",
    x = NULL,
    y = "Exports (Million Tonnes)"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank())

# Panel 3: Concentration by crop
crop_concentration <- grain_long %>%
  group_by(crop) %>%
  arrange(desc(exports)) %>%
  mutate(
    rank = row_number(),
    cumulative_share = cumsum(exports) / sum(exports) * 100
  ) %>%
  filter(rank <= 3)

p3 <- ggplot(crop_concentration, aes(x = crop, y = cumulative_share, fill = factor(rank))) +
  geom_col(position = "stack", width = 0.6) +
  geom_hline(yintercept = 80, linetype = "dashed", color = "gray40") +
  geom_text(data = crop_concentration %>% group_by(crop) %>% slice_tail(n = 1),
            aes(label = paste0(round(cumulative_share), "%")), vjust = -0.3, size = 4) +
  scale_fill_manual(
    values = c("1" = "#d62728", "2" = "#ff7f0e", "3" = "#ffbb78"),
    name = "Rank",
    labels = c("Top 1", "Top 2", "Top 3")
  ) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  annotate("text", x = 4.3, y = 82, label = "High concentration", color = "gray40", size = 3) +
  labs(
    title = "Export Concentration by Crop",
    subtitle = "Share of global exports held by top 3 exporters",
    x = NULL,
    y = "Cumulative Share (%)",
    caption = "Source: USDA, FAO trade data (2022-2023 average)\nNote: Ukraine exports significantly reduced from pre-war levels due to Russian invasion"
  ) +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_blank())

# Combine
library(patchwork)
combined <- p1 / (p2 + p3) + plot_layout(heights = c(1.2, 1))

# Save the figure
save_econ_figure(here::here("figures", "fig_03_10_grain_exporters.png"), plot = combined, width = 13, height = 12)

cat("Figure 3.10 created: Grain Exporters\n")
