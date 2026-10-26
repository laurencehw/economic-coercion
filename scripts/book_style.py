"""House style for matplotlib figures. See docs/CHART_STYLE.md.

Usage, at the top of a figure script::

    import book_style as bs
    bs.use()
    fig, ax = bs.new_figure(height=3.8)
    ...
    bs.finish(fig, source="Sources: ...", path=os.path.join(FIG_DIR, "fig_x"))

Figures are drawn at the printed width (6 in) and saved at 300 dpi as PNG and PDF with a fixed
canvas, so text prints at the size it was drawn. Titles belong in the manuscript caption, not the
image; use ``panel_title`` for "A. ..." labels on multi-panel figures.
"""
from __future__ import annotations

import os
import matplotlib as mpl
import matplotlib.pyplot as plt

# -- palette ---------------------------------------------------------------
INK = "#1F2A37"
GREEN, RED, BLUE, ORANGE, GOLD, PURPLE = "#2D6A4F", "#C1292E", "#1B6CA8", "#E07A2F", "#D4A843", "#7B5EA7"
GREY_FADE, GREY_GRID, GREY_REF, GREY_TEXT = "#BDBDBD", "#E5E5E5", "#BDBDBD", "#595959"
HUES = [GREEN, RED, BLUE, ORANGE, GOLD, PURPLE]
PALETTE = {"ink": INK, "green": GREEN, "red": RED, "blue": BLUE, "orange": ORANGE, "gold": GOLD,
           "purple": PURPLE, "fade": GREY_FADE, "grid": GREY_GRID, "ref": GREY_REF, "text": GREY_TEXT}

WIDTH = 6.0  # printed width in inches (one text column)

RC = {
    "font.family": "sans-serif",
    "font.sans-serif": ["Arial", "Liberation Sans", "Helvetica", "DejaVu Sans"],
    "font.size": 8,
    "axes.titlesize": 9, "axes.titleweight": "bold", "axes.titlelocation": "left", "axes.titlepad": 6,
    "axes.labelsize": 8, "axes.labelcolor": GREY_TEXT,
    "axes.edgecolor": GREY_REF, "axes.linewidth": 0.5,
    "axes.spines.top": False, "axes.spines.right": False,
    "axes.grid": True, "axes.grid.axis": "y", "grid.color": GREY_GRID, "grid.linewidth": 0.5,
    "axes.axisbelow": True,
    "axes.prop_cycle": mpl.cycler(color=HUES),
    "xtick.labelsize": 7.5, "ytick.labelsize": 7.5, "xtick.color": GREY_TEXT, "ytick.color": GREY_TEXT,
    "xtick.major.width": 0.5, "ytick.major.width": 0.5, "xtick.major.size": 3, "ytick.major.size": 0,
    "ytick.left": False,
    "legend.fontsize": 7.5, "legend.frameon": False, "legend.handlelength": 1.6, "legend.borderaxespad": 0.2,
    "lines.linewidth": 1.4, "lines.markersize": 3.5,
    "patch.linewidth": 0,
    "savefig.dpi": 300, "savefig.facecolor": "white", "figure.facecolor": "white",
    "figure.dpi": 100, "figure.constrained_layout.use": False,
    "axes.unicode_minus": True,
    "pdf.fonttype": 42, "ps.fonttype": 42,
}


def use() -> None:
    """Apply the house rcParams (call once at the top of a script)."""
    plt.rcParams.update(RC)


def new_figure(height: float = 3.8, nrows: int = 1, ncols: int = 1, width: float = WIDTH, **kw):
    """A figure at the printed width. Returns (fig, ax) like plt.subplots."""
    kw.setdefault("sharex", False)
    fig, ax = plt.subplots(nrows, ncols, figsize=(width, height), **kw)
    return fig, ax


def panel_title(ax, text: str) -> None:
    """'A. Short title' at the top left of a panel."""
    ax.set_title(text, loc="left", fontsize=9, fontweight="bold", color=INK, pad=6)


def zero_line(ax, y: float = 0.0, **kw) -> None:
    """A reference line one step darker than the grid."""
    kw.setdefault("color", GREY_REF); kw.setdefault("linewidth", 0.7); kw.setdefault("zorder", 1)
    ax.axhline(y, **kw)


def vline(ax, x, label: str | None = None, **kw) -> None:
    """A dated reference line (e.g. a shock year) with an optional small grey label at the top."""
    kw.setdefault("color", GREY_REF); kw.setdefault("linewidth", 0.7); kw.setdefault("linestyle", (0, (3, 2)))
    kw.setdefault("zorder", 1)
    ax.axvline(x, **kw)
    if label:
        ax.annotate(label, xy=(x, 1.0), xycoords=("data", "axes fraction"), xytext=(3, -2),
                    textcoords="offset points", ha="left", va="top", fontsize=7, color=GREY_TEXT)


def label_end(ax, x, y, text: str, color: str = INK, dx: float = 4, dy: float = 0, **kw) -> None:
    """Direct label at the end of a line, in the line's colour."""
    kw.setdefault("fontsize", 7.5); kw.setdefault("va", "center"); kw.setdefault("ha", "left")
    ax.annotate(text, xy=(x, y), xytext=(dx, dy), textcoords="offset points", color=color,
                clip_on=False, annotation_clip=False, **kw)


def legend_top(ax, ncol: int | None = None, **kw):
    """Legend above the panel, left aligned, no frame (for four or more series)."""
    handles, labels = ax.get_legend_handles_labels()
    if not handles:
        return None
    ncol = ncol or min(len(handles), 3)
    kw.setdefault("loc", "lower left"); kw.setdefault("bbox_to_anchor", (0, 1.0))
    kw.setdefault("ncol", ncol); kw.setdefault("frameon", False); kw.setdefault("columnspacing", 1.4)
    return ax.legend(handles, labels, **kw)


CHARS_PER_LINE = 125  # at 6.5 pt across a 6 in canvas


def _wrap_source(text: str) -> str:
    """Wrap a source line to the canvas width, keeping any explicit line breaks."""
    import textwrap
    out = []
    for para in text.split("\n"):
        out.extend(textwrap.wrap(para, CHARS_PER_LINE) or [""])
    return "\n".join(out)


def source(fig, text: str, y: float = 0.012) -> None:
    """Source line at the bottom left of the figure, grey, small."""
    fig.text(0.012, y, _wrap_source(text), ha="left", va="bottom", fontsize=6.5, color=GREY_TEXT, linespacing=1.3)


def finish(fig, path: str, source: str | None = None, formats=("png", "pdf"), bottom: float | None = None,
           **subplots_adjust) -> None:
    """Add the source line, fix the layout and save ``path.png`` / ``path.pdf`` with a fixed canvas.

    ``bottom`` is the fraction of the canvas reserved below the axes; by default it leaves room for
    the x tick labels plus the (wrapped) source line.
    """
    h = fig.get_figheight()
    if source:
        n_lines = _wrap_source(source).count("\n") + 1
        if bottom is None:
            bottom = min(0.42, (0.36 + 0.115 * n_lines) / h)  # inches of tick labels + 0.115 in per line
        globals()["source"](fig, source)
    adj = {"left": 0.11, "right": 0.97, "top": 0.93, "bottom": bottom if bottom is not None else 0.36 / h}
    adj.update(subplots_adjust)
    fig.subplots_adjust(**adj)
    base = os.path.splitext(path)[0]
    for ext in formats:
        fig.savefig(f"{base}.{ext}", dpi=300, bbox_inches=None, facecolor="white")
    plt.close(fig)


def fmt_thousands(ax, axis: str = "y") -> None:
    """Thousands separators on an axis."""
    from matplotlib.ticker import FuncFormatter
    f = FuncFormatter(lambda v, _: f"{v:,.0f}")
    (ax.yaxis if axis == "y" else ax.xaxis).set_major_formatter(f)
