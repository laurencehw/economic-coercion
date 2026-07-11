# Full Manuscript Review — *Economic Coercion* Textbook

**Date:** 2026-07-11
**Scope:** All 10 chapters (~140k words), Appendix A (tabletop exercises), front/back matter, figures pipeline, bibliographies, data apparatus.
**Method:** Five parallel deep-read reviews (Ch 1–2, Ch 3–5, Ch 6–8, Ch 9–10 + appendix, apparatus/figures), synthesized. Line references are to files as of commit b9e9111.

---

## Overall Rating: 7.0 / 10

**One-line verdict:** The conceptual architecture, pedagogy, and analytical honesty are at an 8.5 level — genuinely above the standard for this genre — but the manuscript is dragged down by a high rate of verifiable factual errors, internal data contradictions, an uneven mid-2023-to-2026 currency patchwork, and a scholarly apparatus (bibliographies, titles, figure numbering) that would fail university-press copyediting today.

### Dimension scores (synthesized across all reviewers)

| Dimension | Score | Summary |
|---|---|---|
| Analytical framework & rigor | 8.5 | Four-dimension framework + five effectiveness criteria applied consistently; the substitution/coalitional "two margins" thesis is an original contribution; the Ch1 inference note and Ch9 South Africa attribution treatment are exemplary |
| Pedagogy | 8 | Perspective boxes, tools boxes, case studies, tabletops, discussion questions all strong; missing learning-objective blocks; figures rarely discussed in prose |
| Writing quality | 7.5 | Ch7 hits the intended wry-scholarly register; Ch5 exec summary is the best-voiced; but much of Ch4, 6, 9, 10 is bold-header briefing-book scaffolding, one register below target |
| Evidence & sourcing | 6 | Dense author-date citation, but ~40 discrete verifiable errors, ~50 uncited quantitative claims (per citation_audit §E), incomplete reference lists, and several possibly-invented Further Reading entries |
| Internal consistency | 5.5 | Same statistics quoted with different values across chapters (see reconciliation list); two conflicting bibliographies; CFIUS CY2024 given two incompatible sets of numbers |
| Currency (July 2026) | 5.5 | Pockets updated to early 2026 sit beside sections frozen in 2023–24; the 2025 US-China escalation cycle — the strongest real-world validation of the book's own thesis — is largely absent |
| Production readiness | 5 | Three different titles, two licenses, two affiliations, conflicting part structures, figure-numbering drift, 20 orphaned figures, no index |

### Chapter-level composite scores

| Chapter | Score | Note |
|---|---|---|
| Ch 1 Foundations | 7.5 | Best framework; worst statute error (IEEPA vs ECRA) |
| Ch 2 Supply Chains | 7 | Missing promised Case Study 1; API 80% contradiction |
| Ch 3 Critical Sectors | 6.5 | Most dated; frozen at mid-2023 |
| Ch 4 Technology | 7 | Analytically strong; no DeepSeek/H20; garbled chip specs |
| Ch 5 Information/Digital | 7 | Best voice; missing Salt Typhoon; wrong opening instrument (SenseTime) |
| Ch 6 Trade Controls | 6.8 | Most consequential currency failure (2025 tariff regime absent) |
| Ch 7 Financial Statecraft | 7.9 | Best chapter; near press-ready |
| Ch 8 Investment/Industrial Policy | 6.9 | Most internal contradictions; missing OBBBA/Intel equity |
| Ch 9 Historical Cases | 7.4 | Missing Russia 2022–26 comparative case |
| Ch 10 Future | 7.4 | Strong scenario method; buried conclusion |
| Appendix A Tabletops | 7.2 | Genuinely runnable; broken EconWar promise; stale backgrounds |
| Apparatus | 5 | Weakest dimension overall |

---

## What is genuinely strong (protect these in revision)

1. **The two-margins thesis** (substitution margin + coalitional margin, Ch1:366–378, reprised Ch4:11, Ch7:388, Ch9:17) — an original, internally consistent unifying mechanism. It should be the spine of the conclusion; currently it vanishes before the ending.
2. **The Ch1 "Note on Inference"** (Ch1:336–348) on selection, attribution, and coding problems — exceptional for a policy textbook.
3. **Strategic empathy done seriously** — the Chinese, European, and Global South perspective boxes are consistently steelmanned, disclaimed, and current (Ch3's Global South box and Ch7's are standouts).
4. **Chapter 7** — the CIPS/SWIFT messaging-vs-settlement analysis is better than most think-tank treatments; this is the register and rigor target for the whole book.
5. **The tabletop appendix** — ten runnable, template-consistent exercises with role constraints and escalating injects; Ex9's fictional "Meridiana" (avoiding analogy anchoring) and Ex8's CFIUS consistency test are sophisticated designs.
6. **Scenario methodology in Ch10** — probabilities, robust-vs-contingent strategies, monitoring indicators.
7. **Data provenance for CSV-backed figures** — METADATA.md + DATA_DICTIONARY.md documenting all 28 datasets is a genuine reproducibility story.

---

## What holds it back (the five problems)

### Problem 1: Verifiable factual errors (~40 discrete, practitioner-visible)

The highest-severity list — each will be caught by a practitioner reader:

| Location | Error | Correction |
|---|---|---|
| ch1:484–489 | Oct 2022 controls "used IEEPA" | Issued under ECRA (2018)/EAR — in a box teaching legal authorities |
| ch1:29 | "31 entities added to Entity List" Oct 7 2022 | Unverified List; Entity List additions (YMTC etc.) came Dec 2022 |
| ch1:672 | Sberbank in initial March 2022 SWIFT batch | Sberbank excluded June 2022 (6th package); VEB omitted from the initial seven |
| ch1:194, ch2:44, ch6:344 | EDA trio "all American" / "100% control" | Mentor = Siemens EDA (German) since 2017/2021; trio ≈ 70–80% of market |
| ch2:151 | "Samsung planning to follow" TSMC at 3nm | Samsung began 3nm GAA production June 2022, before TSMC |
| ch2:9/276 vs 282 | "China+India supply ~80% of APIs" | Contradicts own facility data (~31%); misquoted FDA facility-count stat |
| ch3:37 | WWI blockade "civilian deaths exceeded combat casualties"; "1970s" grain embargo | German combat deaths ~2M vs ~424–763k blockade deaths; embargo was Jan 1980 |
| ch3:149 | Gas funded "30–40% of Russian federal budget" | Conflates oil+gas (~35–45%) with gas alone (far less) |
| ch4:169–172 | Oct 2022 thresholds "600 TOPS/300 TFLOPS"; A100 "1,200 GB/s, 624 TFLOPS FP16" | 3A090: ~600 GB/s + 4800 TOPS; A100: 600 GB/s, 312 TFLOPS (624 sparse) |
| ch4:337 | China launches "comparable to or exceeding U.S." | US far exceeds China since 2022 (2023: ~116 vs 67) |
| ch4:390 | Government/SOEs fund "60–70%" of Chinese R&D | Business finances ~76–77%; government ~20% |
| ch5:5 | SenseTime put on "Entity List" Dec 2021 | Treasury NS-CMIC investment blacklist (subsidiary on Entity List 2019) |
| ch6:211/236 | Wassenaar "excluding China, India, Israel" | India joined Wassenaar 2017, MTCR 2016, AG 2018 |
| ch6:63/936 | China retaliated on "$185B (70% of US exports)" | Exceeds total US exports to China (~$130B in 2017); Bown: ~$101–110B |
| ch6:352 | "Applied Materials, Lam, KLA lithography systems" | None make lithography (ASML/Nikon/Canon do) |
| ch7:374 | HKAA designated 10 officials | 11 (including Carrie Lam) |
| ch8:158–163 vs 656 | Two incompatible CFIUS CY2024 stat sets | Verify against Treasury annual report; one set is wrong |
| ch8:734 | PacBio "Japanese" | US company (Menlo Park, CA) |
| ch8:446 | "Ambassador Jingye Chen" | Cheng Jingye (surname Cheng) |
| ch8:214 | UK NSI mandatory notification "at 15%" | Thresholds 25%/50%/75%; 15% was draft-bill only |
| ch8:15 vs 467 | Australian wine "95% of revenue from China" | ~39% of exports (body text correct) |
| ch8:529 | Wine duties "removal by 2025" | Removed March 2024 |
| ch9:5 | Soviet invasion "December 29, 1979" | Dec 24–27, 1979 |
| ch10:325 | Trump-era "140 PRC entities added" 2025 | December 2024, under Biden |
| ch10:865 | "Build Back Better World" | Rebranded PGII June 2022 |
| ch10:217/225 | GERD unresolved, "25% water reduction" | Inaugurated Sept 2025; worst case didn't materialize |
| appendix:163 | TWEA listed as authority for China scenario | TWEA now Cuba-only; IEEPA is operative |
| appendix:945/1020 | EO 14110 as authority in 2027 scenario | Rescinded January 2025 |
| appendix:2181–87 | Flooding in "southern China... Xinjiang" solar | Xinjiang is arid northwest; dominates polysilicon (~40–45%), not panels |
| ch1:269 | pinyin "kǎ bózi" | qiǎ bózi (ch2 has it right) |
| ch5:328 | Great Firewall "technically the Golden Shield Project" | Distinct programs |
| ch7:71 | "$13T in non-U.S. dollar-denominated debt" | Means dollar debt of non-US borrowers; also BIS 2022 cited for 2024 figure |
| ch7:368 | India "received waivers" for S-400 | No formal waiver ever issued; sanctions simply not imposed |

### Problem 2: Internal data contradictions (single-source-of-truth failures)

Same fact, different values across (or within) chapters. Each needs one canonical value in DATA_DICTIONARY.md, then propagation:

- Rare earths: 85% (ch1) vs 60% mining / 85–90% processing (ch2, correct)
- Solar panels: 60% (ch1) vs 80% (ch2); batteries: 70% vs 75%
- US-China trade: $700B (appendix) vs $414.7B for 2025 (ch10); series basis (goods vs goods+services) never stated; ch1's 2008 "$560B" is actually ~$409B goods
- China Treasury holdings: "$850B as of 2024" (ch10:86, appendix) — actual ~$700–770B
- Sanctions success rate: "20–30%" (ch1, appendix) vs "roughly a third" (ch1) vs "20–40%" (ch9); HSE actual: 34%
- Big Fund phases: $21B/$29B/$47.5B (ch2:201) vs $30B/$30B/underway (ch2:397)
- RMB reserve share: 1.93% (ch7:50) vs 2.7% (ch7:456, 816) vs 2.2% (ch7:961)
- OFAC staff: <200 (ch7:227) vs ~300 (ch7:990); SDN count: 10k vs 12k+
- IEEPA civil penalty: $330,000 (ch6:362) vs $356,579 (ch7:996)
- Gallium/germanium shares: "80–90%" (ch2) vs "94%/83%" (ch6) — actuals ≈ 98% Ga, ~60% Ge
- Cable count: 485 (ch5:26) vs 400 (ch5:537) — TeleGeography ~570–600 by 2025
- Nephew *Art of Sanctions*: 2017 (ch9 refs) vs 2018 (appendix)
- Saudi BRICS membership: "joins" (ch7:895) vs correctly omitted (ch7:918)

### Problem 3: The July-2026 currency gap

Sections updated to early 2026 (Ch7 currency data, Ch2 DFC box, TikTok JV, CHIPS awards) sit beside sections frozen in 2023–24, making the update look ad hoc. Missing events, most of which are *evidence for the book's own theses*:

- **The 2025 US-China escalation cycle** (ch6's biggest gap, echoes in ch1–3, 9, 10, appendix): IEEPA universal/reciprocal tariffs, triple-digit escalation April–May 2025, Geneva truce, October 2025 rare-earth showdown, Busan Trump-Xi truce, Supreme Court IEEPA case (argued Nov 2025)
- **China's April/October 2025 rare-earth export-licensing regime** — invalidates ch2:405's "these tools remain largely symbolic"
- **DeepSeek (Jan 2025)** — the defining test of ch4's own "algorithmic substitution under export controls" thesis; entirely absent
- **Nvidia H20 arc** (2024 chip → April 2025 ban → July 2025 reversal with revenue-share) — a new export-control model, absent
- **Salt Typhoon** (largest Chinese telecom compromise in US history) — absent from ch5, which features Volt Typhoon
- **Baltic/Taiwan cable incidents 2023–25** — absent from ch5 and from the appendix's own cable-sabotage exercise precedents
- **Red Sea/Houthi crisis + Suez revenue collapse; end of Ukraine gas transit (Jan 1, 2025); GERD inauguration** — ch3
- **OBBBA (July 2025) IRA credit rollback; Intel equity conversion (Aug 2025); proposed US SWF** — ch8
- **GENIUS Act (2025) / dollar stablecoins** — the strongest counterargument to ch10's de-dollarization section, and confirmation of ch7:598's own stablecoin point
- **Rosneft/Lukoil sanctions (Oct 2025); frozen-asset ERA loans / REPO Act** — ch7
- **Fall of Assad (Dec 2024) + refugee returns** — ch9's migration case
- **Russia 2022–26 as a comparative case in Ch9** — the era's defining sanctions episode appears only in asides in the historical-comparative chapter
- Smaller: Gelsinger→Tan at Intel, TSMC Arizona $165B, Indonesia nickel >50%, 2nm frontier, Huawei Ascend 910B/C, quantum "as of 2024" headers, GM/Boeing present-tense claims, Exercise 1 dated in the past (Jan 2026)

### Problem 4: Apparatus and identity

- **Three titles**: "Economic Coercion: A Handbook of Strategic Competition" (INTRODUCTION.md, README) vs "Economic Coercion in the 21st Century: Tools, Strategies, and Great Power Competition" (title_copyright.md) vs "Economic Coercion and Strategic Competition" (book.json)
- **Two licenses**: All-rights-reserved (title_copyright.md:13) vs CC BY-NC 4.0 (LICENSE, README badge)
- **Two affiliations**: Columbia SIPA (preface, copyright, INTRODUCTION) vs NYU Wagner (README, book.json sidebar); two emails
- **Three part structures**: 4 parts (SUMMARY.md) vs 3 parts (preface) vs 5 parts (README)
- **Two conflicting bibliographies**: front_matter/bibliography.md (Chicago notes format — wrong for author-date in-text cites) vs orphaned REFERENCES_BIBLIOGRAPHY.md (right format, not in nav); direct conflicts on Autor et al. journal, Khan et al. authors, Paarlberg issue, Triolo & Greene identity; misfiled and mis-alphabetized entries; leftover HTML editorial comments
- **Radically incomplete chapter reference lists** — dozens of in-text citations (Jentleson 1986, Crawford & Klotz 1999, Copeland 2015, Bachmann et al., IPlytics, Rhodium…) resolve nowhere
- **Suspect Further Reading entries** in the appendix (Acheson/CSIS, Borsari/PIIE, Bacas/Atlantic Council, Saunders/CSIS attribution, Glaser/FA title) — pattern-match to plausible-but-invented references; must be verified given the book's AI disclosure
- **Figures**: 37 embedded (all resolve — good), but 20 orphaned PNGs (ch5 embeds only ONE figure, and it's numbered fig_03_05), 5 R scripts never run (incl. fig_09_02_apartheid_timeline supporting an existing section), numbering gaps in ch3/5/9/10, ch6 file-vs-caption scrambling, legacy .py cruft in the output dir, ~30 R scripts with hard-coded data lacking per-number provenance
- **No index**; glossary missing IEEPA, Wassenaar, Section 301, Made in China 2025, Anti-Foreign Sanctions Law
- Preface claims "70+ visualizations" (37 embedded) and "data current through late 2024" (contradicted by 2026 access dates)

### Problem 5: Structure, duplication, and voice

- **The ending under-lands.** The book's conclusion (ch10:803–915) is buried mid-chapter — the physical last page is a reference list — and never reprises the two-margins framework that ch9:17 sets up as the unifying payoff. Final Reflections are think-tank boilerplate.
- **Broken promises**: ch2 twice references a "Case Study 1" (2010 rare earths) that doesn't exist; appendix front matter promises "→ EconWar variant" pointers that appear in zero exercises; facilitator notes missing from Exercises 6, 7, 9, 10; phantom "Section X.Y" cross-references in ch2, 4, 5 with no numbered sections anywhere
- **Duplication** (~10–15% of length recoverable): Oct 2022 controls narrated 4× in ch1 + again in ch2/4/6; TSMC facts 3–4× in ch2; Huawei 5G twice at length in ch5; ch6 Case Study 1 duplicates its own main section; BNP Paribas fine 5× in ch7; UEL 3×, CIPS stats 2×, five-criteria assessment 2× verbatim in ch4; "Wandel durch Handel falsified" 4× in ch3; substitution/coordination lesson ~5× in ch9
- **Voice**: heavy **Bold-Header:** bullet scaffolding in ch4, 6, 9, 10 reads as briefing-book, one register below the intended wry-scholarly voice (ch7 and the ch5 exec summary show the target); hint boxes often restate adjacent text instead of adding an angle
- **No learning objectives** in any chapter despite an otherwise template-driven pedagogy

---

## Roadmap to 9.5

Ordered by dependency; phases 1–3 are the rating movers.

### Phase 1 — Identity & apparatus (≈ 1–2 days) → ~7.4
1. Settle title, license, affiliation, email, part structure; propagate to INTRODUCTION.md, title_copyright.md, book.json, README.md, SUMMARY.md, preface.
2. Merge the two bibliographies into one author-date bibliography at front_matter/bibliography.md; resolve the entry-level conflicts; re-sort; refile; delete or stub REFERENCES_BIBLIOGRAPHY.md; add the ~8 missing §B references.
3. Fix broken promises: write ch2's missing rare-earths Case Study 1 (or repoint), add EconWar pointers to all 10 exercises (or cut the promise), strip phantom section cross-references, fix figure caption/file numbering, add glossary gaps.
4. Consolidate DATA_DICTIONARY.md + data/METADATA.md; move root-level audit files into editorial_review/; fix preface's "70+" and "late 2024" claims.

### Phase 2 — Fact-and-consistency sweep (≈ 1–2 weeks) → ~8.2
5. Fix all ~40 verifiable errors in the Problem-1 table (statute, list, date, name, market-share errors).
6. Establish canonical values for every Problem-2 statistic in DATA_DICTIONARY.md (value + date + source + series basis), then propagate to every chapter and the appendix. Automate a grep-based consistency check so future edits can't drift.
7. Verify the suspect appendix Further Reading entries and ch1's Kennedy & Shivakumar reference against real publications; replace any that don't exist. (Highest reputational stakes given the AI disclosure.)
8. Work citation_audit §E's ~50 uncited quantitative claims: source, soften, or flag as author's estimate. Add per-script provenance blocks (or promote data to data/sources/ CSVs) for the ~30 hard-coded R scripts.

### Phase 3 — Mid-2026 currency sweep (≈ 2–3 weeks) → ~8.8
9. Rewrite ch6's Phase 5 around the 2025 IEEPA tariff regime, escalation cycle, truces, and Supreme Court case; update Figure 6.2.
10. Add the missing 2025–26 events where they are evidence for the book's own arguments: DeepSeek + H20 arc (ch4), Salt Typhoon + cable incidents (ch5), rare-earth licensing regime (ch2/3/6), Red Sea + Ukraine transit end + GERD (ch3), OBBBA + Intel equity (ch8), GENIUS Act/stablecoins + Rosneft/Lukoil + ERA loans (ch7/10), post-Assad migration (ch9).
11. Add a Russia 2022–26 comparative case to ch9 applying the two-margins framework (cross-referencing ch7 for mechanics).
12. Sweep remaining stale items (Gelsinger, TSMC Arizona, Indonesia nickel, 2nm, quantum headers, B3W→PGII, Exercise 1 date, appendix backgrounds and precedent lists).

### Phase 4 — Structure & landing (≈ 1 week) → ~9.1
13. Promote "Conclusion: Strategic Choices" to a standalone concluding chapter; reprise the two-margins framework as the synthesis lens for the seven recommendations; write a crafted closing that mirrors ch9's Carter grain-embargo opening scene.
14. Add learning-objective blocks to all chapters; standardize Data Sources section length (ch6's 270-line dump → ch7 scale); add facilitator notes to Exercises 6, 7, 9, 10.
15. Reconcile the figure inventory: embed or delete the 20 orphans (ch4, 5, 7, 8 each have finished figures their prose never shows), run the 5 unexecuted R scripts, renumber to close gaps, purge legacy .py files and empty dirs; add one sentence of prose discussion per embedded figure.

### Phase 5 — De-dup & voice pass (≈ 1–2 weeks) → ~9.4
16. One canonical treatment + cross-references for: Oct 2022 controls, TSMC, Huawei 5G, UEL/AFSL, CIPS, BNP Paribas, MIC2025, civil-military fusion, "Wandel durch Handel," use-it-and-lose-it. Merge ch6's case study into its main section; cut ch8's vestigial Case Study 2. Target 10–15% length reduction.
17. Prose pass converting bold-bullet scaffolding to paragraphs in ch4, 6, 9, 10, using ch7 as the register benchmark; rewrite hint boxes that restate adjacent text.

### Phase 6 — External validation (≈ 1 week) → 9.5
18. Build an index (or GitBook topical index page).
19. Commission 2–3 domain expert reads (one sanctions lawyer/practitioner, one semiconductor analyst, one China specialist) against the fixed manuscript — the error classes found here are exactly what external reviewers will hunt.
20. Final automated QA: citation resolution check (every in-text cite has a bibliography entry), figure link check, statistic-drift grep, date consistency.

**Total estimated effort: 6–9 working weeks.** Phases 1–2 are mechanical and high-certainty; Phase 3 requires research judgment; Phase 5 is the only stylistic risk (preserve the perspective boxes and ch7 untouched).
