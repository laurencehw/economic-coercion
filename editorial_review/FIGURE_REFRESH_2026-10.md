<!-- Filed 2026-10-28 from the figure-refresh session's worker report. -->

> **What this is.** The record of the October 2026 pass that replaced synthetic and hand-entered figure data with sourced data (or cut the figure, or kept it as a labelled illustration). It was written by the Claude session that did the work for the coordinating session ("the lead"); paths under `/home/claude/` are that build container's. Every commit it lists has since been pushed (branch HEAD when this file was added: `fba051d`). Per-figure decisions are also in the tracker sheet (https://docs.google.com/spreadsheets/d/1Edv1UHZGLHRfKpRoqGseEemMVhxPOjBKU8ePs0SxKBw).
>
> **What needs the author.** Section 3 lists chapter claims that the real data contradict or no longer support. Chapter prose was **not** changed except where the section says so (captions were made truthful). Section 4 lists blocked sources and what would unblock them.

# economic-coercion: figure data refresh (worker report, 2026-10-28)

Repo: /home/claude/economic-coercion, default branch, one local commit (not pushed): `fba051d`.
Everything was drawn here with `/home/claude/mm/renv/bin/Rscript` from committed extracts in `data/sources/` (each with
`source` and `vintage` columns), and every PNG was viewed. `python3 scripts/qa_manuscript.py` ends "All checks passed" (49 figures embedded).
Two refresh scripts were added (`scripts/fetch_ofac_penalties.py`, `scripts/fetch_worldbank_south_africa.py`). Both fail loudly, have a
`--check` mode and print old-versus-fetched differences; I tested them only against mocks built from the extracts (mocks stayed in /tmp),
because the container cannot reach ofac.treasury.gov or api.worldbank.org. A first `--check` run on Windows is worthwhile.
Commit trailer: the brief's `Claude Opus 5.5` line was used, as instructed. The session model is actually Sonnet 5.5, so the trailer does not name the model that did the work.

## 1. Tracker table

| sheet_row | figure | decision | done | new what_is_synthetic text | source used |
|---|---|---|---|---|---|
| 169 | fig_06_07_section_301 | replace | 2026-10-28 | Nothing synthetic: trade value per list (A) and additional duty by list and effective date (B) as stated in the USTR notices; the invented sector splits are gone and the notices give no 4A/4B split of List 4's $300B. | USTR Section 301 notices, Federal Register: 83 FR 28710, 83 FR 40823, 83 FR 47974, 84 FR 20459, 84 FR 43304, 84 FR 45821, 84 FR 69447, 85 FR 3741 (FR API, `data/sources/section_301_lists.csv`, `section_301_rate_steps.csv`) |
| 170 | fig_07_03_sanctions_programs | replace | 2026-10-28 | Nothing synthetic: OFAC settlements of $150M or more (A) and all OFAC penalties and settlements by year (B), OFAC's own amounts only; the hand-entered country allocation is gone. | OFAC "Civil Penalties and Enforcement Information" year pages 2006 to 27 Oct 2026 (`ofac_penalties_by_year.csv`, 21 rows, total $7,917,367,316.85; `ofac_settlements_150m.csv`, 15 rows); refresh `scripts/fetch_ofac_penalties.py` |
| 171 | fig_08_04_industrial_policy | cut (panel B only; panel A kept) | 2026-10-28 | Panel B (stylized even spread) removed; panel A plots programme totals from `industrial_policy_spending.csv` and the Chinese entries there are still unverified (asserts pin CHIPS 52.7, IRA 369, Big Fund 98.2). | none new; existing `data/sources/industrial_policy_spending.csv` |
| 172 | fig_10_02_new_dependencies | replace | 2026-10-28 | Nothing synthetic: China's share of mining and refining 2024 with the IEA 2035 base case (A) and the largest producer's share for fossil fuels versus critical minerals (B); the hand-entered concentration, China-exposure and demand-growth values are removed. | USGS Mineral Commodity Summaries 2026 data release (ScienceBase, `MCS2026_Commodities_Data.csv`); IEA Global Critical Minerals Outlook 2025 (chart-page CSV, CC BY 4.0); Energy Institute Statistical Review via OWID `owid-energy-data.csv` (2024) |
| 173 | fig_10_01_dollar_reserves | keep as illustration | 2026-10-28 | Paths to 2050 are author scenarios (illustrative assumptions, not data) from an observed IMF COFER 2025Q3 anchor of 56.92%; the render source line now says so. | IMF COFER, IMF Data Brief of 19 Dec 2025 (anchor re-verified); no new data |
| 174 | fig_10_05_scenario_matrix | keep as illustration | 2026-10-28 | Positions and planning weights are author judgments; already labelled "Author's illustration (stylized, not data)" in the render and in the Chapter 10 caption, nothing further needed (PNG regenerated and found unchanged, so reverted). | none |
| 175 (fig 5.5) | fig_05_05_cloud_market | replace (partial: domestic-share panel cut) | 2026-10-28 | Nothing synthetic: Q4 2024 worldwide shares of the providers Synergy names (76% of the market); Huawei Cloud is not reported and no public source gives shares inside China or the US, so that panel and the retired `cloud_market_share.csv` are removed. | Synergy Research Group release on the $330B 2024 cloud market, read through two press-release copies (kalkinemedia.com for Amazon/Microsoft/Google; techpartner.news for the full list), `synergy_cloud_share_2024q4.csv`; the srgresearch.com original was not read |
| 175 (fig 6.2) | fig_06_02_trade_war_escalation | keep, dates re-checked (rows relabelled) | 2026-10-28 | Dates come from the Federal Register for US rows and from secondary timelines for Chinese rows; the vertical position is the author's ordinal judgment; unverified value and rate cells are blank. | Federal Register: 83 FR 3541, 83 FR 11619/11625, 83 FR 28710, 83 FR 40823, 83 FR 47974, 84 FR 20459, 84 FR 22961, 84 FR 43304, 84 FR 45821, 85 FR 29849, 85 FR 51596, 86 FR 30145, 87 FR 62186, 88 FR 73424/73458, 89 FR 76581; government.nl release (Dutch controls); California Research Bureau chronology (6 Jun 2019); Business Insider timeline (Aug 2019) |
| 175 (fig 6.5) | fig_06_05_equipment_market_share | keep as illustration | 2026-10-28 | Shares are rounded approximations with no traceable table (SEMI and VLSI Research are paywalled), labelled "Author's illustration (stylized, not data)"; only the EUV monopoly is a sourced fact. | Counterpoint Technology Market Research top-five 2023 WFE revenue of $93.5B (EE Asia, 2024), quoted for scale only |
| 175 (fig 9.2) | fig_09_02_apartheid_timeline | replace (panels B, C; panel A kept as chronology) | 2026-10-28 | Nothing synthetic in B and C: real GDP growth and the rand-dollar annual average 1980-1994 from the World Bank; panel A is the author's dated chronology and carries no data. | World Bank WDI, ZAF, `NY.GDP.MKTP.KD.ZG` and `PA.NUS.FCRF` (lastupdated 2026-10-08), `south_africa_gdp_rand_1980_1994.csv`; refresh `scripts/fetch_worldbank_south_africa.py` |
| 175 (fig 9.3) | fig_09_03_historical_outcomes | keep as illustration | 2026-10-28 | Both axes are the author's rough estimates and judgments, entered by hand and not drawn from or coded against any dataset; now labelled "Author's illustration (stylized, not data)". | none |

## 2. Windows render

No render is required: all ten figures were drawn here and committed. Optional, to exercise the two fetch paths against the live sites:

```powershell
"economic-coercion" = {
  Run "python scripts/fetch_ofac_penalties.py --check"
  Run "python scripts/fetch_worldbank_south_africa.py --check"
}
```
Both exit 1 if the live values differ from the committed extracts. Optional re-render with Windows fonts (Arial), only if the lead wants the
house typeface instead of the cloud fallback:

```powershell
"economic-coercion" = {
  Run "& '$Rscript' R/figures/fig_05_05_cloud_market.R"
  Run "& '$Rscript' R/figures/fig_06_02_trade_war_escalation.R"
  Run "& '$Rscript' R/figures/fig_06_05_equipment_market_share.R"
  Run "& '$Rscript' R/figures/fig_06_07_section_301.R"
  Run "& '$Rscript' R/figures/fig_07_03_sanctions_penalties.R"
  Run "& '$Rscript' R/figures/fig_08_04_industrial_policy.R"
  Run "& '$Rscript' R/figures/fig_09_02_apartheid_timeline.R"
  Run "& '$Rscript' R/figures/fig_09_03_historical_outcomes.R"
  Run "& '$Rscript' R/figures/fig_10_02_new_dependencies.R"
  Run "python scripts/figures/render_scenarios.py"
}
```
Missing R packages: none for these scripts (`readr` is not on the repo's QA allowlist, so the new scripts use base `read.csv`).

## 3. Real data that contradicts or changes chapter claims (the lead / author decides about prose)

Prose edits I made, all to keep a caption or lead-in truthful about what the figure now is: Chapter 5 (the cloud-share sentence, see 3a), Chapter 6 (Figure 6.2 lead-in and caption), Chapter 9 (Figure 9.3 lead-in "aggregates observed outcomes" now says it is the author's judgment). No other body prose was changed.

**a. Fig 5.5 (Chapter 5).**
- The repo's old 2024 table said AWS 31, Azure 25, Google 12, Alibaba 4.0, Tencent 1.8, Huawei 2.8, Oracle 3.0. Synergy's published Q4 2024 shares are Amazon 30, Microsoft 21, Google 12, Alibaba 4, Oracle 3, and Salesforce, IBM and Tencent 2 each. Azure was 4 points too high.
- Chapter 5 said U.S. hyperscalers hold "roughly two-thirds"; Synergy's three sum to 63%. I changed the sentence to "about three-fifths (63 percent ... Q4 2024)". The techpartner copy quotes a 68% top-three figure for "public cloud", which I did not use because the copy does not tie it to Synergy.
- "Inside China, the ranking inverts: Alibaba and Huawei lead, and the American incumbents are marginal" is now **unsourced**. The old panel B behind it had no traceable source, and I removed the "(Figure 5.5)" pointer from that sentence. It needs a citation (Canalys or IDC China cloud reports are the likely sources, both not reachable here).

**b. Fig 6.2 (Chapter 6).** Checked row by row; changes to `trade_war_timeline.csv`:
- 2021-06-03 was labelled "Entity list expansion, 59 Chinese entities". It is Executive Order 14032 (86 FR 30145, signed 2021-06-03), a Treasury securities-investment prohibition, not an Entity List action. Relabelled; the "59" was dropped because the Annex is an image in the Federal Register and could not be counted.
- 2023-01-27 "Netherlands Japan export controls" is the date of press reports of a US-Dutch-Japanese understanding. The Dutch government announced the measures on 8 March 2023 and published them 30 June 2023, in force 1 September 2023 (government.nl). Redated to 2023-03-08 and limited to the Netherlands; Japan's measures were not checked. Chapter 4 line 609 still refers to "the January 2023 trilateral understanding", which matches the press-report date, not the official one.
- 2020-05-15 "TSMC restrictions" is the Huawei foreign direct product rule (85 FR 29849); relabelled.
- 2024-05-14 "EV tariffs 100%, $18B": the $18B (2023 trade value) covers all 382 subheadings in the May proposal, not electric vehicles alone; the 100% EV rate took effect 2024-09-27 (89 FR 76581). The row keeps the announcement date and says so.
- Steel and aluminum: 25% steel and 10% aluminum (not one 25%), in force 2018-03-23, all countries except Canada and Mexico; the solar safeguard (2018) is global, not China-specific. Their value cells are blank because the proclamations state none.
- Not verified and so left blank or flagged: Chinese Round 1 (2 April 2018, about $3B), all Chinese tariff rates, Phase One's $200B purchase figure (from the agreement text, not re-read), the 2019-08-01 announcement date of List 4. Rounds 2, 3, 4, 5, 6 dates and values are corroborated by a CRB chronology and a timeline, and Round 6's timing by 84 FR 45821.
- The old caption and source line said "tariff rates and dates are sourced" and "2018-2025"; the data end May 2024.
- Chapter 6 line 77 quotes "15% on $112 billion" for List 4A; see 3c.

**c. Fig 6.7 (Chapter 6).** The Federal Register notices give $300B for the whole of List 4 and no 4A/4B split. The "$112 billion" in Chapter 6 (line 77) and in the old figure is a PIIE-style figure I could not trace to a notice, so it is not plotted. The old caption said "2018-2025"; the notices read cover through February 2020.

**d. Fig 7.3 (Chapter 7).** OFAC's own amounts differ from the totals the chapter quotes for the same cases, because the chapter figures are combined resolutions with other agencies:
- Standard Chartered: chapter "$1.1 billion (2019) (OFAC)", OFAC amount $657.0M. UniCredit: chapter "$1.3 billion (2019) (OFAC)", OFAC $611.0M.
- The old "Deutsche Bank $258M" is not an OFAC row; $258,660,796 in OFAC's list is Commerzbank (2015).
- Barclays 2010: old $298M is a combined total; OFAC $176M. Societe Generale "$1.3 billion, 2018" in the text compares with an OFAC amount of $53.97M.
- The sentence "programs are added far more readily than they are retired" is orphaned from the data and unsupported.

**e. Fig 8.4 (Chapter 8).** The Chinese entries in `industrial_policy_spending.csv` are unverified, `METADATA.md` and `DATA_DICTIONARY.md` give inconsistent sources for the file, and Fig 8.3 includes an "author's estimate" share. I only removed the stylized panel B.

**f. Fig 10.2 (Chapter 10).**
- "China processes 60 to 90%" of critical minerals: IEA 2024 refined shares range 31% to 95% (copper 44%, nickel 31% with Indonesia the top refiner at 43%, rare earth magnets and graphite above 90%).
- "Mining itself remains dispersed": at the mining stage China holds 82% of graphite and 71% of rare earths (USGS 2024).
- Old panel C gave coal China exposure of 20%; the Energy Institute data give 51.8%.
- Lithium prose "Australia about 50%, Chile 25%" is 2023 vintage; 2024 is 37.3% and 22.0%. Cobalt "DRC about 74%" is consistent.
- Uranium dropped (no matching source). The demand-growth panel was removed (no consistent source reachable).
- The repo's own `critical_minerals_data.csv` disagrees with the old panel B (nickel 35 versus 65, manganese 55 versus 95).

**g. Fig 9.2 (Chapter 9).** World Bank WDI matches the old typed series except 1989 real GDP growth, typed 0.3 and actually 2.39 (and a 0.01 rounding in 1983). Chapter text against WDI: "GDP growth slowed from around 5% annually in the 1960s to near-zero in the 1980s" - the 1961-69 mean is 5.77% but the 1980-89 mean is 2.24% (1985-93 mean 0.58%), so "near-zero" fits only the late 1980s and early 1990s. "About $0.40 per rand by 1989, some R2.50 to the dollar": the 1989 annual average is $0.38 (R2.62); 1988 was $0.44 (R2.27). "The dollar first surpassed the rand only in March 1982" is not checkable from annual data; the 1982 annual average (0.92 dollars per rand) is consistent.

**h. Fig 10.1 (Chapter 10, and Chapter 7).** The anchor, COFER 2025Q3 56.92%, was re-verified against the IMF Data Brief of 19 December 2025. Newer vintages exist: 2026Q1 57.18% (brief of 1 July 2026) and 2026Q2 56.70% (brief of 30 September 2026; euro 20.60%, RMB 2.11%, total $13.22tn). I did not move the anchor because Chapter 7 quotes 2025Q3 in many places and the QA script checks that vintage. The lead decides.

## 4. Blocked or partial rows and what unblocks them

- Fig 5.5 inside-China and inside-US shares: need a free, citable source (Canalys or IDC China cloud tables, or a Synergy regional release). Until then the claim in section 3a has no figure.
- Fig 5.5 original release: the Synergy press release on srgresearch.com was not read directly; I used two press-release copies that agree on the shared numbers. Reading the original would let the vintage line drop "via press-release copies".
- Fig 6.5: SEMI, VLSI Research or Gartner equipment-share tables (paywalled), or the five companies' segment revenues from filings plus SEMI's total sales, would allow a replacement.
- Fig 6.2 Chinese rows: State Council Customs Tariff Commission or MOFCOM announcements were not reached; the rows rest on secondary timelines.
- Fig 8.4 and Fig 8.3: Chinese programme sizes need a primary source.
- Fig 9.2 panel A and Fig 9.3 stay author-compiled by design.
- Not blocked, but no source found: Fig 10.2 uranium and demand growth.

## 5. Commit, diff and checker

`fba051d` "Replace untraceable figure data with sourced extracts (rows 169-175)", 42 files changed, 979 insertions, 410 deletions. Not pushed.
Main parts: 10 PNGs and 10 R/Python scripts regenerated or edited; chapters 5, 6, 7, 8, 9, 10 captions and alt text; 9 new CSV extracts in `data/sources/` (2 retired or replaced: `cloud_market_share.csv` removed, `trade_war_timeline.csv` rewritten); 2 new refresh scripts; `FIGURE_LOG.md`, `data/METADATA.md`, `DATA_DICTIONARY.md` updated.

```
$ python3 scripts/qa_manuscript.py
...
  PASS  chapters carry the standard pedagogical blocks
Scenario assumptions
  PASS  scenario CSVs have valid anchors, shares, quadrants, and weights
  PASS  reserve chart anchor agrees with Chapter 7's quoted vintage
  PASS  scenario weights agree with all four chapter headings
  PASS  scenario figure captions disclose their assumptions
  PASS  unsupported sanctions-rate and probability figures remain retired
  note: 49 figures embedded
All checks passed.
```

## 6. Data access routes found (reusable)

- Federal Register API in the browser tab: `/api/v1/documents.json?conditions[term]=...&conditions[agencies][]=...&conditions[publication_date][gte]=...&fields[]=citation&fields[]=document_number&fields[]=signing_date&fields[]=effective_on`, then `/api/v1/documents/<doc>.json?fields[]=raw_text_url` for full text. `conditions[citation]` does not work; annexes that are images (EO 14032) are not in the text.
- OFAC year pages parse as HTML tables (date, name, count, total USD).
- ScienceBase item JSON (`?format=json`) lists files; USGS `MCS2026_Commodities_Data.csv` has the "World Mine Production and Reserves" section ("W" means withheld).
- IEA chart pages embed a `data:text/csv` anchor in the live DOM; iea.org works in the browser tab but not WebFetch.
- OWID energy dataset on GitHub raw (`owid/energy-data`, `owid-energy-data.csv`) holds Energy Institute data; 2024 is the latest year.
- World Bank API works from the browser tab (same-origin `fetch`); a direct navigation to the URL showed "Request Error" but `fetch` inside the page returned 200.
- DBnomics' IMF COFER mirror is stale (July 2025); use IMF data briefs instead. ScienceDirect showed a Cloudflare captcha (not bypassed).
