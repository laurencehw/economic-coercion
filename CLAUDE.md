# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Academic textbook on economic coercion and strategic competition, primarily focused on US-China relations. Complete draft with 10 chapters, data visualizations, and tabletop exercises. Author: Laurence Wilse-Samson (NYU Wagner).

## Build Commands

```powershell
# Compile full textbook to PDF
./compile_improved_textbook.ps1

# Generate all R figures (runs each script)
Get-ChildItem R/figures/*.R | ForEach-Object { Rscript $_.FullName }

# Generate a single R figure
Rscript R/figures/fig_01_02_us_china_trade.R
```

**Prerequisites:** R (with ggplot2, dplyr, tidyr, scales, sf, patchwork), Pandoc, XeLaTeX (MiKTeX)

## Repository Structure

```
/chapters/ch0X_*/chapter_X.md  - Main chapter content (Markdown for GitBook/Pandoc)
/R/figures/fig_XX_YY_*.R       - R scripts for data visualizations
/R/setup_theme.R               - Shared ggplot2 theme (source this first)
/figures/                      - Python figure scripts (legacy, superseded by R)
/data/                         - Datasets and sources
/exercises/ch0X/               - Tabletop exercises by chapter
/front_matter/                 - Preface, bibliography, glossary
/docs/                         - Planning documents and migration status
```

## Figure Generation (R)

All visualizations use R/ggplot2 with a custom theme. Key pattern:

```r
source("R/setup_theme.R")  # Loads theme_econ_textbook() and color palettes
# ... create plot ...
save_econ_figure("figures/fig_XX_YY_name.png", width = 10, height = 6)  # Saves PNG + PDF
```

**Color palettes defined in setup_theme.R:**
- `econ_colors` - Country/region colors (USA blue, China red, EU green, etc.)
- `sector_colors` - Industry sector colors
- `scale_color_countries()` / `scale_fill_countries()` - Helper functions

**Maps:** Use `sf` and `rnaturalearth` packages. See `fig_03_04_chokepoints.R` as template.

## Key Conventions

- **Figure naming:** `fig_CC_NN_description.R` (CC = chapter, NN = figure number)
- **Output formats:** PNG (300 DPI) + PDF for each figure
- **Width:** 10 inches standard, 6 inches for single-column
- **Math in Markdown:** Use `$$...$$` on own lines for GitBook KaTeX compatibility
- **Citations:** Author-date format (Smith 2020)

## Current Status

- 20 core figures + 4 geographic maps complete (R migration done)
- Python figure scripts in `/figures/` are legacy - prefer R versions
- See `docs/R_MIGRATION_MASTER_STATUS.md` for detailed figure inventory
- See `docs/VISUALIZATION_PLAN.md` for remaining planned visualizations (~70-80 total)
