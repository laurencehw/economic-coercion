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

---

## E. Citation pass (Ch.2–10): quantitative claims still needing a source

During the chapter-by-chapter citation pass, the claims below were left uncited because
no source already in the book genuinely covers them. They need a source the author can
supply (or a decision to soften/cut). This is the durable "author to verify" worklist.

**Ch.2** — Ukraine ~50% of global semiconductor-grade neon (softened in text to an estimate).

**Ch.3** — Suez transit-fee revenue ($6–7B/yr); Ukraine gas-transit-fee revenue ($2–3B/yr);
Russian gas export revenue ($150–200B; 30–40% of the federal budget); Chinese clean-energy
manufacturing "30–50% cheaper"; Jordan ~90% energy imports; Chinese phosphate export
tonnage (7–8 Mt → 1–2 Mt); China strategic petroleum reserve ~545M barrels (2020).

**Ch.4** — quantum-computing publication share (20–25%); space-launch economics (SpaceX
$/kg, China 60+ orbital launches/yr, Starlink 5,000+ sats, Guowang 13,000 sats); biotech
publication share (20%+); US/China venture-capital totals ($200–300B / $100–150B);
Chinese talent returnee rate (25% → 50%+).

**Ch.5** — SenseTime IPO valuation ($767M); GDPR fine totals (Google €8B+, Amazon €746M);
Huawei revenue ($140B→$100B) and pricing (20–30% underbid); Great Firewall ~1B users.

**Ch.9** — Europe ~40% Russian gas dependence (exec summary); apartheid-era structural
demographics (Black majority ~75%; whites ~20% holding 87% of land / 90% of formal economy;
13% of territory; Black per-capita income <10% of white); South African GDP growth
(5% 1960s → ~0 1980s); rand depreciation (R1=$1.30 1980 → R2.50 1989); Turkey 3.7M Syrian
refugees / 6M+ total; Soviet Jewish emigration (~400/yr early 1970s → 51,000 in 1979).

**Ch.10** — Russia 2022 reserve freeze ($300B+); Russia dollar-reserve composition
(40% 2018 → 10% 2024); China dollar reserves (~60%, est.); CIPS volumes/participants
(PBoC listed only as an undated database — needs a datable entry); CBDCs "130+ countries";
China U.S. Treasury holdings (~$850B, 2024); grain exporters ~80% of wheat/corn/soy;
economic-weight stats (G7 ~45% of GDP; BRICS+ ~37% GDP / ~45% population / ~25% trade;
China ~70% of BRICS+ GDP; German exports $100B+ to China; NDB ~$30B). Forward 2035–2050
projections were intentionally left uncited (author's scenario analysis, not sourced facts).

**Ch.6** — tariffs "80–95% of federal revenue" before the income tax (historical); China trade-war GDP/employment impact (−0.5–0.8% GDP; $65–100B; 1–3M manufacturing jobs); semiconductor-equipment market shares (U.S. ~40%, Japan ~30%, Netherlands 100% of EUV; coordinated controls cover ~85%); U.S. equipment-firm losses ($10–15B/yr, 2022–24); gallium/germanium "6–12 month disruptions / 20–30% price increases"; China "$17T domestic market, 28% of global manufacturing."

**Ch.7** — U.S. corporate bond market (~$10T) and European (~$4T); U.S. equity market cap (~$50T, ~40% of global), Apple ($3T), Saudi Aramco IPO ($29B); Panda/Dim Sum bond issuance (~$100B); Chinese government bond market (~$20T).

**Ch.8** — IRA "$100B+ clean-energy investment announced" and solar 80% / EV-battery 75% global shares; China semiconductor capacity (12% 2015 → 24% 2024) and SMIC 7nm yields (40–50%); central SOEs (96 SASAC groups, ~$12T assets); China = 35% of Australian exports; WuXi AppTec (20–30% of U.S. biotech; $5.4B revenue); BIOSECURE economics (~$20B market-cap loss, $5–15B U.S. cost, $40–60B Chinese revenue loss); "$40–50B lost investment annually" estimate.
