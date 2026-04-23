#!/bin/bash
# Claude Code hook — PostToolUse(Edit) lint rapide intra-session
# Perimetre : feedback immediat apres chaque Edit — soft gate (exit 0 toujours)
# Justification regle (b) : feedback intra-session avant git, pas d'equivalent git hook
# [CONFIGURER] : chemin filtre + commande lint

TOOL_INPUT=$(cat)
FILE=$(echo "$TOOL_INPUT" | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" \
  2>/dev/null || true)

# [CONFIGURER: filtrer sur les chemins sources du projet]
# Ex: echo "$FILE" | grep -q 'mon-projet/src' || exit 0
echo "$FILE" | grep -q '[CONFIGURER-PATH]/src' || exit 0

# [CONFIGURER: commande lint par stack]
# Node.js  : REPO_DIR=$(echo "$FILE" | sed 's|/src/.*||'); (cd "$REPO_DIR" && pnpm lint --quiet 2>&1 | head -20) || echo "[hook] lint errors detected"
# Maven    : (mvn checkstyle:check -q 2>&1 | tail -10) || echo "[hook] checkstyle errors"

echo "[hook] lint (post-edit) — [CONFIGURER]"
exit 0
