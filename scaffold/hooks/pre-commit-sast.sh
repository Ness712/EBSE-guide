#!/bin/bash
# Claude Code hook — PreToolUse(Bash) sur git commit
# Perimetre : SAST OWASP Top 10 via Semgrep avant commit
#
# Source : PICOC ai-agent-sast-integration GRADE 3 RECOMMANDE
#          DIMVA 2024 N=300 86% precision + semgrep.dev
#          docs.anthropic.com/en/docs/claude-code/hooks

TOOL_INPUT=$(cat)
COMMAND=$(echo "$TOOL_INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null || echo "")
echo "$COMMAND" | grep -qE 'git\b.*\bcommit\b' || exit 0

# Semgrep : SAST OWASP Top 10 — < 20s, 150MB RAM, offline capable
# Installation : pip install semgrep
if command -v semgrep &>/dev/null; then
  STAGED=$(git diff --cached --name-only --diff-filter=ACM 2>/dev/null | grep -E '\.(ts|js|tsx|jsx|py|java|go)$' | head -20)
  if [ -n "$STAGED" ]; then
    if ! echo "$STAGED" | xargs semgrep --config p/owasp-top-ten --error --quiet 2>/dev/null; then
      echo "[hook][SAST] Semgrep OWASP Top 10 : vulnerabilite detectee — voir details ci-dessus." >&2
      echo "[hook] Pour ignorer (justification obligatoire) : # nosemgrep: <rule-id> -- <raison>" >&2
      exit 2
    fi
  fi
else
  echo "[hook][WARN] Semgrep non installe — SAST ignore. Installer : pip install semgrep" >&2
fi
exit 0
