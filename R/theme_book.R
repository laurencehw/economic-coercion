# House style for ggplot2 figures (shared chart house style, October 2026).
#
#   source(here::here("R", "theme_book.R"))   # setup_theme.R does this for every figure script
#   p <- ggplot(...) + theme_lws() + scale_colour_lws()
#   save_book(p, here::here("figures", "fig_x.png"), height = 3.8)
#
# Figures are drawn at the printed width (6 in), 300 dpi, base 9 pt. The title belongs in the
# manuscript caption, not in the image; label panels "A. Short title" via labs(title = ...) or
# patchwork::plot_annotation(tag_levels = "A").
#

library(ggplot2)

lws_colors <- c(
  ink = "#1F2A37",
  green = "#2D6A4F", red = "#C1292E", blue = "#1B6CA8",
  orange = "#E07A2F", gold = "#D4A843", purple = "#7B5EA7",
  fade = "#BDBDBD", grid = "#E5E5E5", ref = "#BDBDBD", text = "#595959"
)
lws_hues <- unname(lws_colors[c("green", "red", "blue", "orange", "gold", "purple")])

lws_font <- function() {
  fams <- systemfonts::system_fonts()$family
  for (f in c("Arial", "Liberation Sans", "Helvetica")) if (f %in% fams) return(f)
  "sans"
}

lws_family <- tryCatch(lws_font(), error = function(e) "sans")

theme_lws <- function(base_size = 9, base_family = NULL) {
  if (is.null(base_family)) base_family <- tryCatch(lws_font(), error = function(e) "sans")
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      plot.title = element_text(face = "bold", size = rel(1.0), hjust = 0, colour = lws_colors[["ink"]],
                                margin = margin(b = 6)),
      plot.title.position = "plot",
      plot.subtitle = element_text(colour = lws_colors[["text"]], size = rel(0.95), hjust = 0, margin = margin(b = 10)),
      plot.caption = element_text(hjust = 0, size = rel(0.78), colour = lws_colors[["text"]], lineheight = 1.1,
                                  margin = margin(t = 8)),
      plot.caption.position = "plot",
      plot.margin = margin(10, 12, 10, 10),
      axis.title = element_text(size = rel(0.9), colour = lws_colors[["text"]]),
      axis.title.x = element_text(margin = margin(t = 6)),
      axis.title.y = element_text(margin = margin(r = 6)),
      axis.text = element_text(colour = lws_colors[["text"]], size = rel(0.85)),
      axis.ticks.x = element_line(colour = lws_colors[["ref"]], linewidth = 0.3),
      axis.ticks.y = element_blank(),
      axis.line = element_blank(),
      panel.grid.major.y = element_line(colour = lws_colors[["grid"]], linewidth = 0.4),
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "white", colour = NA),
      panel.border = element_blank(),
      legend.position = "top", legend.justification = "left",
      legend.title = element_blank(),
      legend.text = element_text(size = rel(0.85), colour = lws_colors[["text"]]),
      legend.background = element_blank(), legend.key = element_rect(fill = NA, colour = NA),
      legend.key.size = unit(0.9, "lines"), legend.margin = margin(0, 0, 6, 0),
      strip.background = element_blank(),
      strip.text = element_text(face = "bold", size = rel(0.9), hjust = 0, colour = lws_colors[["ink"]])
    )
}

scale_colour_lws <- function(...) scale_colour_manual(values = lws_hues, ...)
scale_color_lws <- scale_colour_lws
scale_fill_lws <- function(...) scale_fill_manual(values = lws_hues, ...)

# A reference line one step darker than the grid (zero lines, shock dates).
geom_ref_hline <- function(yintercept = 0, ...) geom_hline(yintercept = yintercept, colour = lws_colors[["ref"]], linewidth = 0.4, ...)
geom_ref_vline <- function(xintercept, ...) geom_vline(xintercept = xintercept, colour = lws_colors[["ref"]], linewidth = 0.4, linetype = "22", ...)

# Horizontal-bar variant: value gridlines run vertically, no category gridlines.
theme_book_h <- function(...) theme_lws(...) + theme(
  panel.grid.major.y = element_blank(),
  panel.grid.major.x = element_line(colour = lws_colors[["grid"]], linewidth = 0.4),
  axis.ticks.x = element_blank(), axis.ticks.y = element_blank())

# Text size for geom_text()/annotate(): mm, about 7.4 pt, legible at 6 in.
book_text_size <- 2.6

# Annotation text in the same family, size and ink as the rest of the figure.
update_geom_defaults("text", list(size = book_text_size, colour = lws_colors[["ink"]], family = lws_family))
update_geom_defaults("label", list(size = book_text_size, colour = lws_colors[["ink"]], family = lws_family))
if (requireNamespace("ggrepel", quietly = TRUE)) {
  update_geom_defaults(ggrepel::GeomTextRepel, list(size = book_text_size, colour = lws_colors[["ink"]], family = lws_family))
  update_geom_defaults(ggrepel::GeomLabelRepel, list(size = book_text_size, colour = lws_colors[["ink"]], family = lws_family))
}

# Source line at the bottom left, wrapped to the 6 in canvas (at most three lines).
book_source <- function(text, width = 105) {
  labs(caption = paste(strwrap(text, width = width), collapse = "\n"))
}

save_book <- function(plot, filename, width = 6, height = 3.8, dpi = 300) {
  ggsave(filename, plot, width = width, height = height, dpi = dpi, units = "in", bg = "white")
  pdf_filename <- sub("\\.(png|jpg)$", ".pdf", filename)
  ggsave(pdf_filename, plot, width = width, height = height, device = cairo_pdf, bg = "white")
  message("Figure saved: ", filename)
}
save_lws <- save_book
