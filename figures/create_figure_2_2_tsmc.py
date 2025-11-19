"""
Figure 2.2: TSMC's Dominance in Advanced Chip Manufacturing
Creates a stacked bar chart showing market share by technology node,
demonstrating TSMC's commanding position at cutting-edge nodes.
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Set style for publication-quality figures
plt.style.use('seaborn-v0_8-darkgrid')
plt.rcParams['font.family'] = 'sans-serif'
plt.rcParams['font.sans-serif'] = ['Arial', 'DejaVu Sans']
plt.rcParams['font.size'] = 11
plt.rcParams['figure.figsize'] = (14, 8)

# Load data
data = pd.read_csv('../data/sources/tsmc_market_share.csv')

# Define colorblind-friendly colors
colors = {
    'TSMC': '#d62728',      # Red
    'Samsung': '#ff7f0e',   # Orange
    'Intel': '#2ca02c',     # Green
    'SMIC': '#9467bd',      # Purple
    'Others': '#8c564b'     # Brown
}

# Create figure
fig, ax = plt.subplots(figsize=(14, 8))

# Get companies (excluding Technology_Node column)
companies = [col for col in data.columns if col != 'Technology_Node']
x = np.arange(len(data))
width = 0.6

# Create stacked bars
bottom = np.zeros(len(data))
bars = []

for company in companies:
    bars.append(ax.bar(x, data[company], width, bottom=bottom,
                       label=company, color=colors[company], alpha=0.9))
    bottom += data[company]

# Customize the plot
ax.set_ylabel('Market Share (%)', fontweight='bold', fontsize=12)
ax.set_xlabel('Technology Node', fontweight='bold', fontsize=12)
ax.set_title('Figure 2.2: TSMC\'s Dominance in Advanced Chip Manufacturing\n' +
             'Global Foundry Market Share by Technology Node (2023-2024)',
             fontweight='bold', fontsize=16, pad=20)

# Set x-axis labels
ax.set_xticks(x)
ax.set_xticklabels(data['Technology_Node'], rotation=0, ha='center')

# Add value labels on bars (only for significant shares > 8%)
for i, node in enumerate(data['Technology_Node']):
    cumsum = 0
    for company in companies:
        value = data.loc[i, company]
        if value >= 8:  # Only label if >= 8%
            label_y = cumsum + value/2
            ax.text(i, label_y, f'{int(value)}%',
                   ha='center', va='center', color='white',
                   fontweight='bold', fontsize=9)
        cumsum += value

# Add grid for easier reading
ax.grid(axis='y', alpha=0.3, linestyle='--', linewidth=0.5)
ax.set_axisbelow(True)

# Set y-axis limits
ax.set_ylim(0, 105)

# Add legend
ax.legend(loc='upper left', framealpha=0.95, edgecolor='black',
         title='Manufacturer', title_fontsize=11)

# Add annotations highlighting TSMC's dominance
ax.annotate('TSMC monopoly\nat cutting edge',
           xy=(0, 100), xytext=(0.5, 115),
           arrowprops=dict(arrowstyle='->', color='red', lw=2),
           fontsize=11, fontweight='bold', color='red',
           ha='center', bbox=dict(boxstyle='round,pad=0.5', facecolor='yellow', alpha=0.7))

ax.annotate('Competition emerges\nat mature nodes',
           xy=(5, 70), xytext=(4.5, 120),
           arrowprops=dict(arrowstyle='->', color='darkblue', lw=1.5),
           fontsize=10, fontweight='bold', color='darkblue',
           ha='center', bbox=dict(boxstyle='round,pad=0.5', facecolor='lightblue', alpha=0.7))

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: TechInsights, Semiconductor Industry Association, Gartner (2023-2024)\n' +
           'Note: Market share based on foundry revenue. Intel data represents foundry services only.\n' +
           'Smaller nodes (3nm, 5nm) represent more advanced technology.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Add strategic importance text box
textstr = ('Strategic Implications:\n'
          '• 3nm/5nm: AI chips, flagship smartphones\n'
          '• 7nm/10nm: High-performance computing\n'
          '• 14nm+: Military, automotive, IoT\n'
          '• TSMC concentration = critical vulnerability')
props = dict(boxstyle='round', facecolor='wheat', alpha=0.85, edgecolor='black', linewidth=1.5)
ax.text(0.98, 0.58, textstr, transform=ax.transAxes, fontsize=9,
        verticalalignment='top', horizontalalignment='right', bbox=props)

# Adjust layout
plt.tight_layout(rect=[0, 0.05, 1, 0.95])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_2_2_tsmc_dominance.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_2_2_tsmc_dominance.pdf', bbox_inches='tight')

print("[OK] Figure 2.2 created successfully!")
print(f"  - PNG: {output_dir}/figure_2_2_tsmc_dominance.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_2_2_tsmc_dominance.pdf (vector)")
print(f"\nTSMC market share by node:")
for _, row in data.iterrows():
    print(f"  • {row['Technology_Node']}: TSMC {row['TSMC']}%, Samsung {row['Samsung']}%, Intel {row['Intel']}%")

plt.close()
