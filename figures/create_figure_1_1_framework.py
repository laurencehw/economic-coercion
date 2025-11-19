"""
Figure 1.1: Four Dimensions Analytical Framework for Economic Coercion
Conceptual diagram showing the key analytical dimensions
"""

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch
import numpy as np

# Create figure
fig, ax = plt.subplots(figsize=(14, 10))
ax.set_xlim(0, 10)
ax.set_ylim(0, 10)
ax.axis('off')

# Title
ax.text(5, 9.5, 'Four Dimensions Framework for Analyzing Economic Coercion',
        ha='center', va='top', fontsize=16, fontweight='bold')

# Define the four main dimensions as quadrants
quadrants = [
    {
        'name': 'DIMENSION 1:\nInstruments & Tools',
        'x': 1.5, 'y': 6.5,
        'color': '#1f77b4',
        'items': [
            'Trade Controls',
            'Financial Sanctions',
            'Investment Restrictions',
            'Technology Export Controls',
            'Energy Leverage',
            'Infrastructure Dependencies'
        ]
    },
    {
        'name': 'DIMENSION 2:\nObjectives & Goals',
        'x': 6.5, 'y': 6.5,
        'color': '#ff7f0e',
        'items': [
            'Policy Change',
            'Behavior Modification',
            'Regime Change',
            'Strategic Containment',
            'Deterrence',
            'Signaling'
        ]
    },
    {
        'name': 'DIMENSION 3:\nTarget Characteristics',
        'x': 1.5, 'y': 2.5,
        'color': '#2ca02c',
        'items': [
            'Economic Interdependence',
            'Regime Type',
            'Domestic Politics',
            'Alternative Partners',
            'Economic Resilience',
            'International Support'
        ]
    },
    {
        'name': 'DIMENSION 4:\nEffectiveness Factors',
        'x': 6.5, 'y': 2.5,
        'color': '#d62728',
        'items': [
            'Economic Impact',
            'Political Outcomes',
            'Multilateral Coordination',
            'Duration & Persistence',
            'Unintended Consequences',
            'Costs to Sender'
        ]
    }
]

# Draw quadrants
for quad in quadrants:
    # Main box
    box = FancyBboxPatch((quad['x'] - 1.8, quad['y'] - 1.8), 3.6, 3.6,
                         boxstyle="round,pad=0.1", linewidth=2.5,
                         edgecolor=quad['color'], facecolor=quad['color'], alpha=0.15)
    ax.add_patch(box)

    # Title box
    title_box = FancyBboxPatch((quad['x'] - 1.6, quad['y'] + 1.2), 3.2, 0.5,
                               boxstyle="round,pad=0.05", linewidth=2,
                               edgecolor=quad['color'], facecolor=quad['color'], alpha=0.8)
    ax.add_patch(title_box)

    # Title text
    ax.text(quad['x'], quad['y'] + 1.45, quad['name'],
            ha='center', va='center', fontsize=11, fontweight='bold', color='white')

    # Items
    y_start = quad['y'] + 0.8
    for i, item in enumerate(quad['items']):
        ax.text(quad['x'], y_start - i * 0.42, f'• {item}',
                ha='center', va='top', fontsize=9)

# Draw connecting arrows showing framework interaction
arrow_style = "Simple, tail_width=1.5, head_width=8, head_length=8"

# Horizontal arrows
arrow1 = FancyArrowPatch((3.3, 8), (5.7, 8),
                         arrowstyle='<->', mutation_scale=20, linewidth=2,
                         color='gray', alpha=0.6)
ax.add_patch(arrow1)
ax.text(4.5, 8.3, 'Selection', ha='center', fontsize=9, style='italic', color='gray')

arrow2 = FancyArrowPatch((3.3, 4), (5.7, 4),
                         arrowstyle='<->', mutation_scale=20, linewidth=2,
                         color='gray', alpha=0.6)
ax.add_patch(arrow2)
ax.text(4.5, 4.3, 'Evaluation', ha='center', fontsize=9, style='italic', color='gray')

# Vertical arrows
arrow3 = FancyArrowPatch((3, 5.5), (3, 3.7),
                         arrowstyle='<->', mutation_scale=20, linewidth=2,
                         color='gray', alpha=0.6)
ax.add_patch(arrow3)
ax.text(2.3, 4.6, 'Analysis', ha='center', fontsize=9, style='italic', color='gray', rotation=90)

arrow4 = FancyArrowPatch((8, 5.5), (8, 3.7),
                         arrowstyle='<->', mutation_scale=20, linewidth=2,
                         color='gray', alpha=0.6)
ax.add_patch(arrow4)
ax.text(8.7, 4.6, 'Assessment', ha='center', fontsize=9, style='italic', color='gray', rotation=90)

# Central integration box
center_box = FancyBboxPatch((3.8, 4.2), 2.4, 1.2,
                           boxstyle="round,pad=0.1", linewidth=3,
                           edgecolor='black', facecolor='lightyellow', alpha=0.9)
ax.add_patch(center_box)

ax.text(5, 5.1, 'INTEGRATED',
        ha='center', va='center', fontsize=12, fontweight='bold')
ax.text(5, 4.7, 'ANALYSIS',
        ha='center', va='center', fontsize=12, fontweight='bold')
ax.text(5, 4.35, 'Framework combines all',
        ha='center', va='center', fontsize=8, style='italic')

# Bottom note
note_text = "Framework Application: Each case of economic coercion should be analyzed across all four dimensions\n"
note_text += "to understand (1) what tools are used, (2) what objectives are sought, (3) how target characteristics\n"
note_text += "affect outcomes, and (4) how to measure effectiveness."
ax.text(5, 0.5, note_text,
        ha='center', va='center', fontsize=9,
        bbox=dict(boxstyle='round,pad=0.5', facecolor='lightgray', alpha=0.5))

plt.tight_layout()

# Save figure
plt.savefig('figure_1_1_framework.png', dpi=300, bbox_inches='tight')
plt.savefig('figure_1_1_framework.pdf', bbox_inches='tight')
print("Figure 1.1 saved successfully!")

plt.show()
