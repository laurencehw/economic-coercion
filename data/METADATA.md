# Dataset Provenance and Metadata {-}

This file documents the source, coverage, and known limitations of each dataset under `data/sources/`. Figures rendered in `figures/` are built from these files via scripts in `R/figures/`. Access dates below are given to month precision (YYYY-MM) because most underlying series are monthly or annual; where a series is maintained by a public agency, readers should re-fetch for current vintages.

---

## Trade and Tariff Data

**`us_china_trade.csv`** — U.S. Census Bureau, Foreign Trade Division, *Trade in Goods with China* series (1990–2024). Accessed 2025-12. Annual, USD billions, not seasonally adjusted. Covers merchandise trade only; services trade excluded.

**`us_china_tariffs.csv`** — Peterson Institute for International Economics (PIIE) *Trade War Tariff Tracker*, Chad P. Bown, supplemented by USTR Section 301 determinations. Accessed 2026-01. Average effective ad-valorem rates by product tranche.

**`trade_war_timeline.csv`** — Compiled from USTR announcements, MOFCOM press releases, and PIIE *Trade War Tariff Tracker*. Accessed 2026-01. Event-level data, 2018–2025.

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

**`dollar_reserves_projection.csv`** — IMF *COFER* (historical); authorial scenario projections 2024–2050 (baseline, gradual erosion, fragmentation). Projections are illustrative only and should not be cited as forecasts.

**`us_sanctions_programs.csv`** — U.S. Department of the Treasury, Office of Foreign Assets Control (OFAC) *Sanctions Programs and Country Information*. Accessed 2026-01.

**`sanctions_success_rates.csv`** — Derived from Hufbauer, Schott, Elliott, and Oegg (2007) *Economic Sanctions Reconsidered* (3rd ed.), updated with Felbermayr et al. (GSDB) and Biersteker et al. (TSC) coding. Accessed 2025-08.

**`russian_frozen_assets_2022.csv`** — REPO Task Force reports; European Commission *Russian Assets Freeze* updates; U.S. Treasury press releases. Accessed 2025-12.

## Cyber, Digital, and Data

**`data_localization_laws.csv`** — OneTrust DataGuidance; ITIF *Data Localization Tracker*; national regulators. Accessed 2025-10.

**`internet_exchange_points.csv`** — PeeringDB (peeringdb.com); Packet Clearing House. Accessed 2025-11.

**`cloud_market_share.csv`** — Synergy Research Group quarterly cloud infrastructure reports; Gartner. Accessed 2025-12.

**`cyber_economic_incidents.csv`** — CSIS *Significant Cyber Incidents Timeline*; ENISA *Threat Landscape*; authorial coding of economic dimension. Accessed 2025-12.

## Historical and Case Data

**`soviet_grain_imports.csv`** — USDA Foreign Agricultural Service historical series; Soviet statistical yearbooks. Accessed 2025-07.

**`economic_coercion_timeline.csv`** — Authorial compilation from textbook case studies; cross-referenced against Hufbauer et al. (2007), Morgan et al. (TIES/GSDB), and contemporary news sources.

**`cfius_reviews.csv`** — CFIUS *Annual Report to Congress*. Accessed 2025-11.

**`chinese_fdi_flows.csv`** — Rhodium Group *China Global Investment Tracker* (with AEI). Accessed 2025-12.

**`industrial_policy_spending.csv`** — OECD *Industrial Policy Review*; CSIS *Industrial Policy Tracker*; national budget documents. Accessed 2025-11.

**`renewable_energy_manufacturing.csv`** — IEA *Renewables 2024*; BloombergNEF. Accessed 2025-10.

**`australia_china_trade.csv`** — DFAT *Composition of Trade* series; ABS. Accessed 2025-09.

## Notes on Reproducibility

- All figures are regenerable via `Rscript R/figures/<name>.R`. Figures depend on `R/setup_theme.R` for palettes and typography.
- Where a dataset is labeled "authorial compilation" or "authorial coding," the reader should treat it as an analytical construct supported by underlying primary sources rather than as an official statistic.
- Projections (e.g., dollar reserves 2024–2050) are scenario-based and should not be cited as forecasts without the accompanying scenario narrative from Chapter 10.
- For policy developments after April 2026, readers should consult primary sources directly; the dataset snapshots are intended to support analysis of the historical trajectory, not to track current policy.
