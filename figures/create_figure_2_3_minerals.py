"""
Figure 2.3: Critical Mineral Processing - China's Dominance
Creates a horizontal bar chart showing China's share of global processing capacity
for strategic minerals critical to clean energy transition and technology manufacturing.
"""

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

# Set style for publication-quality figures
plt.style.use('seaborn-v0_8-darkgrid')
plt.rcParams['font.family'] = 'sans-serif'
plt.rcParams['font.sans-serif'] = ['Arial', 'DejaVu Sans']
plt.rcParams['font.size'] = 11
plt.rcParams['axes.labelsize'] = 12
plt.rcParams['axes.titlesize'] = 14
plt.rcParams['xtick.labelsize'] = 10
plt.rcParams['ytick.labelsize'] = 10
plt.rcParams['legend.fontsize'] = 10
plt.rcParams['figure.titlesize'] = 16

# Load data
data = pd.read_csv('../data/sources/critical_minerals_data.csv')

# Sort by processing share
data = data.sort_values('China_Processing_Share', ascending=True)

# Create figure
fig, ax = plt.subplots(figsize=(12, 8))

# Define colors - using colorblind-friendly palette
china_color = '#d62728'  # Red for China
rest_color = '#7f7f7f'  # Gray for rest of world

# Create horizontal bars
y_pos = np.arange(len(data))
china_bars = ax.barh(y_pos, data['China_Processing_Share'] * 100,
                     color=china_color, alpha=0.8, label='China')
rest_bars = ax.barh(y_pos, (1 - data['China_Processing_Share']) * 100,
                    left=data['China_Processing_Share'] * 100,
                    color=rest_color, alpha=0.5, label='Rest of World')

# Customize the plot
ax.set_yticks(y_pos)
ax.set_yticklabels(data['Mineral'])
ax.set_xlabel('Share of Global Processing Capacity (%)', fontweight='bold')
ax.set_title('Figure 2.3: China\'s Dominance in Critical Mineral Processing\n' +
             'Global Market Share by Mineral (2023-2024)',
             fontweight='bold', pad=20)

# Add percentage labels on the bars
for i, (idx, row) in enumerate(data.iterrows()):
    china_pct = row['China_Processing_Share'] * 100
    # Only show China percentage if > 10%
    if china_pct >= 10:
        ax.text(china_pct/2, i, f'{china_pct:.0f}%',
               ha='center', va='center', color='white', fontweight='bold', fontsize=10)

# Add grid for easier reading
ax.grid(axis='x', alpha=0.3, linestyle='--', linewidth=0.5)
ax.set_axisbelow(True)

# Set x-axis limits
ax.set_xlim(0, 100)

# Add legend
ax.legend(loc='lower right', framealpha=0.9, edgecolor='black')

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: USGS Mineral Commodity Summaries 2024, IEA Critical Minerals Report 2023\n' +
           'Note: Processing share includes refining, smelting, and manufacturing of value-added products',
           ha='right', va='bottom', fontsize=8, style='italic', wrap=True)

# Add a text box with key insights
textstr = 'Key Strategic Minerals:\n• Rare Earths: EV motors, wind turbines\n• Lithium/Cobalt: EV batteries\n• Gallium/Germanium: Semiconductors'
props = dict(boxstyle='round', facecolor='wheat', alpha=0.8, edgecolor='black')
ax.text(0.02, 0.98, textstr, transform=ax.transAxes, fontsize=9,
        verticalalignment='top', bbox=props)

# Adjust layout to prevent label cutoff
plt.tight_layout(rect=[0, 0.03, 1, 1])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_2_3_critical_minerals.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_2_3_critical_minerals.pdf', bbox_inches='tight')

print("[OK] Figure 2.3 created successfully!")
print(f"  - PNG: {output_dir}/figure_2_3_critical_minerals.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_2_3_critical_minerals.pdf (vector)")
print(f"\nShowing minerals with China's processing share:")
for _, row in data.sort_values('China_Processing_Share', ascending=False).iterrows():
    print(f"  • {row['Mineral']}: {row['China_Processing_Share']*100:.0f}% processing, {row['China_Mining_Share']*100:.0f}% mining")

# Display the plot
# plt.show()  # Comment out for batch processing
plt.close()
