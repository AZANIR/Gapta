---
name: conventional-commits
description: Manage git branches and create Conventional Commits for the Gapta project. Use this skill when committing changes, creating branches, preparing PRs, or when the user says "commit", "create branch", "prepare PR", or "push changes".
---

# Conventional Commits for Gapta

You manage git workflow for the **Gapta** project (gapta.com.ua). All work happens on feature branches; commits follow [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

## Step 1: Check Current State

Before any git operation, always run:

```bash
git branch --show-current
git status
```

**If on `main`:**
1. STOP — do not commit to main
2. Ask the user what type of work they're doing
3. Create an appropriate branch (see Branch Types below)
4. Then proceed with the commit

**If on a feature branch:** proceed normally.

## Step 2: Determine Branch Type

| Work type | Branch pattern | Example |
|---|---|---|
| New article | `article/{slug}` | `article/vybir-nythky-polotna` |
| New feature / functionality | `feat/{description}` | `feat/add-dark-mode` |
| Bug fix | `fix/{description}` | `fix/broken-og-image` |
| Design / CSS / UI changes | `style/{description}` | `style/card-hover-effects` |
| Documentation | `docs/{description}` | `docs/update-readme` |
| Refactoring | `refactor/{description}` | `refactor/layout-components` |
| CI/CD changes | `ci/{description}` | `ci/optimize-deploy-cache` |

Create branch from latest main:

```bash
git checkout main
git pull origin main
git checkout -b {type}/{description}
```

## Step 3: Stage Changes

Review what changed:

```bash
git status
git diff
git diff --staged
```

Stage only relevant files. Do NOT stage:
- `.env` or files with secrets
- `node_modules/`
- `.cursor/` internal files (unless explicitly skills/rules/docs)
- Generated build output (`dist/`)

```bash
git add <specific files or paths>
```

## Step 4: Write Commit Message

### Format

```
<type>(<scope>): <description>
```

### Available Types

| Type | Purpose |
|---|---|
| `feat` | New feature or new article |
| `fix` | Bug fix |
| `docs` | Documentation changes |
| `style` | CSS, design, formatting (no logic) |
| `refactor` | Code restructuring |
| `perf` | Performance improvement |
| `test` | Tests |
| `ci` | CI/CD (deploy.yml, GitHub Actions) |
| `chore` | Maintenance, deps, config |
| `content` | Article content edits (not new articles) |

### Available Scopes (optional, in parentheses)

`article`, `ui`, `layout`, `seo`, `config`, `deps`, `skill`, `rule`

### Commit Message Rules

1. First line: `type(scope): description` — max 72 characters
2. Description starts with **lowercase imperative verb**: add, fix, update, remove, refactor, improve, create, delete, move, rename
3. No period at the end
4. If more context needed, add a blank line then a body explaining **why**
5. Use `BREAKING CHANGE:` footer when applicable

### Examples by Scenario

**New article:**
```
feat(article): add Playwright visual testing guide
```

**Fix a component bug:**
```
fix(ui): prevent card image overflow on mobile
```

**Update styling:**
```
style(layout): adjust footer spacing and link colors
```

**Add a new skill:**
```
feat(skill): add conventional-commits workflow skill
```

**Update dependencies:**
```
chore(deps): update astro to 5.4.2
```

**Edit existing article content:**
```
content(article): fix code examples in OWASP guide
```

**Commit with body (complex change):**
```
refactor(ui): extract article card into standalone component

ArticleCard was duplicated across 3 pages with slight variations.
Consolidated into a single component with props for layout variants.
```

## Step 5: Commit

Use HEREDOC to preserve formatting:

```bash
git commit -m "$(cat <<'EOF'
type(scope): description

Optional body here.

EOF
)"
```

## Step 6: Push and create PR

```bash
git push -u origin HEAD
```

**Always create the PR** after pushing — do not stop at push. For article and content work this is part of the standard flow.

- **Preferred:** use GitHub MCP `create_pull_request`: owner `AZANIR`, repo **`Gapta`**, `head` = current branch, `base` = **`main`**, title = same as commit, body = short summary of changes.
- **Fallback:** `gh pr create --title "type(scope): description" --body "Summary of changes"`

PR title must match the conventional commit format.

## Decision Tree

```
User wants to commit
    ↓
On main? → YES → Create branch first → Then commit
    ↓ NO
Check git status → Stage relevant files
    ↓
Determine type (feat/fix/style/docs/refactor/content/...)
    ↓
Determine scope (article/ui/layout/seo/config/...)
    ↓
Write commit message (lowercase verb, max 72 chars)
    ↓
Commit → Push → Create PR (do not skip PR)
```

## What NOT to Do

- Never commit directly to `main`
- Never use generic messages like "update files" or "fix stuff"
- Never commit `.env`, secrets, or `node_modules`
- Never force-push to `main`
- Never skip the type prefix
- Never capitalize the description (after the colon)
