#!/bin/bash
# Claude Code hook — SubagentStart
# Perimetre : injecte du contexte dans un sous-agent au moment de son demarrage
# Declencheur : quand l'agent principal spawne un sous-agent via Agent()
#
# Source : PICOC ai-agent-extended-hook-lifecycle GRADE 3 RECOMMANDE
#          PICOC ai-agent-intermediate-task-delegation GRADE 3 RECOMMANDE
#          docs.anthropic.com/en/docs/claude-code/hooks#subagentstart
#
# Pourquoi : les sous-agents demarrent avec un contexte VIERGE.
# Ce hook compense en injectant : session ID, repo courant, regles minimales.
# Ne pas dupliquer ce qui est dans le prompt du sous-agent — complementaire uniquement.
#
# Format stdin : JSON {"subagent_type": "...", "prompt": "..."}

TOOL_INPUT=$(cat)
SUBAGENT_TYPE=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('tool_input', {}).get('subagent_type', 'unknown'))
except:
    print('unknown')
" 2>/dev/null || echo "unknown")

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "[subagent-start] $TIMESTAMP — type: $SUBAGENT_TYPE"
echo "[subagent-start] Session: ${CLAUDE_SESSION_ID:-unknown}"
echo "[subagent-start] Repo: $(basename ${CLAUDE_PROJECT_DIR:-$(pwd)})"

# [CONFIGURER: injecter contexte projet si necessaire]
# Ex: charger des variables d'environnement pour le sous-agent
# if [ -f "$HOME/.[mon-projet].env" ]; then
#   while IFS= read -r line; do
#     [[ "$line" =~ ^export\ [A-Z_]+=.+ ]] && echo "$line" >> "$CLAUDE_ENV_FILE"
#   done < "$HOME/.[mon-projet].env"
# fi

# Log dans audit trail (PICOC #20 accountability)
AUDIT_LOG="$(dirname "$0")/../audit.log"
echo -e "${TIMESTAMP}\tSubagentStart\ttype=${SUBAGENT_TYPE}" >> "$AUDIT_LOG" 2>/dev/null || true

exit 0
