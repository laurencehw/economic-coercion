# Data Dictionary
## Economic Coercion Textbook

This document provides metadata and documentation for all CSV datasets used in the textbook's data visualizations and analysis.

**Last Updated:** April 10, 2026
**Total Datasets:** 28
**Data Location:** `data/sources/`

---

## Dataset Index

### 1. **ai_development_indicators.csv**
**Variables:** Country, AI publications, AI citations, VC investment, patents filed
**Source:** Stanford AI Index, Scopus, PitchBook
**Retrieval Date:** January 2026
**Notes:** Annual data 2015-2025; normalized per capita where indicated

### 2. **ai_publications.csv**
**Variables:** Year, Country, Publications, Citations, H-index
**Source:** Scopus, Web of Science
**Retrieval Date:** December 2025
**Notes:** Top-20 countries by publication volume; conference proceedings included

### 3. **australia_china_trade.csv**
**Variables:** Year, Commodity, Australian Exports to China (USD), Chinese Share of Australian Exports
**Source:** Australian Bureau of Statistics, UN Comtrade
**Retrieval Date:** February 2026
**Notes:** Covers 2018-2025; includes informal sanctions period 2020-2021

### 4. **chinese_fdi_flows.csv**
**Variables:** Year, Destination Country, Investment Amount (USD), Sector
**Source:** Rhodium Group, AEI China Tracker
**Retrieval Date:** January 2026
**Notes:** 2005-2024 annual flows; technology sector breakdown post-2016

### 5. **cfius_reviews.csv**
**Variables:** Year, Country of Origin, Sector, Review Outcome, Days to Decision
**Source:** U.S. Treasury CFIUS Annual Reports
**Retrieval Date:** March 2026
**Notes:** Covers 2015-2024; includes FIRRMA implementation from 2020

### 6. **cloud_market_share.csv**
**Variables:** Provider, Market Share (%), Revenue (USD), Year
**Source:** Synergy Research Group, Canalys
**Retrieval Date:** January 2026
**Notes:** Global market share; IaaS, PaaS, SaaS segments

### 7. **critical_minerals_data.csv**
**Variables:** Mineral, Country, Production (tons), Reserves, Processing Share
**Source:** USGS Mineral Commodity Summaries, Benchmark Mineral Intelligence
**Retrieval Date:** February 2026
**Notes:** Data for 2024; includes lithium, cobalt, rare earths, graphite

### 8. **cyber_economic_incidents.csv**
**Variables:** Year, Perpetrator, Target Sector, Economic Impact (USD), Attribution Confidence
**Source:** Center for Strategic and International Studies (CSIS), Verizon DBIR
**Retrieval Date:** January 2026
**Notes:** State-sponsored incidents only; impact estimates based on disclosed figures

### 9. **data_localization_laws.csv**
**Variables:** Country, Law Enacted, Data Categories Affected, Enforcement Status
**Source:** European Centre for International Political Economy (ECIPE), Data Protection Laws
**Retrieval Date:** December 2025
**Notes:** Includes GDPR, Chinese Cybersecurity Law, Russia Data Law

### 10. **dollar_reserves_projection.csv**
**Variables:** Year, Dollar Share (%), Scenario, Euro Share (%), Yuan Share (%)
**Source:** IMF COFER, Author projections
**Retrieval Date:** January 2026
**Notes:** Historical data 2000-2025; projections 2025-2050 across 4 scenarios

### 11. **economic_coercion_timeline.csv**
**Variables:** Date, Event, Target, Coercer, Outcome
**Source:** Multiple (compiled from case study chapters)
**Retrieval Date:** March 2026
**Notes:** 1945-2025 major coercion events

### 12. **entity_list_additions.csv**
**Variables:** Year, Entity Name, Country, Reason, Parent Company
**Source:** Bureau of Industry and Security (BIS)
**Retrieval Date:** March 2026
**Notes:** 2018-2025 additions; China-specific subset highlighted

### 13. **huawei_revenue.csv**
**Variables:** Year, Revenue (USD), Region, Segment
**Source:** Huawei Annual Reports, Industry estimates
**Retrieval Date:** January 2026
**Notes:** 2012-2024; consumer vs. enterprise vs. carrier breakdown

### 14. **industrial_policy_spending.csv**
**Variables:** Country, Program, Year Enacted, Amount (USD), Sector Focus
**Source:** Congressional Budget Office, European Commission, Chinese State Council
**Retrieval Date:** February 2026
**Notes:** CHIPS Act, IRA, European Chips Act, Made in China 2025

### 15. **internet_exchange_points.csv**
**Variables:** Country, City, Traffic (Gbps), Year Established
**Source:** Packet Clearing House, RIPE NCC
**Retrieval Date:** December 2025
**Notes:** Major IXPs globally; traffic data 2024

### 16. **rd_spending.csv**
**Variables:** Country, Year, R&D Spending (USD), % of GDP
**Source:** UNESCO Institute for Statistics, OECD, NSF
**Retrieval Date:** January 2026
**Notes:** 2000-2024; PPP adjusted where noted

### 17. **renewable_energy_manufacturing.csv**
**Variables:** Technology, Country, Manufacturing Share (%), Capacity (GW)
**Source:** International Energy Agency (IEA), BloombergNEF
**Retrieval Date:** January 2026
**Notes:** Solar panels, wind turbines, batteries; 2024 data

### 18. **russian_frozen_assets_2022.csv**
**Variables:** Asset Type, Country Holding, Amount (USD), Status
**Source:** U.S. Treasury, European Central Bank, Bank of England
**Retrieval Date:** February 2026
**Notes:** Post-February 2022 freeze; by country and asset class

### 19. **sanctions_success_rates.csv**
**Variables:** Study, Period, Success Definition, Success Rate (%), Sample Size
**Source:** Hufbauer et al. 2007, Biersteker et al. 2016, Drezner 1999, Pape 1997
**Retrieval Date:** December 2025
**Notes:** Comparative analysis of quantitative sanctions studies

### 20. **soviet_grain_imports.csv**
**Variables:** Year, Total Imports (million tons), U.S. Share (%), Other Suppliers
**Source:** USDA, Paarlberg 1980
**Retrieval Date:** December 2025
**Notes:** 1975-1985; embargo period 1980-1981 highlighted

### 21. **stem_talent_flows.csv**
**Variables:** Year, Country of Origin, Country of Destination, PhDs Granted, Return Rate
**Source:** NSF Survey of Earned Doctorates, OECD
**Retrieval Date:** January 2026
**Notes:** 2000-2023; U.S., China, India, EU flows

### 22. **swift_currency_data.csv**
**Variables:** Month, Currency, Share of Payments (%), Year-over-Year Growth
**Source:** SWIFT RMB Tracker
**Retrieval Date:** January 2026
**Notes:** Monthly 2015-2025; USD, EUR, CNY, GBP, JPY

### 23. **trade_war_timeline.csv**
**Variables:** Date, Action, Tariff Rate (%), Value Affected (USD), Retaliation
**Source:** USTR, Chinese Ministry of Commerce, Bown and Kolb 2021
**Retrieval Date:** March 2026
**Notes:** March 2018 - December 2025 escalation events

### 24. **tsmc_market_share.csv**
**Variables:** Quarter, Foundry, Market Share (%), Revenue (USD), Technology Node
**Source:** TechInsights, TrendForce
**Retrieval Date:** January 2026
**Notes:** Foundry market 2018-2024; advanced nodes (5nm and below) subset

### 25. **us_china_tariffs.csv**
**Variables:** HS Code, Product Description, Tariff Rate 2018, Tariff Rate 2024
**Source:** USTR, U.S. Census Bureau
**Retrieval Date:** February 2026
**Notes:** Comprehensive tariff schedule; Tranche A, B, C classifications

### 26. **us_china_trade.csv**
**Variables:** Year, U.S. Exports to China, U.S. Imports from China, Trade Balance
**Source:** U.S. Census Bureau, BEA
**Retrieval Date:** March 2026
**Notes:** 1990-2025 annual; monthly data available 2015-2025

### 27. **us_sanctions_programs.csv**
**Variables:** Program, Year Established, Targets, Status, Annual Enforcement Actions
**Source:** OFAC, Congressional Research Service
**Retrieval Date:** February 2026
**Notes:** 30+ active programs; includes Iran, Russia, China, North Korea

### 28. **us_treasury_holdings.csv**
**Variables:** Country, Year, Holdings (USD billions), % of Total Foreign Holdings
**Source:** U.S. Treasury TIC Data
**Retrieval Date:** February 2026
**Notes:** Major foreign holders 2000-2025; China and Japan highlighted

---

## Standard Data Conventions

### Monetary Values
- All monetary values in **USD** unless otherwise specified
- Historical values are **nominal** (not inflation-adjusted) unless marked as "real" or "constant"

### Dates
- Format: **YYYY-MM-DD** or **YYYY** for annual data
- Fiscal year vs. calendar year noted where relevant

### Country Codes
- **ISO 3166-1 alpha-3** country codes used
- "CHN" for China, "USA" for United States, "EUR" for Eurozone aggregates

### Missing Data
- **NA** for missing or unavailable data
- **0** used only for confirmed zero values
- **...** for suppressed or confidential data

---

## Data Quality and Limitations

### Known Issues:
1. **Chinese data:** Official statistics may understate or overstate certain figures; cross-referenced with industry sources where possible
2. **Sanctions impact:** Economic effects difficult to isolate from other factors; estimates based on econometric studies
3. **Attribution:** Cyber incidents and state-sponsored activities often have uncertain attribution
4. **Forward projections:** Scenario-based data (dollar reserves, critical minerals) based on author modeling and assumptions

### Updates:
- Data updated quarterly where possible
- Significant revisions noted in dataset changelog
- Historical data frozen at time of textbook publication

---

## Reproducibility

All figures in the textbook were generated using R scripts in `R/figures/` directory. These scripts:
- Load data from `data/sources/`
- Apply transformations documented in `R/setup_theme.R`
- Output to `figures/` as PNG (300 DPI) and PDF

To reproduce any visualization:
```r
source("R/setup_theme.R")
source("R/figures/fig_XX_YY_description.R")
```

---

**Questions about data sources?** Contact: lhw2110@columbia.edu