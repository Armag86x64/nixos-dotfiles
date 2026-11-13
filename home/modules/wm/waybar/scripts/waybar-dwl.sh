#!/usr/bin/env bash

# Если текущий рабочий стол не dwl, выходим
if [[ "${XDG_CURRENT_DESKTOP,,}" != "dwl" ]]; then
    exit 0
fi

############### USER: MODIFY THESE VARIABLES ###############
readonly dwl_output_filename="$HOME"/.cache/dwltags
readonly labels=( " 1 " " 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " )

pango_tag_default="<span                      foreground='#ffffff'>" # Pango span style for 'default' tags
pango_tag_active="<span                       foreground='#aaaaaa'>" # Pango span style for 'active' tags
pango_tag_selected="<span                     foreground='#39c89d'>" # Pango span style for 'selected' tags
pango_tag_urgent="<span                       background='#444444'>" # Pango span style for 'urgent' tags
pango_layout="<span                           foreground='#444444'>" # Pango span style for 'layout' character
pango_title="<span                            foreground='#444444'>" # Pango span style for 'title' monitor
pango_inactive="<span                         foreground='#928374'>" # Pango span style for elements on an INACTIVE monitor

# Вертикальный разделитель, раскладка и заголовок окна
pango_separator="<span foreground='#555555'>  │   </span>"

hide_unused_tags=false
############### USER: MODIFY THESE VARIABLES ###############

dwl_log_lines_per_focus_change=7 

full_components_list=()
for ((i=0; i<${#labels[@]}; i++)); do
    full_components_list+=("$i")
done
full_components_list+=("layout" "title")

monitor="$1"

_cycle() {
    output_text=""
    local cur_default="$pango_tag_default"
    local cur_active="$pango_tag_active"
    local cur_selected="$pango_tag_selected"
    local cur_layout="$pango_layout"
    local cur_title="$pango_title"

    if [[ "$selmon" = 0 ]]; then
        cur_default="$pango_inactive"
        cur_active="$pango_inactive"
        cur_selected="$pango_inactive"
        cur_layout="$pango_inactive"
        cur_title="$pango_inactive"
    fi

    for component in "${full_components_list[@]}"; do
        case "$component" in
            [0-9]|[1-9][0-9])
                mask=$((1<<component))
                tag_text=${labels[component]}
                if [[ "$hide_unused_tags" = true ]] && ! (( ("$activetags" | "$urgenttags" | "$selectedtags") & mask )); then
                    continue
                fi
                if (( "$urgenttags" & mask )) 2>/dev/null; then
                    tag_text="${pango_tag_urgent}${tag_text}</span>"
                elif (( "$selectedtags" & mask )) 2>/dev/null; then
                    tag_text="${cur_selected}${tag_text}</span>"
                elif (( "$activetags" & mask )) 2>/dev/null; then
                    tag_text="${cur_active}${tag_text}</span>"
                else
                    tag_text="${cur_default}${tag_text}</span>"
                fi
                output_text+="${tag_text} "
                ;;
            layout)
                output_text+="${pango_separator}${cur_layout}${layout} </span>"
                ;;
            title)
                output_text+=" ${cur_title}${title}</span>"
                ;;
            *)
                output_text+="?" 
                ;;
        esac
    done
}

# Первая принудительная отрисовка при запуске Waybar
if [[ -f "$dwl_output_filename" ]]; then
    dwl_latest_output_by_monitor="$(grep -E "^${monitor}\s" "$dwl_output_filename" | tail -n"$dwl_log_lines_per_focus_change")"
    title="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* title'  | cut -d ' ' -f 3- )"
    title="${title//\"/“}" 
    title="${title//\&/+}" 
    layout="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* layout' | cut -d ' ' -f 3- )"
    selmon="$(echo "$dwl_latest_output_by_monitor" | grep 'selmon' | cut -d ' ' -f 3)"
    layout="$(echo "$layout" | sed -e 's/</\&lt;/g' -e 's/>/\&gt;/g')"
    activetags="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* tags' | awk '{print $3}')"
    selectedtags="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* tags' | awk '{print $4}')"
    urgenttags="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* tags' | awk '{print $6}')"
    _cycle
    printf -- '{"text":"%s"}\n' "$output_text"
fi

# Бесконечный цикл, завязанный только на события файла
while true; do
    [[ ! -f "$dwl_output_filename" ]] && printf -- '%s\n' \
                    "You need to redirect dwl stdout to ~/.cache/dwltags" >&2

    inotifywait -qq --event modify "$dwl_output_filename" || continue

    dwl_latest_output_by_monitor="$(grep -E "^${monitor}\s" "$dwl_output_filename" | tail -n"$dwl_log_lines_per_focus_change")"
    title="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* title'  | cut -d ' ' -f 3- )"
    title="${title//\"/“}" 
    title="${title//\&/+}" 
    layout="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* layout' | cut -d ' ' -f 3- )"
    selmon="$(echo "$dwl_latest_output_by_monitor" | grep 'selmon' | cut -d ' ' -f 3)"

    layout="$(echo "$layout" | sed -e 's/</\&lt;/g' -e 's/>/\&gt;/g')"
    
    activetags="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* tags' | awk '{print $3}')"
    selectedtags="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* tags' | awk '{print $4}')"
    urgenttags="$(echo "$dwl_latest_output_by_monitor" | grep '^[[:graph:]]* tags' | awk '{print $6}')"

    _cycle
    printf -- '{"text":"%s"}\n' "$output_text"
done
