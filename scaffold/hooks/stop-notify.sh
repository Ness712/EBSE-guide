#!/bin/bash
# Claude Code hook — Stop : notification fin de tour
# Perimetre : signale que Claude attend une reponse
# [CONFIGURER] : adapter la commande de notification a l'OS

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
