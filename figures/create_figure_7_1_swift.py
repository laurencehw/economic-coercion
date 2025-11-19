"""
Figure 7.1: SWIFT Transaction Volumes by Currency
Shows the U.S. dollar's dominance in global payment systems,
with the euro as second and China's yuan gradually increasing.
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
data = pd.read_csv('../data/sources/swift_currency_data.csv')

# Create figure with main plot and inset for 2024 breakdown
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 7))

# ===== LEFT PANEL: Time Series =====
# Define colors
colors = {
    'USD': '#1f77b4',    # Blue
    'EUR': '#ff7f0e',    # Orange
    'GBP': '#2ca02c',    # Green
    'JPY': '#d62728',    # Red
    'CNY': '#9467bd',    # Purple
}

# Plot main currencies
for currency in ['USD', 'EUR', 'GBP', 'JPY', 'CNY']:
    ax1.plot(data['Year'], data[currency],
            marker='o', linewidth=2.5, markersize=5,
            color=colors[currency], label=currency, alpha=0.9)

# Customize left panel
ax1.set_xlabel('Year', fontweight='bold', fontsize=12)
ax1.set_ylabel('Share of SWIFT Messages (%)', fontweight='bold', fontsize=12)
ax1.set_title('SWIFT Payment System Currency Shares Over Time',
             fontweight='bold', fontsize=13, pad=15)
ax1.grid(True, alpha=0.3, linestyle='--', linewidth=0.5)
ax1.set_xlim(2009, 2025)
ax1.set_ylim(0, 50)
ax1.legend(loc='center left', framealpha=0.95, edgecolor='black', fontsize=11)

# Add simple annotation for CNY growth
ax1.text(2024.5, data.iloc[-1]['CNY'], f"{data.iloc[-1]['CNY']:.1f}%",
        fontsize=9, fontweight='bold', color='#9467bd', va='center')

# ===== RIGHT PANEL: 2024 Pie Chart =====
latest = data.iloc[-1]
currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CNY', 'Others']
values = [latest[c] for c in currencies]
colors_pie = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b']

wedges, texts, autotexts = ax2.pie(values, labels=currencies, colors=colors_pie,
                                     autopct='%1.1f%%', startangle=90,
                                     textprops={'fontsize': 11, 'fontweight': 'bold'})

# Make percentage text white for better contrast
for autotext in autotexts:
    autotext.set_color('white')
    autotext.set_fontsize(10)

ax2.set_title('2024 Currency Breakdown\n(% of SWIFT Messages)',
             fontweight='bold', fontsize=13, pad=15)

# Add main title
fig.suptitle('Figure 7.1: SWIFT Transaction Volumes by Currency (2010-2024)\n' +
            'The U.S. Dollar\'s Continued Dominance in Global Payments',
            fontweight='bold', fontsize=16, y=0.98)

# Add statistics box
stats_text = (f'2024 Rankings:\n'
             f'1. USD: {latest["USD"]:.1f}%\n'
             f'2. EUR: {latest["EUR"]:.1f}%\n'
             f'3. GBP: {latest["GBP"]:.1f}%\n'
             f'4. JPY: {latest["JPY"]:.1f}%\n'
             f'5. CNY: {latest["CNY"]:.1f}%')
props = dict(boxstyle='round', facecolor='lightblue', alpha=0.85, edgecolor='gray', linewidth=1)
ax1.text(0.02, 0.40, stats_text, transform=ax1.transAxes, fontsize=9,
        verticalalignment='top', bbox=props, family='monospace')

# Add source citation
plt.figtext(0.99, 0.01,
           'Sources: SWIFT RMB Tracker, Bank for International Settlements (BIS)\n' +
           'Note: Percentage of total SWIFT messages by currency. USD maintains ~40% share despite gradual decline.\n' +
           'CNY (Chinese yuan/renminbi) has grown from 0.3% (2010) to 5.5% (2024).',
           ha='right', va='bottom', fontsize=8, style='italic')

# Adjust layout
plt.tight_layout(rect=[0, 0.05, 1, 0.94])

# Save in multiple formats
output_dir = '.'
plt.savefig(f'{output_dir}/figure_7_1_swift_currencies.png', dpi=300, bbox_inches='tight')
plt.savefig(f'{output_dir}/figure_7_1_swift_currencies.pdf', bbox_inches='tight')

print("[OK] Figure 7.1 created successfully!")
print(f"  - PNG: {output_dir}/figure_7_1_swift_currencies.png (300 DPI)")
print(f"  - PDF: {output_dir}/figure_7_1_swift_currencies.pdf (vector)")
print(f"\nCurrency Shares 2024:")
print(f"  • USD: {latest['USD']:.1f}%")
print(f"  • EUR: {latest['EUR']:.1f}%")
print(f"  • CNY: {latest['CNY']:.1f}% (up from {data.iloc[0]['CNY']:.1f}% in 2010)")
print(f"  • CNY growth: {((latest['CNY']/data.iloc[0]['CNY'])-1)*100:.0f}% increase")

plt.close()
