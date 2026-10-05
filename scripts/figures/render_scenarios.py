#!/usr/bin/env python3
"""Render Figures 10.1 and 10.5 with Python 3 and matplotlib, from any directory.

PNG and PDF outputs go to figures/. No network data is fetched.
"""

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "scripts"))
from scenario_data import load_reserve_paths, load_planning_weights

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
from matplotlib.ticker import PercentFormatter

COLORS = ["#2ca02c", "#d62728", "#ff7f0e", "#1f77b4"]


def save(fig, filename):
    target = ROOT / "figures" / filename
    target.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(target, dpi=300, facecolor="white")
    fig.savefig(target.with_suffix(".pdf"), facecolor="white")
    plt.close(fig)


def reserve_figure():
    rows = load_reserve_paths(ROOT / "data/sources/dollar_reserves_projection.csv")
    years = [r["Year"] for r in rows]
    fig, ax = plt.subplots(figsize=(12, 7))
    fig.subplots_adjust(left=.10, right=.87, top=.80, bottom=.30)
    fig.text(.10, .93, "Dollar reserve share: observed anchor and illustrative paths",
             fontsize=17, weight="bold")
    fig.text(.10, .875, "Future points are assumptions, not fitted forecasts", fontsize=12, color="#555555")
    ax.axvspan(years[0], years[-1], color="#eeeeee", alpha=.5)
    ax.fill_between(years, [r["USD_Disruption"] for r in rows],
                    [r["USD_Baseline"] for r in rows], color="#aaaaaa", alpha=.2)
    for key, label, color, style in [
        ("USD_Baseline", "Baseline", "#1f77b4", "--"),
        ("USD_Diversification", "Greater diversification", "#2ca02c", ":"),
        ("USD_Disruption", "Disruption", "#d62728", "-."),
    ]:
        values = [r[key] for r in rows]
        ax.plot(years, values, color=color, linestyle=style, linewidth=2.5, label=label)
        ax.text(years[-1] + .4, values[-1], f"{values[-1]:g}%", color=color, va="center", fontsize=11)
    observed = rows[0]["USD_Observed"]
    ax.scatter([years[0]], [observed], color="black", s=55, zorder=5)
    ax.annotate(f"2025Q3 observed: {observed:.2f}%", (years[0], observed),
                xytext=(2028, 65), arrowprops={"arrowstyle": "->", "color": "#444444"}, fontsize=11)
    ax.set(xlim=(2025, 2052), ylim=(0, 70), xlabel="Year", ylabel="Share of foreign exchange reserves")
    ax.set_xticks([2025.75, 2030, 2035, 2040, 2045, 2050],
                  ["2025Q3", "2030", "2035", "2040", "2045", "2050"])
    ax.yaxis.set_major_formatter(PercentFormatter(100))
    ax.grid(axis="y", color="#dddddd")
    ax.spines[["top", "right"]].set_visible(False)
    ax.legend(loc="lower left", frameon=False)
    fig.text(.10, .06, "Observed anchor: IMF COFER 2025Q3, released 19 December 2025 (Chapter 7).\n"
             "Future paths: illustrative author assumptions through 2050. Shading is the span of the paths,\n"
             "not a confidence interval. No probabilities are assigned to these three reserve-share paths.",
             fontsize=10, color="#555555", linespacing=1.5)
    save(fig, "fig_10_01_dollar_reserves.png")


def scenario_figure():
    rows = load_planning_weights(ROOT / "data/sources/scenario_planning_weights.csv")
    fig = plt.figure(figsize=(12, 9))
    fig.text(.10, .95, "Four reference worlds for 2035–2050", fontsize=18, weight="bold")
    fig.text(.10, .905, "Qualitative positions and subjective planning weights; no calibrated probabilities",
             fontsize=11, color="#555555")
    ax = fig.add_axes([.10, .30, .53, .53])
    bars = fig.add_axes([.72, .35, .22, .42])
    for r, color, (x, y) in zip(rows, COLORS, [(0.5, .5), (0, .5), (0, 0), (.5, 0)]):
        ax.add_patch(Rectangle((x, y), .5, .5, facecolor=color, alpha=.10))
        # scatter s is area in points squared, so weight is proportional to area.
        ax.scatter(r["Integration"], r["Competition"], s=r["Planning_Weight"] * 35,
                   color=color, edgecolors="black", alpha=.85)
        offset = -55 if r["Competition"] > .5 else 40
        label = r["Label"].replace(" ", "\n", 1)
        ax.annotate(f"{r['Scenario']}: {label}\n{r['Planning_Weight']:g}% weight",
                    (r["Integration"], r["Competition"]), xytext=(0, offset),
                    textcoords="offset points", ha="center", va="center", fontsize=10, weight="bold")
    ax.axhline(.5, color="#888888", linewidth=1)
    ax.axvline(.5, color="#888888", linewidth=1)
    ax.set(xlim=(0, 1), ylim=(0, 1), xlabel="Integration", ylabel="Intensity of bilateral competition")
    ax.set_xticks([.1, .9], ["Fragmented", "Integrated"])
    ax.set_yticks([.1, .9], ["Less coherent", "Intense"])
    ax.set_aspect("equal")
    weights = [r["Planning_Weight"] for r in rows]
    bars.bar([r["Scenario"] for r in rows], weights, color=COLORS, alpha=.85)
    for i, weight in enumerate(weights):
        bars.text(i, weight + 1, f"{weight:g}%", ha="center", fontsize=10)
    bars.set(ylim=(0, 50), ylabel="Planning weight", xlabel="Reference world")
    bars.yaxis.set_major_formatter(PercentFormatter(100))
    bars.spines[["top", "right"]].set_visible(False)
    bars.grid(axis="y", color="#dddddd", alpha=.6)
    bars.set_axisbelow(True)
    fig.text(.10, .14, "A: Strategic rivalry with guardrails; trade continues outside sensitive sectors.\n"
             "B: Rival blocs; deep technology and financial fragmentation.\n"
             "C: Uneven regional crises; less coherent U.S.–China bloc rivalry, but high disruption risk.\n"
             "D: Wider cooperation and renewed integration.", fontsize=11, linespacing=1.6)
    fig.text(.10, .025, "Source: Chapter 10’s stylized scenario exercise. Bubble area is proportional to planning weight.\n"
             "Coordinates are illustrative; weights sum to 100 for classroom analysis. Worlds can overlap or follow\n"
             "one another. Low bilateral competition does not mean low regional crisis risk.",
             fontsize=10, color="#555555", linespacing=1.5)
    save(fig, "fig_10_05_scenario_matrix.png")


if __name__ == "__main__":
    reserve_figure()
    scenario_figure()
