"""
Figure 10.1: Dollar Share of Global Foreign Exchange Reserves (1995-2050)
Shows historical trends and future scenarios for de-dollarization
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read data
df = pd.read_csv('../data/sources/dollar_reserves_projection.csv')

# Create figure
fig, ax = plt.subplots(figsize=(14, 8))

# Plot historical data
historical = df[df['Year'] <= 2024].copy()
ax.plot(historical['Year'], historical['USD_Historical'], linewidth=3, marker='o', markersize=7,
        color='#1f77b4', label='USD (Historical)', zorder=5)
ax.plot(historical['Year'], historical['EUR_Historical'], linewidth=2.5, marker='s', markersize=6,
        color='#ff7f0e', label='EUR (Historical)', zorder=4)
ax.plot(historical['Year'], historical['CNY_Historical'], linewidth=2.5, marker='^', markersize=6,
        color='#d62728', label='CNY (Historical)', zorder=4)

# Plot projections - USD scenarios
future = df[df['Year'] >= 2024].copy()

# Baseline scenario
ax.plot(future['Year'], future['USD_Baseline'], linewidth=3, linestyle='--',
        color='#1f77b4', label='USD - Baseline Scenario', alpha=0.8, zorder=3)

# Slow decline scenario
ax.plot(future['Year'], future['USD_Slow_Decline'], linewidth=3, linestyle=':',
        color='#2ca02c', label='USD - Slow Decline', alpha=0.8, zorder=3)

# Accelerated decline scenario
ax.plot(future['Year'], future['USD_Accelerated'], linewidth=3, linestyle='-.',
        color='#d62728', label='USD - Accelerated Decline', alpha=0.8, zorder=3)

# Shade projection area
ax.fill_between(future['Year'], future['USD_Baseline'], future['USD_Accelerated'],
                alpha=0.15, color='gray', label='Range of Scenarios')

# Mark 2024 dividing line
ax.axvline(x=2024, color='black', linestyle='-', linewidth=2, alpha=0.5)
ax.text(2024, 72, '← Historical | Projections →',
        ha='center', va='bottom', fontsize=11, fontweight='bold',
        bbox=dict(boxstyle='round,pad=0.5', facecolor='yellow', alpha=0.6, edgecolor='black'))

# Mark key events
events = [
    (1999, 'Euro\nLaunch'),
    (2008, 'Global\nFinancial\nCrisis'),
    (2022, 'Russia\nSanctions'),
]

for year, label in events:
    ax.axvline(x=year, color='gray', linestyle='--', linewidth=1, alpha=0.4)
    ax.text(year, 75, label, rotation=0, ha='center', va='bottom', fontsize=8,
            bbox=dict(boxstyle='round,pad=0.2', facecolor='lightgray', alpha=0.6))

# Labels and title
ax.set_xlabel('Year', fontsize=12)
ax.set_ylabel('Share of Global Foreign Exchange Reserves (%)', fontsize=12)
ax.set_title('U.S. Dollar Share of Global Reserves: Historical and Projected (1995-2050)',
             fontsize=14, fontweight='bold', pad=20)
ax.legend(loc='upper right', fontsize=10, ncol=2)
ax.grid(True, alpha=0.3)
ax.set_xlim(1995, 2050)
ax.set_ylim(25, 75)

# Add scenario descriptions
scenario_text = "Three Scenarios for 2050:\n\n"
scenario_text += "Baseline (50.5%): Gradual diversification,\nUSD maintains dominance\n\n"
scenario_text += "Slow Decline (38.0%): Steady shift to\nmulti-polar reserve system\n\n"
scenario_text += "Accelerated (30.0%): Major disruption,\nrapid de-dollarization"
ax.text(0.02, 0.30, scenario_text, transform=ax.transAxes,
        fontsize=9, verticalalignment='bottom', horizontalalignment='left',
        bbox=dict(boxstyle='round', facecolor='lightyellow', alpha=0.8, edgecolor='black'))

# Add key statistics
stats_text = "Historical Trend:\n"
stats_text += f"1995: {historical['USD_Historical'].iloc[0]:.1f}%\n"
stats_text += f"2024: {historical['USD_Historical'].iloc[-1]:.1f}%\n"
stats_text += f"Change: {historical['USD_Historical'].iloc[-1] - historical['USD_Historical'].iloc[0]:.1f} percentage points\n\n"
stats_text += "2024 Composition:\n"
stats_text += f"USD: {historical['USD_Historical'].iloc[-1]:.1f}%\n"
stats_text += f"EUR: {historical['EUR_Historical'].iloc[-1]:.1f}%\n"
stats_text += f"CNY: {historical['CNY_Historical'].iloc[-1]:.1f}%"
ax.text(0.98, 0.02, stats_text, transform=ax.transAxes,
        fontsize=9, verticalalignment='bottom', horizontalalignment='right',
        bbox=dict(boxstyle='round', facecolor='lightblue', alpha=0.8))

plt.tight_layout()

# Save figure
plt.savefig('figure_10_1_dollar_reserves.png', dpi=300, bbox_inches='tight')
plt.savefig('figure_10_1_dollar_reserves.pdf', bbox_inches='tight')
print("Figure 10.1 saved successfully!")

plt.show()
