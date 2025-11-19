"""
Figure 7.4: Russian Foreign Reserves - Frozen Assets 2022
Shows the breakdown of ~$370B in Russian assets frozen following
the February 2022 invasion of Ukraine.
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
data = pd.read_csv('../data/sources/russian_frozen_assets_2022.csv')

# Create figure with two panels
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 7))

# ===== LEFT PANEL: By Category =====
category_totals = data.groupby('Category')['Amount_Billions_USD'].sum().sort_values(ascending=False)

colors_cat = ['#d62728', '#ff7f0e', '#2ca02c']
bars1 = ax1.barh(range(len(category_totals)), category_totals.values,
                 color=colors_cat, alpha=0.8, edgecolor='black', linewidth=1)

ax1.set_yticks(range(len(category_totals)))
ax1.set_yticklabels(['Foreign Reserves', 'Oligarch Assets', 'State Assets'], fontsize=11)
ax1.set_xlabel('Amount Frozen (Billions USD)', fontweight='bold', fontsize=12)
ax1.set_title('Assets Frozen by Category', fontweight='bold', fontsize=13, pad=15)
ax1.grid(True, alpha=0.3, linestyle='--', linewidth=0.5, axis='x')

# Add value labels
for i, (cat, value) in enumerate(category_totals.items()):
    ax1.text(value + 5, i, f'${value:.1f}B', va='center', fontsize=10, fontweight='bold')

# ===== RIGHT PANEL: Foreign Reserves by Location =====
reserves_data = data[data['Category'] == 'Foreign_Reserves'].sort_values('Amount_Billions_USD', ascending=True)

colors_loc = ['#1f77b4'] * len(reserves_data)
bars2 = ax2.barh(range(len(reserves_data)), reserves_data['Amount_Billions_USD'].values,
                 color=colors_loc, alpha=0.8, edgecolor='black', linewidth=1)

# Clean up location labels
location_labels = [loc.replace('_', ' ') for loc in reserves_data['Location'].values]
ax2.set_yticks(range(len(reserves_data)))
ax2.set_yticklabels(location_labels, fontsize=10)
ax2.set_xlabel('Amount Frozen (Billions USD)', fontweight='bold', fontsize=12)
ax2.set_title('Foreign Reserves by Location', fontweight='bold', fontsize=13, pad=15)
ax2.grid(True, alpha=0.3, linestyle='--', linewidth=0.5, axis='x')

# Add value labels
for i, value in enumerate(reserves_data['Amount_Billions_USD'].values):
    ax2.text(value + 3, i, f'${value:.1f}B', va='center', fontsize=9, fontweight='bold')

# Add main title
fig.suptitle('Figure 7.4: Russian Assets Frozen by Western Sanctions (2022)\n' +
            'Unprecedented Financial Coercion Following Ukraine Invasion',
            fontweight='bold', fontsize=16, y=0.98)

# Add statistics box
total_frozen = data['Amount_Billions_USD'].sum()
reserves_total = category_totals['Foreign_Reserves']
stats_text = (f'Total Frozen: ${total_frozen:.1f}B\n\n'
             f'Foreign Reserves: ${reserves_total:.1f}B\n'
             f'(~55% of Russia\'s $630B total)\n\n'
             f'Largest holder:\n'
             f'Eurozone: ${reserves_data.iloc[-1]["Amount_Billions_USD"]:.1f}B')
props = dict(boxstyle='round', facecolor='lightyellow', alpha=0.85, edgecolor='gray', linewidth=1)
ax1.text(0.98, 0.97, stats_text, transform=ax1.transAxes, fontsize=9,
        verticalalignment='top', horizontalalignment='right',
        bbox=props, family='monospace')

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: European Commission, U.S. Treasury, Bank of Russia, IMF, CSIS estimates\n' +
           'Note: Assets frozen following Russian invasion of Ukraine (Feb 24, 2022). Includes central bank reserves,\n' +
           'assets of sanctioned oligarchs, and state-owned entities. Data as of Q4 2022.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Adjust layout
plt.tight_layout(rect=[0, 0.05, 1, 0.94])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_7_4_russian_frozen_assets.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_7_4_russian_frozen_assets.pdf', bbox_inches='tight')

print("[OK] Figure 7.4 created successfully!")
print(f"  - PNG: {output_dir}/figure_7_4_russian_frozen_assets.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_7_4_russian_frozen_assets.pdf (vector)")
print(f"\nKey Statistics:")
print(f"  • Total assets frozen: ${total_frozen:.1f}B")
print(f"  • Foreign reserves frozen: ${reserves_total:.1f}B (~55% of Russia's $630B total)")
print(f"  • Oligarch assets frozen: ${category_totals['Oligarch_Assets']:.1f}B")
print(f"  • Largest location: Eurozone (${reserves_data.iloc[-1]['Amount_Billions_USD']:.1f}B)")
print(f"  • Number of jurisdictions: {len(reserves_data)}")

plt.close()
