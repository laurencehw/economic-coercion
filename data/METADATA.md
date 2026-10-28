# Dataset Provenance and Metadata {-}

This file documents the source, coverage, and known limitations of each dataset under `data/sources/`. Figures rendered in `figures/` are built from these files via scripts in `R/figures/`. Access dates below are given to month precision (YYYY-MM) because most underlying series are monthly or annual; where a series is maintained by a public agency, readers should re-fetch for current vintages.

> **Authority / reconciliation note.** The root `DATA_DICTIONARY.md` is the single source of truth for both (a) canonical values of statistics quoted in the manuscript and (b) dataset retrieval/access dates. This file is a narrative supplement. **Where an access date below differs from the "Retrieval Date" recorded for the same dataset in `DATA_DICTIONARY.md`, the Data Dictionary value governs.** (Several access dates here were captured on an earlier pass and are superseded by the Data Dictionary — e.g., `us_china_trade.csv`, `critical_minerals_data.csv`, `tsmc_market_share.csv`, `rd_spending.csv`. Do not cite the dates in this file against those in the Data Dictionary; defer to the Dictionary.) For any statistic the manuscript quotes, use the value, as-of date, and series basis in the Data Dictionary's "Canonical Statistics" table.

---

## Trade and Tariff Data

**`us_china_trade.csv`** — U.S. Census Bureau, Foreign Trade Division, *Trade in Goods with China* series (1990–2024). Accessed 2025-12. Annual, USD billions, not seasonally adjusted. Covers merchandise trade only; services trade excluded.

**`us_china_tariffs.csv`** — Peterson Institute for International Economics (PIIE) *Trade War Tariff Tracker*, Chad P. Bown, supplemented by USTR Section 301 determinations. Accessed 2026-01. Average effective ad-valorem rates by product tranche.

**`trade_war_timeline.csv`** — Event-level timeline, January 2018 to May 2024; the vertical position in Figure 6.2 (`escalation_level`) is the author's ordinal judgment. Re-checked 2026-10-28: U.S. rows against the Federal Register (USTR notices, BIS rules, presidential documents) and the Government of the Netherlands release; Chinese rows against secondary timelines (California Research Bureau chronology; Business Insider timeline), cross-read with USTR notices. Each row carries `date_basis` (announced, signed or in force), `source` and a `verification` note; value and rate cells that could not be verified were left blank. Rows relabelled in this pass: 2021-06-03 (EO 14032 investment ban, formerly called an Entity List expansion), 2023-03-08 (Dutch lithography controls, formerly 2023-01-27 and bundled with Japan), 2020-05-15 (Huawei foreign direct product rule, formerly "TSMC restrictions").

## Technology, Supply Chains, and R&D

**`critical_minerals_data.csv`** — USGS *Mineral Commodity Summaries 2024*; IEA *Critical Minerals Outlook 2024*; Cobalt Institute. Accessed 2025-09. Processing and mining shares as percent of global; strategic-use column is authorial coding, not from source.

**`tsmc_market_share.csv`** — TrendForce quarterly foundry revenue reports; TSMC 10-K filings; SIA. Accessed 2025-11. Foundry revenue share by manufacturer, not wafer-starts.

**`entity_list_additions.csv`** — U.S. Bureau of Industry and Security *Federal Register* notices of Entity List additions. Accessed 2026-01. Event-level; administrative classification is authorial.

**`rd_spending.csv`** — OECD *Main Science and Technology Indicators*; NSF *Science and Engineering Indicators*; Chinese National Bureau of Statistics. Accessed 2025-10. GERD, current PPP USD.

**`ai_publications.csv`** — Stanford HAI *AI Index Report 2024*; OECD.AI. Accessed 2025-09. Peer-reviewed AI publications by author-affiliation country; may differ from funding-country counts.

**`ai_development_indicators.csv`** — Stanford HAI *AI Index 2024*; CSET/Georgetown; MacroPolo *Global AI Talent Tracker*. Accessed 2025-09.

**`stem_talent_flows.csv`** — MacroPolo *Global AI Talent Tracker* (2022); NSF *Survey of Earned Doctorates*. Accessed 2025-10.

**`huawei_revenue.csv`** — Huawei Annual Reports (2018–2024); Huawei press releases. Accessed 2025-12. Figures self-reported; unaudited by international auditors for consolidated financials.

## Finance and Sanctions

**`swift_currency_data.csv`** — SWIFT *RMB Tracker* monthly reports. Accessed 2026-01. Share of customer-initiated and institutional payments by value; excludes interbank flows.

**`us_treasury_holdings.csv`** — U.S. Treasury *TIC* data, *Major Foreign Holders of Treasury Securities*. Accessed 2026-01. Monthly; by custodial country, not beneficial owner.

**`dollar_reserves_projection.csv`** — One observed anchor, the IMF COFER 2025Q3 dollar share of 56.92% quoted in Chapter 7, followed by three author-assumed sensitivity paths through 2050. No mixed-vintage historical series or euro/renminbi forecast is included. Future points and the shaded range are illustrative assumptions, not fitted forecasts or confidence bounds.

**`scenario_planning_weights.csv`** — The four stylized 2035–2050 worlds in Chapter 10. Coordinates and weights are author judgments for classroom analysis, not observed indices or calibrated probabilities.

**`us_sanctions_programs.csv`** — U.S. Department of the Treasury, Office of Foreign Assets Control (OFAC) *Sanctions Programs and Country Information*. Accessed 2026-01.

**Retired sanctions-rate table (October 2026).** The former `sanctions_success_rates.csv` and associated type/duration chart were removed because the repository contained no case-level extraction or harmonization supporting its 712-case attribution. HSE, GSDB, and TSC use different samples and coding; a new empirical comparison must supply case identifiers, source versions, overlap rules, and reproducible aggregation before publication. Chapter 9 retains the published aggregate finding with its attribution caveats.

**`russian_frozen_assets_2022.csv`** — REPO Task Force reports; European Commission *Russian Assets Freeze* updates; U.S. Treasury press releases. Accessed 2025-12.

## Cyber, Digital, and Data

**`data_localization_laws.csv`** — OneTrust DataGuidance; ITIF *Data Localization Tracker*; national regulators. Accessed 2025-10.

**`internet_exchange_points.csv`** — PeeringDB (peeringdb.com); Packet Clearing House. Accessed 2025-11.

**`synergy_cloud_share_2024q4.csv`** — Synergy Research Group, worldwide cloud infrastructure services shares for Q4 2024 (release on the $330 billion 2024 market), read via press-release copies (kalkinemedia.com for Amazon, Microsoft and Google; techpartner.news for the full list) on 2026-10-28; the srgresearch.com original was not read. Providers named in the release only; Huawei Cloud is not reported. Replaces the retired `cloud_market_share.csv` (2019–2024 shares and domestic-market columns that could not be traced to a source and disagreed with Synergy for Microsoft Azure, 25% against 21%). To refresh, read Synergy's latest release and edit the CSV; the script asserts the three leaders' shares.

**`cyber_economic_incidents.csv`** — CSIS *Significant Cyber Incidents Timeline*; ENISA *Threat Landscape*; authorial coding of economic dimension. Accessed 2025-12.

## Historical and Case Data

**`soviet_grain_imports.csv`** — USDA Foreign Agricultural Service historical series; Soviet statistical yearbooks. Accessed 2025-07.

**`economic_coercion_timeline.csv`** — Authorial compilation from textbook case studies; cross-referenced against Hufbauer et al. (2007), Morgan et al. (TIES/GSDB), and contemporary news sources.

**`cfius_reviews.csv`** — CFIUS *Annual Report to Congress*. Accessed 2025-11.

**`chinese_fdi_flows.csv`** — Attributed to Rhodium Group investment research and the separate AEI *China Global Investment Tracker*. Accessed 2025-12. The repository lacks a row-level extraction identifying which series supplies each observation; use as a descriptive compilation, not a harmonized dataset for causal inference.

**`industrial_policy_spending.csv`** — OECD *Industrial Policy Review*; CSIS *Industrial Policy Tracker*; national budget documents. Accessed 2025-11.

**`renewable_energy_manufacturing.csv`** — IEA *Renewables 2024*; BloombergNEF. Accessed 2025-10.

**`australia_china_trade.csv`** — DFAT *Composition of Trade* series; ABS. Accessed 2025-09.

## Sourced extracts added 28 October 2026

Each file below carries a `source` column and a `vintage` (and, where relevant, `series`) column. Where a refresh script exists it compares the fetched values with the committed extract and exits non-zero on any difference (`--check`); none falls back to stored values.

**`ofac_penalties_by_year.csv`, `ofac_settlements_150m.csv`** — U.S. Treasury, OFAC, *Civil Penalties and Enforcement Information* year pages (`ofac.treasury.gov/civil-penalties-and-enforcement-information/<year>-enforcement-information`), 2006 to 27 October 2026. OFAC's own amounts only; global resolutions that also involved the Justice Department, the Federal Reserve or state regulators are larger than the OFAC figure. Refresh: `python3 scripts/fetch_ofac_penalties.py`. Figure 7.3.

**`section_301_lists.csv`, `section_301_rate_steps.csv`** — USTR notices in the Federal Register (83 FR 28710, 83 FR 40823, 83 FR 47974, 84 FR 20459, 84 FR 43304, 84 FR 45821, 84 FR 69447, 85 FR 3741), read through the Federal Register API on 2026-10-28; each row has its citation and document number. The notices give list totals only; there is no sector split and no 4A/4B split of List 4's $300 billion. Figure 6.7.

**`usgs_mcs2026_world_production_2024.csv`** — USGS *Mineral Commodity Summaries 2026* data release (ScienceBase item, file `MCS2026_Commodities_Data.csv`, section "World Mine Production and Reserves"), 2024 world mine production by country for copper (mine and refinery), lithium, nickel, cobalt, graphite and rare earths. "W" (withheld) rows are flagged and excluded from the sums; the lithium world total excludes U.S. output. Figure 10.2.

**`iea_gcmo2025_refined_shares.csv`** — IEA, *Global Critical Minerals Outlook 2025*, refined production shares by country for 2024 and the 2035 base case (CC BY 4.0; read from the chart pages' embedded CSV). Graphite is battery-grade and rare earths are magnet elements only. Figure 10.2.

**`energy_fossil_production_2024.csv`** — Energy Institute *Statistical Review of World Energy*, via the Our World in Data energy dataset (`owid-energy-data.csv`), 2024 production of coal, oil and gas in TWh by country. Figure 10.2.

**`south_africa_gdp_rand_1980_1994.csv`** — World Bank, *World Development Indicators*, South Africa: `NY.GDP.MKTP.KD.ZG` (real GDP growth, annual %) and `PA.NUS.FCRF` (official exchange rate, rand per US dollar, period average), last updated 2026-10-08. Refresh: `python3 scripts/fetch_worldbank_south_africa.py`. Figure 9.2.

## Notes on Reproducibility

- All figures are regenerable via `Rscript R/figures/<name>.R`. Figures depend on `R/setup_theme.R` for palettes and typography.
- Where a dataset is labeled "authorial compilation" or "authorial coding," the reader should treat it as an analytical construct supported by underlying primary sources rather than as an official statistic.
- Projections (e.g., dollar reserves 2024–2050) are scenario-based and should not be cited as forecasts without the accompanying scenario narrative from Chapter 10.
- For policy developments after April 2026, readers should consult primary sources directly; the dataset snapshots are intended to support analysis of the historical trajectory, not to track current policy.

