# Figure 4.6: Dual-Use Technology Matrix
# Chapter 4: High Technology Competition
# Shows technologies with both commercial and military applications

# Load required packages and theme
library(here)
source(here::here("R", "setup_theme.R"))
library(dplyr)
library(ggrepel)
library(tidyr)

# Define dual-use technology matrix
dual_use <- data.frame(
  technology = c(
    "Advanced Semiconductors",
    "Artificial Intelligence",
    "Quantum Computing",
    "Biotechnology",
    "Hypersonics",
    "Space Technology",
    "Autonomous Systems",
    "Advanced Materials",
    "5G/6G Networks",
    "Cyber Capabilities"
  ),
  commercial_intensity = c(10, 10, 6, 9, 3, 7, 8, 7, 10, 6),
  military_intensity = c(10, 10, 9, 7, 10, 9, 10, 8, 7, 10),
  us_lead = c(8, 8, 7, 8, 6, 9, 7, 7, 6, 9),
  china_lead = c(5, 7, 5, 6, 8, 6, 7, 6, 8, 8),
  commercial_example = c(
    "Consumer electronics, EVs",
    "Recommendation systems",
    "Drug discovery",
    "Gene therapy, vaccines",
    "High-speed transport",
    "Satellites, GPS",
    "Self-driving cars",
    "Lightweight structures",
    "Mobile connectivity",
    "Fraud detection"
  ),
  military_example = c(
    "Guided weapons, radar",
    "Autonomous targeting",
    "Code breaking",
    "Bioweapons defense",
    "Missile systems",
    "Reconnaissance, ASAT",
    "Drones, UUVs",
    "Stealth, armor",
    "Secure comms, EW",
    "Offensive operations"
  ),
  control_status = c(
    "Heavy restrictions",
    "Emerging controls",
    "Emerging controls",
    "Biosecurity focus",
    "Strict controls",
    "ITAR controlled",
    "Mixed regime",
    "Selective controls",
    "Standards battle",
    "Intelligence focus"
  )
)

# Calculate dual-use score (product of intensities)
dual_use <- dual_use %>%
  mutate(
    dual_use_score = commercial_intensity * military_intensity / 10,
    category = case_when(
      dual_use_score >= 8 ~ "Critical Dual-Use",
      dual_use_score >= 5 ~ "Significant Dual-Use",
      TRUE ~ "Moderate Dual-Use"
    )
  )

# Highlight the critical dual-use technologies; the rest in ink
p1 <- ggplot(dual_use, aes(x = commercial_intensity, y = military_intensity)) +
  annotate("rect", xmin = 7.5, xmax = 10.6, ymin = 7.5, ymax = 10.6, fill = lws_colors[["red"]], alpha = 0.07) +
  annotate("text", x = 10.5, y = 7.8, label = "Critical dual-use", hjust = 1, colour = lws_colors[["red"]]) +
  geom_point(aes(colour = category == "Critical Dual-Use"), size = 2.2, show.legend = FALSE) +
  scale_colour_manual(values = c("TRUE" = lws_colors[["red"]], "FALSE" = lws_colors[["ink"]])) +
  geom_text_repel(aes(label = technology), seed = 42, box.padding = 0.45, point.padding = 0.25,
                  min.segment.length = 0.2, segment.colour = lws_colors[["fade"]], segment.size = 0.3) +
  scale_x_continuous(limits = c(2, 11), breaks = seq(2, 10, 2)) +
  scale_y_continuous(limits = c(6, 11), breaks = seq(6, 10, 1)) +
  labs(title = "A. Commercial and military application intensity",
       x = "Commercial application intensity (1 to 10)", y = "Military intensity (1 to 10)") +
  theme_econ_textbook() +
  theme(panel.grid.major.x = element_line(colour = lws_colors[["grid"]], linewidth = 0.4))

# US vs China leadership comparison (dumbbell, technologies sorted by dual-use score)
leadership <- dual_use %>%
  select(technology, us_lead, china_lead, dual_use_score) %>%
  mutate(technology = factor(technology, levels = technology[order(dual_use_score)]))
leadership_long <- leadership %>%
  pivot_longer(cols = c(us_lead, china_lead), names_to = "country", values_to = "score") %>%
  mutate(country = ifelse(country == "us_lead", "United States", "China"))

p2 <- ggplot() +
  geom_segment(data = leadership, aes(x = us_lead, xend = china_lead, y = technology, yend = technology),
               colour = lws_colors[["fade"]], linewidth = 0.7) +
  geom_point(data = leadership_long, aes(x = score, y = technology, colour = country, size = country)) +
  scale_size_manual(values = c("United States" = 3.4, "China" = 1.9), guide = "none") +
  scale_colour_manual(values = c("United States" = lws_colors[["blue"]], "China" = lws_colors[["red"]]),
                      breaks = c("United States", "China"), name = NULL) +
  scale_x_continuous(limits = c(4, 10), breaks = 4:10) +
  labs(title = "B. Relative U.S. and Chinese capability", x = "Capability score (1 to 10)", y = NULL) +
  theme_book_h() +
  theme(legend.position = "top")

library(patchwork)
combined <- p1 / p2 + plot_layout(heights = c(1, 1.1)) +
  plot_annotation(
    caption = paste(strwrap("Source: Author's ordinal assessment (scores are judgments, not measurements), based on industry reports and government assessments; 2024. Advanced semiconductors and AI share the same position in panel A.", 105), collapse = "\n"),
    theme = theme_econ_textbook())

save_econ_figure(here::here("figures", "fig_04_03_dual_use_matrix.png"), plot = combined, width = 6, height = 7)

cat("Figure 4.3 created: Dual-Use Technology Matrix\n")
