"""
Figure 9.1: Soviet Grain Imports by Source Country (1975-1985)
Shows how the Soviet Union became dependent on grain imports and
the impact of the 1980 U.S. grain embargo
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read data
df = pd.read_csv('../data/sources/soviet_grain_imports.csv')

# Create figure with two panels
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 10))

# Top panel: Stacked area chart showing sources
countries = ['USA', 'Canada', 'Argentina', 'Australia', 'EU', 'Others']
colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']

ax1.stackplot(df['Year'], df['USA'], df['Canada'], df['Argentina'],
              df['Australia'], df['EU'], df['Others'],
              labels=countries, colors=colors, alpha=0.8)

# Mark 1980 grain embargo
ax1.axvline(x=1980, color='black', linestyle='--', linewidth=2, alpha=0.7)
ax1.text(1980, 55, '1980: U.S. Grain Embargo\n(Afghanistan Invasion)',
         rotation=0, verticalalignment='top', horizontalalignment='center', fontsize=10,
         bbox=dict(boxstyle='round,pad=0.5', facecolor='yellow', alpha=0.7, edgecolor='black'))

ax1.set_xlabel('Year', fontsize=11)
ax1.set_ylabel('Grain Imports (million metric tons)', fontsize=11)
ax1.set_title('Soviet Grain Imports by Source Country (1975-1985)', fontsize=13, fontweight='bold', pad=15)
ax1.legend(loc='upper left', fontsize=10, ncol=2)
ax1.grid(True, alpha=0.2)
ax1.set_xlim(1975, 1985)

# Add statistics
stats_text = f"Total imports growth:\n1975: {df['Total'].iloc[0]:.1f}M tons\n"
stats_text += f"1985: {df['Total'].iloc[-1]:.1f}M tons\n"
stats_text += f"Increase: {int((df['Total'].iloc[-1] / df['Total'].iloc[0] - 1) * 100)}%"
ax1.text(0.98, 0.35, stats_text, transform=ax1.transAxes,
         fontsize=9, verticalalignment='bottom', horizontalalignment='right',
         bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.8))

# Bottom panel: U.S. share vs. non-U.S. sources
us_share = (df['USA'] / df['Total']) * 100
non_us_total = df['Total'] - df['USA']

ax2.plot(df['Year'], df['USA'], linewidth=3, marker='o', markersize=7,
         color='#1f77b4', label='U.S. Exports to USSR')
ax2.plot(df['Year'], non_us_total, linewidth=3, marker='s', markersize=7,
         color='#d62728', label='Non-U.S. Exports to USSR')

# Mark embargo
ax2.axvline(x=1980, color='black', linestyle='--', linewidth=2, alpha=0.7)

# Shade embargo period
ax2.axvspan(1980, 1981, alpha=0.2, color='red', label='Embargo Period')

ax2.set_xlabel('Year', fontsize=11)
ax2.set_ylabel('Grain Imports (million metric tons)', fontsize=11)
ax2.set_title('Impact of 1980 U.S. Grain Embargo on Soviet Imports', fontsize=13, fontweight='bold', pad=15)
ax2.legend(loc='upper left', fontsize=10)
ax2.grid(True, alpha=0.2)
ax2.set_xlim(1975, 1985)

# Add impact statistics
impact_text = "Embargo Impact:\n"
impact_text += f"U.S. share dropped: {us_share.iloc[4]:.1f}% → {us_share.iloc[5]:.1f}%\n"
impact_text += f"Others filled gap: {non_us_total.iloc[4]:.1f}M → {non_us_total.iloc[5]:.1f}M tons\n"
impact_text += "Lesson: Alternative suppliers available"
ax2.text(0.98, 0.55, impact_text, transform=ax2.transAxes,
         fontsize=9, verticalalignment='bottom', horizontalalignment='right',
         bbox=dict(boxstyle='round', facecolor='lightcoral', alpha=0.8))

plt.tight_layout()

# Save figure
plt.savefig('figure_9_1_soviet_grain.png', dpi=300, bbox_inches='tight')
plt.savefig('figure_9_1_soviet_grain.pdf', bbox_inches='tight')
print("Figure 9.1 saved successfully!")

plt.show()
