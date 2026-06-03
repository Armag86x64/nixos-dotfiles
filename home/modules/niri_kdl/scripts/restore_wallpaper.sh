#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.cache/current_wallpaper"

if [ ! -f "$STATE_FILE" ]; then
    echo "0" > "$STATE_FILE"
fi

current_index=$(cat "$STATE_FILE")
mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" \) | sort)

if [ ${#wallpapers[@]} -gt 0 ] && [ "$current_index" -lt "${#wallpapers[@]}" ]; then
    wallpaper="${wallpapers[$current_index]}"
    swww img "$wallpaper" --transition-type none
fi
