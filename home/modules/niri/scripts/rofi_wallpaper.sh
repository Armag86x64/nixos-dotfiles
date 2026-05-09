#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.cache/current_wallpaper"

# Получаем список всех обоев
wallpapers=()
while IFS= read -r file; do
    wallpapers+=("$file")
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" \) | sort)

if [ ${#wallpapers[@]} -eq 0 ]; then
    notify-send "Ошибка" "Нет обоев в $WALLPAPER_DIR"
    exit 1
fi

# Читаем текущий индекс
current_index=0
if [ -f "$STATE_FILE" ]; then
    current_index=$(cat "$STATE_FILE")
fi

# Формируем список для отображения
entries=()
for i in "${!wallpapers[@]}"; do
    filename=$(basename "${wallpapers[$i]}")
    if [ "$i" -eq "$current_index" ]; then
        entries+=("✓ $filename")
    else
        entries+=("  $filename")
    fi
done

# Запускаем Wofi
selected=$(printf "%s\n" "${entries[@]}" | wofi --dmenu --prompt "Выберите обои" --width 450 --height 350 --lines 12)

if [ -n "$selected" ]; then
    # Убираем ВСЕ пробелы и маркер в начале (важное исправление!)
    selected=$(echo "$selected" | sed 's/^[✓ ]*//')
    
    # Находим и применяем
    for i in "${!wallpapers[@]}"; do
        filename=$(basename "${wallpapers[$i]}")
        if [[ "$filename" == "$selected" ]]; then
            swww img "${wallpapers[$i]}" --transition-type fade --transition-duration 0.5
            echo "$i" > "$STATE_FILE"
            # notify-send "Обои изменены" "$selected"
            break
        fi
    done
fi
