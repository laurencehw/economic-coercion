"""
Figure 8.3: Industrial Policy Spending Comparison - U.S. vs China
Compares major government industrial policy programs in strategic sectors
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read data
df = pd.read_csv('../data/sources/industrial_policy_spending.csv')

# Create figure with two panels
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 7))

# Left panel: Total spending by program
usa_programs = df[df['Country'] == 'USA']
china_programs = df[df['Country'] == 'China']

# Create grouped bar chart by sector
sectors = ['Semiconductors', 'Clean Energy', 'Infrastructure', 'Advanced Manufacturing', 'Electric Vehicles']

usa_semi = usa_programs[usa_programs['Sector'] == 'Semiconductors']['Total_Spending_Billions'].sum()
usa_clean = usa_programs[usa_programs['Sector'] == 'Clean Energy']['Total_Spending_Billions'].sum()
usa_infra = usa_programs[usa_programs['Sector'] == 'Infrastructure']['Total_Spending_Billions'].sum()

china_semi = china_programs[china_programs['Sector'] == 'Semiconductors']['Total_Spending_Billions'].sum()
china_clean = china_programs[china_programs['Sector'] == 'Solar Energy']['Total_Spending_Billions'].sum()
china_infra = china_programs[china_programs['Sector'] == 'Digital Infrastructure']['Total_Spending_Billions'].sum()
china_mfg = china_programs[china_programs['Sector'] == 'Advanced Manufacturing']['Total_Spending_Billions'].sum()
china_ev = china_programs[china_programs['Sector'] == 'Electric Vehicles']['Total_Spending_Billions'].sum()

# Set up data for stacked bars
programs_usa = [
    ('CHIPS Act', 52.7, '#1f77b4'),
    ('IRA (Clean Energy)', 369, '#2ca02c'),
    ('Infrastructure', 550, '#ff7f0e'),
]

programs_china = [
    ('Big Fund I+II+III', 98.2, '#1f77b4'),
    ('Made in China 2025', 300, '#9467bd'),
    ('New Infrastructure', 411, '#ff7f0e'),
    ('EV Subsidies', 58.5, '#d62728'),
    ('Solar Subsidies', 42.3, '#2ca02c'),
]

# Plot USA programs
bottom_usa = 0
for name, value, color in programs_usa:
    ax1.barh(0, value, left=bottom_usa, height=0.6, color=color, alpha=0.8, label=name, edgecolor='black', linewidth=1)
    if value > 40:
        ax1.text(bottom_usa + value/2, 0, f'${value:.0f}B\n{name}',
                ha='center', va='center', fontsize=9, fontweight='bold', color='white')
    bottom_usa += value

# Plot China programs
bottom_china = 0
for name, value, color in programs_china:
    ax1.barh(1, value, left=bottom_china, height=0.6, color=color, alpha=0.8, label=name, edgecolor='black', linewidth=1)
    if value > 40:
        ax1.text(bottom_china + value/2, 1, f'${value:.0f}B\n{name}',
                ha='center', va='center', fontsize=8, fontweight='bold', color='white')
    bottom_china += value

ax1.set_yticks([0, 1])
ax1.set_yticklabels(['USA', 'China'], fontsize=12, fontweight='bold')
ax1.set_xlabel('Total Committed Spending (Billions USD)', fontsize=11)
ax1.set_title('Major Industrial Policy Programs - Total Spending', fontsize=13, fontweight='bold', pad=15)
ax1.grid(True, alpha=0.2, axis='x')

# Add totals
usa_total = sum([v for _, v, _ in programs_usa])
china_total = sum([v for _, v, _ in programs_china])
ax1.text(usa_total + 50, 0, f'Total: ${usa_total:.0f}B', fontsize=11, fontweight='bold', va='center')
ax1.text(china_total + 50, 1, f'Total: ${china_total:.0f}B', fontsize=11, fontweight='bold', va='center')

# Right panel: Annual spending comparison over time (2014-2032)
years = np.arange(2014, 2033)
usa_annual = np.zeros(len(years))
china_annual = np.zeros(len(years))

for _, row in df.iterrows():
    start_idx = row['Start_Year'] - 2014
    end_idx = row['End_Year'] - 2014 + 1
    annual = row['Annual_Avg_Billions']

    if row['Country'] == 'USA':
        usa_annual[start_idx:end_idx] += annual
    else:
        china_annual[start_idx:end_idx] += annual

ax2.plot(years, usa_annual, linewidth=3, marker='o', markersize=6,
         color='#1f77b4', label='USA Annual Spending')
ax2.plot(years, china_annual, linewidth=3, marker='s', markersize=6,
         color='#d62728', label='China Annual Spending')

# Fill areas
ax2.fill_between(years, 0, usa_annual, alpha=0.2, color='#1f77b4')
ax2.fill_between(years, 0, china_annual, alpha=0.2, color='#d62728')

# Mark key events
ax2.axvline(x=2022, color='gray', linestyle='--', linewidth=1.5, alpha=0.6)
ax2.text(2022, ax2.get_ylim()[1] * 0.95, 'CHIPS & IRA\nPassed',
         ha='center', va='top', fontsize=9,
         bbox=dict(boxstyle='round,pad=0.3', facecolor='lightyellow', alpha=0.8, edgecolor='gray'))

ax2.set_xlabel('Year', fontsize=11)
ax2.set_ylabel('Annual Spending (Billions USD)', fontsize=11)
ax2.set_title('Annual Industrial Policy Spending Over Time', fontsize=13, fontweight='bold', pad=15)
ax2.legend(loc='upper left', fontsize=10)
ax2.grid(True, alpha=0.3)
ax2.set_xlim(2014, 2032)

# Add statistics box
stats_text = "Peak Annual Spending:\n"
stats_text += f"USA: ${usa_annual.max():.1f}B (2022-2031)\n"
stats_text += f"China: ${china_annual.max():.1f}B (2024-2027)\n"
stats_text += f"\nChina started earlier (2014)\nUSA ramping up rapidly (2022+)"
ax2.text(0.98, 0.35, stats_text, transform=ax2.transAxes,
         fontsize=9, verticalalignment='bottom', horizontalalignment='right',
         bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.8))

plt.tight_layout()

# Save figure
plt.savefig('figure_8_3_industrial_policy.png', dpi=300, bbox_inches='tight')
plt.savefig('figure_8_3_industrial_policy.pdf', bbox_inches='tight')
print("Figure 8.3 saved successfully!")

plt.show()
