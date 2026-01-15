# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Academic textbook on economic coercion and strategic competition, primarily focused on US-China relations. 10 chapters with data visualizations and tabletop exercises. Author: Laurence Wilse-Samson (NYU Wagner).

## Build Commands

```bash
# Generate all R figures
for f in R/figures/*.R; do Rscript "$f"; done

# Generate a single R figure
Rscript R/figures/fig_01_02_us_china_trade.R
```

**Prerequisites:** R (with ggplot2, dplyr, tidyr, scales, sf, patchwork), Pandoc, LaTeX

## Repository Structure

```
chapters/ch0X_*/       Chapter content (Markdown)
R/figures/             R scripts for visualizations
R/setup_theme.R        Shared ggplot2 theme
figures/               Output figures (PNG + PDF)
data/                  Datasets and sources
exercises/ch0X/        Tabletop exercises by chapter
front_matter/          Preface, bibliography, glossary
templates/             Chapter and content templates
```

## Figure Generation (R)

All visualizations use R/ggplot2 with a custom theme:

```r
source("R/setup_theme.R")  # Loads theme_econ_textbook() and color palettes
# ... create plot ...
save_econ_figure("figures/fig_XX_YY_name.png", width = 10, height = 6)
```

**Color palettes in setup_theme.R:**
- `econ_colors` — Country/region colors (USA blue, China red, EU green, etc.)
- `sector_colors` — Industry sector colors
- `scale_color_countries()` / `scale_fill_countries()` — Helper functions

**Maps:** Use `sf` and `rnaturalearth` packages. See `fig_03_04_chokepoints.R` as template.

## Conventions

- **Figure naming:** `fig_CC_NN_description.R` (CC = chapter, NN = figure number)
- **Output formats:** PNG (300 DPI) + PDF for each figure
- **Width:** 10 inches standard, 6 inches for single-column
- **Math in Markdown:** Use `$$...$$` on own lines for GitBook KaTeX compatibility
- **Citations:** Author-date format (Smith 2020)
