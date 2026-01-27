#!/usr/bin/env sh

if pgrep -f waybar >/dev/null; then
    pkill -f waybar
else
    waybar &
fi

