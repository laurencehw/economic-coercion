# GitHub Setup Instructions

## Step 1: Create Repository on GitHub

1. Go to https://github.com/laurencehw
2. Click "New repository"
3. Repository name: `economic-coercion`
4. Description: "Textbook on economic coercion and strategic competition between states"
5. **Keep it Private initially** (or Public if you prefer)
6. **Do NOT initialize with README** (we already have one)
7. Click "Create repository"

## Step 2: Connect Local Repository to GitHub

Once you've created the repository on GitHub, run these commands from your local repository:

```bash
cd "G:\My Drive\book drafts\strategic economic policy\_50economic coercion"

# Add the remote repository
git remote add origin https://github.com/laurencehw/economic-coercion.git

# Verify the remote was added
git remote -v

# Push main branch
git checkout main
git push -u origin main

# Push develop branch
git checkout develop
git push -u origin develop
```

## Step 3: Set Default Branch (Optional)

On GitHub:
1. Go to repository Settings
2. Click "Branches" in left sidebar
3. Change default branch to `develop` (so PRs default to develop)

## Step 4: Protect Main Branch (Recommended)

On GitHub:
1. Go to Settings > Branches
2. Add branch protection rule for `main`
3. Enable:
   - Require pull request reviews before merging
   - Require status checks to pass
   - Include administrators (optional)

## Current Status

✓ Local repository initialized
✓ Folder structure created
✓ Initial files committed to main
✓ Develop branch created

⏳ Pending: Push to GitHub remote

## Authentication Note

If you haven't set up GitHub authentication, you'll need to:

**Option 1: Personal Access Token**
1. Go to GitHub Settings > Developer settings > Personal access tokens > Tokens (classic)
2. Generate new token with `repo` scope
3. Use token as password when pushing

**Option 2: SSH Key**
1. Generate SSH key: `ssh-keygen -t ed25519 -C "your_email@example.com"`
2. Add to SSH agent: `ssh-add ~/.ssh/id_ed25519`
3. Add public key to GitHub account
4. Use SSH URL instead: `git@github.com:laurencehw/economic-coercion.git`

---

After completing these steps, you'll be able to push changes to GitHub with:
```bash
git push origin develop
```
