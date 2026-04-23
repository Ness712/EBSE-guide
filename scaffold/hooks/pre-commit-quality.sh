#!/bin/bash
# Claude Code hook — PreToolUse(Bash) sur git commit
# Perimetre : verifications SPECIFIQUES A L'AGENT uniquement
# Les quality gates universelles (lint, typecheck, conventions) → git hooks reels (.husky/pre-commit)
# Regle de decision : conserver ici seulement ce qui satisfait (a) ou (b) du scaffold

set -euo pipefail
TOOL_INPUT=$(cat)

echo "$TOOL_INPUT" | grep -qE 'git\b.*\bcommit\b' || exit 0

COMMAND=$(echo "$TOOL_INPUT" | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" \
  2>/dev/null || echo "")

# ============================================================
# (a) Co-Authored-By obligatoire — audit trail agent (MANDATORY)
# Specifique a l'agent : seul l'agent est tenu d'ajouter cette attribution
# ============================================================
if echo "$COMMAND" | grep -qE 'git\b.*\bcommit\b'; then
  if ! echo "$COMMAND" | grep -q 'Co-Authored-By'; then
    echo "[hook][GATE] MANDATORY — Co-Authored-By manquant dans le commit." >&2
    echo "[hook] Ajouter : Co-Authored-By: Claude <model> <noreply@anthropic.com>" >&2
    exit 2
  fi
fi

# ============================================================
# (a) .claude/settings.json en lecture seule — protection config agent (STRIDE EoP)
# Specifique a l'agent : empeche l'agent de modifier sa propre config
# ============================================================
REPO_PATH=$(python3 - "$COMMAND" <<'PYEOF'
import sys, re, os
cmd = sys.argv[1]
def to_os_path(p):
    m = re.match(r'^/([a-zA-Z])/(.*)', p)
    if m: return m.group(1).upper() + ':/' + m.group(2)
    return p
for m in re.finditer(r'cd\s+"?([^";&\s]+)"?', cmd):
    p = to_os_path(m.group(1))
    if any(os.path.isfile(os.path.join(p, f)) for f in ('package.json', 'pom.xml', 'go.mod', 'Cargo.toml')):
        print(p); sys.exit(0)
for m in re.finditer(r'git\s+-C\s+"?([^";&\s]+)"?', cmd):
    p = to_os_path(m.group(1))
    if os.path.isdir(p): print(p); sys.exit(0)
PYEOF
)
[ -z "$REPO_PATH" ] && REPO_PATH="${CLAUDE_PROJECT_DIR:-$(pwd)}"

if [ -n "$REPO_PATH" ] && [ -d "$REPO_PATH" ]; then
  SETTINGS_STAGED=$(git -C "$REPO_PATH" diff --cached --name-only 2>/dev/null \
    | grep '\.claude/settings\.json' || true)
  if [ -n "$SETTINGS_STAGED" ]; then
    echo "[hook][GATE] MANDATORY — .claude/settings.json ne peut etre modifie que manuellement par le PO." >&2
    exit 2
  fi
fi

exit 0
