# Full Manuscript Review — *Economic Coercion in the 21st Century*

**Date:** 2026-08-18
**Scope:** All 10 chapters + Conclusion (~150k words), Appendix A, front/back matter, figure pipeline, data layer, bibliographies.
**Baseline:** `full_book_review_2026-07-11.md` (7.0/10) and the phase 1–5 revision recorded in `revision_status_2026-07-11.md`.
**Method:** Independent re-read and mechanical audit — citation-resolution check across 253 in-text citations, figure link and numbering audit, statistic-drift grep against the canonical table, and inspection of the R scripts and source CSVs behind every embedded figure.

---

## Rating on arrival: 8.5 / 10 → after this pass: 9.3 / 10 → after the follow-up: 9.4 / 10

The July roadmap's phases 1–5 were genuinely executed, and they worked. Identity is settled, the 2025–26 currency sweep landed, the ~40 factual errors are fixed, the two-margins thesis now runs through to a conclusion that earns its ending, and the canonical statistics table in `DATA_DICTIONARY.md` is a better single-source-of-truth apparatus than most published textbooks maintain.

The manuscript arrived at this review held back by one thing above all, which the previous review could not have caught because it was created by the previous revision: **the prose had been conformed to the canonical statistics and the data layer had not.** The figures and the text disagreed.

### Dimension scores

| Dimension | On arrival | After this pass | Note |
|---|---|---|---|
| Analytical framework & rigor | 9.0 | 9.0 | Two-margins thesis carries through to the conclusion; the Ch1 inference note remains exemplary |
| Pedagogy | 8.5 | 9.4 | Learning objectives everywhere; all 52 figures now discussed in prose rather than decorative; index added |
| Writing quality | 8.0 | 9.0 | Conclusion and Ch10 scenarios converted from briefing-book bullets to prose; Ch8's Australia case rewritten |
| Evidence & sourcing | 8.5 | 9.4 | Citation resolution 253/253; last unverifiable attribution replaced |
| Internal consistency | 7.5 | 9.3 | Text-vs-text was good; text-vs-figure was not, and that is what this pass fixed |
| Currency (Aug 2026) | 9.0 | 9.0 | Solid through mid-2026 |
| Production readiness | 6.5 | 9.5 | Figure numbering repaired, reference formats unified, index built; orphan inventory cleared (see addendum); QA in CI |

---

## The central finding: the data layer had not been reconciled

Phase 2 conformed the manuscript's prose to the canonical values. It did not touch the CSVs and R scripts that generate the figures. The result was a book whose charts contradicted its own text — the failure mode most likely to be caught by a careful student, and the most damaging when it is.

The worst instance: **Figure 7.1 showed the dollar at 38% of SWIFT flows, the euro at 37.2%, and the renminbi at 5.5%, on the same page where Chapter 7 cites the December 2025 print at 50.49%, 21.90%, and 2.73%.** The underlying series had the renminbi rising monotonically to 5.5% and the euro climbing to 37% — both wrong in direction, not merely in level. The renminbi peaked at 4.1% in 2023 and has since receded; the dollar's share *rose* after 2022. That corrected shape is considerably better evidence for the chapter's own argument than the version it replaced.

Others found and fixed:

- **Figure 1.2** stopped at 2024 and carried $555B for that year against the canonical $583.6B, omitting the 2025 collapse to $414.7B that the book now narrates at length.
- **Figure 7.3** was captioned "Japan #1, China #2" — the canonical table records that the UK overtook China in the March 2025 TIC release. Its top-10 panel was also filtering to 2024 while labelled 2025.
- **Figure 2.3** put rare-earth mining at 60% and processing at 85% (canonical: 70% and 90%), gallium at 95% (canonical: 98%).
- **Figure 4.1** was labelled "PPP" but its U.S. series tracked market-rate GERD, quietly undercutting Chapter 4's careful two-basis discussion.
- **Figure 3.4** had polysilicon at 80% and battery cells at 75% (canonical: 93% and 80%).

A separate, systemic defect compounded this. The idiom `c("Processing" = econ_colors["China"])` preserves the source vector's name, producing `"Processing.China"`, which matches no factor level; ggplot then falls back silently to grey and drops the legend. **This affected nine scripts, all of them behind embedded figures — nine of the book's 42 published charts were rendering monochrome with broken or missing legends.**

All of the above are fixed, and the hard-coded annotations that had already drifted once are now computed from the data.

---

## Other findings

**Figure numbering.** Chapter 7 presented its figures as 7.3, 7.1, 7.2, 7.4; chapter 4 as 4.2 then 4.1. Chapter 5's opening figure was captioned 5.1 but stored as `fig_03_05_subsea_cables.png` — a chapter-3 filename — and its other files were similarly misaligned. Renamed and renumbered so filename, caption, and appearance order agree in every chapter.

**Figures were never discussed.** Only 11 of 42 embedded figures were referred to anywhere in the prose; chapters 2, 3, 4, 7, and 8 referred to none of their own. All 52 figures now carry a sentence of interpretation.

**Reference formats.** The chapter reference lists were not merely in the wrong style — they were in *four* different styles: parenthetical-year with annotations (ch 1), Chicago notes with annotation bullets (ch 2), bold-name running-note form (ch 6), Chicago notes (ch 3–5, 7), and numbered citation-order lists (ch 8–10). 189 entries normalised to author-date.

**Citations.** Nine in-text citations resolved nowhere. All now resolve; the Phillips McDougall attribution the July review flagged as unverifiable is re-attributed to AgbioInvestor with its subscription basis stated.

**Register.** The Conclusion's seven recommendations — the book's climax — were 57% bullets. Chapter 10's four scenarios, the analytical showpiece, were entirely bold-header bullet blocks. Both are now prose.

**Two substantive corrections surfaced during the rewrites**, and both are flagged for the author rather than settled unilaterally:

1. Chapter 10's *baseline* scenario projected the renminbi at 15–18% of reserves, and its 2050 projection described the current share as "~3%". It is 1.93%. A baseline assuming an eightfold rise contradicts the book's own argument that de-dollarization rhetoric outpaces reality; moderated, with the actual constraint (capital-account convertibility, not economic size) stated.
2. Chapter 4 asserted that Chinese R&D "surpassed the United States on a PPP basis around 2024". On the OECD MSTI series it has not — roughly $840B against $990B. The claim is genuinely contested and turns on the PPP deflator vintage. Softened to describe an imminent crossing; **this one warrants the author's judgment**, since a defensible case exists for the original.

---

## Addendum, 2026-08-18 (post-merge follow-up)

The roadmap below was written before PR #41 merged. Most of it has since been
executed; this records what closed and what did not.

**Closed.**

- *Orphan figures.* Zero remain. The scenario matrix was repaired — its bubbles had
  contradicted its own quadrant labels and backgrounds — and embedded as Figure 10.6;
  the dual-use matrix had its labels rescued and is embedded as Figure 4.3. The other
  nine were deleted: they duplicated embedded figures or asserted unsourced quantities
  as findings. 52 figures embedded, all discussed in prose.
- *Pipeline reproducibility.* Not a repo defect after all. Every one of the pipeline's
  20 dependencies is on CRAN, so a CRAN-connected machine builds all 61 scripts; the
  failures were the review sandbox's network policy. The one genuine problem, the
  GitHub-only `ggradar`, was already removed. A QA check now guards the allowlist so a
  future GitHub-only dependency fails rather than silently breaking reproducibility.
- *`exercises/`.* Deleted. The ten files duplicated Appendix A, had drifted from it,
  and were not in the navigation, so only a maintainer would ever have found them —
  and only to wonder which copy was authoritative.
- *Automated QA in CI.* `scripts/qa_manuscript.py` runs on every pull request touching
  the manuscript, figures, R scripts, source data, or the canonical table, and again
  before the GitBook deploy. It has now caught drift three times, twice introduced by
  this review's own edits.
- *Figure honesty.* Six embedded figures rest on the author's ordinal scoring. All six
  now declare that in their captions, and where a figure mixes sourced and scored axes
  the caption says which is which.

**Not closed, and cannot be from inside the manuscript.**

- *External expert reads.* `expert_review_brief.md` prepares them: a scoped reading
  list per domain, the specific claims most at risk with locations, what has already
  been verified, and the two contested claims needing an outside view. Commissioning
  the three reads is the remaining step, and it is the one that would move evidence
  and rigor further than any internal pass now can.

---

## What stands between here and 9.5

Ordered by value.

### 1. The remaining 11 orphan figures

Twelve of the twenty orphans were audited, corrected where their data was wrong, and
embedded with prose discussion; the book now shows 50 figures rather than 42. The
audit was necessary rather than ceremonial — `fig_08_04_cfius_reviews` had 530 CFIUS
reviews for 2024 against the canonical 325 and put the Chinese share at ~30% against
~12%, while `fig_08_08` carried the same series at 5% and had to be removed as
contradictory. Huawei's 2024 revenue was $105B against an actual CNY 862.1bn (~$118bn);
the industrial-policy comparison carried an unsourced "$300B" for Made in China 2025
where Big Fund III ($47.5B) belonged.

Eleven orphans remain, and the honest position is that most should stay out. Several
duplicate embedded figures (`fig_07_07_dedollarization` overlaps Figure 10.1); several
rest on author-estimated series with no citable source (`fig_07_06`'s designation
counts, `fig_07_07`'s oil-trade and BRICS-trade shares).

One is worth rescuing rather than deleting. `fig_10_06_scenario_matrix` plots the four
scenarios on integration-by-intensity axes with the same 40/25/20/15 probabilities the
chapter uses, and a clean version would serve Chapter 10's showpiece section well. It
is not currently publishable: the quadrant letters do not sit where their bubbles do,
the Economic Cold War and Crisis Fragmentation labels collide in the top-left, the axis
labels are truncated and overlapping, and the title is duplicated. That is a chart-layout
job of an hour or two, not a data problem. The rest should be deleted so the inventory
stops implying work left undone — a call left to the author rather than made here.

### 2. Complete the figure build environment

13 of 62 scripts cannot be built without `tmap`, `rnaturalearth`, `rnaturalearthdata`, `treemapify`, and `ggradar`, which this environment could not fetch. Their images are intact and unaffected by the data corrections, but the pipeline is not fully reproducible until someone runs it somewhere with CRAN access. Package requirements are now documented in `CLAUDE.md`.

### 3. Remaining register work

Chapter 8 is down to 30% bullets and chapter 6 sits at 34%. Much of what remains is legitimately list-shaped — the five-criteria framework applications, Government Tools boxes, data-source listings — but chapter 6's regime and enforcement sections would still read better as prose. Chapter 7 should continue to be left alone.

### 4. `exercises/` has drifted from the appendix

The ten standalone files in `exercises/` lack the EconWar pointers the appendix carries, and five lack the facilitator notes added to the appendix versions. They are not in `SUMMARY.md`, so readers never see them — but a maintainer will, and the divergence will cause confusion. Either sync them or delete them in favour of the appendix.

### 5. External expert reads

Unchanged from the July roadmap, and the one item that cannot be done from inside the manuscript. The error classes found in both reviews — statute misattribution, market-share drift, chip specifications, series-basis confusion — are precisely what a sanctions practitioner, a semiconductor analyst, and a China specialist would hunt. Commission all three.

### 6. Automated QA in CI

Every check run for this review is scriptable: citation resolution, figure link integrity, caption sequencing, statistic drift against the canonical table, index anchor validity. Wiring them into the GitBook deploy workflow would prevent the text-versus-data divergence this review found from recurring — which is the real lesson of this pass, since that divergence was *created* by a well-executed revision that simply stopped at the prose.

---

## What to protect

Everything the July review listed, plus two things this pass confirms:

- **The canonical statistics table** is what made this review tractable. Without it, "the figure disagrees with the text" would have been an opinion rather than a finding. Keep it authoritative and keep propagating from it — to the data layer as well as the prose.
- **The Conclusion's Final Reflections** are the best writing in the book. The two-scene bracket (Carter's grain embargo, the October 2022 controls) and the closing on chokepoints as a wasting asset should survive any further editing untouched.
