# Citation Integrity and Data Traceability Audit Report
## Chapters 2-5: Economic Coercion Textbook
**Auditor:** Virtual Editorial Board - Agent 2 (Fact & Source Auditor)
**Date:** January 22, 2026

---

## Executive Summary

This audit examines citation integrity and data traceability across Chapters 2-5 of the economic coercion textbook. The analysis identifies figures, their data sources, orphan statistics lacking inline citations, and priority flags for potentially inconsistent or outdated information.

### Summary Table: Uncited Statistics by Chapter

| Chapter | Title | Total Statistics Identified | Properly Cited | Uncited/Orphan | Citation Rate |
|---------|-------|----------------------------|----------------|----------------|---------------|
| 2 | Supply Chain Vulnerabilities | ~85 | 12 | 73 | 14% |
| 3 | Critical Sectors and Strategic Resources | ~110 | 8 | 102 | 7% |
| 4 | Technology and Innovation Competition | ~75 | 10 | 65 | 13% |
| 5 | Information, Standards, Digital Infrastructure | ~60 | 6 | 54 | 10% |
| **Total** | | **~330** | **36** | **~294** | **11%** |

**Overall Assessment:** The chapters contain extensive quantitative claims with a relatively low inline citation rate. Many statistics appear to derive from reputable sources (USGS, IEA, SIA) but lack explicit attribution. The data files in `/data/sources/` provide underlying data for figures but lack comprehensive source documentation.

---

## Chapter 2: Supply Chain Vulnerabilities and Dependencies

### Figures Audit Table

| Figure | Description | Data Source Cited in Script? | Raw Data Available? | Source Attribution | Status |
|--------|-------------|------------------------------|---------------------|-------------------|--------|
| Fig 2.1 | Semiconductor Supply Chain Geography | Yes (SIA, TechInsights, Company Reports 2024) | No raw CSV | Script contains hardcoded location data | NEEDS SOURCE FILE |
| Fig 2.2 | TSMC Dominance in Advanced Chip Manufacturing | Yes (TechInsights, SIA, Gartner) | Yes (`tsmc_market_share.csv`) | Source noted in script caption | OK |
| Fig 2.3 | Critical Minerals Supply Chain Concentration | Yes (USGS, IEA) | Yes (`critical_minerals_data.csv`) | Source noted in script | OK |
| Fig 2.4 | Supply Chain Risk Matrix | No explicit source | No raw CSV | Script not examined in detail | NEEDS REVIEW |
| Fig 2.5 | Reshoring and Friend-shoring Initiatives | No explicit source | No raw CSV | Script not examined in detail | NEEDS REVIEW |

### Orphan Statistics List (Sample - High Priority)

| Statistic | Location (Line ~) | Data File Exists? | Priority |
|-----------|-------------------|-------------------|----------|
| TSMC manufactures ~90% of world's most advanced semiconductors | Line 9, 29, 100 | Partial (tsmc_market_share.csv shows 90% at 5nm) | LOW - Consistent with data |
| China processes ~85% of rare earth elements | Line 9, 52, 222 | Yes (critical_minerals_data.csv) | LOW - Data available |
| China/India supply ~80% of APIs to US | Line 9, 56, 290 | No | HIGH - No source file |
| Building semiconductor fab costs $15-20 billion | Line 31, 68, 137 | No | MEDIUM - Industry standard |
| EUV machine costs ~$150 million | Line 108 | No | MEDIUM - Commonly cited |
| CHIPS Act provides $52 billion | Line 35, 161, 360 | No | LOW - Public policy figure |
| China's Big Fund exceeds $100 billion | Line 43, 173, 183 | No | HIGH - Verify current total |
| SMIC can produce at 14nm and 7nm | Line 112, 185 | No | MEDIUM - Verify yields |
| U.S. share of global semiconductor fabrication fell from 37% (1990) to 12% (2020) | Line 161 | No | HIGH - Need historical data |
| TSMC Arizona fabs face 30-50% cost disadvantages | Line 145, 165, 360 | No | HIGH - Verify claim |
| 90-95% of antibiotics from China | Line 290 | No | HIGH - Critical claim |
| 28% of API manufacturing facilities in US (2019 FDA) | Line 296 | No | MEDIUM - Cited to FDA |
| API manufacturing in US down from 50% (1970s) | Line 296 | No | HIGH - Historical claim |
| Mountain Pass closed in 2002 | Line 237 | No | LOW - Historical fact |
| IEA estimates 6x more mineral inputs by 2040 | Line 208 | No | MEDIUM - Cited to IEA |

### Citations Present in Chapter 2

- Khan, Mann, and Peterson 2021 (Line 29, 31)
- Miller 2022 (Line 29, 108)
- U.S. Geological Survey 2023 (Line 29)
- White House 2021 (Line 41, 56)
- Rasser et al. 2022 (Line 35)
- IEA 2023 (Line 60)
- NDRC 2015 (Line 62)

---

## Chapter 3: Critical Sectors and Strategic Resources

### Figures Audit Table

| Figure | Description | Data Source Cited in Script? | Raw Data Available? | Source Attribution | Status |
|--------|-------------|------------------------------|---------------------|-------------------|--------|
| Fig 3.4 | Strategic Maritime Chokepoints | Yes (U.S. EIA 2023) | No raw CSV (hardcoded in R) | Script credits EIA | OK |
| Fig 3.5 | Subsea Cable Infrastructure | No | No | Not examined | NEEDS REVIEW |
| Fig 3.6 | Renewable Energy Manufacturing | No | renewable_energy_manufacturing.csv exists | Needs verification | NEEDS SOURCE DOC |
| Fig 3.7 | Strategic Ports and Chinese Maritime Investment | No | No | Not examined | NEEDS REVIEW |
| Fig 3.8 | Russian Energy Pipeline Infrastructure | No | No | Not examined | NEEDS REVIEW |
| Fig 3.9 | Energy Transition Sankey Diagram | No | No | Not examined | NEEDS REVIEW |
| Fig 3.10 | Global Grain Export Concentration | No | No | Not examined | NEEDS REVIEW |
| Fig 3.11 | Global LNG Infrastructure | No | No | Not examined | NEEDS REVIEW |

### Orphan Statistics List (Sample - High Priority)

| Statistic | Location (Line ~) | Data File Exists? | Priority |
|-----------|-------------------|-------------------|----------|
| Germany imported 55% of gas from Russia | Line 5 | No | MEDIUM - Cited to IEA 2022 |
| Italy imported 40% of gas from Russia | Line 5 | No | MEDIUM - Cited to IEA 2022 |
| Russia supplies ~40% of European gas imports | Line 15, 144 | No | HIGH - Pre-war baseline |
| Strait of Hormuz handles 21% of global oil | Line 15, 125 | Yes (hardcoded in R script) | LOW - Cited to US EIA |
| Ukraine/Russia export 30% of global wheat | Line 15, 45 | No | MEDIUM - Cited to FAO 2022 |
| Petroleum accounts for 30-32% of primary energy | Line 115 | No | MEDIUM - Standard figure |
| Global oil production ~100 million b/d | Line 115 | No | MEDIUM - Standard figure |
| US produces 18-20 mb/d oil | Line 117 | No | MEDIUM - Standard figure |
| China imports 10-11 mb/d oil (70% consumption) | Line 121 | No | HIGH - Verify current |
| Nord Stream 1 capacity 55 bcm/year | Line 150 | No | LOW - Technical spec |
| Russian gas was $150-200B annually | Line 158 | No | HIGH - Verify figure |
| Egypt imports 80%+ wheat from Black Sea | Line 45, 59 | No | MEDIUM - Cited to World Bank |
| Yemen imports ~90% of food | Line 69 | No | HIGH - Humanitarian data |
| Fertilizers could reduce production 40-50% | Line 83 | No | HIGH - Critical claim |
| Morocco controls ~70% phosphate reserves | Line 87, 247 | No | MEDIUM - Cited to USGS 2023 |
| Canada 30%, Russia 20%, Belarus 17% potash | Line 89 | No | HIGH - Verify current |
| China produces 80% of solar panels | Line 201 | No | HIGH - Key claim |
| China produces 60% of wind turbines | Line 203 | No | HIGH - Key claim |
| China controls 75% lithium-ion battery manufacturing | Line 205 | No | HIGH - Verify with IEA |

### Citations Present in Chapter 3

- IEA 2022 (Line 5)
- U.S. EIA 2023 (Line 15)
- FAO 2022 (Line 15, 45)
- World Bank 2022 (Line 45)
- U.S. Geological Survey 2023 (Line 87)
- Headey and Fan 2010 (Line 41)

---

## Chapter 4: Technology and Innovation Competition

### Figures Audit Table

| Figure | Description | Data Source Cited in Script? | Raw Data Available? | Source Attribution | Status |
|--------|-------------|------------------------------|---------------------|-------------------|--------|
| Fig 4.1 | R&D Spending by Country | Yes | rd_spending.csv exists | Needs verification | NEEDS SOURCE DOC |
| Fig 4.2 | AI Development Indicators | Yes (Stanford AI Index, arXiv, Scopus) | Yes (ai_publications.csv, ai_development_indicators.csv) | Good attribution | OK |
| Fig 4.3 | Semiconductor Supply Chain Chokepoints | No explicit source | No | Caption has claims | NEEDS SOURCE |
| Fig 4.4 | Huawei Impact | Yes | huawei_revenue.csv exists | Needs verification | NEEDS SOURCE DOC |
| Fig 4.5 | STEM Talent Flows | Yes | stem_talent_flows.csv exists | Needs verification | NEEDS SOURCE DOC |
| Fig 4.6 | Dual-Use Technology Matrix | No | No | Not examined | NEEDS REVIEW |

### Orphan Statistics List (Sample - High Priority)

| Statistic | Location (Line ~) | Data File Exists? | Priority |
|-----------|-------------------|-------------------|----------|
| Big Fund III secured over $47 billion | Line 7 | No | HIGH - Cited to Triolo/Greene 2023 |
| American semiconductor firms derive 30-40% revenue from China | Line 9 | No | MEDIUM - Cited to SIA 2023 |
| US dominates EDA software (100% market share) | Line 47, 51, 104 | No | MEDIUM - Industry consensus |
| TSMC 90% of advanced nodes | Line 51 | Yes (tsmc_market_share.csv) | LOW - Data available |
| EDA from 3 companies (Synopsys, Cadence, Mentor) | Line 104, 106 | No | LOW - Industry fact |
| CHIPS Act $39B manufacturing, $11B R&D | Line 161 | No | LOW - Public policy |
| TSMC building Arizona fabs $40B investment | Line 163 | No | MEDIUM - News reports |
| Samsung $17B Texas expansion | Line 163 | No | MEDIUM - News reports |
| Intel $20B Ohio facilities | Line 163 | No | MEDIUM - News reports |
| Over $200B announced semiconductor investments | Line 163 | No | HIGH - Aggregate claim |
| 600 TOPS compute threshold for INT8 | Line 166 | No | LOW - Regulatory spec |
| Nvidia lost $7-10B in China AI chip sales | Line 478 | No | MEDIUM - Cited to Del Rey 2023 |
| GLM-130B claims comparable to GPT-3 (175B params) | Line 211 | No | HIGH - Technical claim |
| Huawei captured ~30% telecom equipment market | Line 192 (Ch5) | No | HIGH - Pre-sanctions |
| Huawei underprice competitors by 20-30% | Line 194 (Ch5) | No | HIGH - Verify claim |
| Training frontier AI costs $100M-$1B | Line 818 | No | HIGH - Fast-changing |
| Global AI market $200B (2023), $2T by 2030 | Line 815 | No | HIGH - Projection |

### Citations Present in Chapter 4

- Triolo and Greene 2023 (Line 7)
- Allen and Feng 2023 (Line 7)
- SIA 2023 (Line 9)
- Sullivan 2022 (Line 60)
- Del Rey 2023 (Line 478 area)
- Shane and Wakabayashi 2018 (Line 150)
- Mozur 2019 (Line 152)

---

## Chapter 5: Information, Standards, and Digital Infrastructure

### Figures Audit Table

| Figure | Description | Data Source Cited in Script? | Raw Data Available? | Source Attribution | Status |
|--------|-------------|------------------------------|---------------------|-------------------|--------|
| Fig 5.1 | Subsea Cable Infrastructure | No | No | Uses fig_03_05 | NEEDS REVIEW |
| Fig 5.2 | Data Localization Requirements | Yes | data_localization_laws.csv exists | Needs verification | NEEDS SOURCE DOC |
| Fig 5.3 | Cyber-Economic Incidents | Yes (CSIS, industry reports) | Yes (cyber_economic_incidents.csv) | Good attribution | OK |
| Fig 5.4 | Cloud Infrastructure Market Share | Yes | cloud_market_share.csv exists | Needs verification | NEEDS SOURCE DOC |

### Orphan Statistics List (Sample - High Priority)

| Statistic | Location (Line ~) | Data File Exists? | Priority |
|-----------|-------------------|-------------------|----------|
| SenseTime IPO worth $767 million | Line 5 | No | MEDIUM - News fact |
| SenseTime deployed in 100+ Chinese cities | Line 5 | No | HIGH - Company claim |
| Over 95% intercontinental data via subsea cables | Line 31 | No | HIGH - Infrastructure claim |
| APT1 intrusions into 141 organizations | Line 44 | No | MEDIUM - Cited to Mandiant 2013 |
| 145 million Americans affected (Equifax) | Line 412 | No | LOW - Well-documented |
| 22 million OPM records stolen | Data file | Yes (cyber_incidents.csv) | LOW - Well-documented |
| Chinese VC in US startups: $9.9B (2018) to $1B (2023) | Line 514 | No | HIGH - Investment data |
| MoneyGram-Ant Financial $1.2B abandoned | Line 521 | No | MEDIUM - News fact |
| Huawei revenue fell $140B (2020) to $100B (2022) | Line 685 | huawei_revenue.csv exists | VERIFY DATA |
| TikTok has 150 million American users | Line 274 | No | HIGH - Fast-changing |
| US cloud providers control 65%+ global market | Line 169 | cloud_market_share.csv | VERIFY DATA |
| Taiwan cables carry 99% international data | Line 830 | No | HIGH - Critical claim |
| Taiwan stock exchange dropped 60% | Line 877 | No | SCENARIO - Not factual |
| ~500 submarine cables globally | Line 998 | No | MEDIUM - Infrastructure |
| $10 trillion daily via cables | Line 999 | No | HIGH - Financial claim |

### Citations Present in Chapter 5

- Mandiant 2013 (Line 44)
- DOJ 2014 (Line 53)
- DOJ 2020 (Line 55)
- White House 2015 (Line 71)
- Microsoft 2023 (Line 79)
- CISA 2023 (Line 79)
- Creemers, Triolo, and Webster 2022 (Line 115)
- FIRRMA 2018 (Line 448)

---

## Priority Flags

### 1. Numerical Claims Requiring Verification

| Claim | Chapter | Concern |
|-------|---------|---------|
| China's Big Fund exceeds $100 billion total | 2, 4 | Big Fund III announced 2024; total may have changed |
| TSMC Arizona cost 30-50% higher | 2, 4 | Widely cited but primary source unclear |
| 90-95% of antibiotics from China | 2 | Critical public health claim; FDA source needed |
| China produces 80% of solar panels globally | 3 | Varies by segment (cells vs modules); IEA source needed |
| Training frontier AI costs $100M-$1B | 4 | Fast-evolving; GPT-4/5 costs may differ |
| TikTok 150 million US users | 5 | Fast-changing; verify current figure |
| $10 trillion daily via submarine cables | 5 | Extraordinary claim needs strong source |

### 2. Citations Potentially Outdated (Pre-2020 Data Used for Current Claims)

| Citation | Year | Chapter | Concern |
|----------|------|---------|---------|
| Headey and Fan 2010 | 2010 | 3 | Food crisis analysis; may need updating |
| Mandiant 2013 | 2013 | 5 | APT1 report; operations have evolved |
| DOJ 2014 | 2014 | 5 | PLA indictments; Chinese tactics changed |
| Made in China 2025 (NDRC 2015) | 2015 | 2 | Policy document; implementation evolved |
| Shane and Wakabayashi 2018 | 2018 | 4 | Project Maven; AI military use expanded |
| Mozur 2019 | 2019 | 4 | Xinjiang surveillance; situation evolved |

### 3. Internal Consistency Issues

| Issue | Chapters | Details |
|-------|----------|---------|
| TSMC market share | 2, 4 | Text says "90% of advanced chips" but data shows 90% at 5nm, 70% at 7nm |
| China rare earth processing | 2, 3 | Some places say 85%, others 85-90%; standardize |
| Big Fund total | 2, 4 | References vary between $100B and specific phases |
| API dependency | 2 | Says "80%" for China+India, then "90-95%" for antibiotics specifically - clarify |

---

## Recommendations

### Immediate Actions

1. **Create Source Documentation File:** Add `/data/sources/README.md` documenting the provenance of each CSV file with full citations
2. **Add Inline Citations:** Priority statistics (marked HIGH) should receive proper author-date citations
3. **Verify Fast-Changing Data:** Update statistics on AI market size, TikTok users, cloud market share for 2024-2025
4. **Standardize Rare Earth Figures:** Choose consistent figure (85% vs 85-90%) across chapters

### Medium-Term Actions

1. **Create Data Dictionary:** Document methodology for each data file (sources, date of access, any transformations)
2. **Add Figure Source Notes:** Ensure all R scripts include explicit source citations in captions
3. **Historical Data Verification:** Verify historical claims (Mountain Pass 2002 closure, 1970s API manufacturing share)
4. **Cross-Reference Check:** Ensure figures in text match data in CSV files exactly

### Data Files Needing Source Documentation

| File | Documented? | Action Needed |
|------|-------------|---------------|
| tsmc_market_share.csv | No | Add source (TechInsights? SIA?) |
| critical_minerals_data.csv | No | Add source (USGS? IEA?) |
| ai_publications.csv | No | Add source (Scopus? Stanford AI Index?) |
| ai_development_indicators.csv | No | Add source |
| cyber_economic_incidents.csv | Partial (CSIS noted in script) | Formalize |
| cloud_market_share.csv | No | Add source (Synergy? Canalys?) |
| huawei_revenue.csv | No | Add source (company reports?) |
| data_localization_laws.csv | No | Add source |

---

## Conclusion

The chapters contain well-researched content with extensive quantitative data, but citation practices need strengthening. Approximately 89% of numerical claims lack explicit inline citations. While many figures appear to use reputable data sources (noted in R script captions), the underlying data files lack formal provenance documentation.

The most critical gaps involve:
1. Public health claims (API/antibiotic dependency percentages)
2. Fast-moving technology data (AI costs, market sizes)
3. Aggregate investment figures (Big Fund totals, CHIPS Act investments)
4. Infrastructure claims (submarine cable traffic volumes)

Addressing these gaps will strengthen the textbook's credibility for academic and policy audiences.

---
*Report generated by Virtual Editorial Board - Agent 2*
