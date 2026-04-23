#!/bin/bash
# Claude Code hook — PreToolUse(Write) gate secrets/PII avant ecriture
# Perimetre : intercepte Write() AVANT que le fichier soit ecrit sur disque
# Complementaire au git hook pre-commit : couvre les fichiers ecrits mais pas encore stages
# Universel — aucune configuration projet requise

set -euo pipefail

TOOL_INPUT=$(cat)
FILE=$(echo "$TOOL_INPUT" | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" \
  2>/dev/null || true)
CONTENT=$(echo "$TOOL_INPUT" | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('content',''))" \
  2>/dev/null || true)

[ -z "$CONTENT" ] && exit 0

# Exclure fichiers d'audit, examples et docs
echo "$FILE" | grep -qE '(audit\.log|\.env\.example|CLAUDE\.md|scaffold-claude\.md|compliance-matrix|decisions/)' && exit 0

# --- Gate secrets (patterns haute confiance) ---
SECRETS=$(echo "$CONTENT" | grep -inE \
  '(password|passwd|api_key|apikey|secret_key|secret|access_token|auth_token|bearer|private_key|client_secret)\s*[=:]\s*["'"'"'][^"'"'"']{8,}' \
  2>/dev/null || true)
if [ -n "$SECRETS" ]; then
  echo "[hook][GATE] MANDATORY — Secret potentiel detecte dans Write($FILE)" >&2
  echo "[hook] Pattern : $(echo "$SECRETS" | head -3)" >&2
  echo "[hook] Utiliser des variables d'environnement, jamais de valeurs en dur." >&2
  exit 2
fi

# --- Gate PII (email, telephone FR) ---
PII=$(echo "$CONTENT" | grep -inE \
  '([a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}|(\+33|0033|0)[1-9][0-9]{8})' \
  2>/dev/null || true)
if [ -n "$PII" ]; then
  REAL_PII=$(echo "$PII" | grep -ivE '(example|test|foo|bar|user@|admin@|noreply|your-email|xxx|placeholder)' || true)
  if [ -n "$REAL_PII" ]; then
    echo "[hook][GATE] MANDATORY — PII potentielle detectee dans Write($FILE)" >&2
    echo "[hook] Pattern : $(echo "$REAL_PII" | head -2)" >&2
    echo "[hook] Gate PO requise avant ecriture de donnees personnelles." >&2
    exit 2
  fi
fi

exit 0
