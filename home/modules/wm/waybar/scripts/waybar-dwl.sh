#!/usr/bin/env bash

# Гарантируем, что утилиты доступны в NixOS
# export PATH="${pkgs.coreutils}/bin:${pkgs.gnugrep}/bin:${pkgs.gawk}/bin:${pkgs.gnused}/bin:${pkgs.inotify-tools}/bin:$PATH"

# Если текущий рабочий стол не dwl, тихо выходим
if [[ "${XDG_CURRENT_DESKTOP,,}" != "dwl" ]]; then
    exit 0
fi

############### USER: MODIFY THESE VARIABLES ###############
readonly dwl_output_filename="$HOME"/.cache/dwltags                  # File to watch for dwl output
readonly labels=( " 1 " " 2 " " 3 " " 4 " " 5 " " 6 " " 7 " " 8 " " 9 " )              # Number of lables must match dwl's config.h tagcount
pango_tag_default="<span                      foreground='#ffffff'>" # Pango span style for 'default' tags
pango_tag_active="<span                       foreground='#aaaaaa'>" # Pango span style for 'active' tags
pango_tag_selected="<span                     foreground='#aaaaaa'>" # Pango span style for 'selected' tags
pango_tag_urgent="<span                       background='#444444'>" # Pango span style for 'urgent' tags
pango_layout="<span                           foreground='#444444'>" # Pango span style for 'layout' character
pango_title="<span                            foreground='#444444'>" # Pango span style for 'title' monitor
pango_inactive="<span                         foreground='#928374'>" # Pango span style for elements on an INACTIVE monitor
hide_unused_tags=false                                               # Set to 'true' to hide unused tags, 'false' to show all tags
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
    if [[ "$selmon" = 0 ]]; then
        local pango_tag_default="$pango_inactive"
        local pango_layout="$pango_inactive"
        local pango_title="$pango_inactive"
    fi

    for component in "${full_components_list[@]}"; do
        case "$component" in
            [0-9]|[1-9][0-9])
                mask=$((1<<component))
                tag_text=${labels[component]}
                if [[ "$hide_unused_tags" = true ]] && ! (( ("$activetags" | "$urgenttags" | "$selectedtags") & mask )); then
                    continue
                fi
                if (( "$activetags"   & mask )) 2>/dev/null; then tag_text="${pango_tag_active}${tag_text}</span>"; fi
                if (( "$urgenttags"   & mask )) 2>/dev/null; then tag_text="${pango_tag_urgent}${tag_text}</span>"; fi
                if (( "$selectedtags" & mask )) 2>/dev/null; then tag_text="${pango_tag_selected}${tag_text}</span>"
                else
                    tag_text="${pango_tag_default}${tag_text}</span>"
                fi
                output_text+="${tag_text}  "
                ;;
            layout)
                output_text+="${pango_layout}${layout} </span>"
                ;;
            title)
                output_text+="${pango_title}${title}</span>"
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

    # Убран флаг -t 60. Теперь скрипт не паникует при простое.
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
