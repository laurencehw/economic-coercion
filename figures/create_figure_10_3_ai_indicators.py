"""
Figure 10.3: AI Development Indicators - USA vs China vs EU
Radar chart and bar comparisons across multiple dimensions of AI capability
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read data
df = pd.read_csv('../data/sources/ai_development_indicators.csv')

# Create figure with multiple subplots
fig = plt.figure(figsize=(16, 10))
gs = fig.add_gridspec(2, 2, hspace=0.3, wspace=0.3)
ax1 = fig.add_subplot(gs[0, :])  # Top: radar chart
ax2 = fig.add_subplot(gs[1, 0])  # Bottom left
ax3 = fig.add_subplot(gs[1, 1])  # Bottom right

# Top panel: Radar chart for normalized indicators
categories = ['Publications', 'Top Conferences', 'Patents', 'Startups',
              'Venture Capital', 'Supercomputers', 'Researchers']

# Normalize data to 0-100 scale based on each country's share
usa_values = []
china_values = []
eu_values = []

for idx, cat in enumerate(categories):
    if idx == 0:  # Publications
        total = df.loc[0, 'USA'] + df.loc[0, 'China'] + df.loc[0, 'EU']
        usa_values.append(df.loc[0, 'USA'] / total * 100)
        china_values.append(df.loc[0, 'China'] / total * 100)
        eu_values.append(df.loc[0, 'EU'] / total * 100)
    elif idx == 1:  # Top Conferences
        usa_values.append(df.loc[1, 'USA'])
        china_values.append(df.loc[1, 'China'])
        eu_values.append(df.loc[1, 'EU'])
    elif idx == 2:  # Patents
        total = df.loc[2, 'USA'] + df.loc[2, 'China'] + df.loc[2, 'EU']
        usa_values.append(df.loc[2, 'USA'] / total * 100)
        china_values.append(df.loc[2, 'China'] / total * 100)
        eu_values.append(df.loc[2, 'EU'] / total * 100)
    elif idx == 3:  # Startups
        total = df.loc[3, 'USA'] + df.loc[3, 'China'] + df.loc[3, 'EU']
        usa_values.append(df.loc[3, 'USA'] / total * 100)
        china_values.append(df.loc[3, 'China'] / total * 100)
        eu_values.append(df.loc[3, 'EU'] / total * 100)
    elif idx == 4:  # VC
        total = df.loc[4, 'USA'] + df.loc[4, 'China'] + df.loc[4, 'EU']
        usa_values.append(df.loc[4, 'USA'] / total * 100)
        china_values.append(df.loc[4, 'China'] / total * 100)
        eu_values.append(df.loc[4, 'EU'] / total * 100)
    elif idx == 5:  # Supercomputers
        total = df.loc[5, 'USA'] + df.loc[5, 'China'] + df.loc[5, 'EU']
        usa_values.append(df.loc[5, 'USA'] / total * 100)
        china_values.append(df.loc[5, 'China'] / total * 100)
        eu_values.append(df.loc[5, 'EU'] / total * 100)
    elif idx == 6:  # Researchers
        total = df.loc[7, 'USA'] + df.loc[7, 'China'] + df.loc[7, 'EU']
        usa_values.append(df.loc[7, 'USA'] / total * 100)
        china_values.append(df.loc[7, 'China'] / total * 100)
        eu_values.append(df.loc[7, 'EU'] / total * 100)

# Create radar chart
angles = np.linspace(0, 2 * np.pi, len(categories), endpoint=False).tolist()
usa_values += usa_values[:1]
china_values += china_values[:1]
eu_values += eu_values[:1]
angles += angles[:1]

ax1 = plt.subplot(gs[0, :], projection='polar')
ax1.plot(angles, usa_values, 'o-', linewidth=2.5, label='USA', color='#1f77b4', markersize=8)
ax1.fill(angles, usa_values, alpha=0.15, color='#1f77b4')
ax1.plot(angles, china_values, 's-', linewidth=2.5, label='China', color='#d62728', markersize=8)
ax1.fill(angles, china_values, alpha=0.15, color='#d62728')
ax1.plot(angles, eu_values, '^-', linewidth=2.5, label='EU', color='#2ca02c', markersize=8)
ax1.fill(angles, eu_values, alpha=0.15, color='#2ca02c')

ax1.set_xticks(angles[:-1])
ax1.set_xticklabels(categories, fontsize=10)
ax1.set_ylim(0, 75)
ax1.set_yticks([25, 50, 75])
ax1.set_yticklabels(['25%', '50%', '75%'], fontsize=9)
ax1.set_title('AI Development Indicators - Multi-Dimensional Comparison',
              fontsize=14, fontweight='bold', pad=20)
ax1.legend(loc='upper right', bbox_to_anchor=(1.3, 1.1), fontsize=11)
ax1.grid(True, alpha=0.3)

# Bottom left: Investment and funding comparison
categories_money = ['AI Venture\nCapital', 'Government\nAI Spending']
usa_money = [df.loc[4, 'USA'], df.loc[9, 'USA']]
china_money = [df.loc[4, 'China'], df.loc[9, 'China']]
eu_money = [df.loc[4, 'EU'], df.loc[9, 'EU']]

x = np.arange(len(categories_money))
width = 0.25

ax2.bar(x - width, usa_money, width, label='USA', color='#1f77b4', alpha=0.8, edgecolor='black')
ax2.bar(x, china_money, width, label='China', color='#d62728', alpha=0.8, edgecolor='black')
ax2.bar(x + width, eu_money, width, label='EU', color='#2ca02c', alpha=0.8, edgecolor='black')

# Add value labels
for i, (u, c, e) in enumerate(zip(usa_money, china_money, eu_money)):
    ax2.text(i - width, u + 1.5, f'${u:.1f}B', ha='center', fontsize=9, fontweight='bold')
    ax2.text(i, c + 1.5, f'${c:.1f}B', ha='center', fontsize=9, fontweight='bold')
    ax2.text(i + width, e + 1.5, f'${e:.1f}B', ha='center', fontsize=9, fontweight='bold')

ax2.set_ylabel('Spending (Billions USD, 2024)', fontsize=11)
ax2.set_title('AI Investment and Government Funding', fontsize=12, fontweight='bold', pad=15)
ax2.set_xticks(x)
ax2.set_xticklabels(categories_money, fontsize=10)
ax2.legend(fontsize=10)
ax2.grid(True, alpha=0.2, axis='y')

# Bottom right: Research output comparison
categories_research = ['AI\nPublications', 'Top Conference\nShare (%)', 'AI Patents']
usa_research = [df.loc[0, 'USA']/1000, df.loc[1, 'USA'], df.loc[2, 'USA']/1000]
china_research = [df.loc[0, 'China']/1000, df.loc[1, 'China'], df.loc[2, 'China']/1000]
eu_research = [df.loc[0, 'EU']/1000, df.loc[1, 'EU'], df.loc[2, 'EU']/1000]

# Create grouped bars with different scales (normalized)
x2 = np.arange(len(categories_research))

ax3.bar(x2 - width, [usa_research[0]/2, usa_research[1]*2, usa_research[2]], width,
        label='USA', color='#1f77b4', alpha=0.8, edgecolor='black')
ax3.bar(x2, [china_research[0]/2, china_research[1]*2, china_research[2]], width,
        label='China', color='#d62728', alpha=0.8, edgecolor='black')
ax3.bar(x2 + width, [eu_research[0]/2, eu_research[1]*2, eu_research[2]], width,
        label='EU', color='#2ca02c', alpha=0.8, edgecolor='black')

# Add actual value labels
labels_usa = [f'{usa_research[0]:.0f}k', f'{usa_research[1]:.0f}%', f'{usa_research[2]:.0f}k']
labels_china = [f'{china_research[0]:.0f}k', f'{china_research[1]:.0f}%', f'{china_research[2]:.0f}k']
labels_eu = [f'{eu_research[0]:.0f}k', f'{eu_research[1]:.0f}%', f'{eu_research[2]:.0f}k']

for i, (u, c, e) in enumerate(zip(labels_usa, labels_china, labels_eu)):
    y_usa = usa_research[0]/2 if i == 0 else (usa_research[1]*2 if i == 1 else usa_research[2])
    y_china = china_research[0]/2 if i == 0 else (china_research[1]*2 if i == 1 else china_research[2])
    y_eu = eu_research[0]/2 if i == 0 else (eu_research[1]*2 if i == 1 else eu_research[2])

    ax3.text(i - width, y_usa + 2, u, ha='center', fontsize=9, fontweight='bold')
    ax3.text(i, y_china + 2, c, ha='center', fontsize=9, fontweight='bold')
    ax3.text(i + width, y_eu + 2, e, ha='center', fontsize=9, fontweight='bold')

ax3.set_ylabel('Normalized Scale', fontsize=11)
ax3.set_title('AI Research Output (2024)', fontsize=12, fontweight='bold', pad=15)
ax3.set_xticks(x2)
ax3.set_xticklabels(categories_research, fontsize=10)
ax3.legend(fontsize=10)
ax3.grid(True, alpha=0.2, axis='y')
ax3.set_ylim(0, 100)

plt.tight_layout()

# Save figure
plt.savefig('figure_10_3_ai_indicators.png', dpi=300, bbox_inches='tight')
plt.savefig('figure_10_3_ai_indicators.pdf', bbox_inches='tight')
print("Figure 10.3 saved successfully!")

plt.show()
