"""
Figure 6.3: U.S. Entity List Additions Over Time (2015-2024)
Shows the acceleration of Chinese entities added to the U.S. Commerce
Department's Entity List, restricting access to American technology.
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
data = pd.read_csv('../data/sources/entity_list_additions.csv')

# Create figure with two panels
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 7))

# ===== LEFT PANEL: Stacked Area Chart by Category =====
categories = ['Semiconductors', 'Surveillance', 'Aerospace_Defense',
              'Universities_Research', 'AI_Computing', 'Other']
labels = ['Semiconductors', 'Surveillance', 'Aerospace/Defense',
         'Universities/Research', 'AI/Computing', 'Other']
colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']

ax1.stackplot(data['Year'],
             [data[cat] for cat in categories],
             labels=labels,
             colors=colors,
             alpha=0.8)

ax1.set_xlabel('Year', fontweight='bold', fontsize=12)
ax1.set_ylabel('Number of Chinese Entities Added', fontweight='bold', fontsize=12)
ax1.set_title('Cumulative Additions by Sector',
             fontweight='bold', fontsize=13, pad=15)
ax1.grid(True, alpha=0.3, linestyle='--', linewidth=0.5, axis='y')
ax1.set_xlim(2014.5, 2024.5)
ax1.legend(loc='upper left', framealpha=0.95, edgecolor='black', fontsize=9)

# ===== RIGHT PANEL: Total Additions per Year =====
bars = ax2.bar(data['Year'], data['Total'],
              color='#d62728', alpha=0.7, edgecolor='black', linewidth=1,
              width=0.7)

# Add value labels
for year, total in zip(data['Year'], data['Total']):
    if total > 50:  # Only label significant values
        ax2.text(year, total + 5, f'{total}',
               ha='center', va='bottom', fontsize=9, fontweight='bold')

ax2.set_xlabel('Year', fontweight='bold', fontsize=12)
ax2.set_ylabel('Total Entities Added', fontweight='bold', fontsize=12)
ax2.set_title('Annual Additions to Entity List',
             fontweight='bold', fontsize=13, pad=15)
ax2.grid(True, alpha=0.3, linestyle='--', linewidth=0.5, axis='y')
ax2.set_xlim(2014.5, 2024.5)

# Mark Huawei ban
ax2.axvline(x=2019, color='gray', linestyle=':', alpha=0.6, linewidth=1.5)
ax2.text(2019, 260, 'Huawei\nBan', ha='center', fontsize=8,
        bbox=dict(boxstyle='round,pad=0.2', facecolor='white',
        alpha=0.8, edgecolor='gray', linewidth=0.5))

# Add main title
fig.suptitle('Figure 6.3: U.S. Entity List Additions - Chinese Entities (2015-2024)\n' +
            'Escalating Technology Export Controls',
            fontweight='bold', fontsize=16, y=0.98)

# Add statistics box
latest = data.iloc[-1]
stats_text = (f'2024 Breakdown:\n'
             f'Semiconductors: {latest["Semiconductors"]}\n'
             f'AI/Computing: {latest["AI_Computing"]}\n'
             f'Surveillance: {latest["Surveillance"]}\n'
             f'Aerospace: {latest["Aerospace_Defense"]}\n\n'
             f'Total 2015-2024:\n'
             f'{data["Total"].sum():,} entities')
props = dict(boxstyle='round', facecolor='lightyellow', alpha=0.85, edgecolor='gray', linewidth=1)
ax1.text(0.98, 0.40, stats_text, transform=ax1.transAxes, fontsize=9,
        verticalalignment='top', horizontalalignment='right',
        bbox=props, family='monospace')

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: U.S. Bureau of Industry and Security (BIS), Federal Register\n' +
           'Note: Chinese entities added to Entity List, requiring licenses for U.S. technology exports.\n' +
           'Includes companies, universities, and research institutions. Dramatic acceleration post-2018.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Adjust layout
plt.tight_layout(rect=[0, 0.05, 1, 0.94])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_6_3_entity_list_additions.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_6_3_entity_list_additions.pdf', bbox_inches='tight')

print("[OK] Figure 6.3 created successfully!")
print(f"  - PNG: {output_dir}/figure_6_3_entity_list_additions.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_6_3_entity_list_additions.pdf (vector)")
print(f"\nEntity List Growth:")
print(f"  • 2015: {data.iloc[0]['Total']} entities")
print(f"  • 2024: {data.iloc[-1]['Total']} entities")
print(f"  • Total 2015-2024: {data['Total'].sum():,} entities added")
print(f"  • Top category 2024: Semiconductors ({latest['Semiconductors']} entities)")

plt.close()
