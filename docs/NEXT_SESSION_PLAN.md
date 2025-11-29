# Next Session Plan: Textbook Finalization and Publication Preparation

**Book Status**: ✅ All 10 chapters complete (~134,050 words)
**Current Phase**: Post-writing finalization and production

---

## Session Objectives Priority Order

### Priority 1: Create Visualizations (HIGH IMPACT)
**Estimated time**: 3-4 hours
**Impact**: Publication-quality textbook requires professional figures

#### Task 1.1: Review and Prioritize Visualization Plan
- Review `VISUALIZATION_PLAN.md` (70-80 planned figures)
- Identify highest-priority visualizations for each chapter
- Create execution order based on:
  - Essential vs. supplementary figures
  - Data availability
  - Complexity/time required

#### Task 1.2: Create High-Priority Visualizations
**Suggested focus areas** (top 20-25 figures):

**Chapter 1 (Foundations)**:
- Figure 1.1: Analytical Framework - Four Dimensions Matrix
- Figure 1.2: U.S.-China Trade Flows (1990-2024)

**Chapter 2 (Supply Chains)**:
- Figure 2.1: Global Semiconductor Supply Chain Map
- Figure 2.2: TSMC Market Share by Technology Node
- Figure 2.3: Critical Mineral Processing Concentration (China dominance)

**Chapter 4 (Technology)**:
- Figure 4.1: R&D Spending by Country (1990-2024)
- Figure 4.2: AI Research Publications (USA vs China)

**Chapter 6 (Trade Controls)**:
- Figure 6.1: U.S. Tariffs on Chinese Goods Timeline
- Figure 6.3: Entity List Additions Over Time

**Chapter 7 (Financial)**:
- Figure 7.1: SWIFT Message Volumes by Currency
- Figure 7.3: U.S. Treasury Holdings by Country
- Figure 7.4: Russia Frozen Assets Breakdown

**Chapter 8 (Investment/Industrial)**:
- Figure 8.2: Chinese FDI in U.S. and Europe (2008-2024) [ALREADY EXISTS!]
- Figure 8.3: Industrial Policy Spending Comparison (CHIPS/IRA vs Big Fund)

**Chapter 9 (Historical)**:
- Figure 9.1: Soviet Grain Imports by Source Country (1975-1985)
- Figure 9.3: Sanctions Success Rates by Type

**Chapter 10 (Future)**:
- Figure 10.1: Dollar Share of Global Reserves (1995-2050 projection)
- Figure 10.3: AI Development Indicators (U.S. vs China vs EU)
- Figure 10.5: Scenario Matrix - Integration vs Competition

#### Task 1.3: Data Collection and Sourcing
For each visualization:
- Identify data sources (many listed in chapter "Data Sources" sections)
- Download/compile datasets
- Clean and format data for visualization

#### Task 1.4: Create Visualizations Using Python
- Use matplotlib/seaborn for publication-quality charts
- Export as both PNG (300 DPI for print) and PDF (vector)
- Save source data CSVs for reproducibility
- Create Python scripts for each figure (reproducibility)

**Deliverables**:
- 20-25 publication-quality figures (PNG + PDF)
- Python scripts for all visualizations
- Source data files (CSV)
- Figure captions document

---

### Priority 2: Generate PDF Textbook (MEDIUM-HIGH IMPACT)
**Estimated time**: 1-2 hours
**Impact**: Creates reviewable, shareable format

#### Task 2.1: Set Up Pandoc/LaTeX Environment
- Verify Pandoc installation (already on system based on previous commands)
- Install LaTeX distribution if needed (MiKTeX or TeX Live)
- Test basic markdown-to-PDF conversion

#### Task 2.2: Create Custom LaTeX Template
Design textbook-specific template with:
- Professional formatting (margins, fonts, spacing)
- Chapter headers and styling
- Figure placement and captions
- Table of contents
- Bibliography/references formatting
- Page numbering and headers/footers

#### Task 2.3: Compile Individual Chapters
Test compilation for each chapter:
- Convert markdown → PDF via Pandoc
- Verify formatting, figure placement, citations
- Fix any conversion issues

#### Task 2.4: Compile Complete Book
- Combine all chapters into single document
- Add front matter (title page, TOC, preface)
- Add back matter (index, bibliography)
- Generate final PDF

**Deliverables**:
- Complete textbook PDF (~300-400 pages estimated)
- Individual chapter PDFs
- LaTeX template for future updates

---

### Priority 3: Add Front Matter and Structure (MEDIUM IMPACT)
**Estimated time**: 1-2 hours
**Impact**: Professional presentation, usability

#### Task 3.1: Create Title Page and Copyright
- Full title and subtitle
- Author information
- Copyright and licensing information
- Publication date

#### Task 3.2: Write Preface/Introduction
**Content** (~1,500-2,000 words):
- Book's purpose and audience
- How the book is organized
- How to use the book (instructors, students, practitioners)
- Acknowledgments
- Note about visualizations and data sources

#### Task 3.3: Generate Table of Contents
- Chapter-level TOC
- Section-level TOC (detailed)
- List of Figures
- List of Tables (if any)

#### Task 3.4: Create Glossary
**Include**:
- Key terms with definitions
- Chinese terms with pinyin and characters
- Acronyms (CFIUS, FIRRMA, CHIPS, CIPS, BRICS, etc.)
- Technical terminology

#### Task 3.5: Compile Index
- Subject index (alphabetical)
- Key concepts, people, organizations, countries
- Cross-references

**Deliverables**:
- Preface (~2,000 words)
- Complete table of contents
- Glossary of terms (100+ entries)
- Subject index

---

### Priority 4: Review and Polish Content (MEDIUM IMPACT)
**Estimated time**: 2-3 hours
**Impact**: Quality assurance, consistency

#### Task 4.1: Consistency Check
- Verify Chinese characters + pinyin formatting across all chapters
- Check citation format consistency
- Verify figure/table numbering
- Cross-reference accuracy (e.g., "see Chapter 4" references correct content)

#### Task 4.2: Content Review by Chapter
For each chapter:
- Read for clarity and flow
- Check for repetition or contradictions
- Verify data accuracy (statistics, dates, quotes)
- Update any outdated information (if writing occurred over time)

#### Task 4.3: Style and Tone
- Consistent voice throughout
- Appropriate academic level (graduate/professional)
- Balance technical depth with accessibility
- Remove any informal language

#### Task 4.4: Fact-Checking Key Claims
Priority fact-check:
- Major statistical claims (trade volumes, sanctions numbers)
- Historical events (dates, participants, outcomes)
- Technical descriptions (how SWIFT works, CFIUS procedures)
- Chinese perspective box accuracy (cultural/linguistic authenticity)

**Deliverables**:
- Consistency checklist completed
- List of corrections/updates made
- Fact-check verification document

---

### Priority 5: Create Study Materials (LOWER IMPACT - FUTURE)
**Estimated time**: 3-4 hours
**Impact**: Teaching support materials

#### Task 5.1: Discussion Questions
For each chapter (~5-7 questions):
- Conceptual understanding questions
- Application/case analysis questions
- Critical thinking/debate questions
- Connection to current events

**Example for Chapter 1**:
1. How does the four-dimension framework apply to current U.S.-China trade tensions?
2. Compare the effectiveness criteria for financial sanctions vs. export controls.
3. Should economic coercion be judged primarily on achieving stated objectives or on broader strategic outcomes?

#### Task 5.2: Teaching Notes
For each chapter:
- Key learning objectives (3-5 per chapter)
- Suggested readings (academic articles, policy papers)
- Recommended class activities
- Common student misconceptions to address

#### Task 5.3: Slide Decks
Create PowerPoint/Google Slides for each chapter:
- Key concepts (10-15 slides per chapter)
- Important figures from visualizations
- Discussion prompts
- Suggested activities

#### Task 5.4: Problem Sets/Exercises
Create applied exercises:
- Case study analysis assignments
- Data analysis exercises (using visualization data)
- Policy memo writing prompts
- Debate/simulation scenarios

**Deliverables**:
- Discussion questions document (50-70 questions total)
- Instructor's manual with teaching notes
- Slide deck (100-150 slides for full course)
- Problem set document (10-15 exercises)

---

## Recommended Session Sequence

### Session A (3-4 hours): Visualizations Foundation
1. Review VISUALIZATION_PLAN.md and prioritize figures ✓
2. Gather data for top 10 highest-priority figures ✓
3. Create first 5-7 visualizations ✓
4. Test visualization scripts and quality ✓

### Session B (3-4 hours): Visualizations Completion
1. Create remaining 10-15 priority visualizations ✓
2. Generate all figure files (PNG + PDF) ✓
3. Write figure captions ✓
4. Organize figures in `/figures` directory by chapter ✓

### Session C (2-3 hours): PDF Generation
1. Set up Pandoc/LaTeX environment ✓
2. Create custom template ✓
3. Test compile individual chapters ✓
4. Generate complete book PDF ✓

### Session D (2-3 hours): Front Matter and Structure
1. Write preface ✓
2. Generate TOC, glossary ✓
3. Create index ✓
4. Compile complete front/back matter ✓

### Session E (2-3 hours): Review and Polish
1. Consistency check ✓
2. Content review ✓
3. Fact-checking ✓
4. Final polish ✓

### Session F (Optional - 3-4 hours): Study Materials
1. Discussion questions ✓
2. Teaching notes ✓
3. Slide decks ✓
4. Problem sets ✓

---

## Quick Start Guide for Next Session

**If you have 2-3 hours**: Start with Priority 1 (Visualizations) - create top 10 figures

**If you have 3-4 hours**: Complete visualizations foundation (Session A)

**If you have 4-6 hours**: Complete visualizations + start PDF generation

**Recommended sequence**: Visualizations → PDF → Front Matter → Review → Study Materials

---

## Resources and Tools Needed

### Software/Libraries
- ✅ Python 3.x (already installed)
- ✅ matplotlib, seaborn, pandas (for visualizations)
- ✅ Pandoc (already on system)
- ⚠️ LaTeX distribution (check if installed, install if needed)
- Optional: Adobe Illustrator/Inkscape for manual figure editing

### Data Sources
- See each chapter's "Data Sources" section
- Key databases:
  - World Bank, IMF, BIS (economic data)
  - SIPRI (military spending, arms)
  - Rhodium Group, AEI (Chinese investment)
  - CSIS, CFR (policy analysis)
  - Official government sources (Treasury, Commerce, etc.)

### Reference Materials
- VISUALIZATION_PLAN.md (figure specifications)
- Each chapter's "References" section
- PROJECT_PLAN.md (original scope)

---

## Success Metrics

**Minimum Viable Product (MVP)**:
- ✅ 10 chapters complete (DONE!)
- ✅ All committed to GitHub (DONE!)
- ⬜ 20 core visualizations created
- ⬜ Complete book PDF generated
- ⬜ Basic front matter (TOC, preface)

**Full Professional Product**:
- ⬜ 40-50 visualizations (comprehensive coverage)
- ⬜ Polished PDF with professional formatting
- ⬜ Complete front/back matter (preface, TOC, glossary, index)
- ⬜ Reviewed and fact-checked content
- ⬜ Teaching materials (discussion questions, slides)

**Publication-Ready**:
- ⬜ All 70-80 visualizations
- ⬜ Professional copyediting
- ⬜ Complete instructor materials
- ⬜ Student workbook/problem sets
- ⬜ Online companion materials

---

## Notes

- Prioritize visualizations first - they have highest impact on book quality
- PDF generation is quick once template is set up
- Review/polish can be iterative (don't need to perfect everything at once)
- Study materials are valuable but lower priority than core textbook completion

**Remember**: You've already accomplished the hardest part - writing 134,000 words of comprehensive, high-quality content! The remaining tasks are production and polish.

---

*Plan created: 2025-11-19*
*Book status: 10/10 chapters complete, ready for finalization*
*Next milestone: Create first 20 visualizations*
