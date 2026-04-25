#!/bin/bash
# Claude Code hook — UserPromptSubmit
# Perimetre : valide et enrichit le prompt utilisateur avant traitement
# Declencheur : a chaque message envoye par l'utilisateur
#
# Source : PICOC ai-agent-extended-hook-lifecycle GRADE 3 RECOMMANDE
#          PICOC ai-agent-prompt-injection-defense GRADE 4 RECOMMANDE
#          docs.anthropic.com/en/docs/claude-code/hooks#userpromptsubmit
#
# Usages typiques :
# 1. Detection de prompt injection (patterns suspects dans l'input)
# 2. Injection de contexte session automatique (date, branch, etc.)
# 3. Validation que le prompt correspond au scope autorise
#
# Format stdin : JSON {"prompt": "...", "session_id": "..."}
# exit code 2 = bloque le prompt + affiche stderr a l'utilisateur
# exit code 0 = laisse passer

TOOL_INPUT=$(cat)
PROMPT=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('tool_input', {}).get('prompt', ''))
except:
    print('')
" 2>/dev/null || echo "")

# --- Detection prompt injection ---
# Patterns d'injection connus (adapter selon le contexte du projet)
# Source: PICOC ai-agent-prompt-injection-defense (Lupinacci 2025, AgentPoison NeurIPS 2024)
INJECTION_PATTERNS=(
  "ignore previous instructions"
  "ignore all previous"
  "disregard your instructions"
  "you are now"
  "new persona"
  "forget everything"
  "system prompt"
  "<script>"
  "javascript:"
)

PROMPT_LOWER=$(echo "$PROMPT" | tr '[:upper:]' '[:lower:]')
for pattern in "${INJECTION_PATTERNS[@]}"; do
  if echo "$PROMPT_LOWER" | grep -qi "$pattern"; then
    echo "[hook][SECURITE] Prompt potentiellement suspect detecte : pattern '$pattern'" >&2
    echo "[hook] Prompt original conserve — verifier manuellement si legitime." >&2
    # Ne pas bloquer par defaut (exit 2) — alerter seulement
    # Activer exit 2 si besoin de blocage strict :
    # exit 2
  fi
done

# --- Log dans audit trail ---
AUDIT_LOG="$(dirname "$0")/../audit.log"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
PROMPT_EXCERPT=$(echo "$PROMPT" | head -c 100 | tr '\n' ' ')
echo -e "${TIMESTAMP}\tUserPromptSubmit\t${PROMPT_EXCERPT}" >> "$AUDIT_LOG" 2>/dev/null || true

# --- [CONFIGURER: enrichissement automatique optionnel] ---
# Injecter la date courante, la branche git, etc. dans le contexte
# (Claude Code injecte ces infos via ce hook si exit 0 avec output)
# echo "Contexte session : $(date -u +%Y-%m-%d), branch: $(git branch --show-current 2>/dev/null || echo 'unknown')"

exit 0
