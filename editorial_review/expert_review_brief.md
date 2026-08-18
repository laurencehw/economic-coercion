# Expert Reviewer Brief

**Prepared:** 2026-08-18
**For:** the three external reads recommended in `full_book_review_2026-07-11.md` (item 19) and
`full_book_review_2026-08-18.md` — one sanctions lawyer or practitioner, one semiconductor
analyst, one China specialist.

Two internal review cycles have fixed roughly forty verifiable errors, reconciled the
figures to the canonical statistics in `DATA_DICTIONARY.md`, and put mechanical checks
in CI. What remains is the class of error no internal process catches: claims that are
internally consistent, correctly sourced, and wrong — or right but stated with more
confidence than the evidence carries.

This brief exists so a reviewer's limited hours go where they pay. It is not a request
to read 150,000 words. Each section below names the specific claims most likely to be
wrong and where to find them.

---

## How to record findings

Please give each finding as: **location** (chapter and section, or figure number),
**the claim as written**, **what is wrong**, and **the correction with a source**. A
one-line note is worth more than a paragraph of impression. If a claim is defensible
but should be hedged, say so — several of the items below are contested rather than
false, and knowing which is which is the point.

---

## 1. Sanctions lawyer / practitioner

**Estimated time: 4–6 hours.** Read Chapter 6 (trade controls), Chapter 7 (financial
statecraft), Chapter 8's CFIUS sections, and the Government Tools boxes throughout.

### Highest-risk claims

The book cites legal authorities constantly — IEEPA 52 times, Section 301 44 times,
FIRRMA 43, Section 232 23, EAR 19, ECRA 14 — and the July review found that the single
worst error in the first draft was a statute misattribution (October 2022 controls
described as issued under IEEPA when they were issued under ECRA/EAR), sitting inside a
box teaching legal authorities. That error class is the reason this read matters most.

Specific things to check:

- **Which authority does what.** ECRA/EAR versus IEEPA versus Section 232 versus
  Section 301 — particularly wherever the book describes an action's legal basis rather
  than just its effect. Chapter 6's export-control sections and Chapter 1's Government
  Tools Box 1 are the concentrations.
- **The 2025 IEEPA tariff litigation.** Chapter 6's Phase 5 rests on *Learning Resources
  v. Trump* being decided 6–3 in February 2026 holding that IEEPA does not authorise
  tariffs. Verify the holding, its scope, and what it left standing.
- **Civil penalty figures.** The book distinguishes the IEEPA maximum ($377,700,
  2025 inflation adjustment) from the ECRA/EAR maximum ($374,474). Both are stated;
  confirm both, and that the distinction is drawn correctly in each place.
- **CFIUS mechanics.** Chapter 8 states CY2024 as 325 transactions (116 declarations,
  209 notices), 49 withdrawals of which 42 refiled, China filing the most notices of any
  country at 26. Confirm against the Treasury annual report, and check the description of
  mandatory versus voluntary filing, the declaration process, and mitigation agreements.
- **Secondary sanctions and extraterritoriality.** Chapter 7's account of how secondary
  sanctions actually bind non-US persons, and the over-compliance discussion.
- **Statutes cited by public law number:** BIOSECURE (§851 of the FY2026 NDAA, P.L.
  119-60), OBBBA (P.L. 119-21), PAFACA, CHIPS (P.L. 117-167), FIRRMA (P.L. 115-232).
- **Whether the off-ramps discussion** in the Conclusion describes sanctions relief
  mechanics as they actually work.

---

## 2. Semiconductor analyst

**Estimated time: 3–5 hours.** Read Chapter 2 (supply chains), Chapter 4 (technology
competition), and Chapter 6's technology-specific control sections.

### Highest-risk claims

The first draft garbled chip specifications badly enough that the July review listed
them among its highest-severity findings (A100 memory bandwidth and FLOPS, the October
2022 performance thresholds). Those were corrected, but this is exactly the material
where a non-specialist's corrections can themselves be wrong.

Specific things to check:

- **The October 2022 control thresholds** and their subsequent revisions — the
  interconnect-bandwidth and compute criteria, and how the 2023 update changed them.
- **Device specifications** wherever stated: A100, H100, H20, Ascend 910B/910C. The book
  uses 600 GB/s and 400 GB/s figures in places; confirm each against the part it
  describes.
- **Node claims.** 3nm, 5nm, 7nm, 14nm, 28nm appear throughout, with claims about who can
  produce what. Particularly: SMIC's 7nm yields, what DUV multipatterning can and cannot
  reach economically, and the GAA transition.
- **Equipment market shares.** Figure 6.5 puts ASML at ~30%, Applied Materials 20%,
  Tokyo Electron 15%, Lam 13%, KLA 7%, and the US/Japan/Netherlands split at 40/15/30.
  Confirm the basis (all WFE versus lithography-only) and the numbers.
- **EDA concentration** — the book states the top three at ~74–75% combined, with Siemens
  EDA correctly identified as German-owned. Confirm, including the advanced-node figure.
- **The DeepSeek argument.** Chapter 4 treats DeepSeek as a test of algorithmic
  substitution under export controls. Is the technical characterisation right, and is the
  inference the chapter draws from it sound?
- **Figure 2.1** (semiconductor geography) and **Figure 4.1** (chip supply chain stages) —
  whether the chokepoints identified are the right ones.

---

## 3. China specialist

**Estimated time: 4–6 hours.** Read the Chinese Perspective boxes in every chapter,
Chapter 8's industrial-policy sections, Chapter 2's rare-earth and 2010 case study, and
Chapter 10's Chinese-vision box.

### Highest-risk claims

The perspective boxes are the book's most distinctive feature and its most exposed. They
attempt to steelman Chinese positions, which means a misreading is both more likely and
more damaging than in ordinary exposition.

Specific things to check:

- **Do the Chinese Perspective boxes represent actual Chinese policy discourse**, or a
  Western reconstruction of it? Where they cite Chinese sources, are those sources
  representative or cherry-picked? This is the single most valuable judgment this read
  can offer.
- **Institutional accuracy.** MOFCOM, NDRC, SASAC, PBOC, CAC, MIIT, SAMR, GACC appear as
  actors; confirm each is doing what the book says it does.
- **Big Fund phases** — I, II and III at ¥138.7B/¥204.15B/¥344B (~$21B/$29B/$47.5B), with
  Phase III established May 2024. Confirm sizes, dates, and what Phase III is actually
  funding.
- **The Unreliable Entity List and Anti-Foreign Sanctions Law** — how they have actually
  been used versus how they are described, and whether the book overstates or understates
  their bite.
- **Dual circulation** and the 14th Five-Year Plan — whether the book's characterisation
  matches the documents.
- **The 2010 rare-earth episode.** Chapter 2 and Chapter 9 both treat it, through
  different lenses. Was there a formal embargo? The scholarly dispute here (King and
  Armstrong argue no ban occurred) is cited; confirm the book represents it fairly.
- **Rare-earth shares** — ~70% mining, ~90% processing/separation. And gallium at ~98%,
  germanium ~60%.
- **Chinese R&D composition** — business enterprises performing ~78% and funding ~77%,
  government ~20%. This corrects a common misconception and is worth confirming.

---

## Cross-cutting: two claims the author has already flagged as contested

Both are live disagreements rather than errors, and a reviewer's view would settle them.

1. **Chinese R&D on a PPP basis** (Chapter 4, and Figure 4.4). The book states that
   China has *not yet* passed the United States — roughly $840B against $990B on the
   OECD MSTI series — and describes the crossing as imminent. Some NSF and OECD readings
   put the crossing at or before 2024. The disagreement turns on the PPP deflator vintage.
   Which framing should stand?

2. **The renminbi's reserve trajectory** (Chapter 10). The baseline scenario originally
   projected 15–18% of allocated reserves by 2050; this was moderated to 8–15% on the
   grounds that the binding constraint is capital-account convertibility rather than
   economic size, and that an eightfold rise from 1.93% sits awkwardly against the
   book's own argument that de-dollarization rhetoric outpaces reality. Is the moderated
   range right?

---

## What is already known and does not need re-checking

To save time, these have been verified internally and are documented in
`DATA_DICTIONARY.md`'s canonical statistics table with sources and as-of dates:
US–China trade on a goods basis, China's Treasury holdings and its slip to third place,
sanctions success rates from Hufbauer et al., OFAC staffing and SDN list size, submarine
cable counts, Australian wine export shares and duty removal dates, CFIUS CY2024, US and
Chinese orbital launches, and the WWI blockade mortality figures.

Six embedded figures rest wholly or partly on the author's ordinal scoring rather than
measurement — Figures 2.4, 4.3, 6.2, 9.5, 10.5 and 10.6. Each says so in its caption. They
are offered as ways of organising the material, and a reviewer should treat disagreement
with the scores as a matter of judgment rather than a factual finding, unless the ordering
itself is wrong.

---

## Reproducing the figures

Every figure is generated from `R/figures/*.R` against data in `data/sources/`. All
dependencies are on CRAN. `python3 scripts/qa_manuscript.py` verifies figure numbering,
data consistency, and apparatus integrity, and runs in CI on every pull request.
