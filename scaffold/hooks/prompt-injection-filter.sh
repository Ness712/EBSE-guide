#!/bin/bash
# Claude Code hook — PreToolUse(Bash) filtre prompt injection
# Perimetre : detection patterns jailbreak/injection avant execution (KAOS G23, STRIDE EoP)
# Universel — aucune configuration projet requise

TOOL_INPUT=$(cat)
COMMAND=$(echo "$TOOL_INPUT" | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" \
  2>/dev/null || echo "")

[ -z "$COMMAND" ] && exit 0

INJECTION_FOUND=""

echo "$COMMAND" | grep -qiE '\[SYSTEM\]|\[INST\]|<\|im_start\||<\|system\||SYSTEM_PROMPT' \
  && INJECTION_FOUND="$INJECTION_FOUND [SYSTEM-override]"

echo "$COMMAND" | grep -qiE 'ignore (all )?(previous|prior|above) (instructions|rules|constraints)' \
  && INJECTION_FOUND="$INJECTION_FOUND [jailbreak-ignore-instructions]"

echo "$COMMAND" | grep -qiE 'you are now|pretend (you are|to be)|act as (an? )?(unrestricted|evil|malicious|DAN)' \
  && INJECTION_FOUND="$INJECTION_FOUND [jailbreak-persona-override]"

echo "$COMMAND" | grep -qE 'eval.*curl|eval.*wget|bash.*<\(curl|bash.*<\(wget' \
  && INJECTION_FOUND="$INJECTION_FOUND [suspicious-remote-exec]"

echo "$COMMAND" | grep -qE '\.claude/hooks/|\.claude/settings\.json' \
  && echo "$COMMAND" | grep -qE '(cat >|tee |echo.*>|sed -i|write to)' \
  && INJECTION_FOUND="$INJECTION_FOUND [hook-tampering]"

if [ -n "$INJECTION_FOUND" ]; then
  echo "[hook][SECURITY] Pattern injection detecte :$INJECTION_FOUND" >&2
  echo "[hook][SECURITY] Commande : ${COMMAND:0:200}" >&2
  if echo "$INJECTION_FOUND" | grep -q 'hook-tampering'; then
    echo "[hook][GATE] MANDATORY — Tentative de modification des hooks detectee. Gate PO requise." >&2
    exit 2
  fi
fi

exit 0
