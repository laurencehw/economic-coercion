# Git Quick Reference

## Daily Workflow

### Starting work on a new chapter
```bash
cd "G:\My Drive\book drafts\strategic economic policy\_50economic coercion"
git checkout develop
git checkout -b chapter-01  # or chapter-02, etc.
```

### Committing your work
```bash
git add chapters/ch01_foundations/
git commit -m "Chapter 1: Add weaponized interdependence section"
git push origin chapter-01
```

### Finishing a chapter
```bash
git checkout develop
git merge chapter-01
git push origin develop
git branch -d chapter-01  # Delete local branch after merge
```

### Checking status
```bash
git status              # See what's changed
git log --oneline -5    # See recent commits
git branch              # See all branches
```

## Current Status

✅ Repository initialized
✅ Main branch created with initial commit
✅ Develop branch created
✅ Folder structure in place
⏳ Need to push to GitHub (see SETUP_GITHUB.md)

## Branch Structure

- **master** (main) - Stable, publication-ready
- **develop** - Integration branch (currently active)
- **chapter-XX** - Individual chapter work (create as needed)

## Next Steps

1. Follow instructions in SETUP_GITHUB.md to connect to GitHub
2. Start working on templates in develop branch
3. When ready to write Chapter 1, create chapter-01 branch
