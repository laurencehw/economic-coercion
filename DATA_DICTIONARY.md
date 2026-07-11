# Data Dictionary
## Economic Coercion Textbook

This document provides metadata and documentation for all CSV datasets used in the textbook's data visualizations and analysis.

**Last Updated:** July 11, 2026
**Total Datasets:** 28
**Data Location:** `data/sources/`

> **Authority note.** This file is the single source of truth for (a) the canonical values of statistics quoted in the manuscript (see the next section) and (b) dataset retrieval dates. Where retrieval/access dates in `data/METADATA.md` differ from those recorded here, **the values in this Data Dictionary govern**; `data/METADATA.md` is a narrative supplement.

---

## Canonical Statistics (single source of truth)

Every figure below was reconciled on 2026-07-11 against primary sources to resolve the cross-chapter inconsistencies identified in `editorial_review/full_book_review_2026-07-11.md` (Problem 2). **Chapters must quote the canonical value here, with the stated as-of date and series basis.** Where a book passage currently disagrees (e.g., US-China trade "$700B," rare earths "85% mining," Treasury "$850B," gallium "80–90%," R&D "government funds 60–70%"), that passage is wrong and should be conformed to this table. Full source citations follow the table.

| # | Statistic | Canonical value | As-of date | Source | Notes |
|---|---|---|---|---|---|
| 1 | US-China bilateral trade (**goods only**, Census basis) | Two-way totals: **2008 $407.5B** (exp $69.7B / imp $337.8B); **2017 $635.2B** (exp $130.0B / imp $505.2B); **2018 $658.8B** (exp $120.3B / imp $538.5B); **2022 $690.3B** (exp $154.0B / imp $536.3B, record peak); **2024 $583.6B** (exp $143.3B / imp $440.3B); **2025 $414.7B** (exp $106.0B / imp $308.7B) | Full-year 2025 (accessed 2026-07) | U.S. Census Bureau, *Trade in Goods with China* (series C5700) | **Goods only, nominal, not seasonally adjusted.** State the basis explicitly wherever cited. Goods+services two-way is ~$100–130B higher (2024 goods+services ≈ $660.7B, BEA). The book's "$700B" refers to a peak (2022 goods = $690.3B; goods+services ≈ $758B); its 2008 "$560B" is wrong (goods = $407.5B). 2018 was the pre-trade-war peak; 2022 the all-time record; the 2025 collapse reflects the tariff escalation. |
| 2 | China's holdings of US Treasury securities (TIC) | **$683.5B** (year-end); declining further to ~$652B (March 2026). End-2024 ≈ $759B | Dec 2025 (latest year-end TIC); Mar 2026 monthly | U.S. Treasury, *Treasury International Capital (TIC) — Major Foreign Holders of Treasury Securities* | Custodial, not beneficial, ownership. **Not "$850B."** China is the 3rd-largest foreign holder, behind Japan (~$1.1–1.2T) and the United Kingdom (which overtook China in the March 2025 TIC release); holdings have fallen steadily from the 2013 peak (~$1.32T). |
| 3 | Rare earths — China share of **mining** vs **processing** (stated separately) | **Mining ≈ 70%** (China 270,000 t of ~390,000 t world REO); **processing/separation ≈ 90%** (85–90%) | 2024 data (USGS MCS 2025) | USGS, *Mineral Commodity Summaries: Rare Earths* (2025); IEA | Report the two stages **separately**. Mine share has ranged ~58–70% over 2019–2024 (China's decline reversed as output rose); the book's "85% mining" conflates mining with processing. China refines ~90% of global output and hosts the dominant separation/magnet capacity. |
| 4 | Gallium and germanium — China production shares (stated separately) | **Gallium ≈ 98–99%** of primary/low-purity production; **Germanium ≈ 60%** of global production | 2024 data (USGS MCS 2025) | USGS, *Mineral Commodity Summaries: Gallium* and *Germanium* (2025) | State separately. USGS: China ~99% of primary low-purity gallium; ~60% of germanium. The book's "80–90%" (ch2) and "94%/83%" (ch6) are both off. China imposed gallium/germanium export licensing (Aug 2023) and banned exports to the US (Dec 2024). |
| 5 | Solar & EV batteries — China manufacturing shares (stated by stage) | **Polysilicon ≈ 93%**; **module assembly ≈ 85–86%** (wafers ~97%, cells ~92%); **EV battery cell production ≈ 80%** (75–80%) | 2024 data | IEA, *Solar PV Global Supply Chains* & *Global EV Outlook 2025*; Wood Mackenzie; TaiyangNews | Quote polysilicon and module assembly **separately** (the book's ch1 "60%" vs ch2 "80%" conflict is a stage confusion). Overall solar manufacturing share exceeds 80% at every stage. Battery **cell** production ~80% (2024, IEA); upstream material refining is higher. |
| 6 | EDA software — top-3 vendors' combined market share | **≈ 74–75%** (Synopsys ~31% + Cadence ~30% + Siemens EDA ~13%) | 2024 (TrendForce) | TrendForce, EDA market share 2024; SemiEngineering | **Siemens EDA is German-owned** (Siemens AG acquired Mentor Graphics 2017; rebranded Siemens EDA 2021) — the trio is not "all American." Combined share of **advanced-node** (≤7nm) design flows is materially higher (~90%+). |
| 7 | Sanctions success rate (Hufbauer/Schott/Elliott/Oegg) | **34%** ("at least partial success") | HSE&O 2007 (3rd ed.); cases 1914–2000 | Hufbauer, Schott, Elliott & Oegg (2007), *Economic Sanctions Reconsidered* | 174 case studies / 204 episodes. Standard caveats: generous "partial success" coding; selection and attribution problems; Pape's critique yields ~5% once cases with concurrent military force are excluded. Cite as "roughly a third," not "20–30%" or "20–40%." |
| 8 | China IC "Big Fund" — phase sizes and dates | **Phase I** (Sept 2014) **¥138.7B (~$21B)**; **Phase II** (Oct 2019) **¥204.15B (~$29B)**; **Phase III** (May 24, 2024) **¥344B (~$47.5B)** | Phase III established 2024-05-24 | TrendForce; Caixin; Wikipedia (China IC Industry Investment Fund) | Registered capital. Phase III is the largest single tranche since 2014. Use these three consistently (the book's ch2 gives two conflicting sets). |
| 9 | RMB share — global reserves vs payments (stated separately) | **Reserves (COFER) ≈ 1.93%** of allocated reserves; **SWIFT payments ≈ 2.9%** (2.88%, 6th) | Reserves 2025 Q3; payments June 2025 | IMF COFER; SWIFT RMB Tracker (July 2025) | Two different denominators — never merge. RMB reserve share eased to **1.93% in 2025 Q3** (from 1.99% in 2025 Q2; IMF COFER data brief, Dec 2025), down from a ~2.8% peak in early 2022; report as "~1.9% of allocated reserves (2025 Q3)." SWIFT payment share peaked at 4.74% (Dec 2023, 4th place) and has since declined to ~2.9%. Chapter 7's 1.93% (2025 Q3) is correct and matches this row; its earlier 2.7% / 2.2% figures should be conformed to it. |
| 10 | OFAC — staff and SDN list size | Staff **~200+** ("more than 200," Treasury); SDN list **>12,000 entries** | Staff 2020 statement; SDN list 2026 | U.S. Treasury/OFAC; CNAS *Sanctions by the Numbers* | OFAC does not publish an exact headcount; "more than 200" is the last official figure (estimates run ~200–300 with detailees/contractors). SDN list exceeds 12,000 persons/entities/vessels/aircraft/crypto addresses; record 3,135 additions in 2024. Use "~200 staff" and ">12,000 SDN entries." |
| 11 | IEEPA maximum civil penalty (inflation-adjusted) | **$377,700 per violation**, or twice the transaction value, whichever is greater | Effective 2025-01-15 through 2026-01-14 | Treasury/OFAC, *Inflation Adjustment of Civil Monetary Penalties*, 90 Fed. Reg. (Jan 2025) | Adjusted annually. Prior year (2024) was $368,136. Both the book's "$330,000" and "$356,579" are stale — use the current $377,700 (and note it is re-indexed each January). |
| 12 | CFIUS CY2024 statistics | **116 declarations; 209 notices; 325 total transactions reviewed/assessed.** China = most notices of any investor country (**26**, though <21 distinct transactions). **49 notices withdrawn (42 refiled).** | Calendar year 2024 (report released Aug 2025) | U.S. Treasury, *CFIUS Annual Report to Congress, CY2024* | **This is the authoritative set — resolves the ch8 contradiction (ch8:158–163 vs 656).** Declarations fell (325 total transactions vs 342 in 2023, 440 in 2022). ~78% of declarations were cleared after the 30-day assessment. |
| 13 | Chinese FDI into the US (Rhodium series) | **Peak 2016 ≈ $46B**; since fallen ~90% to low single-digit billions; 2024 new-investment ≈ **$589M** (BEA) | 2016 peak; 2024 latest | Rhodium Group, *China Global Investment Tracker*; BEA (for the 2024 point) | Flag the series basis: Rhodium (completed FDI transactions) and BEA (new-investment expenditures) differ — do not mix. Peak year is 2016 (~$46B); flows have collapsed since 2017 and remain depressed. |
| 14 | Australia wine — China export share and duty removal | China ≈ **39–40%** of Australian wine exports pre-2020 (2019, surpassing France); duties **removed 29 March 2024** | 2019 share; 2024-03-29 removal | Wine Australia; DFAT; UNSW/CNN reporting | The "95% of revenue from China" figure (ch8:15) is wrong; ~39% of exports is correct (matches body text). Punitive duties (up to 218%) ran 2020–2024; removed 29 March 2024 (not "by 2025"). |
| 15 | China retaliatory tariff coverage, 2018–19 trade war | Covered **~58% of US exports to China (~$90B at 2017 levels), rising to ~69% product coverage by Dec 2019**; announced tariff-list totals ~$100–110B | 2018–2019 | Bown/PIIE, *US-China Trade War Tariffs* tracker | Corrects ch6's "$185B (70% of US exports)," which is impossible — total US goods exports to China in 2017 were only ~$130B. Use ~$90–110B / roughly two-thirds of US exports covered. |
| 16 | Undersea (submarine) cables — global count | **~570 in-service systems** (597 including under construction); 1,712 landings | 2025 map (TeleGeography) | TeleGeography, *Submarine Cable Map 2025* | Replaces the book's 485 (ch5:26) and 400 (ch5:537). Use "~570 active systems (about 600 including those under construction)." |
| 17 | Pharma/API — China dependence (facility-share framing) | Of API facilities registered to supply the US market: **US ~28%, EU ~26%, India ~18%, China ~13%, rest ~15%** | 2019 (FDA); China ~20% by 2025 | FDA, Woodcock congressional testimony, 30 Oct 2019; USP; Brookings | **The "80% of supply from China (or China+India)" claim is unsupported** — it conflates facility counts with production volume and has no reliable primary source. Use the facility-share framing. China's facility share rose to ~20% by 2025; India leads in generics volume. |
| 18 | US vs China orbital launches | **2023: US ~116 / China 67; 2024: US 154 / China 66; 2025: US 193 / China 92** | 2023–2025 annual | SpaceNews; Payload; illdefined.space launch summaries | US **far exceeds** China (SpaceX alone ~134 in 2024, ~165 in 2025). Corrects ch4:337's "comparable to or exceeding U.S." The US-China gap has widened every year since 2022. |
| 19 | China R&D spending — level, basis, composition | **¥3.613 trillion (~$496B at market rate; ~$0.86T PPP, 2020 dollars)**; intensity 2.68% of GDP. Funding: **business ~77%, government ~20%** | 2024 | China NBS (2025 communiqué); OECD MSTI | State the **PPP-vs-market basis explicitly** (China surpassed the US on a PPP basis in 2024; on a market-rate basis US R&D is still nearly double—about $993B for the US in 2024 versus roughly $500B for China). Composition corrects ch4:390: enterprises perform 77.7% and fund ~77%; government funds ~20% — not "government/SOEs 60–70%." |
| 20 | German WWI blockade — civilian vs combat deaths | Blockade **civilian deaths ~424,000–763,000**; German **military/combat deaths ~2.0 million** | 1914–1919 | *1914-1918-Online* Encyclopedia; German Board of Public Health (Dec 1918) | Combat deaths **far exceeded** blockade civilian deaths — corrects ch3:37's reversed claim. The 763,000 figure is the (contested) German 1918 official estimate; Winter's excess-death estimate is ~300,000; range ~0.5–1% of population. |

### Sources for canonical statistics

- **U.S. Census Bureau.** *Trade in Goods with China* (series C5700). https://www.census.gov/foreign-trade/balance/c5700.html (accessed 2026-07).
- **U.S. Bureau of Economic Analysis (BEA).** *U.S. International Trade in Goods and Services* (annual). https://www.bea.gov (goods+services basis; 2024 China FDI new-investment point).
- **U.S. Department of the Treasury.** *Treasury International Capital (TIC) System — Major Foreign Holders of Treasury Securities.* https://ticdata.treasury.gov (accessed 2026, Dec 2025 vintage).
- **U.S. Geological Survey.** *Mineral Commodity Summaries 2025* — Rare Earths, Gallium, Germanium chapters. https://pubs.usgs.gov/periodicals/mcs2025/.
- **International Energy Agency (IEA).** *Solar PV Global Supply Chains* (2022) and *Global EV Outlook 2025.* https://www.iea.org.
- **TrendForce.** EDA market share 2024 (Synopsys/Cadence/Siemens EDA); and *China's Big Fund Phase III* (May 2024) reporting. https://www.trendforce.com.
- **Hufbauer, Gary Clyde, Jeffrey J. Schott, Kimberly Ann Elliott, and Barbara Oegg.** 2007. *Economic Sanctions Reconsidered*, 3rd ed. Washington, DC: Peterson Institute for International Economics.
- **IMF.** *Currency Composition of Official Foreign Exchange Reserves (COFER).* https://data.imf.org (2025 Q3 print, released Dec 2025).
- **SWIFT.** *RMB Tracker* (July 2025). https://www.swift.com.
- **Office of Foreign Assets Control (OFAC) / U.S. Treasury.** SDN List and program information; *Inflation Adjustment of Civil Monetary Penalties*, Federal Register (Jan 2025). https://ofac.treasury.gov.
- **Center for a New American Security (CNAS).** *Sanctions by the Numbers: 2024 Year in Review.* https://www.cnas.org.
- **U.S. Department of the Treasury.** *CFIUS Annual Report to Congress, CY2024* (released Aug 2025). https://home.treasury.gov.
- **Rhodium Group.** *China Global Investment Tracker* (with AEI). https://rhg.com; MERICS–Rhodium COFDI updates.
- **Wine Australia** and **Australian DFAT.** Wine export data and the 29 March 2024 duty removal. https://www.wineaustralia.com.
- **Bown, Chad P. / Peterson Institute for International Economics (PIIE).** *US-China Trade War Tariffs: An Up-to-Date Chart* and underlying data. https://www.piie.com.
- **TeleGeography.** *Submarine Cable Map 2025.* https://www.submarinecablemap.com.
- **U.S. Food and Drug Administration.** Testimony of Janet Woodcock, M.D., "Safeguarding Pharmaceutical Supply Chains in a Global Economy," 30 Oct 2019. https://www.fda.gov.
- **SpaceNews; Payload Space; illdefined.space.** 2023–2025 global orbital launch summaries.
- **National Bureau of Statistics of China.** 2024 R&D expenditure communiqué (2025); **OECD**, *Main Science and Technology Indicators.*
- **1914-1918-Online: International Encyclopedia of the First World War.** "Naval Blockade (of Germany)"; German Board of Public Health estimate (Dec 1918).

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
- Country and region identifiers follow the labels used in each dataset's column headers
- Most datasets use readable names or abbreviations such as "China", "USA", "EU", or prefixed forms like "China_Publications"
- Aggregate entities such as the European Union or Eurozone may appear as "EU", "EUR", or similar non-country labels

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

**Questions about data sources?** Contact: lw3387@nyu.edu