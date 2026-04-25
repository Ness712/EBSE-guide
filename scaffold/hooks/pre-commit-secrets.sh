#!/bin/bash
# Claude Code hook — PreToolUse(Bash) sur git commit
# Perimetre : detection de secrets via TruffleHog avant commit
#
# Source : PICOC ai-agent-secret-detection-hooks GRADE 3 RECOMMANDE
#          OWASP DevSecOps Guideline + trufflesecurity.com 700+ detectors
#          docs.anthropic.com/en/docs/claude-code/hooks

TOOL_INPUT=$(cat)
COMMAND=$(echo "$TOOL_INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null || echo "")
echo "$COMMAND" | grep -qE 'git\b.*\bcommit\b' || exit 0

# TruffleHog : detection secrets avec verification API active (elimine les faux positifs)
# Installation : brew install trufflesecurity/trufflehog/trufflehog
if command -v trufflehog &>/dev/null; then
  if ! trufflehog git file://. --results=verified --no-update --fail --quiet 2>/dev/null; then
    echo "[hook][SECURITE] Secret verifie detecte par TruffleHog — commit bloque." >&2
    echo "[hook] Supprimer le secret + rotation immediate si deja pousse." >&2
    exit 2
  fi
else
  echo "[hook][WARN] TruffleHog non installe — scan secrets ignore. Installer : brew install trufflesecurity/trufflehog/trufflehog" >&2
fi
exit 0
