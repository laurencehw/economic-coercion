"""
Figure 7.2: U.S. Sanctions Programs Over Time (1990-2024)
Shows the growth in U.S. sanctions programs and designated entities
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read data
df = pd.read_csv('../data/sources/us_sanctions_programs.csv')

# Create figure with two subplots
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 10))

# Top panel: Programs by type (stacked area)
ax1.fill_between(df['Year'], 0, df['Country_Based'],
                  alpha=0.7, label='Country-Based Programs', color='#d62728')
ax1.fill_between(df['Year'], df['Country_Based'], df['Total_Programs'],
                  alpha=0.7, label='Thematic Programs', color='#ff7f0e')

# Key events
events = [
    (2001, 'Post-9/11'),
    (2014, 'Crimea Annexation'),
    (2022, 'Ukraine Invasion')
]

for year, label in events:
    ax1.axvline(x=year, color='gray', linestyle='--', linewidth=1, alpha=0.5)
    ax1.text(year, ax1.get_ylim()[1] * 0.95, label,
             rotation=0, verticalalignment='top', fontsize=9,
             bbox=dict(boxstyle='round,pad=0.3', facecolor='white', alpha=0.8, edgecolor='gray'))

ax1.set_xlabel('Year', fontsize=11)
ax1.set_ylabel('Number of Active Sanctions Programs', fontsize=11)
ax1.set_title('U.S. Sanctions Programs Over Time (1990-2024)', fontsize=13, fontweight='bold', pad=15)
ax1.legend(loc='upper left', fontsize=10)
ax1.grid(True, alpha=0.2)
ax1.set_xlim(1990, 2024)

# Add statistics box
stats_text = f"Growth: {df['Total_Programs'].iloc[0]} → {df['Total_Programs'].iloc[-1]} programs\n"
stats_text += f"Increase: {int((df['Total_Programs'].iloc[-1] / df['Total_Programs'].iloc[0] - 1) * 100)}% since 1990"
ax1.text(0.98, 0.05, stats_text, transform=ax1.transAxes,
         fontsize=9, verticalalignment='bottom', horizontalalignment='right',
         bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.7))

# Bottom panel: Designated entities and individuals
ax2.plot(df['Year'], df['Entities_Individuals'] / 1000,
         linewidth=3, marker='o', markersize=6, color='#2ca02c', label='Designated Entities & Individuals')

# Fill area under curve
ax2.fill_between(df['Year'], 0, df['Entities_Individuals'] / 1000, alpha=0.3, color='#2ca02c')

# Key events
for year, label in events:
    ax2.axvline(x=year, color='gray', linestyle='--', linewidth=1, alpha=0.5)

ax2.set_xlabel('Year', fontsize=11)
ax2.set_ylabel('Designated Entities & Individuals (thousands)', fontsize=11)
ax2.set_title('Growth in Sanctioned Entities and Individuals', fontsize=13, fontweight='bold', pad=15)
ax2.grid(True, alpha=0.2)
ax2.set_xlim(1990, 2024)
ax2.legend(loc='upper left', fontsize=10)

# Add statistics box
stats_text2 = f"2024: ~{df['Entities_Individuals'].iloc[-1]:,} designated\n"
stats_text2 += f"Growth: {int((df['Entities_Individuals'].iloc[-1] / df['Entities_Individuals'].iloc[0] - 1) * 100)}% since 1990\n"
stats_text2 += f"Post-Ukraine: +{df['Entities_Individuals'].iloc[-1] - df['Entities_Individuals'].iloc[-4]:,} (2022-2024)"
ax2.text(0.98, 0.05, stats_text2, transform=ax2.transAxes,
         fontsize=9, verticalalignment='bottom', horizontalalignment='right',
         bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.7))

plt.tight_layout()

# Save figure
plt.savefig('figure_7_2_sanctions_programs.png', dpi=300, bbox_inches='tight')
plt.savefig('figure_7_2_sanctions_programs.pdf', bbox_inches='tight')
print("Figure 7.2 saved successfully!")

plt.show()
