#!/bin/bash
# Claude Code hook — PostToolUse(Bash) sur gh pr merge
# Perimetre : nettoie les refs worktree stale apres chaque merge
# [CONFIGURER] : liste des repos du projet

TOOL_INPUT=$(cat)
COMMAND=$(echo "$TOOL_INPUT" | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" \
  2>/dev/null || echo "")
echo "$COMMAND" | grep -q 'gh pr merge' || exit 0

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# [CONFIGURER: liste des repos git du projet]
for REPO in \
  "$PROJECT_DIR/[REPO-1]" \
  "$PROJECT_DIR/[REPO-2]"; do
  [ -d "$REPO/.git" ] || continue
  PRUNED=$(git -C "$REPO" worktree prune -v 2>&1 || true)
  [ -n "$PRUNED" ] && echo "[hook][worktree] $REPO : $PRUNED"

  ACTIVE=$(git -C "$REPO" worktree list --porcelain 2>/dev/null \
    | grep '^worktree' | grep -v "^worktree $REPO$" || true)
  if [ -n "$ACTIVE" ]; then
    echo "[hook][worktree] RAPPEL — worktrees actifs dans $(basename "$REPO") :"
    echo "$ACTIVE" | sed 's/^worktree /  /'
    echo "[hook][worktree] Sequence : git worktree remove <path> [--force si Windows] → git worktree prune → git branch -d <branche>"
  fi
done

exit 0
