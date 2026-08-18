# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Academic textbook on economic coercion and strategic competition, primarily focused on US-China relations. 10 chapters with data visualizations and tabletop exercises. Author: Laurence Wilse-Samson (Columbia SIPA).

## Build Commands

```bash
# Generate all R figures
for f in R/figures/*.R; do Rscript "$f"; done

# Generate a single R figure
Rscript R/figures/fig_01_02_us_china_trade.R
```

```bash
# Run the manuscript QA checks (figure alignment, share-table sums, link integrity)
python3 scripts/qa_manuscript.py
```

**Prerequisites:** R, Pandoc, LaTeX.

R packages, by what they unlock (49 of the 61 figure scripts build with the first
group alone):

- **Core** (needed by nearly every script): `tidyverse`, `ggplot2`, `dplyr`, `tidyr`,
  `scales`, `forcats`, `patchwork`, `here`
- **Extras**: `ggforce` (framework/toolbox/cascade/decision-tree diagrams),
  `ggraph` + `igraph` (interdependence network), `ggalluvial` (Sankey/flow charts),
  `ggrepel`, `viridis`, `cowplot`, `gridExtra`
- **Maps and specialty** (12 scripts): `sf`, `tmap`, `rnaturalearth`,
  `rnaturalearthdata`, `treemapify`. All are on CRAN — the pipeline no longer has
  any GitHub-only dependency

On Debian/Ubuntu most of these install far faster from apt binaries
(`r-cran-tidyverse`, `r-cran-sf`, `r-cran-ggforce`, …) than from source.

## Repository Structure

```
chapters/              Chapter content (Markdown, 10 chapters)
front_matter/          Preface, bibliography, glossary
appendices/            Appendix A (tabletop exercises)
figures/               Output figures (PNG + PDF)
R/figures/             R scripts for visualizations
R/setup_theme.R        Shared ggplot2 theme
data/                  Datasets and sources
exercises/ch0X/        Original exercise files by chapter
editorial_review/      Editorial reviews and citation audits
templates/             Chapter and content templates
SUMMARY.md             GitBook table of contents
book.json              GitBook configuration
INTRODUCTION.md        Book landing page (GitBook home)
```

The book is deployed via GitBook web (GitHub sync). `.gitbook.yaml` points to the repo root.

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
