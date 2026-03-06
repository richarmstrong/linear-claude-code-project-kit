# Linear + Claude Code Project Kit

A portable project template for high-traceability software development using [Claude Code](https://claude.ai/code) and [Linear](https://linear.app).

## What you get

- **Every code change traces to a Linear issue** — no cowboy commits
- **Daily syncs** (`/daily-sync`) — structured review of your board: triage, stale items, blockers, top goal
- **User story intake** (`/new-item`) — guided issue creation that pushes for clear "as a / I want / so that"
- **Work-on-item flow** (`/work-on-item PROJ-123`) — fetch issue, plan or implement, PR, status updates
- **Conventional commits** and branch-per-ticket discipline
- **Sync logs** in `sync-log/` for session continuity

## Prerequisites

- [Claude Code CLI](https://claude.ai/code) installed
- [Linear](https://linear.app) workspace
- Linear MCP configured in Claude Code (see setup below)
- A Linear team with this status workflow:

  | Status | Type |
  |---|---|
  | Triage | backlog |
  | Backlog | backlog |
  | Ideation | backlog |
  | Icebox | backlog |
  | Under Consideration | unstarted |
  | In Progress | started |
  | In Review | started |
  | To Be Communicated | started |
  | Done | completed |
  | Canceled | canceled |
  | Duplicate | canceled |
  | Probably Not | canceled |

- An "Attention" label group with: Alignment Needed, Action Needed, Waiting/Blocked, On Track

## Setting up the Linear MCP (one-time)

The skills in this kit talk to Linear through the [Linear MCP server](https://linear.app/docs/mcp). This is a one-time setup at the user level — it works across all your projects.

```bash
# Add the Linear MCP server to Claude Code
claude mcp add --transport http linear --scope user https://api.linear.app/mcp
```

Then authenticate:

```bash
claude
# Inside Claude Code, run:
/mcp
# This opens a browser to authorize with your Linear account
```

Verify it's working:

```bash
claude mcp list
```

You should see `linear` listed. The OAuth token is stored in your system keychain — you won't need to re-authenticate unless the token expires.

## Quick start

```bash
# Clone the template
git clone https://github.com/richarmstrong/linear-claude-code-project-kit.git

# Set up a new project
./linear-claude-code-project-kit/setup.sh "MyProject" ~/code/my-project

# Start working
cd ~/code/my-project
claude
```

Then in Claude Code:
- `/daily-sync` — run your daily standup
- `/new-item add dark mode toggle` — create a well-scoped issue
- `/work-on-item PROJ-42` — pick up an issue and start building

## Applying to an existing project

If you already have a repo and just want to add the workflow:

```bash
./setup.sh "MyProject" ~/code/existing-project
```

This copies `CLAUDE.md`, `.claude/settings.json`, and `sync-log/` into the existing directory without overwriting other files. Edit `CLAUDE.md` to fill in your project-specific sections.

## Customizing

### Status UUIDs

The status UUIDs in `CLAUDE.md.template` and `.claude/settings.json` are specific to a Linear team. If you use a different team, update the UUIDs:

1. In Claude Code with the Linear MCP, run: `mcp__linear__list_issue_statuses` for your team
2. Replace the UUIDs in both files

### Team name

The template defaults to team `Yukta-athanor`. Find-and-replace if your team differs.

### Skills

The three skills in `.claude/settings.json` are plain-text prompts. Edit them to match your team's conventions, add people, or adjust the sync agenda.

## File structure

```
your-project/
  CLAUDE.md                 ← workflow rules + project description (edit this)
  .claude/
    settings.json           ← skill definitions (daily-sync, new-item, work-on-item)
  sync-log/
    .gitkeep                ← daily sync logs accumulate here
    2024-01-15.md
    2024-01-16.md
```

## Philosophy

> "Progress is fastest where correctness is legible and cheaply verifiable."

This kit enforces a deliberate pace: every change has a ticket, every session has a sync, every issue has a story. It slows you down just enough to make you methodical.
