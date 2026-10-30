# Editing Guide: Voice, De-AI, and Citations

This file is the shared brief for every tool that edits the prose of this book: Claude Code, Codex, Gemini,
Cursor, or a person. `CLAUDE.md` and `CONTRIBUTING.md` cover the book's structure, figures and build;
`DATA_DICTIONARY.md` holds the canonical statistics. This file covers how the prose should read and how to check
its sources.

The book was drafted with AI assistance. The goal of an editing pass is prose that reads as if Laurence
Wilse-Samson wrote it directly, with every citation real and fairly described. Each chapter gets three passes,
in this order:

1. **De-AI pass**: remove the patterns listed below.
2. **Voice pass**: move the prose toward the author's own register.
3. **Citation pass**: confirm every cited work exists and says roughly what the text says it says.

The same rules were applied to the author's macroeconomics, antitrust, history of economic thought,
international finance, South African economy, and public economics textbooks and approved by the author
(October 2026).

**Edit `chapters/`, `appendices/`, and `front_matter/preface.md` only.** The bibliography, glossary, index,
`SUMMARY.md`, figures, data and scripts are kept in step with the chapters by hand or by `scripts/qa_manuscript.py`,
and a prose pass must not touch them.

---

## 1. The author's voice

The reference is the author's paper "Structural Change and Democratization: Evidence from Rural Apartheid" (SSRN 2479681).
Its habits:

- **Say what you do, in the first person.** "I use subnational variation in South Africa to test this
  mechanism." In this book, use "I" for the author's own choices and judgments ("I start with semiconductors
  because…", "I leave financial sanctions to Chapter 7"), and "we" only where the reader is genuinely doing the
  work alongside (a tabletop exercise, a worked scenario). Do not use "this chapter" as a stand-in for "I" more
  than once a chapter.
- **Claim, then evidence.** A paragraph opens with its point in plain words; the specifics follow (the statute,
  the agency, the rule, the date, the number).
- **Institutional detail.** Name the regulation, the agency, the list, the date, the amount. Prefer one exact
  fact to three general adjectives. "BIS added Huawei to the Entity List in May 2019" beats "sweeping
  restrictions on Chinese technology firms".
- **Hedge only where the evidence is weak, and say why.** Do not hedge settled facts, and do not inflate
  tentative ones. Forecasts and scenarios are labelled as such.
- **Authors as subjects of plain verbs.** "Farrell and Newman (2019) argue…", "Hufbauer et al. (2007) code…".
  The verb says what the author did (argues, shows, estimates, documents, proposes), not "highlights" or
  "underscores".
- **Asides in parentheses or a short separate paragraph,** not as a clause bolted on with dashes.
- **Plain verbs, short-to-medium sentences.** Little signposting, no throat-clearing, few adjectives.
- **Dashes sparingly.** Default to a comma, colon, parentheses, or a full stop; keep a dash only where nothing
  else works, never two in one paragraph, and no more than about 2 per 1,000 words of running prose. (The author
  approved about 30 em dashes in 9,000 words on the macro book, then asked for 20% fewer. The chapters here have
  about 7–9 per 1,000 words.) Dashes in headings, inside quotations, inside `<figure>` blocks, and en dashes in
  ranges (1949–1994) stay.
- **Bold for defined terms only.** In running prose, bold a term once, where it is defined (normally a term that
  also appears in the glossary), and unbold other emphasis. Bold in tables, `{% hint %}` boxes, list-item labels,
  box labels (`> **Tabletop Exercise:**`) and Key Insights stays.
- Oxford comma: yes. American spelling. The book writes "U.S."; keep it.

---

## 2. De-AI checklist

Banned words: crucial, delve, landscape (generic), it is important to note, testament to, navigate, tapestry.
The patterns below are sentence shapes, which a word filter does not catch.

| Pattern | Example | Fix |
|---|---|---|
| "Not X. It is Y." / "not merely A but B" contrast frames | "Export controls are not merely trade policy but instruments of strategic competition." | State Y directly, or cut it. |
| "The standard story is X. True, but incomplete." setups | | Give the claim and its evidence. |
| Grand abstractions | "the deep architecture of weaponized interdependence" | Say the specific claim. |
| Personified or dramatic verbs | "shattered", "unleashed", "the dollar reigns" | Describe what happened. |
| Fragment punchlines | "Leverage cuts both ways." after a run of short sentences, used for effect | Fold into one sentence where it is rhythm, not content. |
| Rule-of-three lists used for rhythm | "chips, code, and capital" | Keep a list only if each item adds information. |
| Rhetorical question volleys | Three questions in a row to open a section | One question at most, or state the puzzle. |
| Empty closers | "The stakes could not be higher." "The game has changed." | Delete, or give the specific consequence. |
| Hollow intensifiers | deeply, profoundly, fundamentally, truly, remarkably, striking, unprecedented | Delete, or give the number that shows it. |
| "Today, …" / "In recent years, …" without a date | | Give the date or drop the time phrase. |
| Stock citation verbs | highlights, underscores, sheds light on, showcases | argues, shows, estimates, documents. |
| Scare quotes around ordinary words | | Keep quotation marks only for quotations and coined terms. |
| Symmetric hedging | "While X, it is also true that Y" as filler | Say which matters more and why. |

---

## 3. What not to change

- **Facts.** Names, dates, titles, numbers, dollar amounts and their as-of dates, quotations (word for word), and
  citations. Statistics quoted in the chapters must match the canonical values in `DATA_DICTIONARY.md`, and many
  recur in a chapter's tables, figure captions, the glossary and the tabletop exercises. If one looks wrong, flag
  it in the change log; do not "fix" it from memory.
- **Structure.** Headings (the index links to them by anchor); the end-matter order; every `<figure>` block,
  character for character; tables, `$$` math, `{% hint %}` boxes, and the labelled boxes (Perspective Boxes,
  Government Tools Boxes, Case Studies, Tabletop Exercises). Tighten the prose inside a box; keep its labels.
- **Strings `scripts/qa_manuscript.py` reads.** The paragraph that introduces a figure must still name it
  ("Figure 6.2"), every figure must be named at least once outside its caption, Chapter 7's sentence quoting the
  dollar's reserve-currency share with its quarter, and Chapter 10's `### Scenario A:` headings with their
  planning weights.
- **Content.** Do not drop list items, examples, Learning Objectives, Key Insights, Discussion Questions,
  references, or qualifiers (a date range, "as of 2026", "roughly"). Cut words only where the prose is padded
  (typically 3–10%) and add no new material, examples, or citations.

After a pass, `python3 scripts/qa_manuscript.py` and `python3 -m unittest discover -s scripts -p 'test_*.py'`
must still pass (CI runs both on every pull request).

---

## 4. Citation pass

The lookup script checks existence mechanically. Run it on a machine with network access to Crossref and OpenAlex
(the cloud sandbox cannot reach them):

```bash
pip install requests
python3 scripts/lookup_citations.py --all --mailto you@example.edu
```

It reads `front_matter/bibliography.md` and every chapter's References and Further Reading sections, merges
duplicates, and writes `data/citation_lookups/all.csv` (or `ch06.csv` with `--chapter 6`, `app_a.csv` with
`--chapter A`): one row per work, with where it is listed, the best match, a verdict (`match`, `likely`, `check`,
`no_match`), the abstract where one is indexed, and the chapter lines that name the first author and the year.
Commit the CSV so that a model without network access can do steps 2 and 3. A `no_match` is common for books,
think-tank and government reports, press articles, statutes, and datasets, so it means "look by hand", not
"fake".

For every citation in the chapter:

1. **Does it exist?** Use the CSV, the publisher's page, the agency's site (BIS, OFAC, USTR, the Federal
   Register), the think tank's site, or a library catalogue. A model's memory does not count as a source.
2. **Is the characterization fair?** Read at least the abstract (for a report, the relevant section). The text
   must not be *radically* different from what the work says. Loose paraphrase is fine; attributing a claim the
   author did not make, reversing its sign, or citing it for a different topic is not. Direct quotations must
   match the source word for word.
3. **Fix what fails.** Wrong details (year, venue, co-author, title): correct the entry in
   `front_matter/bibliography.md` and in the chapter's own reference list. Does not exist or says something else:
   replace it with a real work that supports the sentence and check that one the same way; if none does, soften
   or cut the sentence. Cannot decide: prefix the entry with `[VERIFY] ` and explain in the change log. Never
   invent a source.

---

## 5. Who does what

| Task | Tier |
|---|---|
| De-AI and voice pass, one chapter at a time | Fast model (Sonnet, Codex, Gemini, Cursor) |
| Citation existence lookup | `scripts/lookup_citations.py`, run at home (no model) |
| Comparing a claim with the abstract or passage | Fast model |
| Finding replacement sources | Strong model, with the author reviewing |
| Final read of each Part | Strong model, then the author |

Every pass ends with a short change log in the PR description: sentences cut or substantially rewritten,
citations corrected, replaced, or flagged, and anything that needs the author's judgment.
