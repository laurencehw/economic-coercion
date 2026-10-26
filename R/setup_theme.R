# Custom Theme for Economic Coercion Textbook Figures
# Author: Laurence Wilse-Samson
# Purpose: Consistent, professional styling for all visualizations

# Load required packages
library(ggplot2)
library(scales)

# House chart style (shared across the author's books): theme, palette, 6 in canvas.
source(here::here("R", "theme_book.R"))
has_viridis <- requireNamespace("viridis", quietly = TRUE)

# ============================================================================
# THEME
# ============================================================================

# The textbook theme is the house theme. Scripts that still pass a base_size
# get the house 9 pt base; titles and subtitles are carried by the chapter
# caption, so any that remain in a script are suppressed here.
theme_econ_textbook <- function(base_size = 9, base_family = NULL) {
  theme_lws(base_size = 9, base_family = base_family) +
    theme(plot.subtitle = element_blank())
}

# ============================================================================
# COLOR PALETTES
# ============================================================================

# Country/region colors: five hues at most, the rest in greys.
econ_colors <- c(
  "USA" = "#1B6CA8",            # blue
  "China" = "#C1292E",          # red
  "EU" = "#2D6A4F",             # green
  "Russia" = "#E07A2F",         # orange
  "Japan" = "#7B5EA7",          # purple
  "South Korea" = "#7F7F7F",
  "India" = "#D4A843",          # gold
  "UK" = "#9E9E9E",
  "Canada" = "#BDBDBD",
  "Australia" = "#595959",
  "Taiwan" = "#D4A843",
  "ASEAN" = "#BDBDBD",
  "Middle East" = "#BDBDBD",
  "Africa" = "#BDBDBD",
  "Latin America" = "#BDBDBD"
)

# Sector colors (five hues, then ink and grey)
sector_colors <- c(
  "Semiconductors" = "#1B6CA8",
  "Rare Earths" = "#E07A2F",
  "Energy" = "#2D6A4F",
  "Defense" = "#C1292E",
  "Telecommunications" = "#7B5EA7",
  "Financial Services" = "#1F2A37",
  "Pharmaceuticals" = "#D4A843",
  "Agriculture" = "#9E9E9E"
)

# Single-hue sequential ramps (light to dark)
econ_seq_blue <- c("#EAF1F8", "#C9DBEC", "#A3C3DE", "#78A6CC", "#4D89B9", "#1B6CA8", "#175A8C", "#124A73", "#0D3A5A")
econ_seq_red <- c("#FBEBEB", "#F4CBCC", "#EBA3A5", "#E0797C", "#D24F53", "#C1292E", "#A12226", "#821B1E", "#631417")
econ_seq_green <- c("#E9F2EE", "#C8DFD5", "#A0C8B7", "#76AF98", "#4C917A", "#2D6A4F", "#265A43", "#1F4A37", "#183A2B")

# Diverging colors around a true midpoint
econ_div_colors <- c("#C1292E", "#D4605F", "#E49A98", "#F1CCCA", "#F2F2F2", "#C6D9EA", "#8DB6D5", "#4F8FBF", "#1B6CA8")

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Function to save figures with consistent settings
# NOTE: For reliable path handling, callers should use here::here() to construct
# absolute paths, e.g.: save_econ_figure(here("figures", "fig_01_01_name.png"), ...)
# This ensures scripts work correctly from any working directory.
save_econ_figure <- function(filename, plot = last_plot(), width = 6, height = 4, dpi = 300) {
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

# Set the house theme as default
theme_set(theme_econ_textbook())
