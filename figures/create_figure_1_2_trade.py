"""
Figure 1.2: U.S.-China Trade Flows Over Time (1990-2024)
Shows the dramatic growth and recent volatility in U.S.-China trade,
with key milestones marked (WTO accession, trade war, COVID-19).
"""

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

# Set style for publication-quality figures
plt.style.use('seaborn-v0_8-whitegrid')
plt.rcParams['font.family'] = 'sans-serif'
plt.rcParams['font.sans-serif'] = ['Arial', 'DejaVu Sans']
plt.rcParams['font.size'] = 11

# Load data
data = pd.read_csv('../data/sources/us_china_trade.csv')

# Create figure with two subplots
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(14, 10), height_ratios=[2, 1])

# ===== TOP PANEL: Trade Flows =====
ax1.plot(data['Year'], data['US_Exports_to_China'],
         marker='o', linewidth=2.5, markersize=4,
         color='#2ca02c', label='U.S. Exports to China', alpha=0.9)
ax1.plot(data['Year'], data['US_Imports_from_China'],
         marker='s', linewidth=2.5, markersize=4,
         color='#d62728', label='U.S. Imports from China', alpha=0.9)
ax1.plot(data['Year'], data['Total_Trade'],
         marker='^', linewidth=2, markersize=4,
         color='#1f77b4', label='Total Bilateral Trade', alpha=0.7, linestyle='--')

# Mark key events with vertical lines and simple labels
events = [
    (2001, 'WTO', 650),
    (2018, 'Trade War', 650),
    (2020, 'COVID-19', 650)
]

for year, label, ypos in events:
    ax1.axvline(x=year, color='gray', linestyle=':', alpha=0.5, linewidth=1.2)
    ax1.text(year, ypos, label, ha='center', fontsize=9,
            fontweight='bold', rotation=0,
            bbox=dict(boxstyle='round,pad=0.3', facecolor='white',
                     alpha=0.8, edgecolor='gray', linewidth=0.5))

# Customize top panel
ax1.set_ylabel('Trade Value (Billions USD)', fontweight='bold', fontsize=12)
ax1.set_title('Figure 1.2: U.S.-China Trade Flows Over Time (1990-2024)\n' +
             'The Rise, Peak, and Volatility of Bilateral Trade',
             fontweight='bold', fontsize=16, pad=15)
ax1.legend(loc='upper left', framealpha=0.95, edgecolor='black', fontsize=11)
ax1.grid(True, alpha=0.3, linestyle='--', linewidth=0.5)
ax1.set_xlim(1988, 2026)
ax1.set_ylim(0, 750)

# Shaded region removed for cleaner look

# ===== BOTTOM PANEL: Trade Balance =====
colors_balance = ['#d62728' if x < 0 else '#2ca02c' for x in data['Trade_Balance']]
ax2.bar(data['Year'], data['Trade_Balance'], color=colors_balance, alpha=0.7, edgecolor='black', linewidth=0.5)
ax2.axhline(y=0, color='black', linestyle='-', linewidth=1.5)

# Customize bottom panel
ax2.set_xlabel('Year', fontweight='bold', fontsize=12)
ax2.set_ylabel('U.S. Trade Balance\n(Billions USD)', fontweight='bold', fontsize=11)
ax2.set_title('U.S. Trade Deficit with China', fontweight='bold', fontsize=13, pad=10)
ax2.grid(True, alpha=0.3, linestyle='--', linewidth=0.5, axis='y')
ax2.set_xlim(1988, 2026)

# Simplified peak deficit label
peak_deficit_idx = data['Trade_Balance'].idxmin()
peak_year = data.loc[peak_deficit_idx, 'Year']
peak_value = data.loc[peak_deficit_idx, 'Trade_Balance']
ax2.text(peak_year, peak_value - 30, f'Peak: ${abs(peak_value):.0f}B',
        ha='center', fontsize=9, fontweight='bold', color='darkred')

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: U.S. Census Bureau, U.S. International Trade Commission (USITC), UN Comtrade\n' +
           'Note: Values in current USD billions. Trade balance = U.S. exports minus U.S. imports (negative = deficit).\n' +
           '2024 values are estimates based on first three quarters.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Statistics box moved to bottom right to avoid legend overlap
stats_text = (f'1990: ${data.iloc[0]["Total_Trade"]:.1f}B\n'
             f'Peak 2022: ${data["Total_Trade"].max():.1f}B\n'
             f'2024: ${data.iloc[-1]["Total_Trade"]:.1f}B')
props = dict(boxstyle='round', facecolor='lightblue', alpha=0.85, edgecolor='gray', linewidth=1)
ax1.text(0.98, 0.03, stats_text, transform=ax1.transAxes, fontsize=9,
        verticalalignment='bottom', horizontalalignment='right', bbox=props, family='monospace')

# Adjust layout
plt.tight_layout(rect=[0, 0.05, 1, 1])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_1_2_us_china_trade.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_1_2_us_china_trade.pdf', bbox_inches='tight')

print("[OK] Figure 1.2 created successfully!")
print(f"  - PNG: {output_dir}/figure_1_2_us_china_trade.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_1_2_us_china_trade.pdf (vector)")
print(f"\nKey trade milestones:")
print(f"  • 2001 (WTO): Total trade ${data[data['Year']==2001]['Total_Trade'].values[0]:.1f}B")
print(f"  • 2018 (Trade War): Total trade ${data[data['Year']==2018]['Total_Trade'].values[0]:.1f}B")
print(f"  • 2022 (Peak): Total trade ${data['Total_Trade'].max():.1f}B")
print(f"  • 2024 (Current): Total trade ${data.iloc[-1]['Total_Trade']:.1f}B")
print(f"  • Peak deficit: ${abs(data['Trade_Balance'].min()):.1f}B in {data.loc[data['Trade_Balance'].idxmin(), 'Year']:.0f}")

plt.close()
