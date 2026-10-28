#!/usr/bin/env python3
"""Refresh the South African GDP-growth and exchange-rate extract behind Figure 9.2.

Source: World Bank World Development Indicators through the public API (api.worldbank.org)
  NY.GDP.MKTP.KD.ZG   GDP growth (annual %)
  PA.NUS.FCRF         Official exchange rate (LCU per US$, period average)

Writes data/sources/south_africa_gdp_rand_1980_1994.csv.

Usage (from the repository root)
  python3 scripts/fetch_worldbank_south_africa.py            # fetch, print comparison, rewrite the extract
  python3 scripts/fetch_worldbank_south_africa.py --check    # fetch and compare only; exit 1 on any change

Fails loudly if a year is missing. There is no fallback to stored values.
"""
import csv
import json
import sys
import urllib.request
from datetime import date
from pathlib import Path

API = "https://api.worldbank.org/v2/country/ZAF/indicator/{ind}?format=json&date=1980:1994&per_page=100"
GDP, FX = "NY.GDP.MKTP.KD.ZG", "PA.NUS.FCRF"
SOURCE = "World Bank World Development Indicators (api.worldbank.org, country ZAF)"
SERIES = ("NY.GDP.MKTP.KD.ZG (GDP growth, annual %); "
          "PA.NUS.FCRF (official exchange rate, LCU per USD, period average)")
OUT = Path(__file__).resolve().parents[1] / "data" / "sources" / "south_africa_gdp_rand_1980_1994.csv"
YEARS = range(1980, 1995)


def http_get_json(url):
    with urllib.request.urlopen(url, timeout=60) as r:
        return json.load(r)


def series(payload):
    meta, rows = payload
    out = {int(d["date"]): d["value"] for d in rows}
    missing = [y for y in YEARS if out.get(y) is None]
    if missing:
        raise SystemExit(f"World Bank API returned no value for {missing}")
    return meta["lastupdated"], out


def build(fetch=http_get_json):
    lu_g, g = series(fetch(API.format(ind=GDP)))
    lu_f, f = series(fetch(API.format(ind=FX)))
    vintage = f"WDI lastupdated {max(lu_g, lu_f)}; retrieved {date.today().isoformat()}"
    return [[y, round(g[y], 4), round(f[y], 4), SOURCE, SERIES, vintage] for y in YEARS]


def read_committed():
    with open(OUT, encoding="utf-8") as fh:
        return {int(r["year"]): (float(r["gdp_growth_pct"]), float(r["zar_per_usd"])) for r in csv.DictReader(fh)}


def main(argv, fetch=http_get_json):
    rows = build(fetch)
    old = read_committed() if OUT.exists() else {}
    changed = 0
    for y, g, f, *_ in rows:
        if y in old and (abs(old[y][0] - g) > 1e-3 or abs(old[y][1] - f) > 1e-3):
            changed += 1
            print(f"{y}: committed GDP {old[y][0]} / ZAR per USD {old[y][1]}  ->  fetched {g} / {f}")
    print(f"{len(rows)} years fetched; {changed} differences from the committed extract")
    if "--check" in argv:
        return 1 if changed else 0
    with open(OUT, "w", newline="", encoding="utf-8") as fh:
        w = csv.writer(fh, lineterminator="\n")
        w.writerow(["year", "gdp_growth_pct", "zar_per_usd", "source", "series", "vintage"])
        w.writerows(rows)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
