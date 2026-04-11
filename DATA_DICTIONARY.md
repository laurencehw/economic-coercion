# Data Dictionary
## Economic Coercion Textbook

This document provides metadata and documentation for all CSV datasets used in the textbook's data visualizations and analysis.

**Last Updated:** April 10, 2026
**Total Datasets:** 28
**Data Location:** `data/sources/`

---

## Dataset Index

### 1. **ai_development_indicators.csv**
**Variables:** Indicator, USA, China, EU, Global_Total
**Source:** Stanford AI Index, Scopus, PitchBook
**Retrieval Date:** January 2026
**Notes:** Rows represent different AI indicators; columns show values by country/region

### 2. **ai_publications.csv**
**Variables:** Year, USA_Publications, China_Publications, EU_Publications, USA_Citations, China_Citations, USA_Top10_Share, China_Top10_Share
**Source:** Scopus, Web of Science
**Retrieval Date:** December 2025
**Notes:** Annual publication and citation counts by country; includes top-10% publication share

### 3. **australia_china_trade.csv**
**Variables:** product, exports_2019_billions, exports_2021_billions, exports_2023_billions, pct_change_2019_2021, restriction_type, status_2024
**Source:** Australian Bureau of Statistics, UN Comtrade
**Retrieval Date:** February 2026
**Notes:** Product-level export data across snapshot years; includes informal sanctions period 2020-2021

### 4. **chinese_fdi_flows.csv**
**Variables:** Year, US_Billions, Europe_Billions
**Source:** Rhodium Group, AEI China Tracker
**Retrieval Date:** January 2026
**Notes:** Annual Chinese FDI flows to US and Europe in billions USD

### 5. **cfius_reviews.csv**
**Variables:** year, covered_transactions, declarations, notices, withdrawals, presidential_decisions, mitigation_agreements, china_related_pct
**Source:** U.S. Treasury CFIUS Annual Reports
**Retrieval Date:** March 2026
**Notes:** Covers 2015-2024; includes FIRRMA implementation from 2020

### 6. **cloud_market_share.csv**
**Variables:** year, provider, headquarters, global_share, china_share, europe_share, us_share, revenue_billions
**Source:** Synergy Research Group, Canalys
**Retrieval Date:** January 2026
**Notes:** Global and regional market share by provider; IaaS, PaaS, SaaS segments

### 7. **critical_minerals_data.csv**
**Variables:** Mineral, China_Processing_Share, China_Mining_Share, Top_Other_Processors, Strategic_Use
**Source:** USGS Mineral Commodity Summaries, Benchmark Mineral Intelligence
**Retrieval Date:** February 2026
**Notes:** China's processing and mining dominance; includes lithium, cobalt, rare earths, graphite

### 8. **cyber_economic_incidents.csv**
**Variables:** year, incident_name, attacker_attribution, target_country, target_sector, estimated_damage_usd, incident_type, economic_coercion_link, description
**Source:** Center for Strategic and International Studies (CSIS), Verizon DBIR
**Retrieval Date:** January 2026
**Notes:** State-sponsored incidents only; impact estimates based on disclosed figures

### 9. **data_localization_laws.csv**
**Variables:** country, region, law_name, year_enacted, stringency, data_residency_required, cross_border_transfer_restricted, sector_specific, notes
**Source:** European Centre for International Political Economy (ECIPE), Data Protection Laws
**Retrieval Date:** December 2025
**Notes:** Includes GDPR, Chinese Cybersecurity Law, Russia Data Law

### 10. **dollar_reserves_projection.csv**
**Variables:** Year, USD_Historical, EUR_Historical, CNY_Historical, Others_Historical, USD_Baseline, USD_Slow_Decline, USD_Accelerated, EUR_Baseline, CNY_Baseline
**Source:** IMF COFER, Author projections
**Retrieval Date:** January 2026
**Notes:** Historical data 2000-2025; projections 2025-2050 across multiple scenarios

### 11. **economic_coercion_timeline.csv**
**Variables:** Year, Event, Category, Description
**Source:** Multiple (compiled from case study chapters)
**Retrieval Date:** March 2026
**Notes:** 1945-2025 major coercion events

### 12. **entity_list_additions.csv**
**Variables:** Year, Semiconductors, Surveillance, Aerospace_Defense, Universities_Research, AI_Computing, Other, Total
**Source:** Bureau of Industry and Security (BIS)
**Retrieval Date:** March 2026
**Notes:** 2018-2025 additions by sector category; China-specific

### 13. **huawei_revenue.csv**
**Variables:** year, total_revenue_billions, consumer_business, carrier_business, enterprise_business, yoy_growth, sanctions_phase
**Source:** Huawei Annual Reports, Industry estimates
**Retrieval Date:** January 2026
**Notes:** 2012-2024; revenue by business segment with sanctions phase annotation

### 14. **industrial_policy_spending.csv**
**Variables:** Program, Country, Sector, Total_Spending_Billions, Duration_Years, Annual_Avg_Billions, Start_Year, End_Year
**Source:** Congressional Budget Office, European Commission, Chinese State Council
**Retrieval Date:** February 2026
**Notes:** CHIPS Act, IRA, European Chips Act, Made in China 2025

### 15. **internet_exchange_points.csv**
**Variables:** ixp_name, city, country, region, peak_traffic_tbps, members, year_founded, operator_type
**Source:** Packet Clearing House, RIPE NCC
**Retrieval Date:** December 2025
**Notes:** Major IXPs globally; traffic data in Tbps

### 16. **rd_spending.csv**
**Variables:** Year, USA, China, EU, Japan, South_Korea, Rest_of_World
**Source:** UNESCO Institute for Statistics, OECD, NSF
**Retrieval Date:** January 2026
**Notes:** Annual R&D spending by country/region; PPP adjusted where noted

### 17. **renewable_energy_manufacturing.csv**
**Variables:** Technology, China, Europe, USA, Rest_of_Asia, Others
**Source:** International Energy Agency (IEA), BloombergNEF
**Retrieval Date:** January 2026
**Notes:** Manufacturing share (%) by region for solar panels, wind turbines, batteries

### 18. **russian_frozen_assets_2022.csv**
**Variables:** Category, Location, Amount_Billions_USD
**Source:** U.S. Treasury, European Central Bank, Bank of England
**Retrieval Date:** February 2026
**Notes:** Post-February 2022 freeze; by category and location

### 19. **sanctions_success_rates.csv**
**Variables:** Sanction_Type, Success_Rate, Partial_Success, Failure, Total_Cases, Avg_Duration_Years
**Source:** Hufbauer et al. 2007, Biersteker et al. 2016, Drezner 1999, Pape 1997
**Retrieval Date:** December 2025
**Notes:** Success and failure rates by sanction type with average duration

### 20. **soviet_grain_imports.csv**
**Variables:** Year, USA, Canada, Argentina, Australia, EU, Others, Total
**Source:** USDA, Paarlberg 1980
**Retrieval Date:** December 2025
**Notes:** 1975-1985; grain imports by supplier country; embargo period 1980-1981 highlighted

### 21. **stem_talent_flows.csv**
**Variables:** year, origin_country, phd_graduates_us, stay_rate_pct, return_country_pct, third_country_pct, field
**Source:** NSF Survey of Earned Doctorates, OECD
**Retrieval Date:** January 2026
**Notes:** PhD graduates in US by origin country with stay/return rates by field

### 22. **swift_currency_data.csv**
**Variables:** Year, USD, EUR, GBP, JPY, CNY, Others
**Source:** SWIFT RMB Tracker
**Retrieval Date:** January 2026
**Notes:** Annual currency share of SWIFT payments (%)

### 23. **trade_war_timeline.csv**
**Variables:** date, event, actor, action_type, value_billions, tariff_rate, products_affected, escalation_level
**Source:** USTR, Chinese Ministry of Commerce, Bown and Kolb 2021
**Retrieval Date:** March 2026
**Notes:** March 2018 - December 2025 escalation events

### 24. **tsmc_market_share.csv**
**Variables:** Technology_Node, TSMC, Samsung, Intel, SMIC, Others
**Source:** TechInsights, TrendForce
**Retrieval Date:** January 2026
**Notes:** Foundry market share (%) by technology node

### 25. **us_china_tariffs.csv**
**Variables:** Year, Average_Tariff_Rate, Section301_Tariffs, Total_Goods_Under_Tariffs_Billions
**Source:** USTR, U.S. Census Bureau
**Retrieval Date:** February 2026
**Notes:** Annual tariff data; Section 301 tariff rates and affected goods value

### 26. **us_china_trade.csv**
**Variables:** Year, US_Exports_to_China, US_Imports_from_China, Trade_Balance, Total_Trade
**Source:** U.S. Census Bureau, BEA
**Retrieval Date:** March 2026
**Notes:** 1990-2025 annual bilateral trade data

### 27. **us_sanctions_programs.csv**
**Variables:** Year, Total_Programs, Country_Based, Thematic, Entities_Individuals
**Source:** OFAC, Congressional Research Service
**Retrieval Date:** February 2026
**Notes:** Annual counts of active sanctions programs and designated entities

### 28. **us_treasury_holdings.csv**
**Variables:** Year, China, Japan, UK, Ireland, Luxembourg, Brazil, Belgium, Taiwan, Switzerland, Saudi_Arabia, Others
**Source:** U.S. Treasury TIC Data
**Retrieval Date:** February 2026
**Notes:** Major foreign holders of U.S. Treasury securities by country; 2000-2025

---

## Standard Data Conventions

### Monetary Values
- All monetary values in **USD** unless otherwise specified
- Historical values are **nominal** (not inflation-adjusted) unless marked as "real" or "constant"

### Dates
- Format: **YYYY-MM-DD** or **YYYY** for annual data
- Fiscal year vs. calendar year noted where relevant

### Country Codes
- **ISO 3166-1 alpha-3** country codes used where applicable
- "CHN" for China, "USA" for United States; "EU" or "EUR" used as non-standard aggregate codes for European Union/Eurozone data

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