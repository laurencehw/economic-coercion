"""
Figure 9.3: Sanctions Success Rates by Type
Shows the effectiveness of different types of economic sanctions
Based on analysis of historical sanctions cases (1945-2020)
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read data
df = pd.read_csv('../data/sources/sanctions_success_rates.csv')

# Create figure with two panels
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

# Left panel: Success rates by type (stacked horizontal bar)
categories = df['Sanction_Type']
success = df['Success_Rate']
partial = df['Partial_Success']
failure = df['Failure']

y_pos = np.arange(len(categories))

# Create stacked horizontal bars
p1 = ax1.barh(y_pos, success, color='#2ca02c', alpha=0.8, label='Success')
p2 = ax1.barh(y_pos, partial, left=success, color='#ff7f0e', alpha=0.8, label='Partial Success')
p3 = ax1.barh(y_pos, failure, left=success + partial, color='#d62728', alpha=0.8, label='Failure')

# Add percentage labels
for i, (s, p, f) in enumerate(zip(success, partial, failure)):
    # Success label
    if s > 5:
        ax1.text(s/2, i, f'{s}%', ha='center', va='center', fontsize=10, fontweight='bold', color='white')
    # Partial label
    if p > 5:
        ax1.text(s + p/2, i, f'{p}%', ha='center', va='center', fontsize=10, fontweight='bold', color='white')
    # Failure label
    if f > 5:
        ax1.text(s + p + f/2, i, f'{f}%', ha='center', va='center', fontsize=10, fontweight='bold', color='white')

ax1.set_yticks(y_pos)
ax1.set_yticklabels(categories, fontsize=10)
ax1.set_xlabel('Percentage of Cases (%)', fontsize=11)
ax1.set_title('Sanctions Outcomes by Type (% of cases)', fontsize=13, fontweight='bold', pad=15)
ax1.legend(loc='lower right', fontsize=10)
ax1.set_xlim(0, 100)
ax1.grid(True, alpha=0.2, axis='x')

# Add note
note_text = f"Based on {df['Total_Cases'].sum()} historical cases (1945-2020)\n"
note_text += "Success = achieved stated objectives\nPartial = some concessions obtained"
ax1.text(0.02, 0.98, note_text, transform=ax1.transAxes,
         fontsize=8, verticalalignment='top', horizontalalignment='left',
         bbox=dict(boxstyle='round', facecolor='lightgray', alpha=0.6))

# Right panel: Success rate vs. average duration
combined_success = success + (partial * 0.5)  # Weight partial as 50% success

ax2.scatter(df['Avg_Duration_Years'], combined_success, s=df['Total_Cases']*3,
            alpha=0.6, c=combined_success, cmap='RdYlGn', edgecolors='black', linewidth=1.5)

# Add labels for each point
for i, txt in enumerate(df['Sanction_Type']):
    ax2.annotate(txt.replace(' Sanctions', '').replace(' Controls', '').replace(' Restrictions', ''),
                 (df['Avg_Duration_Years'].iloc[i], combined_success.iloc[i]),
                 fontsize=9, ha='center', va='bottom',
                 xytext=(0, 5), textcoords='offset points')

ax2.set_xlabel('Average Duration (Years)', fontsize=11)
ax2.set_ylabel('Success Rate (%, including 50% partial)', fontsize=11)
ax2.set_title('Sanctions Effectiveness vs. Duration', fontsize=13, fontweight='bold', pad=15)
ax2.grid(True, alpha=0.3)
ax2.set_ylim(25, 65)

# Add trend insight
insight_text = "Key Insight:\n"
insight_text += "• Shorter sanctions more effective\n"
insight_text += "• Export controls most successful\n"
insight_text += "• Comprehensive sanctions least effective\n"
insight_text += "• Bubble size = number of cases"
ax2.text(0.98, 0.02, insight_text, transform=ax2.transAxes,
         fontsize=9, verticalalignment='bottom', horizontalalignment='right',
         bbox=dict(boxstyle='round', facecolor='lightblue', alpha=0.7))

plt.tight_layout()

# Save figure
plt.savefig('figure_9_3_sanctions_success.png', dpi=300, bbox_inches='tight')
plt.savefig('figure_9_3_sanctions_success.pdf', bbox_inches='tight')
print("Figure 9.3 saved successfully!")

plt.show()
