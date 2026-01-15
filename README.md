# Economic Coercion: A Handbook of Strategic Competition

[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)

**Author:** Laurence Wilse-Samson (NYU Wagner)

A comprehensive textbook examining economic coercion in the context of strategic competition, with primary focus on US-China rivalry and applications to other geographies including the Cold War and contemporary cases.

## Overview

This book combines academic rigor with practical policy relevance, serving three audiences:

- **Policymakers and practitioners** — Practical reference for understanding tools and strategies
- **Students and educators** — Comprehensive textbook with exercises and teaching materials
- **Analysts and researchers** — Data sources, case studies, and analytical frameworks

## Contents

| Part | Chapters |
|------|----------|
| **I. Foundations** | Ch 1: The Return of Geoeconomics |
| **II. Strategic Terrain** | Ch 2: Global Supply Chains and Critical Infrastructure<br>Ch 3: Critical Sectors — Food, Energy, and Minerals<br>Ch 4: High Technology Competition |
| **III. Information Domain** | Ch 5: Information, Cyber, and Intelligence |
| **IV. Tools of Economic Coercion** | Ch 6: Trade Controls — Tariffs, Quotas, and Export Controls<br>Ch 7: Financial Statecraft and Sanctions<br>Ch 8: Investment Screening, Industrial Policy, and Strategic Assets |
| **V. Context and Future** | Ch 9: Historical Cases and Contemporary Applications<br>Ch 10: The Future of Economic Coercion |

## Features

Each chapter includes:

- **Executive Summary** — Practitioner-focused key takeaways
- **Government Tools Boxes** — Detailed authorities, mechanisms, and examples
- **Perspective Boxes** — Chinese and other international viewpoints
- **Case Studies** — Real-world applications with lessons learned
- **Tabletop Exercises** — Scenario-based learning activities
- **Data Sources** — Guide to relevant databases and tracking tools

## Repository Structure

```
chapters/           Main chapter content (Markdown)
figures/            Data visualizations (PNG + PDF)
R/                  R scripts for figure generation
data/               Datasets and sources
exercises/          Tabletop exercises by chapter
front_matter/       Preface, glossary, bibliography
templates/          Chapter and content templates
```

## Building

**Prerequisites:** R (with ggplot2, dplyr, tidyr, scales, sf, patchwork), Pandoc, LaTeX

```bash
# Generate all R figures
for f in R/figures/*.R; do Rscript "$f"; done

# Or use PowerShell on Windows
Get-ChildItem R/figures/*.R | ForEach-Object { Rscript $_.FullName }
```

## License

This work is licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/). See [LICENSE](LICENSE) for details.

## Contact

For questions, suggestions, or collaboration inquiries, please open an issue on GitHub.
