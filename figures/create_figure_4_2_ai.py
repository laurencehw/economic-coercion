"""
Figure 4.2: AI Research Publications - USA vs China
Shows China's surge in AI research output, surpassing the U.S. in volume
but with ongoing debates about quality and impact.
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
data = pd.read_csv('../data/sources/ai_publications.csv')

# Create figure with two subplots
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 7))

# ===== LEFT PANEL: Publications and Citations =====
# Plot publications on primary y-axis
color1 = '#1f77b4'  # Blue for USA
color2 = '#d62728'  # Red for China

l1 = ax1.plot(data['Year'], data['USA_Publications'],
              marker='o', linewidth=2.5, markersize=6,
              color=color1, label='USA Publications', linestyle='-')
l2 = ax1.plot(data['Year'], data['China_Publications'],
              marker='s', linewidth=2.5, markersize=6,
              color=color2, label='China Publications', linestyle='-')
l3 = ax1.plot(data['Year'], data['EU_Publications'],
              marker='^', linewidth=2, markersize=5,
              color='#2ca02c', label='EU Publications', linestyle='--', alpha=0.7)

# Mark crossover point where China surpasses USA - simplified
crossover = data[data['China_Publications'] > data['USA_Publications']].iloc[0]
ax1.axvline(x=crossover['Year'], color='gray', linestyle=':', alpha=0.5, linewidth=1.5)
ax1.text(crossover['Year'], 120000, 'China > USA',
        fontsize=9, fontweight='bold', color='darkred', rotation=90,
        va='bottom', ha='right')

# Customize left panel
ax1.set_xlabel('Year', fontweight='bold', fontsize=12)
ax1.set_ylabel('Number of AI/ML Publications', fontweight='bold', fontsize=12, color='black')
ax1.set_title('AI Research Publications by Country\n(2010-2024)',
             fontweight='bold', fontsize=14, pad=15)
ax1.tick_params(axis='y', labelcolor='black')
ax1.grid(True, alpha=0.3, linestyle='--', linewidth=0.5)
ax1.set_xlim(2009, 2025)
ax1.legend(loc='upper left', framealpha=0.95, edgecolor='black', fontsize=10)

# ===== RIGHT PANEL: Quality Metrics (Top-tier conference share) =====
ax2.plot(data['Year'], data['USA_Top10_Share'],
        marker='o', linewidth=2.5, markersize=6,
        color=color1, label='USA (Top-10 conferences)', linestyle='-')
ax2.plot(data['Year'], data['China_Top10_Share'],
        marker='s', linewidth=2.5, markersize=6,
        color=color2, label='China (Top-10 conferences)', linestyle='-')

# Removed shaded region for cleaner look

# Customize right panel
ax2.set_xlabel('Year', fontweight='bold', fontsize=12)
ax2.set_ylabel('Share of Top-Tier Conference Publications (%)', fontweight='bold', fontsize=12)
ax2.set_title('Research Quality: Top-10 AI Conference Share\n(NeurIPS, ICML, CVPR, etc.)',
             fontweight='bold', fontsize=14, pad=15)
ax2.grid(True, alpha=0.3, linestyle='--', linewidth=0.5)
ax2.set_xlim(2009, 2025)
ax2.set_ylim(0, 50)
ax2.legend(loc='upper right', framealpha=0.95, edgecolor='black', fontsize=10)

# Removed annotation for cleaner look

# Add main title
fig.suptitle('Figure 4.2: The AI Research Race - USA vs China (2010-2024)\n' +
            'Quantity vs Quality in Artificial Intelligence Research',
            fontweight='bold', fontsize=16, y=0.98)

# Statistics box moved to lower right to avoid legend overlap
stats_text = ('2024:\n'
             f'USA: {data.iloc[-1]["USA_Publications"]:,.0f}\n'
             f'China: {data.iloc[-1]["China_Publications"]:,.0f}\n'
             f'Ratio: {data.iloc[-1]["China_Publications"]/data.iloc[-1]["USA_Publications"]:.1f}x')
props = dict(boxstyle='round', facecolor='lightblue', alpha=0.85, edgecolor='gray', linewidth=1)
ax1.text(0.98, 0.03, stats_text, transform=ax1.transAxes, fontsize=9,
        verticalalignment='bottom', horizontalalignment='right', bbox=props, family='monospace')

# Removed quality note for cleaner design

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: arXiv.org, Scopus, Web of Science, Stanford AI Index Report 2024, OpenAI Research Trends\n' +
           'Note: Publications include conference papers, journal articles, and preprints in AI/ML fields.\n' +
           'Top-10 conferences represent the most prestigious venues for AI research with rigorous peer review.',
           ha='right', va='bottom', fontsize=8, style='italic')

# Adjust layout
plt.tight_layout(rect=[0, 0.04, 1, 0.94])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_4_2_ai_publications.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_4_2_ai_publications.pdf', bbox_inches='tight')

print("[OK] Figure 4.2 created successfully!")
print(f"  - PNG: {output_dir}/figure_4_2_ai_publications.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_4_2_ai_publications.pdf (vector)")
print(f"\nAI Research Trends:")
print(f"  2010: USA {data.iloc[0]['USA_Publications']:,} papers, China {data.iloc[0]['China_Publications']:,} papers")
print(f"  2024: USA {data.iloc[-1]['USA_Publications']:,} papers, China {data.iloc[-1]['China_Publications']:,} papers")
print(f"  China now publishes {data.iloc[-1]['China_Publications']/data.iloc[-1]['USA_Publications']:.2f}x USA volume")
print(f"  But USA maintains {data.iloc[-1]['USA_Top10_Share']:.0f}% vs China's {data.iloc[-1]['China_Top10_Share']:.0f}% share at top conferences")

plt.close()
