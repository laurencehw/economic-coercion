# Citation Audit

*Purpose:* strengthen the manuscript's sourcing. This file records (a) what was
added to the central bibliography in this pass, (b) in-text scholarly citations that
still need a full reference, (c) institutional/data sources each chapter cites that
should appear in that chapter's "Data Sources and Further Research" section, and
(d) a spot-check of numeric claims that may lack an inline source.

*Method:* in-text parenthetical author–year citations in each chapter body were
matched against the central bibliography and the chapter's own end-matter
(References / Data Sources). Anything matching neither is reported below. Matching is
lexical, so treat the lists as a worklist, not a verdict.

*Important matcher caveat:* several providers **are** already in the central
bibliography under their full names and were not gaps even where flagged by an early
pass — e.g. `IEA` = International Energy Agency, `FAO` = Food and Agriculture
Organization, `IFA` = International Fertilizer Association, `Rhodium` = Rhodium Group,
`BIS` = Bank for International Settlements. For reader convenience, consider adding the
acronym in parentheses to those central-bibliography entries so a reader who sees
"(IEA 2022)" can find "IEA" alphabetically.

---

## A. Added to the central bibliography in this pass

**Scholarly works** (cited in-text, previously absent; details given conservatively —
verify page ranges before publication):

- Paarlberg, Robert L. "Lessons of the Grain Embargo." *Foreign Affairs* 59, no. 1 (1980). — cited repeatedly in Ch.9; the key source for the grain-embargo case.
- Copeland, Dale C. *Economic Interdependence and War*. Princeton University Press, 2015. — Ch.3 (and the interdependence-and-war theme generally).
- Bellemare, Marc F. "Rising Food Prices, Food Price Volatility, and Social Unrest." *AJAE* 97, no. 1 (2015): 1–21. — Ch.3.
- Hendrix, Cullen S., and Stephan Haggard. "Global Food Prices, Regime Type, and Urban Unrest in the Developing World." *Journal of Peace Research* 52, no. 2 (2015): 143–157. — Ch.3.
- Brinkman, Henk-Jan, and Cullen S. Hendrix. "Food Insecurity and Violent Conflict." World Food Programme Occasional Paper, 2011. — Ch.3.
- Smil, Vaclav. *Enriching the Earth*. MIT Press, 2001. — Ch.3 (fertilizer / Haber–Bosch).
- Heckscher, Eli F. *The Continental System: An Economic Interpretation*. Oxford University Press, 1922. — Ch.9 (historical blockade case).

**Data / institutional providers** (added to "Data Sources and Databases"): USGS
(*Mineral Commodity Summaries*), SWIFT (*RMB Tracker* / activity statistics), IMF
(COFER and WEO databases), OECD (Main Science and Technology Indicators), OPEC
(*Annual Statistical Bulletin*), UN Comtrade, World Food Programme, TechInsights,
SemiAnalysis, Benchmark Mineral Intelligence, Congressional Research Service.

---

## B. Scholarly citations still needing a full reference (please verify and add)

These appear in-text but I could not resolve them to a source already in the repo, and
I was not confident enough of the exact publication to add them without risking wrong
details. Suggested identifications are marked *(verify)*.

- **Ch.3** — `Szabo 2022` *(verify: likely Stephen F. Szabo on German–Russian relations / energy)*; `Phillips McDougall 2020` *(agribusiness/agro-chemical market data — confirm report title)*.
- **Ch.2** — `Chang 2021` *(confirm author and outlet)*.
- **Ch.9** — `Jentleson 1986` *(verify: Bruce W. Jentleson, *Pipeline Politics*, Cornell UP, 1986)*; `Crawford and Klotz 1999` *(verify: Crawford & Klotz, eds., *How Sanctions Work: Lessons from South Africa*, Macmillan, 1999)*; `USDA 1981` (the 1981 USDA grain-embargo assessment — add to Ch.9 Data Sources).
- **Ch.5** — `IPlytics 2023`, `PitchBook 2024`, `Mandiant 2013` (Mandiant is in the central bib as the 2013 *APT1* report — cite it by that name); `Rhodium Group 2024` (Rhodium is in the central bib; add the specific 2024 product).
- **Ch.8** — `Sovereign Wealth Fund Institute 2024`; `Congressional Budget Office 2022` (CBO is cited; add a CBO entry to the bibliography).
- **Ch.7** — institutional report-years to pin to specific publications: `AIIB Annual Report 2024`, `NDB Annual Report 2024`, `CIPS Annual Report 2024`, `People's Bank of China 2025`, `UN Panel of Experts 2023`.
- **Ch.10** — `Cobalt Institute`, `United Nations World Water Development Report 2023` (add to Ch.10 Data Sources).

---

## C. Institutional sources to list in each chapter's "Data Sources" section

Cited in-text as the basis for statistics; add to the relevant chapter's Data Sources
list (most now also appear centrally, per Section A):

- **Ch.1:** Kpler (2021), TankerTrackers.com (2020), IEA, USGS.
- **Ch.2:** ASML, TechInsights, Benchmark Mineral Intelligence, FDA, USGS, U.S. Dept. of Commerce, CSIS, SCMP, Reuters.
- **Ch.3:** FAO, IFA, OPEC (*Annual Statistical Bulletin*), UK ONS, USDA, WFP, Bruegel.
- **Ch.4:** TechInsights, SemiAnalysis, OECD, NSF (*Science & Engineering Indicators*), UNESCO Institute for Statistics.
- **Ch.5:** IPlytics, PitchBook, Rhodium Group, U.S. Treasury.
- **Ch.6:** USDA / USDA FAS, UN Comtrade, Congressional Research Service, PIIE (trade-war tracker), USGS.
- **Ch.7:** IMF (COFER/WEO), SWIFT (RMB Tracker), BIS, OFAC, PBOC, AIIB, NDB, CIPS.
- **Ch.8:** Rhodium Group, CBO, Sovereign Wealth Fund Institute, Bloomberg.
- **Ch.9:** USDA (1981 assessment); Paarlberg now central.
- **Ch.10:** USGS (*Mineral Commodity Summaries*), Benchmark Mineral Intelligence, Cobalt Institute, UN World Water Development Report.

---

## D. Numeric claims to spot-check for a source (sample, not exhaustive)

The sentence-level scan over-flags, because it splits on "U.S." and misses citations in
the adjacent sentence; most flags are false positives. The following are genuine
candidates for an explicit source:

- **Ch.4:** fab build cost ("$15–20 billion"), EUV machine price ("$150–200 million"), leading-firm R&D ("$15–20 billion each") — widely reported industry figures, but currently uncited.
- **Ch.3:** Suez transit fees ("$6–7 billion annually"), Ukraine gas-transit fees ("$2–3 billion"), Russian gas revenue ("$150–200 billion … 30–40% of the federal budget").
- **Ch.7:** market-size figures (U.S. corporate bond market "~$10 trillion", European "~$4 trillion") and enforcement fines (BNP Paribas "$8.9 billion") — the fines are well known but should carry a source.
- **Ch.2:** fab water use ("20–30 million gallons daily"), per-fab cost ("$15–20 billion").

These are reasonable to leave with a general source (industry trackers, company filings)
rather than a precise citation, but each should at least trace to the chapter's Data
Sources list.
