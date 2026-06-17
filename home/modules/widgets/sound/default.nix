{ pkgs, ... }:

let
  # Наш Bash-скрипт для WirePlumber
  wpctl-helper = pkgs.writeShellScriptBin "wpctl-helper" ''
    set -euo pipefail

    get_sinks() {
      echo "["
      wpctl status | sed -n '/Audio/,/^$/p' | grep -E '[0-9]+\.' | grep -v 'Sources' | while read -r line; do
        id=$(echo "$line" | grep -oE '[0-9]+\.' | tr -d '.')
        name=$(echo "$line" | sed -E 's/.*[0-9]+\.\s*//' | sed 's/ \[vol.*//' | tr -d '"')
        if echo "$line" | grep -q '\*'; then
          active="true"
          icon="[X]"
        else
          active="false"
          icon="[ ]"
        fi
        
        if [[ ! "$name" =~ "Microphone" ]] && [[ ! "$name" =~ "Input" ]]; then
          echo "  {\"id\": \"$id\", \"name\": \"$name\", \"active\": $active, \"icon\": \"$icon\"},"
        fi
      done | sed '$s/,$//'
      echo "]"
    }

    case "''${1:-}" in
      "sinks")
        get_sinks
        ;;
      "set-sink")
        wpctl set-default "$2"
        ;;
      *)
        echo "Usage: $0 {sinks|set-sink}"
        exit 1
        ;;
    esac
  '';

  # Копируем конфигурационные файлы eww без изменений
  eww-config-dir = pkgs.stdenv.mkDerivation {
    name = "eww-bw-config";
    src = ./.;
    
    dontUnpack = false;
    dontBuild = true;
    
    installPhase = ''
      mkdir -p $out
      cp $src/eww.yuck $src/eww.css $out
    '';
  };

in {
  # Пробрасываем все необходимые утилиты в пользовательский PATH, 
  # чтобы Eww и его скрипты видели их "из коробки"
  home.packages = [ 
    wpctl-helper 
    pkgs.playerctl 
    pkgs.wireplumber 
  ];

  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = eww-config-dir;
  };
}
