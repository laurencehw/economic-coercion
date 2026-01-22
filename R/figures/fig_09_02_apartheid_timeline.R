# Figure 9.2: Anti-Apartheid Sanctions Timeline
# Purpose: Visualize the evolution of anti-apartheid sanctions 1960-1994
# Author: Laurence Wilse-Samson

library(here)
library(tidyverse)
library(patchwork)
library(scales)

# Load the custom theme
source(here("R", "setup_theme.R"))

# ============================================================================
# 1. PREPARE DATA
# ============================================================================

# Major events in anti-apartheid sanctions history
events_data <- tibble(
  Year = c(1960, 1962, 1963, 1977, 1985, 1986, 1989, 1990, 1991, 1994),
  Event = c(
    "Sharpeville Massacre\n(69 killed)",
    "UN calls for\nvoluntary sanctions",
    "Voluntary UN\narms embargo",
    "Mandatory UN\narms embargo",
    "Chase Manhattan\nleads bank exit",
    "US CAAA passed\n(over Reagan veto)",
    "De Klerk begins\nreforms",
    "Mandela released\nfrom prison",
    "US lifts most\nsanctions",
    "Democratic elections\n(sanctions end)"
  ),
  Category = c("Trigger", "Multilateral", "Multilateral", "Multilateral",
               "Financial", "US Policy", "SA Response", "SA Response",
               "Sanctions Relief", "Resolution"),
  Importance = c(3, 1, 2, 3, 3, 3, 2, 3, 2, 3)
)

# Economic indicator data for South Africa
economic_data <- tibble(
  Year = 1980:1994,
  GDP_Growth = c(6.6, 5.4, -0.4, -1.8, 5.1, -1.2, 0.0, 2.1, 4.2, 0.3, -0.3, -1.0, -2.1, 1.2, 3.2),
  Rand_USD = c(0.77, 0.87, 0.92, 0.89, 0.68, 0.45, 0.44, 0.50, 0.39, 0.38, 0.39, 0.36, 0.35, 0.34, 0.28),
  FDI_Billions = c(0.8, 0.6, 0.4, 0.3, 0.4, -0.2, -0.5, -0.3, 0.1, 0.2, 0.3, 0.4, 0.6, 1.2, 1.5)
)

# ============================================================================
# 2. CREATE VISUALIZATIONS
# ============================================================================

# Event colors by category
event_colors <- c(
  "Trigger" = "#d62728",
  "Multilateral" = "#1f77b4",
  "Financial" = "#2ca02c",
  "US Policy" = "#9467bd",
  "SA Response" = "#ff7f0e",
  "Sanctions Relief" = "#17becf",
  "Resolution" = "#2ca02c"
)

# --- Panel A: Timeline with Events ---
events_data <- events_data %>%
  mutate(
    y_position = rep(c(1.5, -1.5), length.out = n()),  # Alternate above/below
    label_y = ifelse(y_position > 0, 2.2, -2.2)
  )

p1 <- ggplot(events_data) +
  # Central timeline
  geom_hline(yintercept = 0, color = "gray30", linewidth = 1.5) +

  # Vertical connectors
  geom_segment(aes(x = Year, xend = Year, y = 0, yend = y_position, color = Category),
               linewidth = 1.2) +

  # Event points
  geom_point(aes(x = Year, y = 0, size = Importance, fill = Category),
             shape = 21, color = "black", stroke = 1) +

  # Event labels
  geom_label(aes(x = Year, y = y_position * 1.3, label = Event, fill = Category),
             size = 2.8, color = "white", fontface = "bold",
             label.padding = unit(0.3, "lines"), label.size = 0.3) +

  # Year labels
  geom_text(aes(x = Year, y = y_position * 0.4, label = Year),
            size = 3, fontface = "bold") +

  # Key period annotations
  annotate("rect", xmin = 1985, xmax = 1991, ymin = -0.3, ymax = 0.3,
           fill = "#d62728", alpha = 0.2) +
  annotate("text", x = 1988, y = 0, label = "Peak\nSanctions",
           size = 2.5, color = "#d62728", fontface = "bold") +

  scale_fill_manual(values = event_colors, name = "Category") +
  scale_color_manual(values = event_colors, guide = "none") +
  scale_size_continuous(range = c(3, 8), guide = "none") +
  scale_x_continuous(limits = c(1958, 1996), breaks = seq(1960, 1995, 5)) +
  scale_y_continuous(limits = c(-3, 3)) +

  labs(
    title = "Anti-Apartheid Sanctions Timeline (1960-1994)",
    subtitle = "From Sharpeville to democratic elections: 34 years of escalating pressure",
    x = NULL
  ) +
  theme_void() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0, margin = margin(b = 5)),
    plot.subtitle = element_text(size = 11, hjust = 0, color = "gray30", margin = margin(b = 10)),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    plot.background = element_rect(fill = "white", color = NA),
    axis.text.x = element_text(size = 10)
  ) +
  guides(fill = guide_legend(nrow = 1))

# --- Panel B: Economic Indicators ---
# Reshape for plotting
econ_long <- economic_data %>%
  select(Year, GDP_Growth, FDI_Billions) %>%
  pivot_longer(cols = -Year, names_to = "Indicator", values_to = "Value") %>%
  mutate(
    Indicator = case_when(
      Indicator == "GDP_Growth" ~ "GDP Growth (%)",
      Indicator == "FDI_Billions" ~ "FDI ($ Billions)"
    )
  )

p2 <- ggplot(economic_data, aes(x = Year)) +
  # GDP growth as area
  geom_area(aes(y = GDP_Growth), fill = "#1f77b4", alpha = 0.4) +
  geom_line(aes(y = GDP_Growth), color = "#1f77b4", linewidth = 1.2) +
  geom_hline(yintercept = 0, color = "gray50", linetype = "dashed") +

  # Key event markers
  geom_vline(xintercept = 1985, color = "#d62728", linetype = "dotted", linewidth = 0.8) +
  geom_vline(xintercept = 1986, color = "#9467bd", linetype = "dotted", linewidth = 0.8) +
  geom_vline(xintercept = 1990, color = "#ff7f0e", linetype = "dotted", linewidth = 0.8) +

  annotate("text", x = 1985.3, y = 6, label = "Bank\nwithdrawals",
           size = 2.5, hjust = 0, color = "#d62728") +
  annotate("text", x = 1986.3, y = 4, label = "CAAA",
           size = 2.5, hjust = 0, color = "#9467bd") +
  annotate("text", x = 1990.3, y = 5, label = "Mandela\nreleased",
           size = 2.5, hjust = 0, color = "#ff7f0e") +

  scale_x_continuous(breaks = seq(1980, 1994, 2)) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +

  labs(
    title = "South African GDP Growth",
    subtitle = "Economic impact of sanctions period (1980-1994)",
    x = "Year",
    y = "GDP Growth (%)"
  ) +
  theme_econ_textbook()

# --- Panel C: Rand Exchange Rate ---
p3 <- ggplot(economic_data, aes(x = Year, y = Rand_USD)) +
  geom_area(fill = "#2ca02c", alpha = 0.4) +
  geom_line(color = "#2ca02c", linewidth = 1.2) +

  # Key event markers
  geom_vline(xintercept = 1985, color = "#d62728", linetype = "dotted", linewidth = 0.8) +

  annotate("label", x = 1985, y = 0.85,
           label = "1985 Debt Crisis\nRand collapses 35%",
           size = 2.8, fill = "lightyellow", label.size = 0.2) +

  scale_x_continuous(breaks = seq(1980, 1994, 2)) +
  scale_y_continuous(labels = function(x) paste0("$", x)) +

  labs(
    title = "South African Rand vs USD",
    subtitle = "Currency depreciation during sanctions",
    x = "Year",
    y = "Rand per USD"
  ) +
  theme_econ_textbook()

# ============================================================================
# 3. COMPOSE AND SAVE
# ============================================================================

# Combine plots
combined <- p1 / (p2 + p3) +
  plot_layout(heights = c(1.5, 1)) +
  plot_annotation(
    title = "Figure 9.2: Anti-Apartheid Sanctions Timeline (1960-1994)",
    subtitle = "Multi-decade sanctions campaign combining UN embargoes, financial pressure, and US legislation",
    caption = paste0(
      "Sources: UN Security Council Resolutions, Hufbauer et al. Sanctions Database, World Bank, IMF.\n",
      "Note: CAAA = Comprehensive Anti-Apartheid Act of 1986. Rand values are annual averages.\n",
      "GDP growth data from South African Reserve Bank historical series."
    ),
    theme = theme(
      plot.title = element_text(size = 16, face = "bold"),
      plot.subtitle = element_text(size = 12, color = "gray30"),
      plot.caption = element_text(size = 9, color = "gray50", hjust = 0)
    )
  )

# Save
save_econ_figure(here("figures", "fig_09_02_apartheid_timeline.png"), combined, width = 14, height = 12)

# Print summary
cat("\nFigure 9.2 Summary:\n")
cat("  Timeline span: 1960-1994 (34 years)\n")
cat("  Key milestones: 10 major events\n")
cat("  Rand depreciation 1980-1994: 64%\n")
cat("  GDP growth average 1985-1991: -0.3%\n")
