#!/usr/bin/env python3
"""Manuscript QA checks.

Every defect class found in the August 2026 review was mechanically detectable.
This script encodes those checks so the same drift cannot return unnoticed.

Run from the repository root:

    python3 scripts/qa_manuscript.py

Exits non-zero if any check fails, so it can be wired into CI.
"""

from __future__ import annotations

import csv
import glob
import os
import re
import sys

CHAPTERS = sorted(
    glob.glob("chapters/chapter_*.md"),
    key=lambda p: int(re.search(r"chapter_(\d+)", p).group(1)),
) + ["chapters/conclusion.md"]
PROSE = CHAPTERS + glob.glob("appendices/*.md")

failures: list[str] = []
notes: list[str] = []


def check(name: str, ok: bool, detail: str = "") -> None:
    print(f"  {'PASS' if ok else 'FAIL'}  {name}" + (f" — {detail}" if detail else ""))
    if not ok:
        failures.append(f"{name}: {detail}")


def read(path: str) -> str:
    with open(path, encoding="utf-8") as fh:
        return fh.read()


# ---------------------------------------------------------------- figures ---
def figure_checks() -> None:
    print("\nFigures")

    embedded = set()
    broken = []
    for path in PROSE:
        for png in re.findall(r'src="\.\./figures/([a-z0-9_.]+)"', read(path)):
            embedded.add(png)
            if not os.path.exists(os.path.join("figures", png)):
                broken.append(f"{path} → {png}")
    check("every embedded figure file exists", not broken, "; ".join(broken))
    notes.append(f"{len(embedded)} figures embedded")

    # filename number == caption number == order of first appearance
    misaligned = []
    for path in CHAPTERS:
        m = re.search(r"chapter_(\d+)", path)
        if not m:
            continue
        ch = int(m.group(1))
        pairs = re.findall(
            r'src="\.\./figures/fig_(\d+)_(\d+)_[a-z0-9_]+\.png".*?'
            r"<figcaption>Figure (\d+)\.(\d+):",
            read(path),
            re.S,
        )
        for i, (fc, fn, cc, cn) in enumerate(pairs, start=1):
            if not (int(fc) == ch == int(cc) and int(fn) == i == int(cn)):
                misaligned.append(f"{path} position {i}: file {fc}.{fn}, caption {cc}.{cn}")
    check("filename, caption, and appearance order agree", not misaligned,
          "; ".join(misaligned))

    # the prose must actually discuss each figure, and name the right one
    undiscussed, mislabelled = [], []
    for path in CHAPTERS:
        text = read(path)
        for m in re.finditer(
            r'<figure class="book-figure">.*?<figcaption>Figure (\d+)\.(\d+):', text, re.S
        ):
            cap = f"{m.group(1)}.{m.group(2)}"
            if len(re.findall(rf"Figure {re.escape(cap)}\b", text)) < 2:
                undiscussed.append(f"{path} Figure {cap}")
            paras = [p for p in text[: m.start()].split("\n\n") if p.strip()]
            if paras:
                # a stale reference anywhere in the introducing paragraph counts,
                # not just one at its start
                refs = set(re.findall(r"Figure (\d+\.\d+)", paras[-1]))
                if refs and cap not in refs:
                    mislabelled.append(
                        f"{path}: lead-in names {', '.join(sorted(refs))}, caption {cap}"
                    )
    check("every figure is discussed in the prose", not undiscussed, "; ".join(undiscussed))
    check("figure lead-ins name the right figure", not mislabelled, "; ".join(mislabelled))

    # a figure number burned into the image cannot be renumbered with the book
    burned = [
        f for f in glob.glob("R/figures/*.R")
        if re.search(r'(title|subtitle)\s*=\s*"Figure \d+\.\d+', read(f))
    ]
    check("no figure numbers burned into plot titles", not burned, "; ".join(burned))

    # in-chapter and cross-chapter references must resolve to a real figure
    all_caps = set()
    for path in CHAPTERS:
        all_caps |= set(re.findall(r"<figcaption>Figure (\d+\.\d+):", read(path)))
    dangling = []
    for path in CHAPTERS:
        body = re.sub(r"<figcaption>[^<]*</figcaption>", "", read(path))
        for ref in set(re.findall(r"Figure (\d+\.\d+)", body)):
            if ref not in all_caps:
                dangling.append(f"{path} → Figure {ref}")
    check("all figure references resolve", not dangling, "; ".join(dangling))


# ------------------------------------------------------------------- data ---
def data_checks() -> None:
    print("\nSource data")

    # share tables must sum to 100 — this is what would have caught the
    # rare-earth mining share being left at 60 while processing moved to 90
    share_files = {
        "data/sources/renewable_energy_manufacturing.csv": "Technology",
        "data/sources/swift_currency_data.csv": "Year",
    }
    bad = []
    for path, key in share_files.items():
        if not os.path.exists(path):
            continue
        for row in csv.DictReader(open(path, encoding="utf-8")):
            total = sum(float(v) for k, v in row.items() if k != key)
            if abs(total - 100) > 0.05:
                bad.append(f"{path} {row[key]}={total:.1f}")
    check("share tables sum to 100", not bad, "; ".join(bad))

    # the same, for share vectors hard-coded inside R scripts
    bad = []
    for rf in glob.glob("R/figures/*.R"):
        src = read(rf)
        for label in ("Processing_Share", "Mining_Share"):
            m = re.search(label + r" = c\((.*?)\n\s*\)", src, re.S)
            if not m:
                continue
            nums = [int(x) for x in re.findall(r"\b(\d+)\b", re.sub(r"#[^\n]*", "", m.group(1)))]
            for i in range(0, len(nums), 5):
                row = nums[i : i + 5]
                if len(row) == 5 and sum(row) != 100:
                    bad.append(f"{rf} {label} row {i // 5 + 1}={sum(row)}")
    check("in-script share vectors sum to 100", not bad, "; ".join(bad))

    # CFIUS totals must be internally consistent
    path = "data/sources/cfius_reviews.csv"
    if os.path.exists(path):
        bad = [
            r["year"]
            for r in csv.DictReader(open(path, encoding="utf-8"))
            if int(r["declarations"]) + int(r["notices"]) != int(r["covered_transactions"])
        ]
        check("CFIUS covered == declarations + notices", not bad, ", ".join(bad))

    # the colour-subscript bug: c("X" = econ_colors["Y"]) keeps the source name
    # and silently matches nothing, dropping the legend
    bad = [f for f in glob.glob("R/figures/*.R")
           if re.search(r'=\s*(econ_colors|sector_colors)\["', read(f))]
    check("no name-preserving colour subscripts", not bad, "; ".join(bad))


# --------------------------------------------------------------- apparatus ---
def apparatus_checks() -> None:
    print("\nApparatus")

    for path in ("SUMMARY.md", "front_matter/index.md"):
        if not os.path.exists(path):
            continue
        base = os.path.dirname(path)
        broken = [
            t for t in re.findall(r"\]\(([^)#]+)\)", read(path))
            if not t.startswith("http")
            and not os.path.exists(os.path.normpath(os.path.join(base, t)))
        ]
        check(f"{path} links resolve", not broken, "; ".join(broken))

    # index anchors must match a real heading
    if os.path.exists("front_matter/index.md"):
        bad = []
        for target, anchor in set(
            re.findall(r"\(\.\./([^)#]+)#([a-z0-9-]+)\)", read("front_matter/index.md"))
        ):
            if not os.path.exists(target):
                bad.append(f"{target}#{anchor}")
                continue
            slugs = {
                re.sub(r"[^a-z0-9\s-]", "", h.strip().lower()).strip().replace(" ", "-")
                for h in re.findall(r"^#{2,3}\s+(.+)$", read(target), re.M)
            }
            if anchor not in slugs:
                bad.append(f"{target}#{anchor}")
        check("index anchors resolve", not bad, "; ".join(bad))

    # pedagogical blocks every chapter is supposed to carry
    required = ("Learning Objectives", "Executive Summary", "Discussion Questions")
    missing = [
        f"{p}: {name}"
        for p in CHAPTERS
        if "conclusion" not in p
        for name in required
        if not re.search(rf"^#+\s+.*{name}", read(p), re.M | re.I)
    ]
    check("chapters carry the standard pedagogical blocks", not missing, "; ".join(missing))


# ------------------------------------------------------------------ pipeline ---
# Packages the figure pipeline is allowed to use. All must be installable from
# CRAN: a GitHub-only dependency makes the pipeline unreproducible for anyone
# without that remote, which is how ggradar came to be imported-but-unused. Adding
# to this list is a deliberate act — check the package is on CRAN first.
CRAN_ALLOWED = {
    "dplyr", "forcats", "ggalluvial", "ggforce", "ggplot2", "ggraph", "ggrepel",
    "here", "igraph", "lubridate", "patchwork", "rnaturalearth",
    "rnaturalearthdata", "scales", "sf", "stringr", "tidyr", "tidyverse",
    "tmap", "treemapify",
}


def pipeline_checks() -> None:
    print("\nFigure pipeline")

    scripts = sorted(glob.glob("R/figures/*.R")) + ["R/setup_theme.R"]
    used = set()
    for rf in scripts:
        if not os.path.exists(rf):
            continue
        src = read(rf)
        used |= set(re.findall(r"^\s*(?:library|require)\(([A-Za-z0-9._]+)\)", src, re.M))
        used |= set(re.findall(r"\b([A-Za-z][A-Za-z0-9._]+)::", src))
    unknown = sorted(used - CRAN_ALLOWED)
    check("figure pipeline uses only reviewed CRAN packages", not unknown,
          "new dependencies need review: " + ", ".join(unknown) if unknown else "")
    # Deliberately not checked here: whether an import is actually used. Detecting
    # that reliably needs each package's exported symbols — a package is normally
    # used through its functions, not its name — and the naive version flags dplyr,
    # patchwork, scales and most of the rest. The allowlist above is what guards
    # reproducibility; a dead import is untidy but harmless.

    # every script should produce the image it names, and every image should have a
    # script that produces it
    produced, missing = {}, []
    for rf in sorted(glob.glob("R/figures/*.R")):
        for png in re.findall(r'"(fig_[a-z0-9_]+\.png)"', read(rf)):
            produced[png] = rf
            if not os.path.exists(os.path.join("figures", png)):
                missing.append(f"{os.path.basename(rf)} → {png}")
    check("every script's output image exists", not missing, "; ".join(missing))

    unproduced = sorted(
        f for f in os.listdir("figures")
        if f.endswith(".png") and f not in produced
    )
    check("every image has a generating script", not unproduced, "; ".join(unproduced))


def main() -> int:
    print("Manuscript QA")
    figure_checks()
    data_checks()
    pipeline_checks()
    apparatus_checks()
    for note in notes:
        print(f"\n  note: {note}")
    if failures:
        print(f"\n{len(failures)} check(s) failed.")
        return 1
    print("\nAll checks passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
