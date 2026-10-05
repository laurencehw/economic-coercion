# Textbook Review and Revision — October 4, 2026

**Baseline:** upstream `main` at `3ed9e14146ec4dbd84f21465ba6004dca37af8c4`.
**Assessment:** **8.6/10 before this revision; 9.3/10 after it**, as a provisional internal editorial assessment. The weighted revised score is 9.295 before rounding, above 9.2. This is a judgment about the reviewed manuscript, not an independent expert endorsement or a claim that every empirical assertion has been externally verified.

## Method and Rubric

Reviewed the structure and learning apparatus of all ten chapters, the Conclusion, both existing front/back matter and Appendix A; performed targeted substantive reads of the legal, technology, financial, historical, and scenario passages; inspected source CSVs and the figure pipeline; and audited all manuscript navigation and index links. Inspected the defective sanctions/reserve charts and the revised scenario figures visually. This was a structural and targeted substantive review, not a line-by-line external fact-check of the entire roughly 150,000-word manuscript. The prior August review’s 9.4 rating was treated as evidence to investigate, not a score to inherit.

| Dimension | Weight | Before | Revised | Basis for revised assessment |
|---|---:|---:|---:|---|
| Analytical rigor | 25% | 9.0 | 9.4 | Two-margins framework retained; causal claims disciplined and operational exercises added |
| Evidence and disclosure | 25% | 8.0 | 9.0 | Unsupported quantitative displays retired; observations, assumptions, and distinct data systems separated |
| Pedagogy | 20% | 8.8 | 9.5 | Six worked problems connect classification, substitution, incidence, inference, and robust decisions |
| Clarity and precision | 15% | 8.8 | 9.2 | Legal authorities, timelines, units, and standards mechanisms stated more precisely |
| Production and reproducibility | 15% | 8.2 | 9.5 | Corrected figures regenerated; inventory and anchors checked; new regression tests run in CI |

The revised score remains conditional on the limitations below. A score should fall if later source verification contradicts an important claim; meeting a numerical target does not override evidence.

## Findings and Executed Fixes

**Sanctions effectiveness.** Figure 9.3 claimed analysis of 712 historical cases and ranked six instrument types. Its six-row CSV provided no case records, harmonization, or extraction procedure supporting that attribution. Figure 9.4 assigned 20/35/50/65% success probabilities to a decision tree without calibration. Both charts and their generators were retired, together with the sanctions-rate CSV. Chapter 9 now compares what published estimates can establish and supplies a qualitative decision protocol. The remaining historical-outcomes chart, already disclosed as author scoring, is renumbered 9.3. No replacement empirical rates were invented.

**Reserve paths and scenarios.** The old Figure 10.1 used a 25% lower axis limit while including euro and renminbi series below that limit, mixed historical and future vintages, and included pre-2016 separately identified CNY values without derivation. The replacement uses one observed anchor—the book’s 2025Q3 dollar share of 56.92%—and three explicitly illustrative paths. Existing future dollar-path endpoints are retained; unsupported other-currency histories and projections are removed. The shaded span is labeled as an assumption range, not a confidence interval. Figure 10.5 now uses the chapter’s 2035–2050 horizon, explicit planning weights, and bubble areas proportional to those weights. Its low crisis-scenario position refers to bilateral bloc rivalry, not low regional danger.

**Legal and historical precision.** Chapter 8 now distinguishes the August 6, 2020 IEEPA transaction order from the August 14 CFIUS-related divestiture order and their different deadlines. Australia filed both barley and wine WTO disputes; the duties ended after negotiated reviews, rather than the claimed 2024 WTO victory or an unfiled wine case. Chapter 6 distinguishes the March 2018 direction to take action from tariffs implemented in July/August. Chapter 7 corrects February 26 to two days after the invasion, separates EU-regulated SWIFT messaging restrictions from asset blocking and dollar clearing, and distinguishes Venezuela’s government/sectoral measures from a comprehensive country embargo. Chapter 9 distinguishes the UN arms embargo from national anti-apartheid trade and financial measures.

**Inference and technical mechanisms.** The FDI decline is no longer attributed entirely to FIRRMA without a comparison. Chapter 4 recognizes SMIC’s pre-October-2022 7nm milestone, qualifies the claim of a hard physical node ceiling without EUV, and replaces a categorical claim about planned economies with a sector-specific innovation question. Chapter 5 separates standards contributions and patent declarations from mandatory equipment purchase and vendor lock-in. Chapter 3 corrects the Hormuz consumption-versus-trade denominator and removes a mechanically inferred price forecast. Chapter 9 no longer treats the captain’s release as proof of an independently identified rare-earth coercion effect.

**Financial denominators.** CIPS annual value is converted to a daily illustration without calling it a share of SWIFT messages. Unsupported precise rupee–ruble and Brazil–China settlement-share assertions are removed or qualified. A currency swap’s capacity is not treated as observed currency use. Rhodium research and AEI’s China Global Investment Tracker are identified as separate products.

**Teaching and maintenance.** Appendix B adds six short problems with worked answers, including a scenario decision whose preference reverses when weights change. Chapter 1 links the exercises to its inference framework; the Preface and navigation make them discoverable. The updated figure inventory is 49, down from the 51 actually present at baseline—not the 52 claimed by the earlier review. Two figures now use a committed Python/matplotlib renderer and shared CSV validation; 47 retain their R generators. Documentation and CI reflect that split.

## Validation and Limits

- All 22 manuscript QA checks pass, including the new reserve-anchor, scenario-weight, disclosure, and retired-figure checks.
- Eight regression tests pass, including mismatched anchors, future observations, invalid percentages/years, reversed shading bounds, incorrect weight totals, duplicate identities, and misplaced quadrants.
- Both revised figures were rendered locally with matplotlib 3.10.8 and visually inspected. All 49 embedded PNG paths and generator mappings resolve.
- Local Markdown targets, index anchors, and GitBook hint-pair counts were audited; whitespace checks pass. The appendix’s worked arithmetic was independently recalculated.

The environment’s shell network proxy was unavailable; the snapshot and changes use the authenticated GitHub connector. No fresh external source retrieval is claimed. Added primary-source references identify the corrected authorities and disputes, but access dates have not been invented. R, PowerShell, and a full HonKit dependency installation were unavailable locally, so the unchanged R pipeline, PowerShell QA, and full web build were not executed here. GitHub CI validates the manuscript and regenerates the two changed figures before merge; the existing deploy workflow runs after merge.

The external sanctions-practitioner, semiconductor, and China-specialist reads described in `expert_review_brief.md` remain valuable. In particular, leading-node market shares, the PPP R&D crossing, corporate yield estimates, recent policy developments, and legacy CSV source extraction deserve specialist verification. Remaining source-provenance gaps should be resolved with raw releases, series identifiers, and extraction code, not another layer of confident chart captions. The book’s central framework and Conclusion’s final reflections are strong and preserved.
