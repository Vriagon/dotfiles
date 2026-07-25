#!/usr/bin/env bash
CAP=$(cat /sys/class/power_supply/BAT*/capacity | head -n 1)
STATUS=$(cat /sys/class/power_supply/BAT*/status | head -n 1)
CACHE=/tmp/bat_notify
LAST=$(cat $CACHE 2>/dev/null || echo 100)

if [ "$STATUS" = "Discharging" ]; then
    if [ "$CAP" -le 15 ] && [ "$LAST" -gt 15 ]; then
        notify-send -u critical "⚠️ Critical Battery" "Battery at ${CAP}%"
    fi
    if [ "$CAP" -le 30 ] && [ "$LAST" -gt 30 ]; then
        notify-send "Low Battery" "Battery at ${CAP}%"
    fi
    echo "$CAP" > "$CACHE"
else
    echo 100 > "$CACHE"
fi
