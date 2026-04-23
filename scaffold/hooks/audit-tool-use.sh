#!/bin/bash
# Claude Code hook — PostToolUse(*) audit trail
# Perimetre : log de tous les appels outils agent (PICOC #20 accountability)
# Universel — aucune configuration projet requise

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
AUDIT_LOG="$SCRIPT_DIR/../audit.log"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

INPUT=$(cat)

ENTRY=$(printf '%s' "$INPUT" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    tool = d.get('tool_name', 'unknown')
    inp  = d.get('tool_input', {})
    if 'command' in inp:
        params = str(inp['command'])[:200]
    elif 'file_path' in inp:
        params = str(inp.get('file_path', ''))[:200]
    elif 'pattern' in inp:
        params = str(inp.get('pattern', ''))[:200]
    elif 'query' in inp:
        params = str(inp.get('query', ''))[:200]
    elif 'url' in inp:
        params = str(inp.get('url', ''))[:200]
    else:
        keys = list(inp.keys())[:3]
        params = str({k: str(inp[k])[:50] for k in keys})[:200]
    print(f'{tool}\t{params}')
except Exception as e:
    print(f'unknown\t(parse error: {e})')
" 2>/dev/null || echo "unknown\t(unavailable)")

echo -e "${TIMESTAMP}\t${ENTRY}" >> "$AUDIT_LOG" 2>/dev/null || true
exit 0
