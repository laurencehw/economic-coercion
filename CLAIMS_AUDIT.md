# Claims audit (October 2026)

Every falsifiable claim we could reach in the ten chapters, the conclusion and the two appendices was checked against a source, and the text was corrected in place where it was wrong. The row-level ledger is `CLAIMS_AUDIT.csv`. Each row covers one claim and records:

- the sentence as it stood;
- the status;
- the old and new values;
- the source;
- a locator (URL or local data file, with a verbatim snippet);
- a note.

## Method

**Claim classes**

| Class | What it covers |
|---|---|
| A | Numbers with a date |
| B | Attributions of acts or words |
| C | Quotations |
| D | Formulas and definitions |
| E | Dates and sequences, including executive orders, statutes and rulings |
| F | Characterisations of a study's finding |

**Statuses**

| Status | Meaning |
|---|---|
| verified | Read in a source this session |
| corrected | The text now carries the verified value |
| softened | The direction is verified; the specific number or detail was dropped |
| removed | The claim was taken out |
| unverified-unreachable | The source named in the text could not be fetched; the text is unchanged |

**Rules for sources and edits**

- `DATA_DICTIONARY.md` holds the canonical values. Chapter text was conformed to them. No canonical entry was changed; the entries that look wrong are listed below for you.
- Primary legal and official sources were preferred: Federal Register, OFAC, BIS, Census, USGS, EIA and IEA.
- Hypothetical scenario facts in Appendix A were out of scope.
- A quotation keeps its quotation marks only if the wording was confirmed against the source. Otherwise it is now attributed paraphrase.
- `scripts/qa_manuscript.py` passes after every chapter's edits.
- New sources used in corrections were added to each chapter's reference list. They are also collected in a new section at the end of `front_matter/bibliography.md`.
- Claims that were never attempted are not in the ledger. The main ones are listed at the end.

**Rate.** The rate is corrected plus removed class A/B claims per 1,000 body words. Body words are the text before Key Insights, Discussion Questions or References.

## Results

Ch 1: 47 claims checked — 31 verified, 14 corrected, 1 softened, 0 removed, 1 unreachable. Corrected or removed class A/B: 10 in 17,287 words (0.58 per 1,000).
Ch 2: 50 claims checked — 19 verified, 19 corrected, 7 softened, 1 removed, 4 unreachable. Corrected or removed class A/B: 17 in 18,723 words (0.91 per 1,000).
Ch 3: 41 claims checked — 18 verified, 16 corrected, 6 softened, 0 removed, 1 unreachable. Corrected or removed class A/B: 13 in 11,315 words (1.15 per 1,000).
Ch 4: 58 claims checked — 24 verified, 21 corrected, 10 softened, 1 removed, 2 unreachable. Corrected or removed class A/B: 15 in 20,195 words (0.74 per 1,000).
Ch 5: 44 claims checked — 26 verified, 13 corrected, 5 softened, 0 removed, 0 unreachable. Corrected or removed class A/B: 5 in 12,919 words (0.39 per 1,000).
Ch 6: 84 claims checked — 43 verified, 29 corrected, 7 softened, 5 removed, 0 unreachable. Corrected or removed class A/B: 20 in 15,582 words (1.28 per 1,000).
Ch 7: 51 claims checked — 22 verified, 14 corrected, 13 softened, 0 removed, 2 unreachable. Corrected or removed class A/B: 11 in 13,685 words (0.80 per 1,000).
Ch 8: 69 claims checked — 34 verified, 23 corrected, 6 softened, 5 removed, 1 unreachable. Corrected or removed class A/B: 20 in 13,543 words (1.48 per 1,000).
Ch 9: 54 claims checked — 25 verified, 19 corrected, 10 softened, 0 removed, 0 unreachable. Corrected or removed class A/B: 12 in 14,238 words (0.84 per 1,000).
Ch 10: 43 claims checked — 28 verified, 13 corrected, 2 softened, 0 removed, 0 unreachable. Corrected or removed class A/B: 9 in 12,036 words (0.75 per 1,000).
Conclusion: 8 claims checked — 5 verified, 3 corrected, 0 softened, 0 removed, 0 unreachable. Corrected or removed class A/B: 0 in 2,318 words (0.00 per 1,000).
Appendix A: 50 claims checked — 19 verified, 22 corrected, 4 softened, 5 removed, 0 unreachable. Corrected or removed class A/B: 23 in 18,013 words (1.28 per 1,000).
Appendix B: 9 claims checked — 8 verified, 1 corrected, 0 softened, 0 removed, 0 unreachable. Corrected or removed class A/B: 0 in 1,217 words (0.00 per 1,000).

**Whole book: 608 claims checked; 155 corrected or removed class A/B claims in about 171,000 words (0.91 per 1,000).**

The book as a whole is just under the 1.0 threshold. Four parts are over it:

- **Chapter 8 (1.48):**
  - Chinese FDI trend now follows the canonical Rhodium/BEA row.
  - CHIPS award status updated.
  - BIOSECURE mechanics corrected.
  - Australia wine and barley figures corrected.
- **Chapter 6 (1.28):**
  - Phase One, Census trade, Section 301 exclusions and the Article XXI chronology corrected.
  - An unsourced "T-7" coalition subsection removed.
- **Appendix A (1.28):**
  - ECRA statute cite corrected.
  - Taiwan, semiconductor and rare-earth background statistics corrected.
- **Chapter 3 (1.15):**
  - EU and member-state gas dependence, Suez flows and grain/fertiliser shares corrected.

The commonest errors were figures from 2019–2022 left standing after newer data had replaced them. Examples:

- TSMC foundry share: 54% → ~70%.
- Lithium mining shares.
- Huawei revenue.
- e-CNY users.

## For the author

**Canonical values and data files that disagree with what the audit found**

- **Row 7 (Hufbauer et al.).** It says "174 case studies / 204 episodes"; the audit could confirm only the 204 episodes.
- **Row 9 (RMB payments share).** It gives a peak of 4.74% (December 2023), but `swift_currency_data.csv` has 4.1%.
- **`us_china_trade.csv` vintages.** The CSV carries older vintages than Census and the canonical row:
  - 2008: CSV $409.3B, canonical $407.5B.
  - 2018 imports: CSV 539.5, Census 538.5.
  - 2019 imports: CSV 451.7, Census 449.1.
- **`chinese_fdi_flows.csv` (Fig 8.2).** It still has 2024 = $2.5B and 2018 = $5.4B. The text now follows canonical row 13; Rhodium gives $4.8B for 2018.
- **AI data (Ch 4, Fig 4.2).** `ai_publications.csv` and `ai_development_indicators.csv` predate the Stanford AI Index 2025, which the text now follows (publications 23% China vs 9% US).
  - `Government_AI_Spending` in the CSV contradicts "rivals or exceeds".
  - Fig 4.4's EU R&D value is 455 in the CSV against $386B in the text.
- **Graphite (Fig 6.6B).** `critical_minerals_data.csv` gives China's graphite mining share as 0.65; USGS 2026 gives ~82%.
- **Soviet grain (Fig 9.1).** The grain CSV shows 1980 imports of 35.5 Mt; the text says 31 Mt.
- **SWIFT series (Fig 7.2).** The figure splices two SWIFT series, so the euro's fall from 36.3% to 22.4% in 2023 is a change in method, not a real drop. Add a break marker or truncate the figure.
- **2050 dollar share (Ch 10).** The chapter gives four values: Fig 10.1 (50.5%), the hint box, "gradual erosion" (35–40%) and "most defensible" (35–45%).

**Cross-chapter consistency**

- **TSMC "~90% of advanced chips".** Chapter 2 keeps it, citing CSET 2021, but it could not be confirmed. Chapter 4 softened it to "large majority". Appendix A now says Taiwan hosts ~90% of advanced logic capacity below 10nm (BCG–SIA). Pick one wording.
- **Grain embargo duration.** Chapter 9 says "sixteen months" and the conclusion says "fifteen" (4 Jan 1980–24 Apr 1981 is about 15.7 months).
- **Grain embargo: Canada.** Chapter 9 says Canada "declined to join" and expanded sales. The conclusion now says Canada restrained its exports. Canada and Australia pledged "normal" levels, but their sales to the USSR still rose. Pick one framing.
- **Section 232 precedent (Ch 6).** Key Insights and the Precedent Alert box say other states "followed" the 2018 Section 232 precedent. Russia (2016) and the UAE (2017) invoked GATT Article XXI first.
- **CoCom staffing (Ch 6).** One passage says "no secretariat"; another describes a "small staff in the US Embassy in Paris".

**Sources to check**

- **Wilse-Samson (2013).** The Chapter 1 claim that Malawi and Mozambique withdrew mine labour (your paper) was not reached.
- **Chapter 9 South Africa box.** Group Areas removals now read "nearly 600,000", sourced to Wikipedia only.
- **Chapter 3 gas shares.** The member-state gas shares (Italy, Poland, Hungary, Czechia, Bulgaria) come from Anadolu Agency citing Bruegel and IEA. They need the Bruegel dataset to count as primary.
- **Chapter 7 OFAC figures.** The Standard Chartered and UniCredit amounts labelled "(OFAC)" are global resolutions; the OFAC portions are $0.66bn and $0.61bn.
- **Chapter 7 Gopinath sentence.** The "asymmetric pass-through" sentence misdescribes the paper.
- **Unsourced items left in the text:**
  - Discussion Question 3's "Tech 10" (Ch 6).
  - The "tens of billions" of lost US revenue (Ch 4, three places).
  - The DARPA–GPS attribution (Ch 4).
- **Appendix A reading list.** Two entries were removed because they could not be found:
  - Stokes, "The Rise of Techno-Statecraft" (Carnegie 2023);
  - Burrows and Manning (Atlantic Council 2020). The closest real item is the Atlantic Council's May 2020 *Emerging Technologies: New Challenges to Global Stability*.
- **Paywalled sources.** Paarlberg (1980) and Mastanduno (1992) are cited but could not be read.

**Developments to watch**

- China's rare-earth export suspension runs until 10 November 2026.
- The December 2024 gallium and germanium ban was reportedly suspended later. This was not read and the text is unchanged.

## Claims not reached

The shared web-fetch budget ran out before these claims were attempted, so they are not in the ledger.

- **Ch 1:**
  - Russia's reserves, rouble and inflation figures.
  - China's GDP and manufacturing shares.
  - Belt and Road counts.
  - Soviet computer lag; KGB Directorate T.
  - German auto profit shares.
- **Ch 2:**
  - Germanium share.
  - DRAM and NAND shares.
  - Kleinhans and Baisakova (2020).
  - Dates of the Unreliable Entity List and the Anti-Foreign Sanctions Law.
- **Ch 3:**
  - Six-country wheat trade share.
  - IEA processing shares.
  - Corn, rice, soy and potash shares.
- **Ch 4:**
  - Fab and EUV costs.
  - A100 and H100 specifications.
  - Big Fund scandals.
  - Huawei FDPR (2020).
- **Ch 5:**
  - Volt Typhoon sectors.
  - Baltic cable incidents.
  - UK Huawei cap; Canada's 2022 ban.
  - P.L. 118-50 dates.
- **Ch 6:**
  - Section 232 on autos and uranium.
  - Fujian Jinhua.
  - Solar Section 201.
  - EU "systemic rival".
  - Lithuania.
- **Ch 7:**
  - SWIFT message counts.
  - mBridge dates.
  - Iran's frozen assets.
- **Ch 8:**
  - Allied screening regimes.
  - FIRRMA thresholds.
  - CFIUS 2008–15 statistics.
  - CNOOC/Unocal.
- **Ch 9:**
  - Sullivan Principles.
  - Euroclear holdings.
  - Price-cap level.
  - Thousand Talents; China Initiative.
- **Ch 10:**
  - Prasad's figures.
  - OPEC share.
  - G7 shares.
  - US share of world GDP in 1945 and 2024.
- **Appendix A:**
  - Most of the reading list.
  - Cable-cut precedents.
