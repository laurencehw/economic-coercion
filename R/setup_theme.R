# Custom Theme for Economic Coercion Textbook Figures
# Author: Laurence Wilse-Samson
# Purpose: Consistent, professional styling for all visualizations

# Load required packages
library(ggplot2)
library(scales)

# Check and load optional packages
has_hrbrthemes <- requireNamespace("hrbrthemes", quietly = TRUE)
has_extrafont <- requireNamespace("extrafont", quietly = TRUE)
has_viridis <- requireNamespace("viridis", quietly = TRUE)

if (has_hrbrthemes) library(hrbrthemes)
if (has_extrafont) library(extrafont)
if (has_viridis) library(viridis)

# ============================================================================
# CUSTOM THEME DEFINITION
# ============================================================================

theme_econ_textbook <- function(base_size = 12, base_family = "sans") {
  
  # Base theme selection
  if (has_hrbrthemes) {
    t <- theme_ipsum(base_size = base_size, base_family = base_family)
  } else {
    # Fallback to theme_minimal if hrbrthemes is missing
    t <- theme_minimal(base_size = base_size, base_family = base_family)
  }
  
  t +
    theme(
      # Plot titles
      plot.title = element_text(
        size = base_size + 4,
        face = "bold",
        hjust = 0,
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        size = base_size,
        color = "gray30",
        hjust = 0,
        margin = margin(b = 15)
      ),
      plot.caption = element_text(
        size = base_size - 2,
        color = "gray50",
        hjust = 0,
        margin = margin(t = 10)
      ),

      # Axes
      axis.title = element_text(
        size = base_size,
        face = "bold",
        color = "gray20"
      ),
      axis.title.x = element_text(margin = margin(t = 10)),
      axis.title.y = element_text(margin = margin(r = 10)),
      axis.text = element_text(
        size = base_size - 1,
        color = "gray30"
      ),
      axis.line = element_line(color = "gray50", linewidth = 0.5),
      axis.ticks = element_line(color = "gray50", linewidth = 0.5),

      # Grid
      panel.grid.major = element_line(color = "gray85", linewidth = 0.5),
      panel.grid.minor = element_line(color = "gray90", linewidth = 0.25),
      panel.background = element_rect(fill = "white", color = NA),

      # Legend
      legend.title = element_text(
        size = base_size,
        face = "bold",
        color = "gray20"
      ),
      legend.text = element_text(
        size = base_size - 1,
        color = "gray30"
      ),
      legend.position = "bottom",
      legend.box = "horizontal",
      legend.background = element_rect(fill = "white", color = NA),
      legend.key = element_rect(fill = "white", color = NA),
      legend.spacing.x = unit(0.5, "cm"),

      # Facets
      strip.background = element_rect(fill = "gray90", color = NA),
      strip.text = element_text(
        size = base_size,
        face = "bold",
        color = "gray20",
        margin = margin(5, 5, 5, 5)
      ),

      # Overall plot
      plot.background = element_rect(fill = "white", color = NA),
      plot.margin = margin(15, 15, 15, 15)
    )
}

# ============================================================================
# COLOR PALETTES
# ============================================================================

# Primary country/region colors
econ_colors <- c(
  "USA" = "#1f77b4",           # Blue
  "China" = "#d62728",          # Red
  "EU" = "#2ca02c",             # Green
  "Russia" = "#ff7f0e",         # Orange
  "Japan" = "#9467bd",          # Purple
  "South Korea" = "#8c564b",    # Brown
  "India" = "#e377c2",          # Pink
  "UK" = "#7f7f7f",             # Gray
  "Canada" = "#bcbd22",         # Yellow-green
  "Australia" = "#17becf",      # Cyan
  "Taiwan" = "#aec7e8",         # Light blue
  "ASEAN" = "#ffbb78",          # Light orange
  "Middle East" = "#98df8a",    # Light green
  "Africa" = "#ff9896",         # Light red
  "Latin America" = "#c5b0d5"   # Light purple
)

# Sector colors
sector_colors <- c(
  "Semiconductors" = "#1f77b4",
  "Rare Earths" = "#ff7f0e",
  "Energy" = "#2ca02c",
  "Defense" = "#d62728",
  "Telecommunications" = "#9467bd",
  "Financial Services" = "#8c564b",
  "Pharmaceuticals" = "#e377c2",
  "Agriculture" = "#7f7f7f"
)

# Sequential color scales for continuous data
econ_seq_blue <- c("#f7fbff", "#deebf7", "#c6dbef", "#9ecae1", "#6baed6", "#4292c6", "#2171b5", "#08519c", "#08306b")
econ_seq_red <- c("#fff5f0", "#fee0d2", "#fcbba1", "#fc9272", "#fb6a4a", "#ef3b2c", "#cb181d", "#a50f15", "#67000d")
econ_seq_green <- c("#f7fcf5", "#e5f5e0", "#c7e9c0", "#a1d99b", "#74c476", "#41ab5d", "#238b45", "#006d2c", "#00441b")

# Diverging color scale for positive/negative values
econ_div_colors <- c("#d73027", "#f46d43", "#fdae61", "#fee090", "#ffffbf", "#e0f3f8", "#abd9e9", "#74add1", "#4575b4")

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Function to save figures with consistent settings
# NOTE: For reliable path handling, callers should use here::here() to construct
# absolute paths, e.g.: save_econ_figure(here("figures", "fig_01_01_name.png"), ...)
# This ensures scripts work correctly from any working directory.
save_econ_figure <- function(filename, plot = last_plot(), width = 10, height = 6, dpi = 300) {
  ggsave(
    filename = filename,
    plot = plot,
    width = width,
    height = height,
    dpi = dpi,
    bg = "white"
  )

  # Also save as PDF for LaTeX
  pdf_filename <- sub("\\.(png|jpg)$", ".pdf", filename)
  ggsave(
    filename = pdf_filename,
    plot = plot,
    width = width,
    height = height,
    device = cairo_pdf,
    bg = "white"
  )

  message("Figure saved: ", filename, " and ", pdf_filename)
}

# Function to format large numbers with proper separators
format_millions <- function(x) {
  paste0("$", comma(x / 1e6), "M")
}

format_billions <- function(x) {
  paste0("$", comma(x / 1e9), "B")
}

format_trillions <- function(x) {
  paste0("$", comma(x / 1e12), "T")
}

# Function to add source note to plots
add_source_note <- function(source_text) {
  labs(caption = paste0("Source: ", source_text))
}

# Function to apply consistent country colors
scale_color_countries <- function() {
  scale_color_manual(values = econ_colors, name = "Country/Region")
}

scale_fill_countries <- function() {
  scale_fill_manual(values = econ_colors, name = "Country/Region")
}

# Function to apply sector colors
scale_color_sectors <- function() {
  scale_color_manual(values = sector_colors, name = "Sector")
}

scale_fill_sectors <- function() {
  scale_fill_manual(values = sector_colors, name = "Sector")
}

# ============================================================================
# SET DEFAULT THEME
# ============================================================================

# Set the custom theme as default for all plots
theme_set(theme_econ_textbook())

# Set default discrete color scale
options(
  ggplot2.discrete.colour = econ_colors,
  ggplot2.discrete.fill = econ_colors
)

# ============================================================================
# PRINT CONFIRMATION
# ============================================================================

cat("\n")
cat("========================================\n")
cat("  Economic Coercion Textbook Theme\n")
cat("========================================\n")
if (has_hrbrthemes) {
  cat("Status: hrbrthemes loaded successfully.\n")
} else {
  cat("Status: hrbrthemes NOT found. Using fallback theme.\n")
}
cat("========================================\n")
cat("\n")
