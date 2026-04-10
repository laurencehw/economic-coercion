# Citation Audit Report: Chapters 6-10

## Fact & Source Auditor Review
**Date:** January 22, 2026
**Reviewer:** Agent 2 (Fact & Source Auditor)
**Scope:** Chapters 6-10 of Economic Coercion textbook

---

## Executive Summary

This audit identifies citation integrity issues across Chapters 6-10, including orphan statistics (numbers without inline citations), figure traceability concerns, and data consistency issues. The review found:

- **42 orphan statistics** requiring citations across all five chapters
- **8 figure reference issues** (missing files or naming inconsistencies)
- **5 potentially outdated citations** requiring verification
- **3 data consistency concerns** between text and figures

---

## Summary Table: Uncited Statistics by Chapter

| Chapter | Title | Orphan Statistics | Figure Issues | Priority Items |
|---------|-------|-------------------|---------------|----------------|
| 6 | Trade Controls and Tariffs | 14 | 0 | 4 HIGH |
| 7 | Financial Statecraft and Sanctions | 12 | 4 | 5 HIGH |
| 8 | Investment Screening and Industrial Policy | 6 | 0 | 2 HIGH |
| 9 | Historical and Comparative Cases | 5 | 3 | 2 HIGH |
| 10 | Looking Forward | 5 | 1 | 3 HIGH |
| **TOTAL** | | **42** | **8** | **16 HIGH** |

---

## Chapter 6: Trade Controls and Tariffs

### Orphan Statistics (14 total)

| Line | Statistic | Context | Priority |
|------|-----------|---------|----------|
| ~5 | "$50 billion worth of Chinese goods" | Section 301 tariff announcement | MEDIUM - USTR 2018 cited but not inline |
| ~5 | "$360 billion in bilateral trade" | Trade war scope | HIGH - needs specific source |
| ~78 | "U.S. tariffs averaged 12% on Chinese goods (up from 3% pre-escalation)" | Year-end 2018 rates | HIGH - needs citation |
| ~78 | "Chinese tariffs averaged 18% on U.S. goods (up from 8%)" | Year-end 2018 retaliation | HIGH - needs citation |
| ~87 | "$362 billion total (66% of U.S. imports from China)" | Peak tariff coverage | MEDIUM - needs verification |
| ~104 | "58% of committed goods in 2020 and 71% over 2020-2021" | Phase One compliance | MEDIUM - Bown 2022 cited but not inline |
| ~127-128 | "U.S. imports from China fell from $539 billion (2018) to $427 billion (2019), a 21% decline" | Trade flow changes | HIGH - Flaaen and Pierce 2019 cited, verify data |
| ~128 | "U.S. imports from Vietnam surged 36% (2018-2019), from Mexico 10%, from Taiwan 25%" | Trade diversion | MEDIUM - needs inline citation |
| ~132-135 | "U.S. soybean exports to China fell 75%", "Aircraft deliveries fell 47%", "Energy product exports fell 54%" | Export declines | HIGH - needs sources |
| ~154 | "Vietnam's exports to U.S. surged from $49 billion (2017) to $115 billion (2023)" | Supply chain shifts | MEDIUM - needs verification |
| ~159-161 | "0.3-0.5% reduction in U.S. GDP", "0.5-0.8% GDP reduction" for China | Aggregate impacts | MEDIUM - sources cited in text |
| ~161 | "$27 billion in lost exports (2018-2020), partially offset by $23 billion in government subsidies" | Agricultural impact | HIGH - needs specific citation |
| ~199 | "over 30 countries face some form of U.S. sanctions" | Sanctions overuse | MEDIUM - needs verification for 2024 |
| ~346 | "over 600 Chinese entities appear on the Entity List" | As of 2024 | MEDIUM - verify current count |

### Figure Audit

| Figure Reference | File Path | Status | Data Source |
|-----------------|-----------|--------|-------------|
| fig_06_01_us_china_tariffs.png | ../figures/fig_06_01_us_china_tariffs.png | **FOUND** | us_china_tariffs.csv |
| fig_06_05_trade_war_escalation.png | ../figures/fig_06_05_trade_war_escalation.png | **FOUND** | trade_war_timeline.csv |
| fig_06_06_section_301.png | ../figures/fig_06_06_section_301.png | **FOUND** | No dedicated source file |
| fig_06_03_entity_list.png | ../figures/fig_06_03_entity_list.png | **FOUND** | entity_list_additions.csv |
| fig_06_02_fdpr_reach.png | ../figures/fig_06_02_fdpr_reach.png | **FOUND** | No dedicated source file |
| fig_06_04_rare_earth_retaliation.png | ../figures/fig_06_04_rare_earth_retaliation.png | **FOUND** | critical_minerals_data.csv |

### Citation Verification Issues

1. **Flaaen and Pierce 2019** - Referenced as "Fed Working Paper" - verify full citation details
2. **Amiti, Redding, and Weinstein (2019, AER)** - Verify publication year (should be 2019 or 2020)
3. **Cavallo et al. (2021, AEJ)** - Verify exact journal and year

---

## Chapter 7: Financial Statecraft and Sanctions

### Orphan Statistics (12 total)

| Line | Statistic | Context | Priority |
|------|-----------|---------|----------|
| ~5 | "$300+ billion" Russian reserves frozen | Executive summary | MEDIUM - U.S. Treasury 2022 cited |
| ~5 | "ruble collapsed 30%" | Post-invasion impact | HIGH - needs specific date/source |
| ~9 | "58% of global foreign exchange reserves" | Dollar dominance | MEDIUM - IMF 2024 cited |
| ~9 | "40% of SWIFT payments" | Dollar invoicing | MEDIUM - needs verification |
| ~44-46 | "$7.6 trillion" foreign Treasury holdings | As of 2024 | MEDIUM - verify current figure |
| ~52-58 | Reserve currency composition percentages (58.4% USD, 20.5% Euro, etc.) | 2024 figures | HIGH - needs IMF COFER citation |
| ~68 | "42% of international payments by value denominated in dollars, 31% in euros, 4% in renminbi" | SWIFT 2024 | MEDIUM - verify SWIFT data |
| ~78 | "$13 trillion in non-U.S. dollar-denominated debt (2024)" | Debt denomination | HIGH - needs BIS or similar source |
| ~100 | "~45 million messages daily" | SWIFT daily volume | MEDIUM - verify current figure |
| ~133 | "$27 trillion outstanding (2024)" | U.S. Treasury market | MEDIUM - verify Treasury data |
| ~138-139 | "U.S. corporate bond market ~$10 trillion", "European corporate bond market ~$4 trillion" | Market comparisons | HIGH - needs sources |
| ~186-188 | "BNP Paribas: $8.9 billion (2014)", "Standard Chartered: $1.1 billion (2019)", "UniCredit: $1.3 billion (2019)" | Sanctions penalties | LOW - well-documented |

### Figure Audit

| Figure Reference | File Path | Status | Data Source |
|-----------------|-----------|--------|-------------|
| fig_07_03_treasury_holdings.png | ../../figures/fig_07_03_treasury_holdings.png | **FOUND** | us_treasury_holdings.csv |
| fig_07_01_swift_currencies.png | ../../figures/fig_07_01_swift_currencies.png | **FOUND** | swift_currency_data.csv |
| figure_7_2_sanctions_programs.png | ../figures/figure_7_2_sanctions_programs.png | **NOT FOUND** | us_sanctions_programs.csv exists |
| fig_07_06_sanctions_by_country.png | ../figures/fig_07_06_sanctions_by_country.png | **FOUND** | No dedicated source |
| fig_07_05_sanctions_cascade.png | ../figures/fig_07_05_sanctions_cascade.png | **FOUND** | No dedicated source (diagram) |
| figure_7_4_russian_frozen_assets.png | ../../figures/figure_7_4_russian_frozen_assets.png | **NOT FOUND** | russian_frozen_assets_2022.csv exists |
| fig_07_07_dedollarization.png | ../figures/fig_07_07_dedollarization.png | **FOUND** | dollar_reserves_projection.csv |

**CRITICAL:** Two figures use inconsistent naming convention (`figure_7_X` vs `fig_07_0X`). These files do not exist in the figures directory.

### Citation Verification Issues

1. **"IMF 2024"** - Multiple references; should specify COFER database or specific report
2. **"U.S. Treasury 2022"** - Need specific press release or document reference
3. **Nephew 2017** vs **Nephew 2018** - Book published 2017 or 2018? (Referenced inconsistently)

---

## Chapter 8: Investment Screening and Industrial Policy

### Orphan Statistics (6 total)

| Line | Statistic | Context | Priority |
|------|-----------|---------|----------|
| ~5 | "100 million Americans" | TikTok user base | HIGH - needs source and date |
| ~varies | "$5 billion" S-400 contract (2018) | India-Russia deal | MEDIUM - needs source |
| ~varies | "200+ U.S. companies had exited South Africa" by 1989 | Disinvestment | MEDIUM - needs verification |
| ~varies | "$52 billion" CHIPS Act | U.S. industrial policy | LOW - well-documented |
| ~varies | "$369 billion" IRA clean energy | U.S. industrial policy | LOW - well-documented |
| ~varies | "$150+ billion" semiconductor Big Fund | Chinese investment | HIGH - verify total across all phases |

### Figure Audit

| Figure Reference | File Path | Status | Data Source |
|-----------------|-----------|--------|-------------|
| fig_08_01_bri_infrastructure.png | ../../figures/fig_08_01_bri_infrastructure.png | **FOUND** | No dedicated source |
| fig_08_02_chinese_fdi.png | ../../figures/fig_08_02_chinese_fdi.png | **FOUND** | chinese_fdi_flows.csv |
| fig_08_04_cfius_reviews.png | ../../figures/fig_08_04_cfius_reviews.png | **FOUND** | cfius_reviews.csv |
| fig_08_05_australia_china.png | ../../figures/fig_08_05_australia_china.png | **FOUND** | australia_china_trade.csv |
| fig_08_06_industrial_policy_compare.png | ../../figures/fig_08_06_industrial_policy_compare.png | **FOUND** | industrial_policy_spending.csv |
| fig_08_07_bri_debt.png | ../../figures/fig_08_07_bri_debt.png | **FOUND** | No dedicated source |

All Chapter 8 figures found with correct naming convention.

---

## Chapter 9: Historical and Comparative Cases

### Orphan Statistics (5 total)

| Line | Statistic | Context | Priority |
|------|-----------|---------|----------|
| ~5 | "17 million tons" grain embargo quantity | 1980 embargo | MEDIUM - Paarlberg 1980 cited |
| ~86-87 | "Total 1980 imports reached 34.8 million tons (vs. 31 million in 1979)" | Soviet grain imports | HIGH - needs verification source |
| ~108 | "Soviet grain imports barely declined: Total 1980 imports reached 34.8 million tons" | Embargo failure | MEDIUM - duplicate, needs citation |
| ~202 | "Whites (13% of population) controlled 90% of economy" | South African apartheid | HIGH - needs historical source |
| ~253 | "GDP growth: South African growth slowed from 5% annually (1960s) to near-zero (1980s)" | Sanctions impact | HIGH - needs economic data source |

### Figure Audit

| Figure Reference | File Path | Status | Data Source |
|-----------------|-----------|--------|-------------|
| figure_9_1_soviet_grain.png | ../../figures/figure_9_1_soviet_grain.png | **NOT FOUND** | soviet_grain_imports.csv exists |
| fig_09_03_sanctions_success.png | ../../figures/fig_09_03_sanctions_success.png | **FOUND** | sanctions_success_rates.csv |
| fig_09_04_sanctions_decision_tree.png | ../figures/fig_09_04_sanctions_decision_tree.png | **NOT FOUND** | Diagram - no data needed |
| fig_09_05_historical_outcomes.png | ../figures/fig_09_05_historical_outcomes.png | **NOT FOUND** | No dedicated source |

**CRITICAL:** 3 figures referenced but not found. `figure_9_1` uses inconsistent naming. `fig_09_04` and `fig_09_05` need to be created.

### Citation Verification Issues

1. **Paarlberg 1980** - Verify full citation (Foreign Affairs article)
2. **Hufbauer et al. 2007** - Standard reference, verify edition
3. **Crawford and Klotz 1999** - Verify publisher (listed as Macmillan)

---

## Chapter 10: Looking Forward

### Orphan Statistics (5 total)

| Line | Statistic | Context | Priority |
|------|-----------|---------|----------|
| ~11 | "$690 billion annually" U.S.-China trade | Despite tensions | HIGH - verify current figure |
| ~46 | "~60% of global foreign exchange reserves (down from 71% in 2000)" | Dollar decline | MEDIUM - verify IMF COFER |
| ~49-50 | "50% of cross-border trade invoiced in dollars (~80% of oil transactions)" | Trade invoicing | HIGH - needs source |
| ~51 | "~90% of currency transactions globally" | FX transactions | MEDIUM - verify BIS Triennial |
| ~72 | "CIPS... processing $13+ trillion annually (2024), growing 50%+ yearly" | CIPS growth | HIGH - verify Chinese official data |

### Figure Audit

| Figure Reference | File Path | Status | Data Source |
|-----------------|-----------|--------|-------------|
| figure_10_1_dollar_reserves.png | ../../figures/figure_10_1_dollar_reserves.png | **NOT FOUND** | dollar_reserves_projection.csv exists |
| fig_10_05_new_dependencies.png | ../figures/fig_10_05_new_dependencies.png | **NOT FOUND** | critical_minerals_data.csv exists |
| figure_10_3_ai_indicators.png | ../../figures/figure_10_3_ai_indicators.png | **NOT FOUND** | ai_development_indicators.csv exists |
| fig_10_04_decoupling_scenarios.png | ../figures/fig_10_04_decoupling_scenarios.png | **NOT FOUND** | No dedicated source |

**CRITICAL:** 4 figures in Chapter 10 are referenced but missing from the figures directory. Data sources exist for 3 of them.

### Citation Verification Issues

1. **Farrell and Newman 2019** - Verify this is correct year (article published 2019 in International Security)
2. **IEA 2021** - Verify report title for critical minerals
3. **National Intelligence Council 2021** - Verify Global Trends report date

---

## Data Consistency Issues

### Issue 1: Reserve Currency Percentages
- **Chapter 7, Line 53**: States "U.S. Dollar: 58.4%"
- **Chapter 10, Line 46**: States "~60% of global foreign exchange reserves"
- **Resolution needed:** Verify IMF COFER data for consistent 2024 figure

### Issue 2: SWIFT Payment Percentages
- **Chapter 7, Line 9**: States "40% of SWIFT payments"
- **Chapter 7, Line 68**: States "42% of international payments"
- **Chapter 7, Line 104**: States "42% of SWIFT messages involve dollar transactions"
- **Resolution needed:** Reconcile SWIFT messaging vs. value percentages

### Issue 3: CIPS Transaction Volume
- **Chapter 7**: States "Daily average ~$50-60 billion (2024)"
- **Chapter 10**: States "processing $13+ trillion annually (2024)"
- **Note:** These are consistent ($50B x 260 trading days = $13T)

---

## Priority Action Items

### HIGH Priority (16 items)

1. **Add citations for trade war GDP impacts** - Ch. 6, 7
2. **Add citation for tariff averages** - Ch. 6, lines 78
3. **Create missing figures for Chapters 7, 9, 10** (8 figures total)
4. **Verify and cite reserve currency percentages** - Ch. 7, 10
5. **Add citation for $13 trillion non-USD debt** - Ch. 7
6. **Add citation for TikTok user base** - Ch. 8
7. **Add citation for South African apartheid economic statistics** - Ch. 9
8. **Verify CIPS transaction volume with official sources** - Ch. 10
9. **Add source for 80% oil invoiced in dollars claim** - Ch. 10
10. **Verify $690 billion current U.S.-China trade figure** - Ch. 10
11. **Fix figure naming inconsistencies** (figure_X_X vs fig_XX_0X format)
12. **Add BIS citation for FX transaction percentages** - Ch. 10
13. **Verify agricultural export loss figures** - Ch. 6
14. **Add citation for corporate bond market sizes** - Ch. 7
15. **Verify Soviet grain import figures** - Ch. 9
16. **Verify Big Fund total across all phases** - Ch. 8

### MEDIUM Priority (18 items)

1. Verify all "2024" data points are current
2. Add inline citations where authors are mentioned but not linked
3. Verify Phase One Agreement compliance percentages
4. Cross-check Vietnamese export growth figures
5. Verify Entity List current count
6. Add specific IMF COFER database references
7. Verify SWIFT daily message volume
8. Add Treasury securities total verification
9. Verify sanctions penalty amounts (BNP, Standard Chartered)
10. Add Paarlberg 1980 full citation
11. Verify S-400 contract value
12. Verify disinvestment company count
13. Add citations for specific sector declines (soybeans, aircraft)
14. Verify trade diversion percentages
15. Add World Bank citation for sanctions impact estimates
16. Verify Heckscher 1922 availability/accessibility
17. Add specific dates for ruble collapse
18. Verify number of countries under U.S. sanctions

### LOW Priority (8 items)

1. Standardize reference format throughout
2. Add page numbers to book citations where available
3. Verify URLs in Further Reading sections still active
4. Check for any duplicate citations with different years
5. Ensure all WTO case numbers are correct
6. Verify sanctions penalty enforcement action dates
7. Confirm CHIPS Act and IRA amounts (well-documented)
8. Review accessibility of cited government documents

---

## Figure Traceability Matrix

### Figures with Verified Data Sources

| Chapter | Figure | Data File | Status |
|---------|--------|-----------|--------|
| 6 | fig_06_01_us_china_tariffs | us_china_tariffs.csv | VERIFIED |
| 6 | fig_06_03_entity_list | entity_list_additions.csv | VERIFIED |
| 6 | fig_06_04_rare_earth_retaliation | critical_minerals_data.csv | VERIFIED |
| 6 | fig_06_05_trade_war_escalation | trade_war_timeline.csv | VERIFIED |
| 7 | fig_07_01_swift_currencies | swift_currency_data.csv | VERIFIED |
| 7 | fig_07_03_treasury_holdings | us_treasury_holdings.csv | VERIFIED |
| 7 | fig_07_07_dedollarization | dollar_reserves_projection.csv | VERIFIED |
| 8 | fig_08_02_chinese_fdi | chinese_fdi_flows.csv | VERIFIED |
| 8 | fig_08_04_cfius_reviews | cfius_reviews.csv | VERIFIED |
| 8 | fig_08_05_australia_china | australia_china_trade.csv | VERIFIED |
| 8 | fig_08_06_industrial_policy_compare | industrial_policy_spending.csv | VERIFIED |
| 9 | fig_09_03_sanctions_success | sanctions_success_rates.csv | VERIFIED |

### Figures Missing or Naming Issues

| Chapter | Referenced Figure | Issue | Data Available? |
|---------|-------------------|-------|-----------------|
| 7 | figure_7_2_sanctions_programs | Wrong naming convention | YES (us_sanctions_programs.csv) |
| 7 | figure_7_4_russian_frozen_assets | Wrong naming convention | YES (russian_frozen_assets_2022.csv) |
| 9 | figure_9_1_soviet_grain | Wrong naming convention | YES (soviet_grain_imports.csv) |
| 9 | fig_09_04_sanctions_decision_tree | File missing | N/A (diagram) |
| 9 | fig_09_05_historical_outcomes | File missing | NO |
| 10 | figure_10_1_dollar_reserves | Wrong naming convention | YES (dollar_reserves_projection.csv) |
| 10 | figure_10_3_ai_indicators | Wrong naming convention | YES (ai_development_indicators.csv) |
| 10 | fig_10_05_new_dependencies | File missing | PARTIAL (critical_minerals_data.csv) |
| 10 | fig_10_04_decoupling_scenarios | File missing | NO |

---

## Recommendations

### Immediate Actions

1. **Standardize figure naming convention** across all chapters to `fig_XX_YY_description.png` format
2. **Generate missing figures** using existing data sources in `/data/sources/`
3. **Add inline citations** for all HIGH priority orphan statistics before publication
4. **Verify 2024 data points** against latest available sources (IMF, BIS, Treasury)

### Pre-Publication Checklist

- [ ] All figures exist with correct filenames
- [ ] All statistics have inline citations
- [ ] Reserve currency percentages consistent across chapters
- [ ] SWIFT percentages clarified (messages vs. value)
- [ ] All "as of 2024" data verified current
- [ ] Bibliography entries match in-text citations
- [ ] URLs in Further Reading verified active

### Suggested Citation Additions

For orphan statistics, recommend adding these standard sources:

| Data Type | Recommended Source |
|-----------|-------------------|
| Reserve currency shares | IMF COFER Database (quarterly) |
| Trade flows | UNCTAD, Census Bureau, Chinese Customs |
| SWIFT data | SWIFT RMB Tracker (monthly) |
| FX transactions | BIS Triennial Central Bank Survey |
| Sanctions data | Treasury OFAC, PIIE Sanctions Database |
| Tariff rates | Chad Bown PIIE Trade War Timeline |
| GDP impacts | IMF World Economic Outlook |
| Corporate bond markets | BIS, SIFMA |

---

*Report compiled by Agent 2: Fact & Source Auditor*
*Virtual Editorial Board Review*
