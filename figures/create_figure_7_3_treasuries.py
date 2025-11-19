"""
Figure 7.3: Foreign Holdings of U.S. Treasury Securities
Shows which countries hold U.S. debt, highlighting China's peak and decline,
Japan's steady position, and the rise of European financial centers.
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Set style for publication-quality figures
plt.style.use('seaborn-v0_8-whitegrid')
plt.rcParams['font.family'] = 'sans-serif'
plt.rcParams['font.sans-serif'] = ['Arial', 'DejaVu Sans']
plt.rcParams['font.size'] = 11

# Load data
data = pd.read_csv('../data/sources/us_treasury_holdings.csv')

# Create figure
fig, ax = plt.subplots(figsize=(14, 8))

# Define colors for top holders
colors = {
    'China': '#d62728',        # Red
    'Japan': '#1f77b4',        # Blue
    'UK': '#2ca02c',           # Green
    'Ireland': '#ff7f0e',      # Orange
    'Luxembourg': '#9467bd',   # Purple
    'Others': '#7f7f7f',       # Gray
}

# Calculate aggregated "Others"
data['Top5_Others'] = data['Brazil'] + data['Belgium'] + data['Taiwan'] + \
                      data['Switzerland'] + data['Saudi_Arabia'] + data['Others']

# Create stacked area chart
countries = ['China', 'Japan', 'UK', 'Ireland', 'Luxembourg', 'Top5_Others']
labels = ['China', 'Japan', 'United Kingdom', 'Ireland', 'Luxembourg', 'Others']

ax.stackplot(data['Year'],
             [data[c] for c in countries],
             labels=labels,
             colors=[colors['China'], colors['Japan'], colors['UK'],
                    colors['Ireland'], colors['Luxembourg'], colors['Others']],
             alpha=0.8)

# Customize the plot
ax.set_xlabel('Year', fontweight='bold', fontsize=12)
ax.set_ylabel('Holdings (Billions USD)', fontweight='bold', fontsize=12)
ax.set_title('Figure 7.3: Foreign Holdings of U.S. Treasury Securities (2000-2024)\n' +
            'China\'s Peak and Decline, Japan\'s Stability, Europe\'s Rise',
            fontweight='bold', fontsize=16, pad=20)

# Add grid
ax.grid(True, alpha=0.3, linestyle='--', linewidth=0.5, axis='y')
ax.set_xlim(1999, 2025)
ax.set_ylim(0, 7500)

# Add legend
ax.legend(loc='upper left', framealpha=0.95, edgecolor='black', fontsize=10)

# Mark China's peak
china_peak_idx = data['China'].idxmax()
china_peak_year = data.loc[china_peak_idx, 'Year']
china_peak_value = data.loc[china_peak_idx, 'China']
ax.text(china_peak_year, 5500, f'China peak\n${china_peak_value:.0f}B',
       ha='center', fontsize=9, fontweight='bold', color='darkred')

# Add statistics box
latest = data.iloc[-1]
stats_text = (f'2024 Holdings (Top 5):\n'
             f'Japan: ${latest["Japan"]:.0f}B\n'
             f'China: ${latest["China"]:.0f}B\n'
             f'UK: ${latest["UK"]:.0f}B\n'
             f'Ireland: ${latest["Ireland"]:.0f}B\n'
             f'Lux: ${latest["Luxembourg"]:.0f}B')
props = dict(boxstyle='round', facecolor='lightblue', alpha=0.85, edgecolor='gray', linewidth=1)
ax.text(0.98, 0.60, stats_text, transform=ax.transAxes, fontsize=9,
       verticalalignment='top', horizontalalignment='right',
       bbox=props, family='monospace')

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: U.S. Treasury TIC (Treasury International Capital) data, Federal Reserve\n' +
           'Note: Holdings of marketable U.S. Treasury securities by foreign official and private investors.\n' +
           'China reduced holdings by 38% from peak ($1,269B in 2014) to $776B (2024). Japan remains top holder.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Adjust layout
plt.tight_layout(rect=[0, 0.05, 1, 1])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_7_3_treasury_holdings.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_7_3_treasury_holdings.pdf', bbox_inches='tight')

print("[OK] Figure 7.3 created successfully!")
print(f"  - PNG: {output_dir}/figure_7_3_treasury_holdings.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_7_3_treasury_holdings.pdf (vector)")
print(f"\nKey Findings:")
print(f"  • China peak: ${china_peak_value:.0f}B in {int(china_peak_year)}")
print(f"  • China 2024: ${latest['China']:.0f}B (down {((latest['China']/china_peak_value)-1)*100:.1f}%)")
print(f"  • Japan 2024: ${latest['Japan']:.0f}B (largest holder)")
print(f"  • UK 2024: ${latest['UK']:.0f}B (up from ${data.iloc[0]['UK']:.0f}B in 2000)")
print(f"  • Total foreign holdings 2024: ${data.iloc[-1][countries].sum():.0f}B")

plt.close()
