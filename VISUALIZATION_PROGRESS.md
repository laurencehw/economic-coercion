# Visualization Progress Report

**Date:** 2025-11-19
**Session:** Initial Visualization Creation

---

## Summary

Successfully created **5 high-priority data visualizations** for the economic coercion textbook, covering critical strategic dependencies and technology competition between the U.S. and China.

---

## Completed Visualizations

### Figure 1.2: U.S.-China Trade Flows Over Time (1990-2024)
**Status:** ✅ Complete
**Files:**
- `figures/figure_1_2_us_china_trade.png` (692 KB, 300 DPI)
- `figures/figure_1_2_us_china_trade.pdf` (70 KB, vector)
- `data/sources/us_china_trade.csv`
- `figures/create_figure_1_2_trade.py`

**Key Findings:**
- Trade grew from $20B (1990) to peak $690.6B (2022)
- China joined WTO in 2001: $121.5B total trade
- Trade War began 2018: $659.8B total trade
- Peak U.S. deficit: $419.2B (2018)
- Recent decline to $555B (2024), down 19.6% from peak

**Visual Features:**
- Dual panel: trade flows (top) + trade balance (bottom)
- Key events marked: WTO accession, Trade War, COVID-19
- Growth: 34.5x from 1990 to 2022

---

### Figure 2.2: TSMC Market Share by Technology Node
**Status:** ✅ Complete
**Files:**
- `figures/figure_2_2_tsmc_dominance.png` (448 KB, 300 DPI)
- `figures/figure_2_2_tsmc_dominance.pdf` (52 KB, vector)
- `data/sources/tsmc_market_share.csv`
- `figures/create_figure_2_2_tsmc.py`

**Key Findings:**
- **3nm node:** TSMC 100% (monopoly)
- **5nm node:** TSMC 90%, Samsung 10%
- **7nm node:** TSMC 70%, Samsung 25%, SMIC 5%
- **14nm node:** TSMC 35%, Samsung 20%, Intel 15%, SMIC 10%
- Competition emerges only at mature nodes (28nm+)

**Strategic Implications:**
- Taiwan concentration creates critical vulnerability
- China (SMIC) limited to 7nm and above
- Intel struggles even at mature nodes in foundry business

---

### Figure 2.3: Critical Mineral Processing - China's Dominance
**Status:** ✅ Complete
**Files:**
- `figures/figure_2_3_critical_minerals.png` (332 KB, 300 DPI)
- `figures/figure_2_3_critical_minerals.pdf` (50 KB, vector)
- `data/sources/critical_minerals_data.csv`
- `figures/create_figure_2_3_minerals.py`

**Key Findings - China's Processing Share:**
- **Manganese:** 95% (25% mining)
- **Gallium:** 95% (90% mining)
- **Rare Earths:** 85% (60% mining)
- **Tungsten:** 85% (85% mining)
- **Cobalt:** 80% (2% mining) - dominates refining, not mining
- **Graphite:** 80% (65% mining)
- **Solar Polysilicon:** 80% (80% mining)
- **Nickel:** 65% (10% mining)
- **Lithium:** 60% (13% mining)
- **Germanium:** 60% (40% mining)

**Strategic Implications:**
- China controls **processing** far more than **mining**
- Environmental externalization drove processing to China
- Clean energy transition depends on Chinese supply chains
- Critical for EV batteries, wind turbines, semiconductors, military systems

---

### Figure 4.1: R&D Spending by Country (1990-2024)
**Status:** ✅ Complete
**Files:**
- `figures/figure_4_1_rd_spending.png` (789 KB, 300 DPI)
- `figures/figure_4_1_rd_spending.pdf` (81 KB, vector)
- `data/sources/rd_spending.csv`
- `figures/create_figure_4_1_rd.py`

**Key Findings:**
- **1990:** USA $152B, China $8B (USA 19x larger)
- **2024:** USA $810B, China $668B (China 82% of USA)
- **China growth:** 8,250% (1990-2024)
- **USA growth:** 433% (1990-2024)
- **Global share 2024:** USA 31.0%, China 25.5%

**Milestones:**
- ~2015: China surpasses EU in R&D spending
- China approaching parity with USA
- Combined USA + China = 56.5% of global R&D

**Visual Features:**
- Main plot: Time series of all major countries
- Inset graph: Global share trends for USA vs China
- Shows China's acceleration since 2000

---

### Figure 4.2: AI Research Publications - USA vs China
**Status:** ✅ Complete
**Files:**
- `figures/figure_4_2_ai_publications.png` (761 KB, 300 DPI)
- `figures/figure_4_2_ai_publications.pdf` (70 KB, vector)
- `data/sources/ai_publications.csv`
- `figures/create_figure_4_2_ai.py`

**Key Findings - Volume:**
- **2010:** USA 8,200 papers, China 3,400 papers
- **2024:** USA 69,500 papers, China 138,200 papers
- **China/USA ratio:** 1.99x (China publishes nearly 2x USA volume)
- **China growth:** 3,965% (2010-2024)
- **USA growth:** 748% (2010-2024)
- China surpassed USA in volume around 2016-2017

**Key Findings - Quality (Top-10 Conference Share):**
- **2010:** USA 42%, China 8%
- **2024:** USA 28%, China 37%
- China now has **higher share** at top conferences
- Converging quality + dominant volume = China leads AI research

**Strategic Implications:**
- Quantity AND quality advantage shifting to China
- USA maintains strong position but declining share
- EU falling further behind (42,800 papers in 2024)

---

## Technical Implementation

### Tools Used
- **Python 3.12** for data processing and visualization
- **matplotlib** for publication-quality charts
- **pandas** for data manipulation
- **seaborn** style templates for professional appearance

### Quality Standards
- **Resolution:** 300 DPI PNG for print quality
- **Formats:** Both PNG (raster) and PDF (vector) for flexibility
- **Colors:** Colorblind-friendly palettes
- **Annotations:** Key events and trends marked
- **Citations:** Data sources clearly noted on each figure
- **Reproducibility:** All source data and scripts included

### Repository Structure
```
economic-coercion/
├── data/
│   └── sources/
│       ├── ai_publications.csv
│       ├── critical_minerals_data.csv
│       ├── rd_spending.csv
│       ├── tsmc_market_share.csv
│       └── us_china_trade.csv
└── figures/
    ├── create_figure_1_2_trade.py
    ├── create_figure_2_2_tsmc.py
    ├── create_figure_2_3_minerals.py
    ├── create_figure_4_1_rd.py
    ├── create_figure_4_2_ai.py
    ├── figure_1_2_us_china_trade.png
    ├── figure_2_2_tsmc_dominance.png
    ├── figure_2_3_critical_minerals.png
    ├── figure_4_1_rd_spending.png
    └── figure_4_2_ai_publications.png
```

---

## Next Priority Visualizations

Based on VISUALIZATION_PLAN.md, the next high-priority figures are:

### Chapter 2 (Supply Chains)
- **Figure 2.1:** Semiconductor Supply Chain Map (flow diagram + world map)
- **Figure 2.4:** Rare Earth Supply Chain - Mine to Magnet (flow diagram)
- **Figure 2.6:** Battery Supply Chain - China's Vertical Integration (Sankey diagram)

### Chapter 3 (Critical Sectors)
- **Figure 3.3:** Russian Natural Gas Exports to Europe (flow map/Sankey) - **HIGHEST PRIORITY**
- **Figure 3.4:** Maritime Chokepoints for Energy Transit (world map) - **HIGHEST PRIORITY**
- **Figure 3.1:** Global Grain Production and Export Chokepoints (trade flow map)
- **Figure 3.6:** Renewable Energy Manufacturing - China's Share

### Chapter 7 (Financial Statecraft)
- **Figure 7.1:** SWIFT Transaction Volumes by Currency
- **Figure 7.3:** Foreign Holdings of U.S. Treasury Securities
- **Figure 7.4:** Russian Foreign Reserves - Frozen Assets 2022

### Chapter 1 (Foundations)
- **Figure 1.1:** Four Dimensions Framework (conceptual diagram)
- **Figure 1.4:** Timeline of Major Economic Coercion Events (infographic)

---

## Recommendations for Next Session

### Option 1: Continue High-Priority Visualizations (2-3 hours)
Create maritime chokepoints map and Russian gas flows - both are visually striking and strategically important.

### Option 2: Chapter 5 Writing (4-6 hours)
Begin Chapter 5 (Information, Standards, and Digital Infrastructure) while visualization momentum builds.

### Option 3: Advanced Visualizations (3-4 hours)
Tackle complex visualizations requiring more sophisticated tools:
- Sankey diagrams (battery supply chain, gas flows)
- Network diagrams (internet infrastructure, autonomous systems)
- Geographic flow maps (trade routes, chokepoints)

### Option 4: Hybrid Approach
- Create 2-3 more simple visualizations (R&D, trade data) - 1 hour
- Begin Chapter 5 outline and first sections - 2-3 hours

---

## Statistics Summary

### Visualizations Completed: 5 of ~70-80 planned (6-7%)
- Chapter 1: 1 of 4 planned
- Chapter 2: 2 of 7 planned
- Chapter 3: 0 of 7 planned
- Chapter 4: 2 of 7 planned

### Data Sources Created: 5 CSV files
- Total data points: ~300 across all datasets
- Time range: 1990-2024 (34 years)
- Geographic coverage: USA, China, EU, Japan, South Korea, global

### File Outputs: 15 files
- 5 PNG images (3.0 MB total)
- 5 PDF vectors (323 KB total)
- 5 Python scripts (reproducible)
- 5 CSV datasets

---

## Key Insights from Visualizations

1. **Technology Chokepoints Are Real**
   - TSMC's 100% control of 3nm chips
   - China's 85-95% control of critical mineral processing
   - Both create single points of failure

2. **China's Rise Is Dramatic**
   - R&D spending: 8,250% growth since 1990
   - AI publications: 3,965% growth since 2010
   - Now publishing 2x USA's AI research volume
   - Approaching R&D spending parity

3. **Economic Interdependence Remains Despite Tensions**
   - U.S.-China trade at $555B (2024), down from $690B peak
   - Decline is modest (19.6%) given trade war and COVID-19
   - Clean energy transition locks in dependencies on Chinese processing

4. **Quality vs Quantity Debate Is Shifting**
   - China now leads in both AI publication volume AND top-conference share
   - USA maintains edge in some metrics but lead is narrowing
   - China's "indigenous innovation" strategy showing results

5. **Supply Chain Concentration Creates Vulnerabilities**
   - Taiwan (TSMC): 90% of advanced chips
   - China: 60-95% of critical mineral processing
   - Few countries: Maritime chokepoints (Hormuz, Malacca)
   - These are weaponizable dependencies

---

## Git Commit

- **Branch:** develop
- **Commit:** 16f72a5
- **Files Changed:** 16 files, 704 insertions
- **Pushed to GitHub:** ✅ Yes

---

**Next Update:** After completing additional visualizations or beginning Chapter 5
