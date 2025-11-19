"""
Figure 1.4: Timeline of Major Economic Coercion Events (1948-2024)
Visual timeline showing the evolution of economic coercion tools and targets
"""

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch
import numpy as np

# Read data
df = pd.read_csv('../data/sources/economic_coercion_timeline.csv')

# Create figure
fig, ax = plt.subplots(figsize=(16, 12))

# Define category colors
category_colors = {
    'Trade/Infrastructure': '#1f77b4',
    'Trade Sanctions': '#ff7f0e',
    'Energy': '#2ca02c',
    'Comprehensive': '#d62728',
    'Extraterritorial': '#9467bd',
    'Financial': '#8c564b',
    'Financial/Trade': '#e377c2',
    'Sectoral': '#7f7f7f',
    'Tariffs': '#bcbd22',
    'Investment Screening': '#17becf',
    'Technology': '#ff9896',
    'Financial/Oil': '#c5b0d5',
    'Strategic Resources': '#c49c94',
    'Investment': '#f7b6d2'
}

# Set up timeline
start_year = 1945
end_year = 2025
ax.set_xlim(start_year, end_year)
ax.set_ylim(-1, len(df) + 2)

# Draw main timeline axis
ax.plot([start_year, end_year], [0, 0], 'k-', linewidth=3, alpha=0.5)

# Title
ax.text((start_year + end_year) / 2, len(df) + 1.5,
        'Timeline of Major Economic Coercion Events (1948-2024)',
        ha='center', va='center', fontsize=16, fontweight='bold')

# Add decade markers
for year in range(1950, 2030, 10):
    ax.plot([year, year], [-0.3, 0.3], 'k-', linewidth=2, alpha=0.4)
    ax.text(year, -0.7, str(year), ha='center', fontsize=10, fontweight='bold')

# Plot events
y_position = 1
alternate = 1  # Alternate above and below timeline

for idx, row in df.iterrows():
    year = row['Year']
    event = row['Event']
    category = row['Category']
    description = row['Description']
    color = category_colors.get(category, '#cccccc')

    # Alternate positions above and below
    y_pos = y_position * alternate
    alternate *= -1

    # Draw connecting line
    ax.plot([year, year], [0, y_pos], 'k-', linewidth=1, alpha=0.3, linestyle='--')

    # Draw event marker
    ax.plot(year, 0, 'o', color=color, markersize=12, markeredgecolor='black',
            markeredgewidth=1.5, zorder=5)

    # Create text box
    box_width = 8
    box_x = year - box_width / 2

    # Adjust for edges
    if box_x < start_year:
        box_x = start_year + 0.5
    elif box_x + box_width > end_year:
        box_x = end_year - box_width - 0.5

    # Event box
    event_box = FancyBboxPatch((box_x, y_pos - 0.3), box_width, 0.6,
                               boxstyle="round,pad=0.05", linewidth=1.5,
                               edgecolor=color, facecolor=color, alpha=0.3)
    ax.add_patch(event_box)

    # Event text
    ax.text(box_x + box_width / 2, y_pos, f'{year}: {event}',
            ha='center', va='center', fontsize=8, fontweight='bold', wrap=True)

    # Description (smaller, below event)
    ax.text(box_x + box_width / 2, y_pos - 0.5 if y_pos > 0 else y_pos + 0.5,
            description[:60] + ('...' if len(description) > 60 else ''),
            ha='center', va='center', fontsize=6, style='italic', wrap=True)

    # Category label
    ax.text(year + 0.3, 0.2 if y_pos > 0 else -0.2, category,
            ha='left', va='center', fontsize=6, color=color, fontweight='bold',
            rotation=45 if y_pos > 0 else -45)

    y_position += 1.5

# Add era labels
eras = [
    (1948, 1990, 'Cold War Era', '#e8f4f8'),
    (1990, 2001, 'Post-Cold War', '#f0f8e8'),
    (2001, 2014, 'War on Terror', '#fff4e6'),
    (2014, 2025, 'Great Power Competition', '#ffe6e6')
]

for start, end, label, color in eras:
    ax.axvspan(start, end, alpha=0.15, color=color, zorder=0)
    ax.text((start + end) / 2, -len(df) * 0.45, label,
            ha='center', va='center', fontsize=11, fontweight='bold',
            bbox=dict(boxstyle='round,pad=0.4', facecolor=color, alpha=0.8, edgecolor='black'))

# Add legend for categories
legend_y = len(df) * 0.75
legend_x_start = start_year + 2
legend_spacing = 0.8

unique_categories = df['Category'].unique()
for i, cat in enumerate(unique_categories[:8]):  # First 8 categories
    color = category_colors.get(cat, '#cccccc')
    ax.plot(legend_x_start, legend_y - i * legend_spacing, 'o',
            color=color, markersize=10, markeredgecolor='black', markeredgewidth=1)
    ax.text(legend_x_start + 1.5, legend_y - i * legend_spacing, cat,
            ha='left', va='center', fontsize=8)

for i, cat in enumerate(unique_categories[8:]):  # Remaining categories
    color = category_colors.get(cat, '#cccccc')
    ax.plot(legend_x_start + 25, legend_y - i * legend_spacing, 'o',
            color=color, markersize=10, markeredgecolor='black', markeredgewidth=1)
    ax.text(legend_x_start + 26.5, legend_y - i * legend_spacing, cat,
            ha='left', va='center', fontsize=8)

ax.text(legend_x_start, legend_y + 1, 'Event Categories:',
        ha='left', va='center', fontsize=10, fontweight='bold')

# Add key insights box
insights = "Key Trends:\n"
insights += "• Financial sanctions increasingly dominant post-2001\n"
insights += "• Technology controls emerge as major tool (2018+)\n"
insights += "• Shift from comprehensive to targeted measures\n"
insights += "• Great power competition drives new instruments"
ax.text(end_year - 18, legend_y + 1, insights,
        ha='left', va='top', fontsize=9,
        bbox=dict(boxstyle='round,pad=0.5', facecolor='lightyellow', alpha=0.8, edgecolor='black'))

# Clean up axes
ax.set_xticks([])
ax.set_yticks([])
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.spines['left'].set_visible(False)
ax.spines['bottom'].set_visible(False)

plt.tight_layout()

# Save figure
plt.savefig('figure_1_4_timeline.png', dpi=300, bbox_inches='tight')
plt.savefig('figure_1_4_timeline.pdf', bbox_inches='tight')
print("Figure 1.4 saved successfully!")

plt.show()
