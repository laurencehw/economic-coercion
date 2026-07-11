# Revision Status — Phases 1–4 Orchestrated Run

**Date:** 2026-07-11
**Baseline review:** `full_book_review_2026-07-11.md` (rated 7.0/10, roadmap to 9.5)
**Decisions locked:** Title = *Economic Coercion in the 21st Century: Tools, Strategies, and Great Power Competition*; affiliation = NYU Wagner (lw3387@nyu.edu); license = CC BY-NC 4.0; part structure = SUMMARY.md's four parts + standalone Conclusion.

## Completed (working tree, NOT yet committed)

**Foundation**
- Identity (title/affiliation/license/parts) propagated: INTRODUCTION.md, title_copyright.md, preface.md, book.json, README.md, LICENSE, DATA_DICTIONARY.md contact.
- Bibliography merged into `front_matter/bibliography.md` (author-date), conflicts resolved by web verification, misfiled entries refiled, missing references added (Jentleson 1986, Crawford & Klotz 1999, Bachmann et al. 2022, etc.); `REFERENCES_BIBLIOGRAPHY.md` reduced to a pointer.
- Canonical Statistics table added to DATA_DICTIONARY.md (single source of truth for ~20 contested stats).
- Suspect references verified: Acheson/CSIS "Elements of Security" = NOT FOUND (replaced); others corrected or flagged.

**All 12 content files fixed** (ch1–ch10, appendix, glossary): the ~40 verifiable factual errors from the review, internal-contradiction reconciliation to canonical values, learning-objective blocks, and the mid-2026 currency sweep — including: ch6 Phase-5 rewrite (2025 IEEPA tariff cycle, Geneva/Busan truces, *Learning Resources v. Trump*, decided 6–3 Feb 20 2026: IEEPA does not authorize tariffs); DeepSeek + H20/revenue-share arc + Ascend 910B/C (ch4); Salt Typhoon + 2023–25 cable incidents + EU AI Act (ch5); Red Sea/Suez collapse + end of Ukraine gas transit + GERD completion (ch3); new Russia 2022–26 comparative case applying the two margins (ch9); new 2010 rare-earths Case Study 1 (ch2); OBBBA IRA rollback + Intel equity stake + PAFACA/*TikTok v. Garland* (ch8); Rosneft/Lukoil + ERA loans + GENIUS Act (ch7); appendix EconWar pointers ×10 + facilitator notes for Ex6–10 + authority/precedent updates.

**Structure**
- Conclusion extracted from ch10 into `chapters/conclusion.md` (two-margins synthesis lens + crafted ending); added to SUMMARY.md.
- Five never-run R figures generated (fig_06_07, fig_08_08, fig_09_02, fig_10_02, fig_10_06). fig_09_02 (apartheid timeline) had wrong 1980–81 rand values and an inverted axis label — fixed in the R script, regenerated, embedded in ch9's South Africa section as Figure 9.2.
- Figure captions renumbered sequential: ch3 (3.1–3.4), ch9 (9.1–9.5); ch5 embeds Figures 5.1–5.5 (formerly one mis-numbered figure); ch1/ch6/ch10 verified sequential. All 42 figure references validated as resolving.

## NOT done (monthly spend limit hit mid-run)

1. **Verification phase** — the four planned adversarial checks never ran: statistic-drift grep across all files, citation-resolution check (every in-text cite → bibliography entry), and two web-verified adversarial spot-checks of the agents' edits (+ remediation). **This is the priority when budget allows** — the revision added many 2025–26 factual claims that were web-verified by their authors but not independently re-checked.
2. **Not embedded (deliberate):** orphaned figures fig_06_07, fig_08_08, fig_10_02, fig_10_06 (generated but data vintage unverified — fig_08_08 prints "2023 Total Reviews: 380" which may conflict with the canonical CFIUS 2024 stats), plus ch4/ch7/ch8 orphans; legacy `create_figure_*.py` cruft in figures/ not purged.
3. **Phase 5 (deferred by design):** de-duplication + voice pass (bold-bullet scaffolding → prose; ch7 as register benchmark).
4. **Phase 6:** index, external expert reads, final automated QA.

## Flagged by agents (author judgment needed)

- **RMB reserve share:** ch7 agent kept 1.93% (verified against IMF COFER 2025Q3 directly) over the canonical table's 2.1% — deliberate, documented deviation.
- **Kennedy & Shivakumar "Competing for Critical Minerals" (CSIS 2023)** in appendix Ex3: could not be verified; review before print.
- **Triolo & Greene 2023** (Carnegie): author confirmed real; exact article title/date unconfirmed.
- **OBBBA public law number (119-21)** not confirmed against a primary source.
- **BIOSECURE** enacted-status wording: verify against enrolled FY2026 NDAA before print.
- Chapter agents' full flag lists: workflow journal at `~/.claude/projects/.../subagents/workflows/wf_dea597f6-151/journal.jsonl`.

## Recommended next steps

1. Review the working-tree diff (`git diff`, ~1,200 insertions) and commit in logical chunks.
2. When spend budget allows: run the verification phase as a small standalone workflow (stat-drift, citation resolution, two adversarial spot-checks).
3. Then Phase 5 (dedup/voice) as its own reviewed pass.
