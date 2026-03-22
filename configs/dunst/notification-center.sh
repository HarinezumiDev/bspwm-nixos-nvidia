#!/usr/bin/env bash

if ! command -v dunstctl &> /dev/null; then
    rofi -e "dunstctl not found"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    rofi -e "jq not found"
    exit 1
fi

history=$(dunstctl history 2>&1)

if echo "$history" | grep -q "No notifications"; then
    rofi -e "No notification history"
    exit 0
fi

parsed=$(echo "$history" | jq -r '.data[0][] | .summary.data' 2>/dev/null)

if [ -z "$parsed" ]; then
    rofi -e "No notifications in history"
    exit 1
fi

options="Clear All
$parsed"

selection=$(echo "$options" | rofi -dmenu -i -p "notifications" -config ~/.config/rofi/config.rasi -theme-str 'window { width: 600px; } listview { lines: 13; }')

if [ "$selection" = "Clear All" ]; then
    dunstctl history-clear
    rofi -e "Notification history cleared"
elif [ -n "$selection" ]; then
    index=$(echo "$parsed" | grep -n "^$selection$" | cut -d: -f1)
    index=$((index - 1))
    dunstctl history-pop $index
fi
