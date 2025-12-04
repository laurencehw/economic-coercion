# Economic Coercion: A Handbook of Strategic Competition

**Author:** Laurence Wilse-Samson
**Repository:** https://github.com/laurencehw/economic-coercion
**Status:** Complete Draft

## Overview

This comprehensive textbook examines economic coercion by states in the context of strategic competition, with primary focus on US-China rivalry and applications to other geographies including US-Soviet Cold War cases and contemporary examples. The book combines academic rigor with practical policy relevance.

## Purpose

This book serves three audiences:
1. **Policymakers and practitioners** - Practical reference for understanding tools and strategies
2. **Students and educators** - Comprehensive textbook with exercises and teaching materials
3. **Analysts and researchers** - Data sources, case studies, and analytical frameworks

## Structure

### Part I: Foundations
- **Chapter 1:** The Return of Geoeconomics

### Part II: Strategic Terrain
- **Chapter 2:** Global Supply Chains and Critical Infrastructure
- **Chapter 3:** Critical Sectors - Food, Energy, and Minerals
- **Chapter 4:** High Technology Competition

### Part III: The Information Domain
- **Chapter 5:** Information, Cyber, and Intelligence

### Part IV: Tools of Economic Coercion
- **Chapter 6:** Trade Controls - Tariffs, Quotas, and Export Controls
- **Chapter 7:** Financial Statecraft and Sanctions
- **Chapter 8:** Investment Screening, Industrial Policy, and Strategic Assets

### Part V: Context and Future
- **Chapter 9:** Historical Cases and Contemporary Applications
- **Chapter 10:** The Future of Economic Coercion

## Special Features

Each chapter includes:
- **Executive Summary** - Practitioner-focused key takeaways
- **Government Tools Boxes** - Detailed authorities, mechanisms, and examples
- **Perspective Boxes** - Chinese and other international viewpoints
- **Maps and Data Visualizations** - Strategic geography and trends
- **Case Studies** - Real-world applications with lessons learned
- **Tabletop Exercises** - Practical scenario-based learning
- **Data Sources** - Comprehensive guide to databases and tracking tools
- **References & Further Reading** - Curated bibliography

## Repository Organization

```
/chapters              - Main chapter content (Markdown)
  /ch01_foundations
  /ch02_supply_chains
  /ch03_critical_sectors
  /ch04_high_tech
  /ch05_information
  /ch06_trade_controls
  /ch07_financial_statecraft
  /ch08_investment_industrial
  /ch09_historical_cases
  /ch10_future
/figures               - All visualizations (PDF and PNG)
  /maps                - Geographic visualizations
  /charts              - Data charts and graphs
  /diagrams            - Conceptual diagrams
/R                     - R scripts for figure generation
  /figures             - Individual figure scripts
  setup_theme.R        - Consistent styling theme
/data                  - Datasets and sources
/references            - Bibliography and key documents
/exercises             - Tabletop exercises by chapter
/front_matter          - Title page, preface, TOC
```

## Building the Book

### Prerequisites
- R (with ggplot2, dplyr, tidyr, scales, sf packages)
- Pandoc
- LaTeX distribution (for PDF output)

### Compilation
```powershell
# Generate all figures
Rscript R/figures/fig_*.R

# Compile full textbook to PDF
./compile_improved_textbook.ps1
```

## Output

The compiled textbook is available as:
- `Economic_Coercion_Complete_Textbook.pdf` - Full textbook with all chapters and figures

## Contributing

This is primarily a single-author project, but feedback and suggestions are welcome via Issues.

## License

Copyright © 2025 Laurence Wilse-Samson. All rights reserved.

## Contact

For questions or collaboration inquiries, please open an issue on GitHub.

---

**Last Updated:** 2025-11-29
