#!/bin/bash
# Rofi Power Menu - JetBrains Mono Nerd Font Compatible

# Define menu options
OPTIONS="  Shutdown\n  Reboot\n  Lock\n  Logout\n⏾  Suspend"

# Show the menu using Rofi
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Power Menu" -theme-str 'window {width: 25%;}')

# Execute selected option
case "$CHOICE" in
"  Shutdown")
  systemctl poweroff
  ;;
"  Reboot")
  systemctl reboot
  ;;
"  Lock")
  if command -v swaylock &>/dev/null; then
    swaylock
  elif command -v loginctl &>/dev/null; then
    loginctl lock-session
  else
    echo "No lock command found!"
  fi
  ;;
"  Logout")
  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    loginctl terminate-session "$XDG_SESSION_ID"
  else
    pkill -KILL -u "$USER"
  fi
  ;;
"⏾  Suspend")
  systemctl suspend
  ;;
*)
  exit 0
  ;;
esac
