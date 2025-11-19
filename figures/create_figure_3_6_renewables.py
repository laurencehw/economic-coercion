"""
Figure 3.6: Renewable Energy Manufacturing - China's Dominance
Shows China's overwhelming share of global clean energy technology
production across multiple critical technologies.
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
data = pd.read_csv('../data/sources/renewable_energy_manufacturing.csv')

# Create figure
fig, ax = plt.subplots(figsize=(14, 8))

# Prepare data for stacked horizontal bars
technologies = data['Technology'].values
regions = ['China', 'Europe', 'USA', 'Rest_of_Asia', 'Others']
colors = {
    'China': '#d62728',        # Red
    'Europe': '#1f77b4',       # Blue
    'USA': '#2ca02c',          # Green
    'Rest_of_Asia': '#ff7f0e', # Orange
    'Others': '#7f7f7f'        # Gray
}

# Create horizontal stacked bars
y_pos = np.arange(len(technologies))
left = np.zeros(len(technologies))

for region in regions:
    values = data[region].values
    bars = ax.barh(y_pos, values, left=left,
                   label=region, color=colors[region],
                   alpha=0.85, edgecolor='black', linewidth=0.5)

    # Add percentage labels for significant values (>10%)
    for i, (value, l) in enumerate(zip(values, left)):
        if value >= 10:
            ax.text(l + value/2, i, f'{int(value)}%',
                   ha='center', va='center', color='white',
                   fontweight='bold', fontsize=9)

    left += values

# Customize the plot
ax.set_yticks(y_pos)
# Clean up technology labels
tech_labels = [t.replace('_', ' ') for t in technologies]
ax.set_yticklabels(tech_labels, fontsize=11)
ax.set_xlabel('Global Manufacturing Share (%)', fontweight='bold', fontsize=12)
ax.set_title('Figure 3.6: Renewable Energy Manufacturing - China\'s Dominance (2023-2024)\n' +
            'Global Market Share of Clean Energy Technology Production',
            fontweight='bold', fontsize=16, pad=20)

# Add grid
ax.grid(True, alpha=0.3, linestyle='--', linewidth=0.5, axis='x')
ax.set_xlim(0, 105)

# Add legend
ax.legend(loc='lower right', framealpha=0.95, edgecolor='black', fontsize=10)

# Add statistics box
avg_china = data['China'].mean()
stats_text = (f'China\'s Average Share:\n'
             f'{avg_china:.0f}% across 7 technologies\n\n'
             f'Highest:\n'
             f'Rare Earth Magnets: {data[data["Technology"]=="Rare_Earth_Magnets"]["China"].values[0]}%\n'
             f'Solar Panels: {data[data["Technology"]=="Solar_Panels"]["China"].values[0]}%')
props = dict(boxstyle='round', facecolor='lightyellow', alpha=0.85, edgecolor='gray', linewidth=1)
ax.text(0.02, 0.97, stats_text, transform=ax.transAxes, fontsize=9,
       verticalalignment='top', bbox=props, family='monospace')

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: International Energy Agency (IEA), BloombergNEF, industry reports\n' +
           'Note: Market share based on manufacturing capacity and production volume (2023-2024).\n' +
           'China\'s dominance in clean energy supply chains creates strategic dependencies for global energy transition.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Adjust layout
plt.tight_layout(rect=[0, 0.05, 1, 1])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_3_6_renewable_manufacturing.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_3_6_renewable_manufacturing.pdf', bbox_inches='tight')

print("[OK] Figure 3.6 created successfully!")
print(f"  - PNG: {output_dir}/figure_3_6_renewable_manufacturing.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_3_6_renewable_manufacturing.pdf (vector)")
print(f"\nChina's Manufacturing Dominance:")
for _, row in data.iterrows():
    tech = row['Technology'].replace('_', ' ')
    print(f"  • {tech}: {row['China']}%")
print(f"\nAverage China share: {avg_china:.0f}%")

plt.close()
