#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.cache/current_wallpaper"

# Создаём массив из всех изображений в папке (поддерживаемые форматы)
mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" \) | sort)

if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "Ошибок: Нет обоев в $WALLPAPER_DIR"
    exit 1
fi

# Читаем индекс текущих обоев
if [ -f "$STATE_FILE" ]; then
    current_index=$(cat "$STATE_FILE")
else
    current_index=0
fi

# Вычисляем следующий индекс
next_index=$(( (current_index + 1) % ${#wallpapers[@]} ))
next_wallpaper="${wallpapers[$next_index]}"

# Меняем обои через swww
swww img "$next_wallpaper" --transition-type any --transition-duration 1

# Сохраняем новый индекс
echo "$next_index" > "$STATE_FILE"

# Опционально: установка обоев через feh для фона в Xwayland (если нужно)
# feh --bg-scale "$next_wallpaper" 2>/dev/null
