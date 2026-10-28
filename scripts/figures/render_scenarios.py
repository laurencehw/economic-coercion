#!/usr/bin/env python3
"""Render Figures 10.1 and 10.5 with Python 3 and matplotlib, from any directory.

PNG and PDF outputs go to figures/. No network data is fetched.
"""

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "scripts"))
from scenario_data import load_reserve_paths, load_planning_weights

import book_style as bs
import matplotlib
matplotlib.use("Agg")
from matplotlib.patches import Rectangle
from matplotlib.ticker import PercentFormatter

bs.use()
ILLUSTRATION = "Author's illustration (stylized, not data)."


def save(fig, filename, source, **adj):
    target = ROOT / "figures" / filename
    target.parent.mkdir(parents=True, exist_ok=True)
    bs.finish(fig, str(target), source=source, **adj)


def reserve_figure():
    rows = load_reserve_paths(ROOT / "data/sources/dollar_reserves_projection.csv")
    years = [r["Year"] for r in rows]
    fig, ax = bs.new_figure(height=3.6)
    ax.fill_between(years, [r["USD_Disruption"] for r in rows],
                    [r["USD_Baseline"] for r in rows], color=bs.GREY_GRID, alpha=.7, linewidth=0)
    series = [("USD_Baseline", "Baseline", bs.INK, "--"),
              ("USD_Diversification", "Greater diversification", bs.GREY_TEXT, ":"),
              ("USD_Disruption", "Disruption", bs.RED, "-")]
    for key, label, color, style in series:
        values = [r[key] for r in rows]
        ax.plot(years, values, color=color, linestyle=style, linewidth=1.6)
        bs.label_end(ax, years[-1], values[-1], f"{label}, {values[-1]:g}%", color=color)
    observed = rows[0]["USD_Observed"]
    ax.scatter([years[0]], [observed], color=bs.INK, s=18, zorder=5)
    ax.annotate(f"2025Q3 observed: {observed:.2f}%", (years[0], observed), xytext=(6, 8),
                textcoords="offset points", fontsize=7.5, color=bs.INK)
    ax.set(xlim=(2025, 2050), ylim=(0, 70), ylabel="Share of foreign exchange reserves (%)")
    ax.set_xticks([2025.75, 2030, 2035, 2040, 2045, 2050], ["2025Q3", "2030", "2035", "2040", "2045", "2050"])
    ax.yaxis.set_major_formatter(PercentFormatter(100))
    save(fig, "fig_10_01_dollar_reserves.png",
         "Sources: observed anchor from IMF COFER 2025Q3, released 19 December 2025 (Chapter 7). Paths to 2050: "
         "author scenarios. " + ILLUSTRATION + " Shading spans the paths and is not a confidence interval; no probabilities are assigned.",
         left=0.11, right=0.72, top=0.96)


def scenario_figure():
    rows = load_planning_weights(ROOT / "data/sources/scenario_planning_weights.csv")
    fig = bs.plt.figure(figsize=(bs.WIDTH, 3.9))
    ax = fig.add_axes([.17, .27, .46, .65])
    bars = fig.add_axes([.74, .26, .23, .66])
    shade = {"A": bs.GREY_GRID, "B": "#F0F0F0", "C": "#F0F0F0", "D": "#F0F0F0"}
    for r, (x, y) in zip(rows, [(0.5, .5), (0, .5), (0, 0), (.5, 0)]):
        ax.add_patch(Rectangle((x, y), .5, .5, facecolor="#F4F4F4", edgecolor="none", zorder=0))
        highlight = r["Scenario"] == "A"
        # scatter s is area in points squared, so weight is proportional to area.
        ax.scatter(r["Integration"], r["Competition"], s=r["Planning_Weight"] * 14,
                   color=bs.RED if highlight else bs.GREY_FADE, edgecolors="none", zorder=3)
        offset = 28 if r["Scenario"] == "D" else -26
        ax.annotate(f"{r['Scenario']}: {r['Label'].replace(' ', chr(10), 1)}\n{r['Planning_Weight']:g}% weight",
                    (r["Integration"], r["Competition"]), xytext=(0, offset),
                    textcoords="offset points", ha="center", va="center", fontsize=7.5, color=bs.INK)
    ax.axhline(.5, color=bs.GREY_REF, linewidth=.7)
    ax.axvline(.5, color=bs.GREY_REF, linewidth=.7)
    ax.grid(False)
    ax.set(xlim=(0, 1), ylim=(0, 1), xlabel="Integration", ylabel="Bilateral competition")
    ax.set_xticks([.25, .75], ["Fragmented", "Integrated"])
    ax.set_yticks([.25, .75], ["Less\ncoherent", "Intense"])
    bs.panel_title(ax, "A. Four reference worlds")
    weights = [r["Planning_Weight"] for r in rows]
    names = [r["Scenario"] for r in rows]
    bars.bar(names, weights, color=[bs.RED if n == "A" else bs.GREY_FADE for n in names], width=.65)
    for i, weight in enumerate(weights):
        bars.text(i, weight + 1, f"{weight:g}%", ha="center", fontsize=7.5, color=bs.INK)
    bars.set(ylim=(0, 50), xlabel="Reference world")
    bars.yaxis.set_major_formatter(PercentFormatter(100))
    bs.panel_title(bars, "B. Planning weight")
    save(fig, "fig_10_05_scenario_matrix.png",
         ILLUSTRATION + " Qualitative positions and subjective planning weights from Chapter 10's scenario exercise; "
         "they are not calibrated probabilities and sum to 100 for classroom analysis. Bubble area is proportional to weight. "
         "C is uneven regional crises: less coherent bilateral rivalry, but high disruption risk.",
         left=0.17, right=0.97, top=0.92, bottom=0.27)


if __name__ == "__main__":
    reserve_figure()
    scenario_figure()
