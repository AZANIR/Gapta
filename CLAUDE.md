# Gapta — Claude Code context

## Project Memory System

Institutional knowledge lives in **`docs/project_notes/`** (tracked in git). Check and update these files across sessions.

### Files

- **bugs.md** — bugs, root cause, fix, prevention
- **decisions.md** — ADRs (context, decision, alternatives, consequences)
- **key_facts.md** — URLs, branches, ports, stack (no secrets)
- **issues.md** — short work log with PR/issue links

### Protocols

**Before architectural changes:** read `decisions.md`; do not contradict ADRs without explicit discussion.

**When debugging:** search `bugs.md` for similar errors; document new fixes when resolved.

**Configuration:** prefer `key_facts.md` over guessing (branches, deploy paths, domains).

**After meaningful work:** add a line to `issues.md`; update `decisions.md` / `bugs.md` / `key_facts.md` when relevant.

### Style

- Bullet lists, dated entries, 1–3 lines per point; include links to PRs/issues.

Full product context and toolchain: **AGENTS.md** (Ukrainian).
