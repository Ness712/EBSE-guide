#!/bin/bash
# Claude Code hook — SessionEnd : nettoyage lock session parallele
# Supprime le lock de cette session immediatement a la fermeture / /clear
# Filet de securite : le timeout 30 min du SessionStart gere les crashs

INPUT=$(cat)
SID=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('session_id',''))" 2>/dev/null)
SCWD=$(echo "$INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('cwd',''))" 2>/dev/null)

[ -z "$SID" ] && exit 0
[ -z "$SCWD" ] && exit 0

CWDHASH=$(printf '%s' "$SCWD" | sha256sum 2>/dev/null | cut -c1-8 || echo "nohash")
rm -f "$HOME/.claude/active-sessions/${CWDHASH}-${SID}.lock"
