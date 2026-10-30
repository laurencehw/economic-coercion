#!/usr/bin/env python3
"""Look up the bibliography in Crossref and OpenAlex, for the citation pass in ``AGENTS.md``.

For each entry in ``front_matter/bibliography.md`` and in the chapters' own "References" lists the script searches both services, keeps the best-scoring
record, and writes one CSV row with the match, a verdict, the abstract when one is indexed, and the
chapter lines that mention the entry's first author and its year. A person or model then uses the
CSV to (1) fix or replace entries that do not exist and (2) compare each citing sentence with the
abstract.

Usage (needs network access to api.crossref.org and api.openalex.org)::

    python3 scripts/lookup_citations.py --chapter 5        # entries cited in Chapter 5
    python3 scripts/lookup_citations.py --chapter A        # entries cited in Appendix A
    python3 scripts/lookup_citations.py --chapter conclusion
    python3 scripts/lookup_citations.py --all              # every entry
    python3 scripts/lookup_citations.py --all --mailto you@example.edu

Output goes to ``data/citation_lookups/<scope>.csv``. Responses are cached in
``data/citation_lookups/cache.json`` (gitignored), so an interrupted run resumes and a re-run is free.

Verdicts:

* ``match``    -- title similarity >= 0.90, first author found, year within one;
* ``likely``   -- title similarity >= 0.75 and either the author or the year agrees;
* ``check``    -- something was found but it does not clearly match: look by hand;
* ``no_match`` -- nothing plausible in either service. Common for books, think-tank and government
  reports, press articles, statutes, and datasets; it is not proof that the work does not exist.
"""

from __future__ import annotations

import argparse
import csv
import glob
import json
import re
import sys
import time
import unicodedata
from difflib import SequenceMatcher
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BIB = ROOT / "front_matter" / "bibliography.md"
OUT_DIR = ROOT / "data" / "citation_lookups"
CACHE = OUT_DIR / "cache.json"
CROSSREF = "https://api.crossref.org/works"
OPENALEX = "https://api.openalex.org/works"
YEAR = re.compile(r"\b(1[5-9]\d\d|20\d\d)[a-z]?\b")
REF_HEADING = re.compile(r"^#{2,3} .*(References|Further Reading)", re.I)


# --------------------------------------------------------------------------- parsing and scoring

def norm(s: str) -> str:
    return unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode().lower()


def make_entry(text: str, where: str) -> dict | None:
    """An author-date entry, ``Surname, First. 2019. "Title." *Venue* 44 (1): 42-79.``; None if it has no year."""
    text = re.sub(r"\s*\[[^\]]*\]\s*$", "", text.strip())  # drop a trailing [annotation]
    found = YEAR.search(text)
    if not found or not 0 < found.start() <= 200:
        return None
    quoted = re.search(r"[\u201c\"](.+?)[\u201d\"]", text)
    italic = re.search(r"\*(.+?)\*", text)
    title = (quoted or italic).group(1) if (quoted or italic) else text[found.end():].lstrip(". ").split(". ")[0]
    author = re.split(r",| \(", text[:found.start()].strip().rstrip(".").strip())[0].strip()
    return {"where": [where], "text": text, "author": author, "title": title.strip().rstrip(".,"), "year": found.group(1)}


def parse_bib() -> list[dict]:
    """Entries of ``front_matter/bibliography.md`` and of the chapters' References and Further Reading sections.

    An entry is one line (a paragraph or a list item) in author-date form; an indented annotation under it is
    skipped. The same work listed in several places becomes one entry with every location in ``where``.
    """
    entries: dict[tuple, dict] = {}

    def add(entry: dict | None) -> None:
        if not entry:
            return
        key = (norm(entry["author"]), entry["year"], " ".join(re.findall(r"[a-z0-9]+", norm(entry["title"])))[:60])
        if key in entries:
            entries[key]["where"] += entry["where"]
        else:
            entries[key] = entry

    for number, line in enumerate(BIB.read_text(encoding="utf-8").splitlines(), 1):
        if re.match(r"^[A-Z0-9\u00c0-\u024f]", line) and not line.startswith(("This ", "##")):
            add(make_entry(line, f"{BIB.relative_to(ROOT)}:{number}"))
    for chapter, path in chapter_files():
        in_refs = False
        for number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
            if line.startswith("## ") or line.startswith("### "):
                in_refs = bool(REF_HEADING.match(line)) or (in_refs and line.startswith("### "))
            elif in_refs and re.match(r"^(?:[-*] )?[A-Z0-9\u00c0-\u024f]", line):
                add(make_entry(re.sub(r"^[-*] ", "", line), f"{path.relative_to(ROOT)}:{number}"))
    out = list(entries.values())
    for entry in out:
        entry["chapters"] = sorted({c for c, _, _ in citing_lines(entry)}
                                   | {c for c, p in chapter_files() for w in entry["where"] if w.startswith(str(p.relative_to(ROOT)) + ":")},
                                   key=chapter_key)
    return out


def title_score(a: str, b: str) -> float:
    """Similarity of two titles in [0, 1], ignoring case, punctuation, and a subtitle on one side only."""
    def clean(s: str) -> str:
        return " ".join(re.findall(r"[a-z0-9]+", norm(s)))

    a, b = clean(a), clean(b)
    if not a or not b:
        return 0.0
    full = SequenceMatcher(None, a, b).ratio()
    head = min(len(a), len(b))
    prefix = SequenceMatcher(None, a[:head], b[:head]).ratio() if head >= 20 else 0.0
    return round(max(full, prefix), 3)


def verdict(score: float, author_ok: bool, year_ok: bool) -> str:
    if score >= 0.90 and author_ok and year_ok:
        return "match"
    if score >= 0.75 and (author_ok or year_ok):
        return "likely"
    if score >= 0.55:
        return "check"
    return "no_match"


def chapter_key(chapter: str) -> tuple:
    return (0, int(chapter), "") if chapter.isdigit() else (1, 0, chapter)


def chapter_files() -> list[tuple[str, Path]]:
    """``(chapter, path)`` for the chapters, the conclusion, and the appendices, e.g. ``("5", chapter_5.md)``."""
    out = []
    for path in sorted(ROOT.glob("chapters/*.md")) + sorted(ROOT.glob("appendices/*.md")):
        chapter = re.match(r"chapter_(\d+)\.md$", path.name)
        appendix = re.match(r"appendix_([a-z])_", path.name)
        if chapter:
            out.append((chapter.group(1), path))
        elif appendix:
            out.append((appendix.group(1).upper(), path))
        elif path.stem == "conclusion":
            out.append(("conclusion", path))
    return out


def citing_lines(entry: dict) -> list[tuple[str, str, str]]:
    """``(chapter, location, line)`` for chapter lines that name the first author and the entry's year."""
    out = []
    for chapter, path in chapter_files():
        for number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
            if entry["author"] in line and entry["year"] in line:
                out.append((chapter, f"{path.relative_to(ROOT)}:{number}", line.strip()[:600]))
    return out


# --------------------------------------------------------------------------- network

class Client:
    def __init__(self, mailto: str | None, pause: float):
        import requests

        self.session = requests.Session()
        agent = "economic-coercion-textbook-citation-audit"
        self.session.headers["User-Agent"] = f"{agent} (mailto:{mailto})" if mailto else agent
        self.mailto = mailto
        self.pause = pause
        self.cache: dict[str, object] = json.loads(CACHE.read_text()) if CACHE.exists() else {}

    def get(self, url: str, params: dict) -> dict | None:
        key = url + "?" + "&".join(f"{k}={v}" for k, v in sorted(params.items()))
        if key in self.cache:
            return self.cache[key]
        for attempt in range(3):
            try:
                response = self.session.get(url, params=params, timeout=30)
            except Exception as exc:  # network error: back off and retry
                print(f"  {type(exc).__name__}; retrying", file=sys.stderr)
                time.sleep(2 ** attempt)
                continue
            if response.status_code == 429 or response.status_code >= 500:
                time.sleep(2 ** (attempt + 1))
                continue
            data = response.json() if response.ok else None
            self.cache[key] = data
            time.sleep(self.pause)
            return data
        return None

    def save(self) -> None:
        OUT_DIR.mkdir(parents=True, exist_ok=True)
        CACHE.write_text(json.dumps(self.cache))

    def crossref(self, query: str) -> list[dict]:
        params = {"query.bibliographic": query[:400], "rows": 3}
        if self.mailto:
            params["mailto"] = self.mailto
        data = self.get(CROSSREF, params) or {}
        out = []
        for item in data.get("message", {}).get("items", []):
            issued = (item.get("issued") or {}).get("date-parts") or [[None]]
            out.append({
                "source": "crossref",
                "title": " ".join(item.get("title") or []),
                "authors": "; ".join(a.get("family", "") for a in item.get("author", [])),
                "year": str(issued[0][0] or ""),
                "venue": " ".join(item.get("container-title") or []) or item.get("publisher", ""),
                "doi": item.get("DOI", ""),
                "abstract": re.sub(r"\s+", " ", re.sub(r"<[^>]+>", " ", item.get("abstract") or "")).strip(),
            })
        return out

    def openalex(self, title: str) -> list[dict]:
        params = {"search": title[:300], "per-page": 3}
        if self.mailto:
            params["mailto"] = self.mailto
        data = self.get(OPENALEX, params) or {}
        out = []
        for item in data.get("results", []):
            venue = ((item.get("primary_location") or {}).get("source") or {}).get("display_name", "")
            inverted = item.get("abstract_inverted_index") or {}
            words = sorted((pos, word) for word, places in inverted.items() for pos in places)
            out.append({
                "source": "openalex",
                "title": item.get("display_name") or "",
                "authors": "; ".join(
                    (a.get("author") or {}).get("display_name", "").split()[-1]
                    for a in item.get("authorships", []) if (a.get("author") or {}).get("display_name")
                ),
                "year": str(item.get("publication_year") or ""),
                "venue": venue or "",
                "doi": (item.get("doi") or "").replace("https://doi.org/", ""),
                "abstract": " ".join(word for _, word in words),
            })
        return out


# --------------------------------------------------------------------------- main

def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--chapter", help="chapter number (e.g. 5), appendix letter (e.g. A), or conclusion")
    group.add_argument("--all", action="store_true", help="every bibliography entry")
    parser.add_argument("--mailto", help="contact e-mail for the Crossref/OpenAlex polite pools (recommended)")
    parser.add_argument("--pause", type=float, default=0.2, help="seconds between uncached requests")
    args = parser.parse_args()

    chapter = None
    if args.chapter:
        chapter = str(int(args.chapter)) if args.chapter.isdigit() else args.chapter
        chapter = chapter.upper() if len(chapter) == 1 and chapter.isalpha() else chapter
    entries = [e for e in parse_bib() if args.all or chapter in e["chapters"]]
    name = (f"ch{int(chapter):02d}" if chapter.isdigit() else f"app_{chapter.lower()}" if len(chapter) == 1 else chapter) if chapter else "all"
    out_path = OUT_DIR / f"{name}.csv"
    print(f"{len(entries)} entries -> {out_path}")

    client = Client(args.mailto, args.pause)
    rows = []
    try:
        for i, entry in enumerate(entries, 1):
            title, year, author = entry["title"], entry["year"], norm(entry["author"])
            candidates = client.crossref(entry["text"]) + client.openalex(title)

            def rank(c: dict) -> tuple:
                return (title_score(title, c["title"]),
                        bool(author) and author in norm(c["authors"]),
                        c["year"].isdigit() and year.isdigit() and abs(int(c["year"]) - int(year)) <= 1)

            best = max(candidates, key=lambda c: (rank(c), bool(c["abstract"])), default=None)
            score, author_ok, year_ok = rank(best) if best else (0.0, False, False)
            if best and not best["abstract"]:  # borrow an abstract from another record of the same work
                for c in candidates:
                    if c["abstract"] and title_score(best["title"], c["title"]) >= 0.9:
                        best = {**best, "abstract": c["abstract"]}
                        break
            located = citing_lines(entry)
            rows.append({
                "listed_at": "; ".join(entry["where"]),
                "entry": entry["text"],
                "chapters": ", ".join(entry["chapters"]),
                "verdict": verdict(score, author_ok, year_ok),
                "title_score": score,
                "author_ok": author_ok,
                "year_ok": year_ok,
                "match_source": best["source"] if best else "",
                "match_title": best["title"] if best else "",
                "match_authors": best["authors"] if best else "",
                "match_year": best["year"] if best else "",
                "match_venue": best["venue"] if best else "",
                "doi": best["doi"] if best else "",
                "abstract": (best["abstract"] if best else "")[:3000],
                "cited_at": "; ".join(loc for _, loc, _ in located),
                "citing_text": " ||| ".join(dict.fromkeys(text for _, _, text in located)),
            })
            if i % 25 == 0:
                client.save()
                print(f"  {i}/{len(entries)}")
    finally:
        client.save()

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    with out_path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]) if rows else ["listed_at"], lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)
    counts: dict[str, int] = {}
    for row in rows:
        counts[row["verdict"]] = counts.get(row["verdict"], 0) + 1
    print("verdicts:", ", ".join(f"{k} {v}" for k, v in sorted(counts.items())))
    return 0


if __name__ == "__main__":
    sys.exit(main())
