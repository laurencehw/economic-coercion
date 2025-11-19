"""
Figure 8.2: Chinese FDI in U.S. and Europe (2008-2024)
Shows the dramatic rise and fall of Chinese foreign direct investment
in the U.S. and Europe, reflecting increased scrutiny and restrictions.
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
data = pd.read_csv('../data/sources/chinese_fdi_flows.csv')

# Create figure
fig, ax = plt.subplots(figsize=(14, 8))

# Plot both regions
ax.plot(data['Year'], data['US_Billions'],
       marker='o', linewidth=3, markersize=6,
       color='#1f77b4', label='United States', alpha=0.9)
ax.plot(data['Year'], data['Europe_Billions'],
       marker='s', linewidth=3, markersize=6,
       color='#2ca02c', label='Europe', alpha=0.9)

# Customize the plot
ax.set_xlabel('Year', fontweight='bold', fontsize=12)
ax.set_ylabel('Chinese FDI Flows (Billions USD)', fontweight='bold', fontsize=12)
ax.set_title('Figure 8.2: Chinese Foreign Direct Investment in U.S. and Europe (2008-2024)\n' +
            'The Rise, Peak, and Collapse of Chinese Investment Flows',
            fontweight='bold', fontsize=16, pad=20)

# Add grid
ax.grid(True, alpha=0.3, linestyle='--', linewidth=0.5)
ax.set_xlim(2007, 2025)
ax.set_ylim(0, 50)

# Add legend
ax.legend(loc='upper left', framealpha=0.95, edgecolor='black', fontsize=12)

# Mark key events
events = [
    (2016, 'U.S. Peak\n$45.6B', 47),
    (2018, 'CFIUS\nReform', 35),
]

for year, label, ypos in events:
    ax.axvline(x=year, color='gray', linestyle=':', alpha=0.5, linewidth=1.2)
    ax.text(year, ypos, label, ha='center', fontsize=9,
           fontweight='bold', bbox=dict(boxstyle='round,pad=0.3',
           facecolor='white', alpha=0.8, edgecolor='gray', linewidth=0.5))

# Add statistics box
us_peak = data['US_Billions'].max()
us_peak_year = data[data['US_Billions'] == us_peak]['Year'].values[0]
eu_peak = data['Europe_Billions'].max()
eu_peak_year = data[data['Europe_Billions'] == eu_peak]['Year'].values[0]

stats_text = (f'U.S. Investment:\n'
             f'Peak: ${us_peak:.1f}B ({int(us_peak_year)})\n'
             f'2024: ${data.iloc[-1]["US_Billions"]:.1f}B\n'
             f'Decline: {((data.iloc[-1]["US_Billions"]/us_peak)-1)*100:.0f}%\n\n'
             f'Europe Investment:\n'
             f'Peak: ${eu_peak:.1f}B ({int(eu_peak_year)})\n'
             f'2024: ${data.iloc[-1]["Europe_Billions"]:.1f}B\n'
             f'Decline: {((data.iloc[-1]["Europe_Billions"]/eu_peak)-1)*100:.0f}%')
props = dict(boxstyle='round', facecolor='lightblue', alpha=0.85, edgecolor='gray', linewidth=1)
ax.text(0.98, 0.97, stats_text, transform=ax.transAxes, fontsize=9,
       verticalalignment='top', horizontalalignment='right',
       bbox=props, family='monospace')

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: Rhodium Group, American Enterprise Institute China Investment Tracker, Eurostat\n' +
           'Note: Annual Chinese foreign direct investment flows (not cumulative stock). Includes M&A and greenfield.\n' +
           'Decline driven by CFIUS expansion (2018), national security reviews, COVID-19, and geopolitical tensions.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Adjust layout
plt.tight_layout(rect=[0, 0.05, 1, 1])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_8_2_chinese_fdi.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_8_2_chinese_fdi.pdf', bbox_inches='tight')

print("[OK] Figure 8.2 created successfully!")
print(f"  - PNG: {output_dir}/figure_8_2_chinese_fdi.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_8_2_chinese_fdi.pdf (vector)")
print(f"\nChinese FDI Trends:")
print(f"  • U.S. peak: ${us_peak:.1f}B in {int(us_peak_year)}")
print(f"  • U.S. 2024: ${data.iloc[-1]['US_Billions']:.1f}B (down {abs(((data.iloc[-1]['US_Billions']/us_peak)-1)*100):.0f}%)")
print(f"  • Europe peak: ${eu_peak:.1f}B in {int(eu_peak_year)}")
print(f"  • Europe 2024: ${data.iloc[-1]['Europe_Billions']:.1f}B (down {abs(((data.iloc[-1]['Europe_Billions']/eu_peak)-1)*100):.0f}%)")

plt.close()
