#!/bin/bash
# Claude Code hook — SessionStart
# Perimetre : charge l'environnement + health check monitoring au demarrage de session
# [CONFIGURER] : fichier env du projet, endpoints monitoring

AUDIT_LOG="$(dirname "$0")/../audit.log"
ISSUES=()

# [CONFIGURER: chemin vers le fichier env du projet contenant les tokens]
# ENV_FILE="$HOME/.[MON-PROJET].env"
# if [ -f "$ENV_FILE" ]; then
#   while IFS= read -r line; do
#     [[ "$line" =~ ^export\ [A-Z_]+=.+ ]] && echo "$line" >> "$CLAUDE_ENV_FILE"
#   done < "$ENV_FILE"
#   source "$ENV_FILE" 2>/dev/null
#   echo "[hook] Tokens charges depuis $ENV_FILE"
# fi

# --- Health check hooks (ADVISORY) ---
HOOKS_DIR="$(dirname "$0")"
for _hook_file in "$HOOKS_DIR"/*.sh; do
  [ -f "$_hook_file" ] || continue
  [ -x "$_hook_file" ] || ISSUES+=("hook non-executable: $(basename "$_hook_file")")
  bash -n "$_hook_file" 2>/dev/null || ISSUES+=("hook syntax-error: $(basename "$_hook_file")")
done

# [CONFIGURER: health checks monitoring (GlitchTip, SonarQube, Grafana, etc.)]
# Exemple pattern curl :
# _HTTP_CODE=$(curl -s --max-time 8 -H "Authorization: Bearer $MON_TOKEN" \
#   -o /tmp/_curl_body -w "%{http_code}" "https://mon-service/api/health")
# STATUS=$(cat /tmp/_curl_body | python3 -c "import sys,json; print(json.load(sys.stdin).get('status','?'))" 2>/dev/null || echo "?")
# [ "$STATUS" != "ok" ] && ISSUES+=("mon-service: $STATUS")
# echo "[mon-service] $STATUS"

# --- Rapport alertes ---
if [ ${#ISSUES[@]} -gt 0 ]; then
  ISSUES_STR=$(printf " | %s" "${ISSUES[@]}"); ISSUES_STR="${ISSUES_STR:3}"
  TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  echo "⚠️  ALERTES : $ISSUES_STR"
  echo "=== HEALTH CHECK $TIMESTAMP ===" >> "$AUDIT_LOG"
  for issue in "${ISSUES[@]}"; do echo "⚠️  $issue" >> "$AUDIT_LOG"; done
else
  echo "[hook] SessionStart OK"
fi
