# Contributing Guidelines

## Development Workflow

### Branch Strategy

1. **main** - Stable, publication-ready content only
2. **develop** - Integration branch for completed chapter drafts
3. **chapter-XX** - Individual chapter development (e.g., `chapter-01`, `chapter-02`)

### Working on a Chapter

1. Create a branch from `develop`:
   ```bash
   git checkout develop
   git checkout -b chapter-01
   ```

2. Write your content in the appropriate chapter folder

3. Commit regularly with descriptive messages:
   ```bash
   git add chapters/ch01_foundations/
   git commit -m "Chapter 1: Add section on weaponized interdependence"
   ```

4. When chapter draft is complete, merge to `develop`:
   ```bash
   git checkout develop
   git merge chapter-01
   ```

5. When chapter is fully polished and reviewed, merge `develop` to `main`

### Commit Message Format

Use clear, descriptive commit messages:

- `Chapter X: Add [section name]`
- `Chapter X: Revise [topic] based on [source]`
- `Figures: Add [map/chart name] for Chapter X`
- `Exercise: Create tabletop scenario for Chapter X`
- `Data: Update [dataset] with [timeframe] data`
- `References: Add [number] sources to Chapter X bibliography`

### Examples:
```
Chapter 3: Add critical minerals section with USGS data
Chapter 7: Revise SWIFT section based on BIS 2024 report
Figures: Add maritime chokepoint map for Chapter 2
Exercise: Create CFIUS simulation for Chapter 8
```

## File Organization

### Chapter Files
- Use Markdown (.md) for all chapter content
- Name files descriptively: `01_introduction.md`, `02_main_content.md`, etc.
- Keep chapters in their designated folders

### Figures
- Maps: SVG or high-res PNG (min 300 DPI)
- Charts: Created from reproducible code when possible (Python/R)
- Diagrams: Vector format (SVG, PDF) preferred
- Name files: `ch02_maritime_chokepoints.svg`

### Data
- Document all data sources in `/data/sources/`
- Include collection date and URL
- Processed data should include processing scripts
- Never commit sensitive or proprietary data

### References
- Use BibTeX format for bibliography
- Organize by chapter if needed
- Include URLs for online sources
- Note access dates for web sources

## Writing Guidelines

### Voice and Tone
- Professional but accessible
- Active voice preferred
- Avoid jargon without explanation
- Define acronyms on first use in each chapter

### Perspective and Balance
- Present multiple viewpoints, especially Chinese perspectives
- Acknowledge uncertainty and contested issues
- Distinguish analysis from advocacy
- Use "the United States" or "Washington" rather than "we" for objectivity

### Citations
- Cite all factual claims that aren't common knowledge
- Use consistent citation format throughout
- Link to sources when available online
- Include page numbers for books

### Structure
- Follow the chapter template
- Use consistent heading hierarchy
- Keep sections focused and digestible
- Use bullet points for lists

## Quality Checks

Before merging to `develop`:
- [ ] Content is complete for the section/chapter
- [ ] All sources are cited
- [ ] Figures are high quality and properly referenced
- [ ] Perspective boxes include Chinese viewpoint
- [ ] Government Tools Boxes are accurate and complete
- [ ] Cross-references to other chapters are correct
- [ ] Spelling and grammar checked
- [ ] Consistent terminology throughout

## Questions?

Open an Issue for:
- Structural questions
- Content uncertainties
- Technical problems
- Suggested improvements
