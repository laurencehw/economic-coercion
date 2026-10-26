# Figure 10.2: Energy Transition Creates New Dependencies
# Chapter 10: Future of Economic Coercion
# Shows how clean energy creates new strategic vulnerabilities

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(tidyr)
library(forcats)

# New dependency landscape
new_deps <- data.frame(
  material = c(
    "Lithium", "Cobalt", "Nickel", "Rare Earths",
    "Graphite", "Copper", "Manganese", "Silicon (Solar)"
  ),
  current_demand_kt = c(85, 140, 2500, 180, 1100, 25000, 14000, 500),
  projected_2040_kt = c(500, 280, 6000, 450, 2800, 45000, 28000, 1500),
  growth_multiple = c(5.9, 2.0, 2.4, 2.5, 2.5, 1.8, 2.0, 3.0),
  china_processing_share = c(65, 72, 35, 90, 70, 40, 55, 95),
  top_producer = c(
    "Australia", "DRC", "Indonesia", "China",
    "China", "Chile", "South Africa", "China"
  ),
  application = c(
    "Batteries", "Batteries", "Batteries", "Motors/Turbines",
    "Batteries", "Wiring/EVs", "Batteries", "Solar Panels"
  )
)

# Application colors
new_deps <- new_deps %>% mutate(material = fct_reorder(material, growth_multiple))

p1 <- ggplot(new_deps, aes(x = material, y = growth_multiple)) +
  geom_col(fill = lws_colors[["fade"]], width = 0.7) +
  geom_text(aes(label = paste0(growth_multiple, "x")), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  coord_flip() +
  scale_y_continuous(expand = expansion(mult = c(0, 0.2))) +
  labs(title = "A. Projected demand growth, 2024-2040", x = NULL, y = "Growth multiple") +
  theme_book_h()

p2 <- ggplot(new_deps, aes(x = material, y = china_processing_share)) +
  geom_col(fill = lws_colors[["red"]], width = 0.7) +
  geom_hline(yintercept = 50, linetype = "dashed", colour = lws_colors[["ref"]]) +
  geom_text(aes(label = paste0(china_processing_share, "%")), hjust = -0.1, colour = lws_colors[["ink"]], size = book_text_size) +
  coord_flip() +
  scale_y_continuous(limits = c(0, 115), breaks = c(0, 50, 100), expand = c(0, 0)) +
  labs(title = "B. China's processing share", x = NULL, y = "Share of global processing (%)") +
  theme_book_h() + theme(axis.text.y = element_blank())

dep_comparison <- data.frame(
  era = factor(c(rep("Fossil fuel era", 4), rep("Clean energy era", 4)), levels = c("Fossil fuel era", "Clean energy era")),
  dependency = c("Oil (Middle East)", "Natural gas (Russia)", "Coal", "Uranium", "Lithium", "Rare earths", "Cobalt", "Solar manufacturing"),
  concentration = c(65, 40, 25, 30, 75, 90, 70, 95),
  china_exposure = c(15, 10, 20, 5, 65, 90, 72, 95)
) %>% mutate(dependency = fct_reorder(dependency, concentration))

p3 <- ggplot(dep_comparison, aes(x = dependency, y = concentration)) +
  geom_col(fill = lws_colors[["fade"]], width = 0.6) +
  geom_point(aes(y = china_exposure), colour = lws_colors[["red"]], size = 2.4, shape = 18) +
  geom_text(aes(y = pmax(concentration, china_exposure), label = paste0(concentration, "%")), hjust = -0.6, colour = lws_colors[["ink"]], size = book_text_size) +
  coord_flip() +
  facet_wrap(~era, scales = "free_y") +
  scale_y_continuous(limits = c(0, 115), breaks = c(0, 50, 100)) +
  labs(title = "C. Supply concentration (bars) and China's share of the supply chain (red diamonds)", x = NULL, y = "Share (%)") +
  theme_book_h() + theme(strip.text = element_text(face = "bold", colour = lws_colors[["ink"]]))

library(patchwork)
combined <- (p1 + p2) / p3 + plot_layout(heights = c(1, 0.8)) +
  plot_annotation(
    caption = paste(strwrap("Source: IEA Critical Minerals Report, BloombergNEF and author calculations. Demand and processing shares in panels A and B are as compiled for the book; the concentration and China-exposure figures in panel C are the author's rough estimates, not a published series.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here::here("figures", "fig_10_02_new_dependencies.png"), plot = combined, width = 6, height = 6.4)

cat("Figure 10.2 created: New Dependencies\n")
