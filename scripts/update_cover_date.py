#!/usr/bin/env python3
"""Rewrite the cover-page date line from the last content commit.

Usage: update_cover_date.py COVER_FILE [--content-path PATH ...] [--dry-run]

Date = committer date of the newest commit touching the content paths that is
NOT by a bot and NOT a date-only commit (subject starts "chore(cover-date)").
Preserves the existing line's style; recognised forms (with optional *, **, _):
  *Last updated: October 2026*          *Last Updated: July 2026*
  **Last Updated:** October 4, 2026     *Draft version - January 2026*
  *February 2026*  (bare month-year line)   Last updated: 2026-10-16
Also keeps the status banner in step: a blockquote line such as
  > **Full draft, last updated November 2026.** ...
gets the same month and year as the date line.
Exits 0 with no change if the date is already correct or no line is found.
"""
import argparse, datetime as dt, re, subprocess, sys

MONTHS = "January February March April May June July August September October November December".split()
MON = "(?:" + "|".join(MONTHS) + r"|Jan|Feb|Mar|Apr|Jun|Jul|Aug|Sept?|Oct|Nov|Dec)\.?"
DATE = rf"(?:{MON}\s+(?:\d{{1,2}},\s+)?\d{{4}}|\d{{4}}-\d{{2}}-\d{{2}})"
# prefix label (optional) + date; keep surrounding markup untouched
LINE = re.compile(
    rf"^(?P<pre>[\s>*_]*(?:(?:Last\s+(?:updated|revised|modified)|Updated|Draft\s+version|Version\s+[\d.]+)"
    rf"[\s:*_\-–—,]*)?)(?P<date>{DATE})(?P<post>[\s*_.]*)$", re.I)
BANNER = re.compile(rf"^(?P<pre>\s*>.*?last\s+updated\s+)(?P<date>{MON}\s+\d{{4}})", re.I)
BOT = re.compile(r"\[bot\]|github-actions|dependabot", re.I)
MARK = "chore(cover-date)"

def git(*a):
    return subprocess.run(["git", *a], check=True, capture_output=True, text=True).stdout

def mask(line):
    """Blank the date in an update label (LINE or BANNER match); leave dates in other prose alone."""
    for rx in (BANNER, LINE):
        m = rx.match(line)
        if m:
            return line[:m.start("date")] + "<date>" + line[m.end("date"):]
    return line

def last_content_date(paths, cover):
    log = git("log", "--format=%H%x1f%an%x1f%ae%x1f%cI%x1f%s", "--", *paths)
    for row in log.splitlines():
        sha, an, ae, ci, subj = row.split("\x1f")
        if BOT.search(an) or BOT.search(ae) or subj.startswith(MARK):
            continue
        files = [f for f in git("show", "--name-only", "--format=", sha).splitlines() if f]
        if files == [cover]:  # human commit that touched only the cover: still content unless only the date line changed
            diff = git("show", "--format=", "-U0", sha, "--", cover)
            body, in_hunk = [], False
            for l in diff.splitlines():  # changed lines inside hunks only, so a deleted "---" rule still counts
                if l.startswith("@@"):
                    in_hunk = True
                elif in_hunk and l[:1] in ("+", "-"):
                    body.append(l)
            removed = [l[1:] for l in body if l[0] == "-"]
            added = [l[1:] for l in body if l[0] == "+"]
            labels = all(BANNER.match(l) or LINE.match(l) for l in removed + added)
            if added and labels and sorted(map(mask, removed)) == sorted(map(mask, added)):
                continue  # every changed line is an update label and only its date changed
        return dt.datetime.fromisoformat(ci.replace("Z", "+00:00"))
    return None

def render(old, d):
    if re.fullmatch(r"\d{4}-\d{2}-\d{2}", old):
        return d.strftime("%Y-%m-%d")
    if re.search(r"\d{1,2},", old):
        return f"{MONTHS[d.month-1]} {d.day}, {d.year}"
    return f"{MONTHS[d.month-1]} {d.year}"

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("cover")
    ap.add_argument("--content-path", action="append", default=[])
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()
    d = last_content_date(a.content_path or ["."], a.cover)
    if not d:
        print("no qualifying commit"); return
    d = d.astimezone(dt.timezone(dt.timedelta(hours=-5)))  # US Eastern-ish, avoids UTC month rollover
    text = open(a.cover, encoding="utf-8").read().split("\n")
    changed = False
    # status banner near the top: keep its month in step with the date line
    for i, line in enumerate(text):
        m = BANNER.match(line)
        if m:
            new = f"{MONTHS[d.month-1]} {d.year}"
            if m.group("date") != new:
                text[i] = line[:m.start("date")] + new + line[m.end("date"):]
                print(f"{a.cover}:{i+1}: banner {m.group('date')} -> {new}")
                changed = True
    # search from the bottom (cover dates sit in the footer), then top
    for i in list(range(len(text)-1, -1, -1)):
        m = LINE.match(text[i])
        if not m:
            continue
        if not m.group("pre").strip(" >*_") and not text[i].strip().startswith(("*", "_")):
            continue  # bare date must be emphasised (*February 2026*) to avoid hitting prose
        new = render(m.group("date"), d)
        if new == m.group("date"):
            print(f"up to date: {text[i].strip()}")
        else:
            text[i] = m.group("pre") + new + m.group("post")
            print(f"{a.cover}:{i+1}: {m.group('date')} -> {new}")
            changed = True
        break
    else:
        print("no date line found in", a.cover)
    if changed and not a.dry_run:
        open(a.cover, "w", encoding="utf-8").write("\n".join(text))

if __name__ == "__main__":
    sys.exit(main())
