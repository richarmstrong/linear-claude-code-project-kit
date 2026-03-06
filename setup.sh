#!/usr/bin/env bash
set -euo pipefail

# Usage: ./setup.sh "MyProject" [target-dir]
#
# Creates a new project directory with CLAUDE.md, .claude/settings.json,
# and sync-log/ pre-configured for your Linear + Claude Code workflow.
#
# If target-dir is omitted, creates ./MyProject (lowercased, hyphenated).

if [ $# -lt 1 ]; then
  echo "Usage: ./setup.sh \"Project Name\" [target-directory]"
  echo ""
  echo "Example: ./setup.sh \"TakeHome\" ~/code/takehome"
  exit 1
fi

PROJECT="$1"
DEFAULT_DIR=$(echo "$PROJECT" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
TARGET="${2:-$DEFAULT_DIR}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -d "$TARGET" ]; then
  echo "Directory $TARGET already exists."
  echo "Applying template files into existing directory..."
else
  mkdir -p "$TARGET"
  echo "Created $TARGET"
fi

# Copy template files
mkdir -p "$TARGET/.claude"
mkdir -p "$TARGET/sync-log"

# CLAUDE.md — substitute project name
sed "s/{{PROJECT}}/$PROJECT/g" "$SCRIPT_DIR/CLAUDE.md.template" > "$TARGET/CLAUDE.md"

# .claude/settings.json — substitute project name
sed "s/{{PROJECT}}/$PROJECT/g" "$SCRIPT_DIR/.claude/settings.json" > "$TARGET/.claude/settings.json"

# sync-log gitkeep
touch "$TARGET/sync-log/.gitkeep"

# Initialize git if not already a repo
if [ ! -d "$TARGET/.git" ]; then
  cd "$TARGET"
  git init
  git add .
  git commit -m "chore: initialize project with Linear + Claude Code workflow"
  echo ""
  echo "Git repo initialized with initial commit."
fi

echo ""
echo "Done! Project '$PROJECT' is ready at $TARGET"
echo ""
echo "What's included:"
echo "  CLAUDE.md              — workflow rules, Linear integration, placeholders for your project"
echo "  .claude/settings.json  — /daily-sync, /new-item, /work-on-item skills"
echo "  sync-log/              — daily sync logs go here"
echo ""
echo "Next steps:"
echo "  1. cd $TARGET"
echo "  2. Edit CLAUDE.md — fill in the project description, commands, and architecture"
echo "  3. Create a Linear project named '$PROJECT' in team Yukta-athanor"
echo "  4. Start working: claude and use /new-item, /daily-sync, /work-on-item"
