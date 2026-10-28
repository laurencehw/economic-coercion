# Figure log: house chart style

One row per embedded figure (49). Actions: restyled, split (panels reduced to those the chapter discusses; the dropped panels are not embedded), relabelled illustration, replaced with sourced data (28 October 2026), converted to table, untouched-needs-local-run, untouched-no-script.

| File | Script | Action | Flag |
|---|---|---|---|
| fig_01_01_interdependence_network.png | R/figures/fig_01_01_interdependence_network.R | restyled | network diagram, house palette |
| fig_01_02_us_china_trade.png | R/figures/fig_01_02_us_china_trade.R | restyled |  |
| fig_01_03_timeline.png | R/figures/fig_01_03_timeline.R | restyled | timeline |
| fig_01_04_framework.png | R/figures/fig_01_04_framework.R | restyled | framework diagram |
| fig_01_05_toolbox_diagram.png | R/figures/fig_01_05_toolbox_diagram.R | restyled | toolbox diagram |
| fig_01_06_cocom_timeline.png | R/figures/fig_01_06_cocom_timeline.R | restyled | timeline |
| fig_02_01_semiconductor_geography.png | R/figures/fig_02_01_semiconductor_geography.R | untouched-needs-local-run | needs rnaturalearth/sf (not installable here); in-script point data to be checked for sourcing at local run |
| fig_02_02_tsmc_dominance.png | R/figures/fig_02_02_tsmc_dominance.R | restyled |  |
| fig_02_03_critical_minerals.png | R/figures/fig_02_03_critical_minerals.R | restyled |  |
| fig_02_04_supply_chain_risk.png | R/figures/fig_02_04_supply_chain_risk.R | restyled | ordinal criticality axis labelled as author judgment |
| fig_03_01_chokepoints.png | R/figures/fig_03_01_chokepoints.R | untouched-needs-local-run | needs rnaturalearth/sf (not installable here); in-script point data to be checked for sourcing at local run |
| fig_03_02_strategic_ports.png | R/figures/fig_03_02_strategic_ports.R | untouched-needs-local-run | needs rnaturalearth/sf (not installable here); in-script point data to be checked for sourcing at local run |
| fig_03_03_russian_pipelines.png | R/figures/fig_03_03_russian_pipelines.R | untouched-needs-local-run | needs rnaturalearth/sf (not installable here); in-script point data to be checked for sourcing at local run |
| fig_03_04_renewable_manufacturing.png | R/figures/fig_03_04_renewables.R | restyled |  |
| fig_04_01_chip_supply_chain.png | R/figures/fig_04_01_chip_supply_chain.R | restyled |  |
| fig_04_02_ai_development.png | R/figures/fig_04_02_ai_indicators.R | restyled |  |
| fig_04_03_dual_use_matrix.png | R/figures/fig_04_03_dual_use_matrix.R | restyled | author ordinal scores labelled as judgments |
| fig_04_04_rd_spending.png | R/figures/fig_04_04_rd_spending.R | restyled |  |
| fig_04_05_huawei_impact.png | R/figures/fig_04_05_huawei_impact.R | split | restyled: stacked bars+totals; yoy panel dropped (split-reduced) |
| fig_05_01_subsea_cables.png | R/figures/fig_05_01_subsea_cables.R | untouched-needs-local-run | needs rnaturalearth/sf (not installable here); in-script point data to be checked for sourcing at local run |
| fig_05_02_internet_exchange.png | R/figures/fig_05_02_internet_exchange.R | restyled | restyled 2 panels, highlight Europe |
| fig_05_03_cyber_incidents.png | R/figures/fig_05_03_cyber_incidents.R | restyled | restyled; bubble size dropped; DNC (0 damage) omitted noted |
| fig_05_04_data_localization.png | R/figures/fig_05_04_data_localization.R | untouched-needs-local-run | needs rnaturalearth/sf (not installable here); in-script point data to be checked for sourcing at local run |
| fig_05_05_cloud_market.png | R/figures/fig_05_05_cloud_market.R | replaced with sourced data | single panel from data/sources/synergy_cloud_share_2024q4.csv (Synergy Q4 2024 worldwide shares, press-release copies read 2026-10-28); domestic-market panel and the retired cloud_market_share.csv removed (no public source); old 2024 values disagreed with Synergy (Azure 25 vs 21, AWS 31 vs 30); chapter claim about shares inside China now has no figure support |
| fig_06_01_us_china_tariffs.png | R/figures/fig_06_01_tariffs.R | split | reduced 3->2 panels (timeline dropped), area->bars |
| fig_06_02_trade_war_escalation.png | R/figures/fig_06_02_trade_war_escalation.R | restyled | dates re-checked: US rows against the Federal Register, China rows against secondary timelines; rows relabelled or redated (EO 14032 was mislabelled Entity List; Dutch controls moved from 2023-01-27 to 2023-03-08); the CSV now carries date_basis, source and verification columns; ordinal judgment labelled |
| fig_06_03_entity_list.png | R/figures/fig_06_03_entity_list.R | split | reduced 2 panels -> 1 stacked bars; caption said 'by administration' but figure is by year |
| fig_06_04_fdpr_reach.png | R/figures/fig_06_04_fdpr_reach.R | untouched-needs-local-run | needs rnaturalearth/sf (not installable here); in-script point data to be checked for sourcing at local run |
| fig_06_05_equipment_market_share.png | R/figures/fig_06_05_equipment_market_share.R | relabelled illustration | shares are rounded approximations not traceable to a published table; labelled author's illustration (stylized, not data); only the EUV monopoly is a sourced fact; Counterpoint's $93.5B top-five WFE revenue (2023) given for scale |
| fig_06_06_rare_earth_retaliation.png | R/figures/fig_06_06_rare_earth_retaliation.R | restyled | restyled 2 panels; timeline relabelled; minerals shares hardcoded inline; rare earth 90 vs 95-97 inconsistency flagged |
| fig_06_07_section_301.png | R/figures/fig_06_07_section_301.R | replaced with sourced data | sector splits (no source) removed; panel A trade value per list and panel B rate steps from the USTR Federal Register notices (data/sources/section_301_lists.csv, section_301_rate_steps.csv); the notices give no 4A/4B split, so the chapter's $112B for List 4A is not shown |
| fig_07_01_treasury_holdings.png | R/figures/fig_07_01_treasuries.R | split | reduced 4 panels->2 (stacked area, china area, yoy dropped); 'Others' aggregate no longer ranked in top10; biennial data |
| fig_07_02_swift_currencies.png | R/figures/fig_07_02_swift.R | split | reduced 4->2 (stacked area, donut dropped); FLAG EUR 36.3->22.4 break 2022-23 in source csv unexplained; legend used (5 series) |
| fig_07_03_sanctions_programs.png | R/figures/fig_07_03_sanctions_penalties.R | replaced with sourced data | OFAC year pages 2006-2026 (data/sources/ofac_penalties_by_year.csv, ofac_settlements_150m.csv; refresh with scripts/fetch_ofac_penalties.py); OFAC's own amounts only, so several chapter totals for combined resolutions differ; the old hand-entered country allocation is gone |
| fig_07_04_russian_frozen_assets.png | R/figures/fig_07_04_frozen_assets.R | restyled | restyled 2 panels stacked vertically; stats box dropped (foreign reserves ~55% of $630B claim no longer printed) |
| fig_08_01_bri_infrastructure.png | R/figures/fig_08_01_bri_infrastructure.R | untouched-needs-local-run | needs rnaturalearth/sf (not installable here); in-script point data to be checked for sourcing at local run |
| fig_08_02_chinese_fdi.png | R/figures/fig_08_02_chinese_fdi.R | restyled | restyled single line chart, end labels |
| fig_08_03_cfius_reviews.png | R/figures/fig_08_03_cfius_reviews.R | restyled | restyled 3 panels (A stacked bars, B lines, C line); now regenerated from corrected CSV -> chapter caption 'existing image retains unreconciled inputs' now stale |
| fig_08_04_industrial_policy.png | R/figures/fig_08_04_industrial_policy.R | split | panel B (stylized even-spread) cut; panel A only, from data/sources/industrial_policy_spending.csv with asserts on CHIPS 52.7, IRA 369 and Big Fund 98.2; Chinese entries still flagged unverified in the source table |
| fig_08_05_industrial_policy_compare.png | R/figures/fig_08_05_industrial_policy_compare.R | split | 3 panels->1 (totals + focus panel dropped); sum not like-for-like noted |
| fig_08_06_australia_china.png | R/figures/fig_08_06_australia_china.R | split | 3->2 panels (timeline dropped); B -> small multiples; AUD unit as per original label |
| fig_09_01_soviet_grain.png | R/figures/fig_09_01_soviet_grain.R | restyled | restyled 2 panels (stacked area->bars) |
| fig_09_02_apartheid_timeline.png | R/figures/fig_09_02_apartheid_timeline.R | replaced with sourced data | panels B and C from World Bank WDI (data/sources/south_africa_gdp_rand_1980_1994.csv; refresh with scripts/fetch_worldbank_south_africa.py); 1989 GDP growth corrected from 0.3 to 2.39; panel A is the author's chronology, not data |
| fig_09_03_historical_outcomes.png | R/figures/fig_09_03_historical_outcomes.R | relabelled illustration | author-judgment scatter kept and labelled author's illustration (stylized, not data); no dataset behind either axis; chapter lead-in reworded from 'aggregates observed outcomes' |
| fig_10_02_new_dependencies.png | R/figures/fig_10_02_new_dependencies.R | replaced with sourced data | two panels from USGS MCS 2026, IEA GCMO 2025 and Energy Institute/OWID extracts (data/sources/usgs_mcs2026_world_production_2024.csv, iea_gcmo2025_refined_shares.csv, energy_fossil_production_2024.csv); hand-entered concentration, China-exposure and demand-growth values removed; the render log prints old against sourced values |
| fig_10_03_critical_minerals.png | R/figures/fig_10_03_critical_minerals.R | restyled | processing/mining panels kept; vulnerability panel with hand-assigned risk score dropped (flag) |
| fig_10_04_ai_indicators.png | R/figures/fig_10_04_ai_indicators.R | split | 8 small multiples; old script filtered indicator names that do not exist in the CSV, so it could not reproduce the image; now reads CSV (flag) |
| fig_10_01_dollar_reserves.png | scripts/figures/render_scenarios.py | relabelled illustration | paths to 2050 are author scenarios, labelled; observed anchor IMF COFER 2025Q3 56.92% (checked against the IMF Data Brief of 19 Dec 2025); newer vintages exist (2026Q1 57.18%, 2026Q2 56.70%) but Chapter 7 quotes 2025Q3 throughout, so the anchor was not moved |
| fig_10_05_scenario_matrix.png | scripts/figures/render_scenarios.py | relabelled illustration | positions and planning weights are author judgments, labelled; bar panel added |

## Notes
- No file moved or renamed. `R/theme_book.R` and `scripts/book_style.py` are the new house theme files; `R/setup_theme.R` now delegates to them.
- Data integrity flags are in the Flag column; none were corrected silently.
- Maps need rnaturalearth, sf and tmap, which could not be installed; they still use the old style and need a local run.
