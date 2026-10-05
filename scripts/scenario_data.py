"""Load scenario inputs and reject inconsistent anchors, shares, or weights."""

import csv
import math
from pathlib import Path

RESERVE_PATHS = ("USD_Baseline", "USD_Diversification", "USD_Disruption")


def percentage(value, label):
    number = float(value)
    if not math.isfinite(number) or not 0 <= number <= 100:
        raise ValueError(f"{label}: expected a finite percentage in [0, 100]")
    return number


def load_reserve_paths(path: Path):
    with path.open(encoding="utf-8", newline="") as fh:
        source = list(csv.DictReader(fh))
    if len(source) < 2:
        raise ValueError("reserve paths need an observed anchor and future points")
    rows = []
    for raw in source:
        row = {"Period": raw["Period"], "Year": float(raw["Year"]),
               "USD_Observed": percentage(raw["USD_Observed"], "USD_Observed") if raw["USD_Observed"] else None}
        row.update({key: percentage(raw[key], key) for key in RESERVE_PATHS})
        rows.append(row)
    if any(not math.isfinite(r["Year"]) for r in rows):
        raise ValueError("years must be finite")
    if any(b["Year"] <= a["Year"] for a, b in zip(rows, rows[1:])):
        raise ValueError("years must increase strictly")
    anchor = rows[0]["USD_Observed"]
    if anchor is None or any(r["USD_Observed"] is not None for r in rows[1:]):
        raise ValueError("only the first row may contain an observed share")
    if any(abs(rows[0][key] - anchor) > 1e-8 for key in RESERVE_PATHS):
        raise ValueError("every path must start at the observed anchor")
    if any(not r["USD_Disruption"] <= r["USD_Diversification"] <= r["USD_Baseline"] for r in rows):
        raise ValueError("path ordering must agree with the shaded range")
    return rows


def load_planning_weights(path: Path):
    with path.open(encoding="utf-8", newline="") as fh:
        source = list(csv.DictReader(fh))
    if [r["Scenario"] for r in source] != ["A", "B", "C", "D"]:
        raise ValueError("scenario rows must contain A, B, C, D exactly once and in order")
    rows = []
    for raw in source:
        row = dict(raw)
        for axis in ("Integration", "Competition"):
            row[axis] = float(raw[axis])
            if not math.isfinite(row[axis]) or not 0 <= row[axis] <= 1:
                raise ValueError(f"{axis}: expected a coordinate in [0, 1]")
        row["Planning_Weight"] = percentage(raw["Planning_Weight"], "Planning_Weight")
        if not raw["Label"].strip():
            raise ValueError("each scenario needs a label")
        rows.append(row)
    if abs(sum(r["Planning_Weight"] for r in rows) - 100) > 1e-8:
        raise ValueError("planning weights must sum to 100")
    for r, (right, top) in zip(rows, [(True, True), (False, True), (False, False), (True, False)]):
        if (r["Integration"] > .5) != right or (r["Competition"] > .5) != top:
            raise ValueError(f"scenario {r['Scenario']} is outside its stated quadrant")
    return rows
