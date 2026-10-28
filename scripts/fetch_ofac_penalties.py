#!/usr/bin/env python3
"""Refresh the OFAC enforcement extracts behind Figure 7.3.

Source: OFAC "Civil Penalties and Enforcement Information" year pages
(https://ofac.treasury.gov/civil-penalties-and-enforcement-information). Each page lists
one row per enforcement action: date, name, number of penalties/settlements, total USD.

Writes
  data/sources/ofac_penalties_by_year.csv    annual total and count, 2006 onward
  data/sources/ofac_settlements_150m.csv      every row of $150 million or more

Usage (from the repository root)
  python3 scripts/fetch_ofac_penalties.py             # fetch, print comparison, rewrite extracts
  python3 scripts/fetch_ofac_penalties.py --check     # fetch and compare only; exit 1 on any change

Fails loudly if a page cannot be fetched or parsed. There is no fallback to stored values.
The sector label of a new $150 million row has to be set by hand in SECTOR below.
"""
import csv
import re
import sys
import time
import urllib.request
from datetime import date
from html.parser import HTMLParser
from pathlib import Path

BASE = "https://ofac.treasury.gov/civil-penalties-and-enforcement-information"
FIRST_YEAR = 2006          # earlier pages use a different table layout (customs forfeitures, hearings)
THRESHOLD = 150_000_000
SOURCE = "OFAC Civil Penalties and Enforcement Information (year pages)"
SECTOR = {  # entity -> sector for rows at or above the threshold
    "Lloyds TSB Bank, plc": "bank", "Credit Suisse AG": "bank", "Barclays Bank PLC": "bank",
    "ING Bank N.V.": "bank", "HSBC Holdings plc": "bank", "Clearstream Banking, S.A.": "bank",
    "BNP Paribas SA": "bank", "Commerzbank AG": "bank",
    "Crédit Agricole Corporate and Investment Bank": "bank", "Standard Chartered Bank": "bank",
    "UniCredit Bank": "bank",
}
ROOT = Path(__file__).resolve().parents[1]
OUT_YEAR = ROOT / "data" / "sources" / "ofac_penalties_by_year.csv"
OUT_BIG = ROOT / "data" / "sources" / "ofac_settlements_150m.csv"


class RowParser(HTMLParser):
    """Collects the text of every <tr> as a list of cell strings."""

    def __init__(self):
        super().__init__()
        self.rows, self._row, self._cell, self._in_cell = [], None, [], False

    def handle_starttag(self, tag, attrs):
        if tag == "tr":
            self._row = []
        elif tag in ("td", "th") and self._row is not None:
            self._cell, self._in_cell = [], True

    def handle_endtag(self, tag):
        if tag in ("td", "th") and self._in_cell:
            self._row.append(re.sub(r"\s+", " ", "".join(self._cell)).strip())
            self._in_cell = False
        elif tag == "tr" and self._row is not None:
            self.rows.append(self._row)
            self._row = None

    def handle_data(self, data):
        if self._in_cell:
            self._cell.append(data)


def http_get(url, tries=4):
    for k in range(tries):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 (figure refresh)"})
            with urllib.request.urlopen(req, timeout=60) as r:
                return r.read().decode("utf-8")
        except Exception as e:  # noqa: BLE001
            if k == tries - 1:
                raise RuntimeError(f"could not fetch {url}: {e}") from e
            time.sleep(2 * (k + 1))


def year_rows(html):
    p = RowParser()
    p.feed(html)
    out = []
    for c in p.rows:
        if len(c) >= 4 and re.fullmatch(r"\d\d/\d\d/\d{4}", c[0]):
            m, d, y = c[0].split("/")
            out.append((f"{y}-{m}-{d}", c[1], int(c[2].replace(",", "")),
                        round(float(re.sub(r"[^0-9.]", "", c[3])) * 100)))  # amounts in cents
    if not out:
        raise RuntimeError("no enforcement rows parsed: page layout has changed")
    return out


def build(fetch=http_get):
    this_year = date.today().year
    ann, big = [], []
    for y in range(FIRST_YEAR, this_year + 1):
        url = BASE if y == this_year else f"{BASE}/{y}-enforcement-information"
        rows = year_rows(fetch(url))
        if y != this_year and not all(r[0].startswith(str(y)) for r in rows):
            raise RuntimeError(f"{y}: rows dated outside the year")
        ann.append(dict(year=y, n_listed=len(rows), n_actions=sum(r[2] for r in rows),
                        total_usd=f"{sum(r[3] for r in rows) / 100:.2f}",
                        partial_year=str(y == this_year).upper()))
        for dt, name, n, cents in rows:
            if cents >= THRESHOLD * 100:
                if name not in SECTOR and name not in {"British American Tobacco p.l.c.", "Binance",
                                                       "GVA Capital Ltd.", "Adani Enterprises Limited"}:
                    print(f"NEW row at or above $150m, set its sector in SECTOR: {dt} {name} {cents / 100:,.0f}")
                big.append(dict(date=dt, entity=name, n_penalties=n, amount_usd=f"{cents / 100:.0f}",
                                sector=SECTOR.get(name, "other")))
    big.sort(key=lambda r: r["date"])
    return ann, big


def read_csv(path):
    with open(path, newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def compare(new, old, keys, label):
    changed = 0
    for n in new:
        o = [x for x in old if all(x[k] == str(n[k]) for k in keys[:1])]
        if not o:
            print(f"{label}: new row {n}"); changed += 1
        else:
            for k, v in n.items():
                if k in ("source", "series", "vintage"):
                    continue
                if str(o[0][k]).replace(".00", "") != str(v).replace(".00", ""):
                    print(f"{label} {n[keys[0]]}: {k} stored {o[0][k]} fetched {v}"); changed += 1
    return changed


def write(path, rows, series, vintage):
    cols = list(rows[0]) + ["source", "series", "vintage"]
    with open(path, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=cols, lineterminator="\n")
        w.writeheader()
        for r in rows:
            w.writerow({**r, "source": SOURCE, "series": series, "vintage": vintage})


def main(argv, fetch=http_get):
    ann, big = build(fetch)
    # Published aggregate the transcription must reproduce: OFAC's own annual rows sum to the same total
    # in the committed extract. A parser slip changes it.
    total = sum(float(r["total_usd"]) for r in ann)
    print(f"OFAC civil penalties and settlements {FIRST_YEAR}-{date.today().year}: ${total:,.2f} "
          f"across {sum(r['n_actions'] for r in ann)} actions; {len(big)} rows at or above $150m")
    changed = 0
    if OUT_YEAR.exists():
        changed += compare(ann, read_csv(OUT_YEAR), ["year"], "by year")
    if OUT_BIG.exists():
        changed += compare(big, read_csv(OUT_BIG), ["date"], ">=150m")
    print(f"{changed} differences from the committed extracts")
    if "--check" in argv:
        return 1 if changed else 0
    vintage = f"retrieved {date.today().isoformat()}"
    write(OUT_YEAR, ann, "Penalties/Settlements Total in USD summed over listed rows", vintage)
    write(OUT_BIG, big, "Penalties/Settlements Total in USD", vintage)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
