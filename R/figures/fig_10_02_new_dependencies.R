# Figure 10.2: Energy transition creates new dependencies
# Chapter 10: Future of Economic Coercion
# Data (committed extracts in data/sources/; refresh notes in data/METADATA.md):
#   usgs_mcs2026_world_production_2024.csv   USGS Mineral Commodity Summaries 2026 data release, 2024 world mine
#                                            (and copper refinery) production by country
#   iea_gcmo2025_refined_shares.csv          IEA Global Critical Minerals Outlook 2025, refined production shares
#   energy_fossil_production_2024.csv        Energy Institute Statistical Review via Our World in Data, 2024 production
# An earlier version of this figure used author estimates for demand growth, processing shares and "concentration";
# those values are printed below beside the sourced ones so the change shows in the render log.

library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(forcats)
library(patchwork)

usgs <- read.csv(here("data", "sources", "usgs_mcs2026_world_production_2024.csv"), stringsAsFactors = FALSE, encoding = "UTF-8")
iea  <- read.csv(here("data", "sources", "iea_gcmo2025_refined_shares.csv"), stringsAsFactors = FALSE, encoding = "UTF-8")
fuel <- read.csv(here("data", "sources", "energy_fossil_production_2024.csv"), stringsAsFactors = FALSE, encoding = "UTF-8")

# ----------------------------------------------------------------------------
# Checks: each USGS block must add up to its published world total (USGS rounds the totals), and the IEA
# columns must add to 100 within rounding. A transcription slip fails the build.
# ----------------------------------------------------------------------------
blocks <- usgs %>% filter(country != "World total", status != "withheld by USGS") %>%
  group_by(commodity, measure) %>% summarise(listed = sum(as.numeric(value)), .groups = "drop") %>%
  left_join(usgs %>% filter(country == "World total") %>% transmute(commodity, measure, world = as.numeric(value)),
            by = c("commodity", "measure"))
stopifnot(nrow(blocks) == 7, all(abs(blocks$listed / blocks$world - 1) < 0.02))
stopifnot(all(abs(tapply(iea$share_pct, list(iea$mineral, iea$year), sum) - 100) <= 2))

# ----------------------------------------------------------------------------
# Panel A: China's share of mining and of refining, 2024, with the IEA 2035 base case
# ----------------------------------------------------------------------------
share_usgs <- function(commodity, measure, country = "China") {
  b <- usgs %>% filter(commodity == !!commodity, measure == !!measure)
  100 * as.numeric(b$value[b$country == country]) / as.numeric(b$value[b$country == "World total"])
}
minerals <- c("Copper", "Lithium", "Nickel", "Cobalt", "Graphite", "Rare earths")
usgs_name <- c(Copper = "Copper", Lithium = "Lithium", Nickel = "Nickel", Cobalt = "Cobalt",
               Graphite = "Graphite (Natural)", "Rare earths" = "Rare Earths")
china_iea <- function(m, y) iea$share_pct[iea$mineral == m & iea$year == y & iea$country == "China"]

pa <- tibble(
  mineral = minerals,
  Mining = sapply(minerals, function(m) share_usgs(usgs_name[[m]], "Mine production")),
  Refining = sapply(minerals, china_iea, y = 2024),
  Refining2035 = sapply(minerals, china_iea, y = 2035)
)
# Cross-check: USGS refinery output for copper agrees with the IEA refined share to within two points.
stopifnot(abs(share_usgs("Copper", "Refinery production") - pa$Refining[pa$mineral == "Copper"]) < 2)

pa <- pa %>% mutate(mineral = fct_reorder(mineral, Refining))
pa_long <- pa %>% pivot_longer(c(Mining, Refining), names_to = "stage", values_to = "share") %>%
  mutate(stage = factor(stage, levels = c("Mining", "Refining")))

p1 <- ggplot(pa) +
  geom_vline(xintercept = 50, linetype = "22", colour = lws_colors[["ref"]], linewidth = 0.4) +
  geom_segment(aes(x = Mining, xend = Refining, y = mineral, yend = mineral), colour = lws_colors[["fade"]], linewidth = 1.2) +
  geom_point(data = pa_long, aes(x = share, y = mineral, colour = stage), size = 3.2) +
  geom_point(aes(x = Refining2035, y = mineral), shape = 5, size = 2.6, stroke = 0.7, colour = lws_colors[["red"]]) +
  geom_text(data = pa_long, aes(x = share, y = mineral, label = paste0(round(share), "%"), colour = stage),
            vjust = -1.0, size = book_text_size, show.legend = FALSE) +
  scale_colour_manual(values = c(Mining = lws_colors[["text"]], Refining = lws_colors[["red"]])) +
  scale_x_continuous(limits = c(-4, 105), breaks = seq(0, 100, 25), labels = function(x) paste0(x, "%"), expand = c(0, 0)) +
  labs(title = "A. China's share of world mining and refining, 2024",
       x = "Share of world production (%)", y = NULL) +
  theme_book_h()

# ----------------------------------------------------------------------------
# Panel B: share of the largest producing country, fossil fuels versus critical minerals
# ----------------------------------------------------------------------------
fos <- fuel %>% group_by(fuel) %>%
  summarise(top_country = country[country != "World"][which.max(production_twh[country != "World"])],
            top_share = 100 * max(production_twh[country != "World"]) / production_twh[country == "World"],
            china_share = 100 * production_twh[country == "China"] / production_twh[country == "World"], .groups = "drop") %>%
  transmute(item = fuel, era = "Fossil fuels (production)", top_country, top_share, china_share)

mins <- iea %>% filter(year == 2024, country != "Rest of world") %>%
  group_by(mineral) %>%
  summarise(top_country = country[which.max(share_pct)], top_share = max(share_pct),
            china_share = share_pct[country == "China"], .groups = "drop") %>%
  transmute(item = mineral, era = "Critical minerals (refining)", top_country, top_share, china_share)

pb <- bind_rows(fos, mins) %>%
  mutate(era = factor(era, levels = c("Fossil fuels (production)", "Critical minerals (refining)")),
         is_china = top_country == "China",
         item = fct_reorder(item, top_share),
         lab = paste0(sub("United States", "US", top_country), " ", round(top_share), "%"))

p2 <- ggplot(pb, aes(x = item, y = top_share)) +
  geom_col(aes(fill = is_china), width = 0.65) +
  geom_point(data = pb %>% filter(!is_china), aes(y = china_share), colour = lws_colors[["red"]], shape = 18, size = 3) +
  geom_text(aes(y = pmax(top_share, china_share), label = lab), hjust = -0.12, colour = lws_colors[["ink"]], size = book_text_size) +
  scale_fill_manual(values = c("TRUE" = lws_colors[["red"]], "FALSE" = lws_colors[["fade"]]), guide = "none") +
  coord_flip() +
  facet_wrap(~era, scales = "free_y") +
  scale_y_continuous(limits = c(0, 135), breaks = c(0, 50, 100), labels = function(x) paste0(x, "%")) +
  labs(title = "B. Share of world production held by the largest producer, 2024",
       x = NULL, y = "Share of world production (%)") +
  theme_book_h() + theme(strip.text = element_text(face = "bold", colour = lws_colors[["ink"]]))

combined <- p1 / p2 + plot_layout(heights = c(1.05, 1)) +
  plot_annotation(
    caption = paste(strwrap(paste(
      "Sources: USGS Mineral Commodity Summaries 2026 (2024 world mine production; copper refinery output for the cross-check);",
      "IEA, Global Critical Minerals Outlook 2025 (refined production shares, 2024 and 2035 base case; graphite is battery-grade,",
      "rare earths are magnet elements only; CC BY 4.0); Energy Institute Statistical Review of World Energy via Our World in Data (2024 production).",
      "Open diamonds in panel A: IEA base case for China's refining share in 2035. Red diamonds in panel B: China's share where it is not the largest producer.",
      "Lithium's USGS world total excludes US output, which USGS withholds."), 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here::here("figures", "fig_10_02_new_dependencies.png"), plot = combined, width = 6, height = 6.4)

# ----------------------------------------------------------------------------
# Render log: what the earlier typed values said against the sourced ones
# ----------------------------------------------------------------------------
old_typed <- data.frame(
  item = c("Lithium", "Cobalt", "Rare earths", "Oil", "Natural gas", "Coal"),
  old_concentration = c(75, 70, 90, 65, 40, 25),
  old_china_exposure = c(65, 72, 90, 15, 10, 20))
cmp <- old_typed %>% left_join(pb %>% mutate(item = as.character(item)) %>% select(item, top_country, top_share, china_share), by = "item")
cat("\nFigure 10.2: earlier author estimates (panel C) against sourced values, 2024\n")
print(cmp %>% mutate(across(where(is.numeric), ~ round(.x, 1))), row.names = FALSE)
cat("\nChina share of mining versus refining (%), 2024:\n")
print(pa %>% mutate(across(where(is.numeric), ~ round(.x, 1))), row.names = FALSE)
