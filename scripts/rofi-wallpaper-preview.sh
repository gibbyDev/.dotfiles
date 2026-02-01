#!/usr/bin/env bash

# Rofi preview using chafa
# $1 is the file path of the wallpaper
if [[ -f "$1" ]]; then
    chafa "$1" --fill=block --symbols=block --size=30x15
fi

