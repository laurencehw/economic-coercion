# Visualization Progress Report

**Date:** 2025-11-19
**Session:** Initial Visualization Creation + Revision for Clarity

---

## Summary

Successfully created **5 high-priority data visualizations** for the economic coercion textbook, covering critical strategic dependencies and technology competition between the U.S. and China.

**Revision Session (2025-11-19):** Cleaned up 4 figures to eliminate overlapping legends, simplify annotations, and improve visual clarity based on feedback.

---

## Completed Visualizations

### Figure 1.2: U.S.-China Trade Flows Over Time (1990-2024)
**Status:** ✅ Complete (Revised for clarity)
**Files:**
- `figures/figure_1_2_us_china_trade.png` (300 DPI)
- `figures/figure_1_2_us_china_trade.pdf` (vector)
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

**Revisions:**
- Simplified event annotations (removed yellow boxes with arrows)
- Moved statistics box to bottom right to avoid legend overlap
- Removed red shaded region for cleaner look
- Simplified peak deficit annotation

---

### Figure 2.2: TSMC Market Share by Technology Node
**Status:** ✅ Complete (Revised for clarity)
**Files:**
- `figures/figure_2_2_tsmc_dominance.png` (300 DPI)
- `figures/figure_2_2_tsmc_dominance.pdf` (vector)
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

**Revisions:**
- Reduced bar width from 0.6 to 0.5 for cleaner spacing
- Moved legend to upper right to avoid bar overlap
- Simplified annotations (removed multiple callout boxes)
- Removed strategic implications text box for cleaner design

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
**Status:** ✅ Complete (Revised for clarity)
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
- Main plot: Time series of USA, China, and EU only
- Inset graph: Global share trends for USA vs China
- Shows China's acceleration since 2000

**Revisions:**
- Removed Japan and South Korea for cleaner focus on main competitors
- Simplified annotations (removed yellow boxes)
- Increased line width for better visibility
- Simplified statistics box

---

### Figure 4.2: AI Research Publications - USA vs China
**Status:** ✅ Complete (Revised for clarity)
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

**Revisions:**
- Simplified crossover annotation (removed yellow box)
- Moved statistics box to lower right to avoid legend overlap
- Removed shaded regions and quality note box for cleaner look
- Simplified all annotations

---

### Figure 7.1: SWIFT Transaction Volumes by Currency
**Status:** ✅ Complete
**Files:**
- `figures/figure_7_1_swift_currencies.png` (300 DPI)
- `figures/figure_7_1_swift_currencies.pdf` (vector)
- `data/sources/swift_currency_data.csv`
- `figures/create_figure_7_1_swift.py`

**Key Findings:**
- **USD share:** 38.0% (2024) - down from 42.5% (2010)
- **EUR share:** 37.2% (2024) - up from 32.8% (2010)
- **CNY share:** 5.5% (2024) - up from 0.3% (2010)
- **CNY growth:** 1,733% increase over 14 years

**Visual Features:**
- Left panel: Time series (2010-2024) showing all major currencies
- Right panel: 2024 pie chart breakdown
- Clean design with simple annotations

**Strategic Implications:**
- USD maintains dominance but gradual decline
- EUR approaching parity with USD
- CNY rapid growth but still far from challenging USD/EUR
- SWIFT system remains Western-dominated

---

### Figure 7.3: Foreign Holdings of U.S. Treasury Securities
**Status:** ✅ Complete
**Files:**
- `figures/figure_7_3_treasury_holdings.png` (300 DPI)
- `figures/figure_7_3_treasury_holdings.pdf` (vector)
- `data/sources/us_treasury_holdings.csv`
- `figures/create_figure_7_3_treasuries.py`

**Key Findings:**
- **China peak:** $1,269B (2014)
- **China 2024:** $776B (down 38.9%)
- **Japan 2024:** $1,115B (largest holder)
- **UK 2024:** $735B (up from $43B in 2000)
- **Total foreign holdings:** $6,560B (2024)

**Visual Features:**
- Stacked area chart showing composition over time
- Highlights China's peak and decline
- Shows rise of European financial centers (UK, Ireland, Luxembourg)

**Strategic Implications:**
- China reducing exposure to U.S. Treasuries (de-dollarization)
- Japan maintains steady position as top holder
- UK and European centers increasing holdings
- Still massive global demand for U.S. debt

---

### Figure 7.4: Russian Assets Frozen by Western Sanctions (2022)
**Status:** ✅ Complete
**Files:**
- `figures/figure_7_4_russian_frozen_assets.png` (300 DPI)
- `figures/figure_7_4_russian_frozen_assets.pdf` (vector)
- `data/sources/russian_frozen_assets_2022.csv`
- `figures/create_figure_7_4_frozen_assets.py`

**Key Findings:**
- **Total frozen:** $370.3B
- **Foreign reserves:** $256.0B (~55% of Russia's total)
- **Oligarch assets:** $88.5B
- **State assets:** $25.8B
- **Largest holder:** Eurozone central banks ($185.5B)

**Visual Features:**
- Left panel: Assets by category (reserves, oligarchs, state)
- Right panel: Foreign reserves by jurisdiction
- Dual horizontal bar charts for easy comparison

**Strategic Implications:**
- Unprecedented use of financial coercion
- Eurozone holds majority of frozen reserves
- Demonstrates Western control of global financial system
- Raises questions about "safety" of dollar/euro reserves

---

### Figure 3.6: Renewable Energy Manufacturing - China's Dominance
**Status:** ✅ Complete
**Files:**
- `figures/figure_3_6_renewable_manufacturing.png` (300 DPI)
- `figures/figure_3_6_renewable_manufacturing.pdf` (vector)
- `data/sources/renewable_energy_manufacturing.csv`
- `figures/create_figure_3_6_renewables.py`

**Key Findings:**
- **Average China share:** 73% across 7 clean energy technologies
- **Rare Earth Magnets:** 90% (critical for wind turbines, EVs)
- **Solar Panels:** 80%
- **Solar Polysilicon:** 80%
- **EV Batteries:** 75%
- **Wind Turbines:** 60%

**Visual Features:**
- Horizontal stacked bar chart showing global market share
- Seven critical clean energy technologies
- Clear color coding by region

**Strategic Implications:**
- China dominates every key clean energy technology
- Global energy transition dependent on Chinese manufacturing
- Creates leverage similar to oil/gas dependencies
- Western countries locked into Chinese supply chains

---

### Figure 6.1: U.S. Tariffs on Chinese Goods (2015-2024)
**Status:** ✅ Complete
**Files:**
- `figures/figure_6_1_us_china_tariffs.png` (300 DPI)
- `figures/figure_6_1_us_china_tariffs.pdf` (vector)
- `data/sources/us_china_tariffs.csv`
- `figures/create_figure_6_1_tariffs.py`

**Key Findings:**
- **2017 (Pre-trade war):** 3.1% average tariff
- **2024 (Current):** 19.8% average tariff
- **Increase:** 539% (6x higher)
- **Goods affected:** $570B worth of Chinese imports

**Visual Features:**
- Bar chart showing tariff rate over time
- Color coded: green (pre-2018), red (post-2018)
- Marks key events (Trade War, Biden continuation)

**Strategic Implications:**
- Dramatic escalation starting 2018
- Biden maintained Trump tariffs
- Bipartisan consensus on China trade policy
- $570B in goods subject to elevated tariffs

---

### Figure 6.3: U.S. Entity List Additions - Chinese Entities (2015-2024)
**Status:** ✅ Complete
**Files:**
- `figures/figure_6_3_entity_list_additions.png` (300 DPI)
- `figures/figure_6_3_entity_list_additions.pdf` (vector)
- `data/sources/entity_list_additions.csv`
- `figures/create_figure_6_3_entity_list.py`

**Key Findings:**
- **2015:** 15 entities added
- **2024:** 275 entities added (18x increase)
- **Total 2015-2024:** 1,362 Chinese entities added
- **Top category 2024:** Semiconductors (75 entities)
- **Fastest growing:** AI/Computing (62 entities in 2024)

**Visual Features:**
- Left panel: Stacked area chart by sector
- Right panel: Annual total additions
- Six categories tracked

**Strategic Implications:**
- Massive acceleration of export controls
- Focus shifted from surveillance to semiconductors/AI
- Universities and research institutions increasingly targeted
- Tech decoupling intensifying

---

### Figure 8.2: Chinese Foreign Direct Investment in U.S. and Europe (2008-2024)
**Status:** ✅ Complete
**Files:**
- `figures/figure_8_2_chinese_fdi.png` (300 DPI)
- `figures/figure_8_2_chinese_fdi.pdf` (vector)
- `data/sources/chinese_fdi_flows.csv`
- `figures/create_figure_8_2_fdi.py`

**Key Findings:**
- **U.S. peak:** $45.6B (2016)
- **U.S. 2024:** $2.5B (down 95%)
- **Europe peak:** $42.8B (2017)
- **Europe 2024:** $9.5B (down 78%)

**Visual Features:**
- Dual line chart (U.S. vs Europe)
- Shows dramatic rise and fall
- Marks CFIUS reform (2018)

**Strategic Implications:**
- Near-complete collapse of Chinese investment in U.S.
- Europe following similar trend but less severe
- CFIUS expansion (2018) major turning point
- Investment screening as economic coercion tool

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
- ✅ **Figure 7.1:** SWIFT Transaction Volumes by Currency - **COMPLETED**
- **Figure 7.2:** U.S. Sanctions Programs Over Time
- ✅ **Figure 7.3:** Foreign Holdings of U.S. Treasury Securities - **COMPLETED**
- ✅ **Figure 7.4:** Russian Foreign Reserves - Frozen Assets 2022 - **COMPLETED**

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

### Visualizations Completed: 12 of ~70-80 planned (15-17%) ✨
- Chapter 1: 1 of 4 planned
- Chapter 2: 2 of 7 planned
- Chapter 3: 1 of 7 planned ✨
- Chapter 4: 2 of 7 planned
- Chapter 6: 2 of 5 planned ✨
- Chapter 7: 3 of 7 planned
- Chapter 8: 1 of 6 planned ✨

### Data Sources Created: 12 CSV files
- Total data points: ~650 across all datasets
- Time range: 2000-2024 (24 years)
- Geographic coverage: USA, China, EU, Japan, South Korea, Russia, global

### File Outputs: 36 files
- 12 PNG images (300 DPI)
- 12 PDF vectors (vector format)
- 12 Python scripts (reproducible)
- 12 CSV datasets

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

6. **Financial Coercion Has Become a Primary Tool**
   - USD still dominates SWIFT (38%), but declining
   - Russia sanctions froze $370B in assets (unprecedented scale)
   - China reducing U.S. Treasury holdings (39% decline from peak)
   - Western control of financial infrastructure enables coercion

7. **De-dollarization Is Happening But Slowly**
   - China cut Treasury holdings from $1,269B to $776B
   - CNY grew 1,733% in SWIFT but still only 5.5%
   - No viable alternative to USD/EUR system yet
   - Russia sanctions may accelerate alternative payment systems

8. **Clean Energy Transition Creates New Dependencies**
   - China controls 73% average across 7 key clean energy technologies
   - 90% of rare earth magnets, 80% of solar panels
   - Replacing oil dependence with clean tech dependence
   - Energy transition locked into Chinese supply chains

9. **Trade War Is Structural, Not Temporary**
   - U.S. tariffs jumped 539% (3.1% → 19.8%)
   - $570B in goods affected
   - Biden maintained and expanded Trump tariffs
   - Bipartisan consensus on China trade restrictions

10. **Tech Decoupling Is Accelerating**
    - Entity List additions: 15 (2015) → 275 (2024)
    - 1,362 Chinese entities blocked from U.S. tech
    - Focus on semiconductors, AI, and computing
    - Export controls = economic coercion

11. **Investment Screening Collapsed Cross-Border Flows**
    - Chinese FDI in U.S. down 95% from peak
    - CFIUS expansion (2018) was turning point
    - Europe also screening but less aggressive
    - Investment flows now at pre-2010 levels

---

## Git Commit

- **Branch:** develop
- **Commit:** 16f72a5
- **Files Changed:** 16 files, 704 insertions
- **Pushed to GitHub:** ✅ Yes

---

**Last Update:** 2025-11-19 (Evening session)
**Session Summary:** Created 3 new Chapter 7 financial statecraft visualizations + revised 4 existing figures for clarity
**Next Update:** After completing additional visualizations
