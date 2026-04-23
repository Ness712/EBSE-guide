#!/bin/bash
# Claude Code hook — PreToolUse(Bash) sur gh pr create
# Perimetre : verifie structure PR template + chemins critiques
# [CONFIGURER] : sections obligatoires du template PR du projet

TOOL_INPUT=$(cat)
COMMAND=$(echo "$TOOL_INPUT" | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" \
  2>/dev/null || echo "")

echo "$COMMAND" | grep -q 'gh pr create' || exit 0

# --- Sections obligatoires du PR template ---
# [CONFIGURER: adapter aux sections de votre .github/pull_request_template.md]
MISSING=""
# echo "$COMMAND" | grep -q "## Summary" || MISSING="$MISSING\n  - ## Summary"
# echo "$COMMAND" | grep -q "## Test plan" || MISSING="$MISSING\n  - ## Test plan"

if [ -n "$MISSING" ]; then
  printf "[hook] PR manque sections obligatoires :%b\n" "$MISSING" >&2
  exit 2
fi

# --- Taille PR — warning si > 400 LOC ---
LOC=$(git diff --stat "$(git merge-base HEAD main 2>/dev/null || echo HEAD~1)" HEAD 2>/dev/null \
  | tail -1 | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+' || echo 0)
DELETIONS=$(git diff --stat "$(git merge-base HEAD main 2>/dev/null || echo HEAD~1)" HEAD 2>/dev/null \
  | tail -1 | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+' || echo 0)
TOTAL_LOC=$((${LOC:-0} + ${DELETIONS:-0}))
if [ "$TOTAL_LOC" -gt 400 ]; then
  echo "[hook] ⚠️  PR SIZE : $TOTAL_LOC LOC (seuil : 400). Envisager de decouper en PRs atomiques." >&2
fi

echo "[hook] Structure PR OK"
exit 0
