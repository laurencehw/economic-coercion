"""
Figure 6.1: U.S. Tariffs on Chinese Goods (2015-2024)
Shows the dramatic increase in U.S. tariffs on Chinese imports
during the trade war, maintained under both Trump and Biden.
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
data = pd.read_csv('../data/sources/us_china_tariffs.csv')

# Create figure
fig, ax = plt.subplots(figsize=(14, 8))

# Plot average tariff rate as bars
colors = ['#2ca02c' if year < 2018 else '#d62728' for year in data['Year']]
bars = ax.bar(data['Year'], data['Average_Tariff_Rate'],
              color=colors, alpha=0.7, edgecolor='black', linewidth=1,
              width=0.8)

# Add value labels on bars
for i, (year, rate) in enumerate(zip(data['Year'], data['Average_Tariff_Rate'])):
    ax.text(year, rate + 0.5, f'{rate:.1f}%',
           ha='center', va='bottom', fontsize=9, fontweight='bold')

# Mark key events
ax.axvline(x=2018, color='gray', linestyle=':', alpha=0.6, linewidth=1.5)
ax.text(2018, 22, 'Trade War\nBegins', ha='center', fontsize=9,
       fontweight='bold', bbox=dict(boxstyle='round,pad=0.3',
       facecolor='white', alpha=0.8, edgecolor='gray', linewidth=0.5))

ax.axvline(x=2021, color='gray', linestyle=':', alpha=0.6, linewidth=1.5)
ax.text(2021, 22, 'Biden\nContinues', ha='center', fontsize=9,
       fontweight='bold', bbox=dict(boxstyle='round,pad=0.3',
       facecolor='white', alpha=0.8, edgecolor='gray', linewidth=0.5))

# Customize the plot
ax.set_xlabel('Year', fontweight='bold', fontsize=12)
ax.set_ylabel('Average Tariff Rate (%)', fontweight='bold', fontsize=12)
ax.set_title('Figure 6.1: U.S. Tariffs on Chinese Goods (2015-2024)\n' +
            'The Trade War\'s Impact: A 6x Increase in Average Tariff Rates',
            fontweight='bold', fontsize=16, pad=20)

# Add grid
ax.grid(True, alpha=0.3, linestyle='--', linewidth=0.5, axis='y')
ax.set_xlim(2014.5, 2024.5)
ax.set_ylim(0, 25)

# Add statistics box
pre_trade_war = data[data['Year'] == 2017]['Average_Tariff_Rate'].values[0]
current = data[data['Year'] == 2024]['Average_Tariff_Rate'].values[0]
stats_text = (f'Pre-Trade War (2017):\n'
             f'{pre_trade_war:.1f}%\n\n'
             f'Current (2024):\n'
             f'{current:.1f}%\n\n'
             f'Increase: {((current/pre_trade_war)-1)*100:.0f}%\n\n'
             f'Goods affected:\n'
             f'${data.iloc[-1]["Total_Goods_Under_Tariffs_Billions"]:.0f}B')
props = dict(boxstyle='round', facecolor='lightblue', alpha=0.85, edgecolor='gray', linewidth=1)
ax.text(0.02, 0.97, stats_text, transform=ax.transAxes, fontsize=9,
       verticalalignment='top', bbox=props, family='monospace')

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: U.S. International Trade Commission (USITC), Peterson Institute for International Economics\n' +
           'Note: Average tariff rate on Chinese imports. Section 301 tariffs imposed 2018-2019 under Trump,\n' +
           'maintained and expanded under Biden. Does not include Chinese retaliatory tariffs on U.S. goods.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Adjust layout
plt.tight_layout(rect=[0, 0.05, 1, 1])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_6_1_us_china_tariffs.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_6_1_us_china_tariffs.pdf', bbox_inches='tight')

print("[OK] Figure 6.1 created successfully!")
print(f"  - PNG: {output_dir}/figure_6_1_us_china_tariffs.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_6_1_us_china_tariffs.pdf (vector)")
print(f"\nTariff Rate Changes:")
print(f"  • 2017 (Pre-trade war): {pre_trade_war:.1f}%")
print(f"  • 2024 (Current): {current:.1f}%")
print(f"  • Increase: {((current/pre_trade_war)-1)*100:.0f}%")
print(f"  • Value of goods affected: ${data.iloc[-1]['Total_Goods_Under_Tariffs_Billions']:.0f}B")

plt.close()
