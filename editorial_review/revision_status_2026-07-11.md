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

1. ~~**Verification phase**~~ — **COMPLETED later the same day** (workflow `wf_dcb00893-f3c`, 6 agents, ~430 checks). Results: the revision held up under adversarial re-verification — 89 spot-checked 2025–26 claims were confirmed accurate (incl. *Learning Resources v. Trump*, Busan truce, BIOSECURE = §851 FY2026 NDAA / P.L. 119-60 with WuXi AppTec added June 8 2026, OBBBA = P.L. 119-21, chip specs, CFIUS CY2024). 17 of 20 canonical statistics were fully conformed across all files. Fixed in the verification commit: US–China R&D market-rate gap (~double, not 40%), GERD fifth (not sixth) filling, China now THIRD-largest Treasury holder (behind Japan and the UK since March 2025 TIC), 9 previously-unresolvable citations given verified bibliography entries, two fabricated references replaced with real publications (Kennedy & Shivakumar "Competing for Critical Minerals" → Baskaran & Schwartz, CSIS; Triolo & Greene 2023 → Triolo 2024, *American Affairs*), Reuters Nvidia entry corrected (CFO Kress, not CEO), canonical RMB row set to 1.93% (COFER 2025Q3).
2. **Not embedded (deliberate):** orphaned figures fig_06_07, fig_08_08, fig_10_02, fig_10_06 (generated but data vintage unverified — fig_08_08 prints "2023 Total Reviews: 380" which may conflict with the canonical CFIUS 2024 stats), plus ch4/ch7/ch8 orphans; legacy `create_figure_*.py` cruft in figures/ not purged.
3. ~~**Phase 5 (deferred by design)**~~ — **COMPLETED 2026-07-11** (workflow `wf_9e676d6d-de7`, 10 rewrite agents + 2 factual-preservation verifiers + inline structure check). One canonical treatment established per repeated topic (Oct 2022 → ch1 vignette/ch4 detail; TSMC → ch2 deep-dive; Huawei 5G → ch5 Case Study 2; UEL/AFSL → ch6; CIPS/BNP Paribas → ch7 single tellings; ch6 case study reduced to framework application; ch6 data-sources trimmed to standard scale; ch8 vestigial case study folded in). Bullet scaffolding converted to prose in ch4 (quantum/space/biotech/innovation), ch6 (regimes/WTO), ch8 (allied screening/SOEs), ch9 (historical cases + cross-case synthesis), ch10 (climate/tech/alliances). Ch7 untouched stylistically (verified: diff shows only its four named dedup cuts). Verifiers traced every removed number/date/citation: 5 dropped facts found and restored (ch6 Biden tariff rates, 19.3% peak average, ~21% retaliation average, March 2018 announcement; ch2 national-development-fund attribution); Japan rare-earth dependence figures reconciled across ch2/ch3/ch9.
4. **Phase 6 (remaining):** index, external expert reads, final automated QA. Note: ch2 and ch9 both carry a 2010 rare-earths case study (different lenses: supply-chain vs. historical effectiveness) — acceptable, but an editor may wish to differentiate them further.

## Flagged by agents — RESOLVED by verification pass (2026-07-11, second workflow)

- **RMB reserve share:** 1.93% (COFER 2025Q3) CONFIRMED correct; canonical table updated to match.
- **Kennedy & Shivakumar (CSIS 2023):** REFUTED — no such publication; replaced with Baskaran & Schwartz (CSIS) in appendix and exercises/ch03.
- **Triolo & Greene 2023:** REFUTED — replaced with Triolo 2024, "A New Era for the Chinese Semiconductor Industry," *American Affairs* 8(1).
- **OBBBA P.L. 119-21:** CONFIRMED (congress.gov).
- **BIOSECURE:** CONFIRMED — §851 of FY2026 NDAA, P.L. 119-60 (Dec 18, 2025); WuXi AppTec designated June 8, 2026.

## Remaining open items (author judgment)

- **Phillips McDougall 2020** (ch3:100, agrochemical market concentration ~60–65%): real firm (now AgbioInvestor/S&P Global), but the specific 2020 publication is unverifiable — supply a citable source or re-attribute to AgbioInvestor/industry data.
- Low-severity, deliberate-vintage items: ch1 dollar share "58% (COFER 2024)" vs ch7 "56.92% (2025Q3)" — both correct for their dates; ch7 SWIFT RMB share 2.73% (Dec 2025 Tracker) vs canonical ~2.9% (June 2025) — both real prints; "(SCMP 2024)" acronym never glossed.
- Chapter agents' full flag lists: workflow journals `wf_dea597f6-151` and `wf_dcb00893-f3c` under `~/.claude/projects/.../subagents/workflows/`.

## Recommended next steps

1. Review the working-tree diff (`git diff`, ~1,200 insertions) and commit in logical chunks.
2. When spend budget allows: run the verification phase as a small standalone workflow (stat-drift, citation resolution, two adversarial spot-checks).
3. Then Phase 5 (dedup/voice) as its own reviewed pass.
