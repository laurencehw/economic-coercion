"""
Figure 4.1: R&D Spending by Country (1990-2024)
Shows China's dramatic rise in R&D investment, approaching U.S. levels,
while other major economies show more modest growth.
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
data = pd.read_csv('../data/sources/rd_spending.csv')

# Create figure with main plot and inset
fig, ax = plt.subplots(figsize=(14, 9))

# Define colors
colors = {
    'USA': '#1f77b4',        # Blue
    'China': '#d62728',      # Red
    'EU': '#2ca02c',         # Green
    'Japan': '#ff7f0e',      # Orange
    'South_Korea': '#9467bd', # Purple
    'Rest_of_World': '#8c564b' # Brown
}

# Plot main lines
for country in ['USA', 'China', 'EU', 'Japan', 'South_Korea']:
    ax.plot(data['Year'], data[country],
           marker='o', linewidth=2.5, markersize=5,
           color=colors[country], label=country, alpha=0.9)

# Customize the plot
ax.set_xlabel('Year', fontweight='bold', fontsize=12)
ax.set_ylabel('R&D Spending (Billions USD, PPP)', fontweight='bold', fontsize=12)
ax.set_title('Figure 4.1: Global R&D Spending by Country (1990-2024)\n' +
             'China\'s Rapid Rise in Research & Development Investment',
             fontweight='bold', fontsize=16, pad=20)

# Add grid
ax.grid(True, alpha=0.3, linestyle='--', linewidth=0.5)
ax.set_xlim(1988, 2026)
ax.set_ylim(0, 900)

# Add annotations for key moments
# China surpassing EU
china_eu_cross = data[(data['China'] > data['EU'])].iloc[0]
ax.annotate('China surpasses\nEU in R&D',
           xy=(china_eu_cross['Year'], china_eu_cross['China']),
           xytext=(china_eu_cross['Year'] - 3, china_eu_cross['China'] + 100),
           arrowprops=dict(arrowstyle='->', color='darkred', lw=2),
           fontsize=10, fontweight='bold', color='darkred',
           bbox=dict(boxstyle='round,pad=0.5', facecolor='yellow', alpha=0.7, edgecolor='black'))

# Projected convergence
ax.annotate('Approaching\nU.S. levels',
           xy=(2024, data[data['Year']==2024]['China'].values[0]),
           xytext=(2020, 850),
           arrowprops=dict(arrowstyle='->', color='darkred', lw=2),
           fontsize=10, fontweight='bold', color='darkred',
           bbox=dict(boxstyle='round,pad=0.5', facecolor='yellow', alpha=0.7, edgecolor='black'))

# Add shaded region for China's acceleration
ax.axvspan(2000, 2024, alpha=0.1, color='red')
ax.text(2012, 50, 'China\'s R&D Acceleration', ha='center', fontsize=11,
       fontweight='bold', color='darkred', style='italic', alpha=0.7)

# Add legend
ax.legend(loc='upper left', framealpha=0.95, edgecolor='black', fontsize=11, ncol=2)

# Add statistics box
stats_text = ('Key Statistics (2024):\n'
             f'• USA: ${data.iloc[-1]["USA"]:.0f}B\n'
             f'• China: ${data.iloc[-1]["China"]:.0f}B\n'
             f'• EU: ${data.iloc[-1]["EU"]:.0f}B\n'
             f'• Japan: ${data.iloc[-1]["Japan"]:.0f}B\n'
             f'• S. Korea: ${data.iloc[-1]["South_Korea"]:.0f}B\n\n'
             f'China Growth 2000-2024:\n'
             f'{((data.iloc[-1]["China"]/data[data["Year"]==2000]["China"].values[0])-1)*100:.0f}% increase')
props = dict(boxstyle='round', facecolor='lightblue', alpha=0.85, edgecolor='black', linewidth=1.5)
ax.text(0.98, 0.55, stats_text, transform=ax.transAxes, fontsize=9,
       verticalalignment='top', horizontalalignment='right',
       bbox=props, family='monospace')

# Create inset showing China's share of global R&D
ax_inset = fig.add_axes([0.15, 0.60, 0.25, 0.25])  # [left, bottom, width, height]
data['Global_Total'] = data[['USA', 'China', 'EU', 'Japan', 'South_Korea', 'Rest_of_World']].sum(axis=1)
data['China_Share'] = (data['China'] / data['Global_Total']) * 100
data['USA_Share'] = (data['USA'] / data['Global_Total']) * 100

ax_inset.plot(data['Year'], data['China_Share'], color='#d62728', linewidth=2, marker='o', markersize=3, label='China')
ax_inset.plot(data['Year'], data['USA_Share'], color='#1f77b4', linewidth=2, marker='s', markersize=3, label='USA')
ax_inset.set_xlabel('Year', fontsize=9)
ax_inset.set_ylabel('Share of Global R&D (%)', fontsize=9)
ax_inset.set_title('Global Share', fontsize=10, fontweight='bold')
ax_inset.grid(True, alpha=0.3, linestyle='--', linewidth=0.3)
ax_inset.legend(fontsize=8, loc='upper left')
ax_inset.tick_params(labelsize=8)

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: OECD Main Science and Technology Indicators, NSF Science & Engineering Indicators, Chinese National Bureau of Statistics\n' +
           'Note: Values in purchasing power parity (PPP) billions USD. 2023-2024 are estimates based on current trends.\n' +
           'R&D spending includes government, higher education, business enterprise, and private non-profit sectors.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Adjust layout
plt.tight_layout(rect=[0, 0.06, 1, 1])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_4_1_rd_spending.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_4_1_rd_spending.pdf', bbox_inches='tight')

print("[OK] Figure 4.1 created successfully!")
print(f"  - PNG: {output_dir}/figure_4_1_rd_spending.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_4_1_rd_spending.pdf (vector)")
print(f"\nR&D Spending Comparison:")
print(f"  1990: USA ${data.iloc[0]['USA']:.0f}B, China ${data.iloc[0]['China']:.0f}B")
print(f"  2024: USA ${data.iloc[-1]['USA']:.0f}B, China ${data.iloc[-1]['China']:.0f}B")
print(f"  China growth: {((data.iloc[-1]['China']/data.iloc[0]['China'])-1)*100:.0f}%")
print(f"  USA growth: {((data.iloc[-1]['USA']/data.iloc[0]['USA'])-1)*100:.0f}%")
print(f"\nGlobal share 2024: USA {data.iloc[-1]['USA_Share']:.1f}%, China {data.iloc[-1]['China_Share']:.1f}%")

plt.close()
