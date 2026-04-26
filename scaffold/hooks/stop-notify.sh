#!/bin/bash
# Claude Code hook — Stop : notification fin de tour
# Perimetre : signale que Claude attend une reponse
# [CONFIGURER] : adapter la commande de notification a l'OS

# --- Refresh lock session parallele (touch = session toujours active) ---
_STOP_INPUT=$(cat)
_STOP_SID=$(echo "$_STOP_INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('session_id',''))" 2>/dev/null)
_STOP_CWD=$(echo "$_STOP_INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('cwd',''))" 2>/dev/null)
if [ -n "$_STOP_SID" ] && [ -n "$_STOP_CWD" ]; then
  _STOP_HASH=$(printf '%s' "$_STOP_CWD" | sha256sum 2>/dev/null | cut -c1-8 || echo "nohash")
  _STOP_LOCK="$HOME/.claude/active-sessions/${_STOP_HASH}-${_STOP_SID}.lock"
  [ -f "$_STOP_LOCK" ] && touch "$_STOP_LOCK"
fi

# Windows (PowerShell toast)
if command -v powershell.exe &>/dev/null; then
  powershell.exe -NonInteractive -NoProfile -Command "
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    \$n = New-Object System.Windows.Forms.NotifyIcon
    \$n.Icon = [System.Drawing.SystemIcons]::Information
    \$n.Visible = \$true
    \$n.ShowBalloonTip(10000, 'Claude Code', 'Tache terminee — en attente de ta reponse.', [System.Windows.Forms.ToolTipIcon]::Info)
    Start-Sleep 11
    \$n.Dispose()
  " 2>/dev/null &
  exit 0
fi

# macOS
if command -v osascript &>/dev/null; then
  osascript -e 'display notification "Tache terminee — en attente de ta reponse." with title "Claude Code"' 2>/dev/null &
  exit 0
fi

# Linux (notify-send)
if command -v notify-send &>/dev/null; then
  notify-send "Claude Code" "Tache terminee — en attente de ta reponse." 2>/dev/null &
  exit 0
fi

exit 0
