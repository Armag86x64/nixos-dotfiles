#!/usr/bin/env bash

# Цвета под твой райс (можно менять прямо здесь)
RED="#ff0000"
GRAY="#666666"
WHITE="#ffffff"

# 1. Получаем список сетей с расширенным форматированием
# Мы берем: Активность, Сигнал, SSID, Защиту

# 1. Получаем список сетей с четким разделителем ":"

# 1. Получаем список одним быстрым проходом
# -t (terse) дает четкие колонки через двоеточие, которые awk ест мгновенно
wifi_list=$(nmcli -t -f "IN-USE,SIGNAL,SSID,SECURITY" device wifi list | awk -F: -v RED="$RED" -v GRAY="$GRAY" -v WHITE="$WHITE" '
  NF > 0 && $3 != "" {
    # Иконка и цвет текста в зависимости от активности
    icon = ($1 == "*") ? "<span color=\"" RED "\">  </span>" : "<span color=\"" GRAY "\">  </span>";
    text_color = ($1 == "*") ? WHITE : "#d1d1d1";
    
    # Формируем строку с разметкой Pango
    printf "%s  <span color=\"%s\" weight=\"bold\">%s</span>  <span color=\"%s\" size=\"small\">%d%%</span>  <span color=\"%s\" size=\"small\">%s</span>\n", 
           icon, text_color, $3, GRAY, $2, RED, $4
  }
')

# 2. Добавляем пункт статуса
status_entry="<span color='$WHITE'>  </span>  <span weight='bold'>Network Info</span>"
options="$status_entry\n$wifi_list"

# 3. Запуск Wofi с отключенным кэшем для актуальности списка
chosen=$(echo -e "$options" | wofi --dmenu --allow-markup --prompt "Wi-Fi" --width 500 --height 400 --cache-file /dev/null)


[ -z "$chosen" ] && exit

# 3. Сетевой статус
if [[ "$chosen" == *"Network Info"* ]]; then
    # Получаем данные (добавили проверку на ошибки)
    interface=$(nmcli -t -f DEVICE,STATE dev | grep connected | cut -d: -f1 | head -n1)
    [ -z "$interface" ] && interface="none"
    
    local_ip=$(ip addr show "$interface" 2>/dev/null | grep -w inet | awk '{print $2}' | cut -d/ -f1)
    [ -z "$local_ip" ] && local_ip="127.0.0.1"
    
    pub_ip=$(curl -s --max-time 2 ifconfig.me || echo "Offline")

    # Формируем тело сообщения (используем обычные пробелы вместо \t)
    # Это обеспечит стабильность отображения в Mako
    read -r -d '' body <<EOF
<span color='$WHITE' weight='bold' letter_spacing='1500'>Network Info</span>

<span color='$GRAY'>Interface:</span>   <span color='$WHITE'>$interface</span>
<span color='$GRAY'>Local IP:</span>    <span color='$WHITE'>$local_ip</span>
<span color='$GRAY'>Public IP:</span>   <span color='$RED' weight='bold'>$pub_ip</span>
EOF

    notify-send -u critical " " "$body"
    exit
fi




# 4. Извлекаем SSID (убираем теги и иконки)
# Очищаем строку от Pango тегов, чтобы скормить nmcli чистое имя сети
ssid_clean=$(echo "$chosen" | sed 's/<[^>]*>//g' | awk '{print $2}')

# 5. Подключение
notify-send "Сеть" "Подключаюсь к $ssid_clean..."

if nmcli device wifi connect "$ssid_clean"; then
    notify-send "Успех" "Подключено к $ssid_clean"
else
    pass=$(wofi --dmenu --prompt "Пароль для $ssid_clean" --password)
    if [ -n "$pass" ]; then
        nmcli device wifi connect "$ssid_clean" password "$pass" && notify-send "Успех" "Подключено"
    fi
fi
