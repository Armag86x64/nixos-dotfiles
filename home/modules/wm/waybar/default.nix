{ unstable, pkgs, config, ... }:
let
  waybar-dwl-script = pkgs.writeShellApplication {
    name = "waybar-dwl";
    
    # Добавляем все зависимости, которые использует скрипт внутри
    runtimeInputs = with pkgs; [ 
      coreutils 
      procps 
      gnugrep 
      gnused 
      gawk 
      inotify-tools 
    ];

    text = builtins.readFile ./waybar-dwl.sh;
  };
in
{
  home.packages = [ waybar-dwl-script ];

  programs.waybar = {
    enable = true;
    package = unstable.waybar;

    systemd.enable = true; # Автоматический перезапуск при обновлении конфига

    # 1. Конфигурация панелей и модулей
    settings = {
      mainBar = {
        height = 40;

        # ------------
        # Р А С П О Л О Ж Е Н И Е
        # ------------
        modules-left = [ "custom/void-left" "niri/workspaces" "custom/dwl" ];
        modules-center = [
          "custom/void-center"
          "disk"
          "memory"
          "custom/logo"
          "cpu"
          "temperature"
          "network"
        ];
        modules-right = [
          "backlight"
          "group/pulseaudio"
          "battery"
          "clock"
          "custom/void-right"
        ];

        # ------------
        # Л Е В О Е
        # ------------
        "custom/void-left" = {
          format = "   ";
          min-length = 5;
        };

        "custom/dwl" = {
          exec = "${waybar-dwl-script}/bin/waybar-dwl eDP-1";
          format = "{}";
          return-type = "json";
          max-length = 150;
        };

        "niri/workspaces" = {
          format = "{icon}";
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            active = "";
            default = "";
          };
          all-outputs = true;
          sort-by-number = true;
        };
        
        "dwl/tags" = {
          num-tags = 9;
          title-length = 20;
        };

        # ------------
        # Ц Е Н Т Р
        # ------------
        "custom/void-center" = {
          format = " ";
          min-length = 5;
        };

        disk = {
          interval = 30;
          format = "Disk: {free}";
          unit = "GB";
          path = "/";
          min-length = 20;
        };

        memory = {
          interval = 10;
          format = "RAM: {used} GB";
          format-warning = "RAM: {used} GB";
          format-critical = "RAM: {used} GB";
          states = {
            warning = 75;
            critical = 90;
          };
          min-length = 15;
          max-length = 15;
          tooltip-format = "Memory Used: {used:0.1f} GB / {total:0.1f} GB";
        };

        "custom/logo" = {
          format = " ";
          min-length = 5;
          # on-click = "wofi --show drun";
          on-click = "eww open --toggle system_dashboard";
        };

        cpu = {
          interval = 10;
          format = "CPU: {usage}%";
          format-warning = "CPU: {usage}%";
          format-critical = "CPU: {usage}%";
          min-length = 10;
          max-length = 15;
          states = {
            warning = 75;
            critical = 90;
          };
          tooltip = false;
        };

        temperature = {
          thermal-zone = 3;
          interval = 5;
          critical-threshold = 70;
          format-critical = "{temperatureC}°C";
          format = "{temperatureC}°C";
          min-length = 10;
        };

        network = {
          interface = "wlp0s20f3";
          format = "{ifname}";
          format-wifi = "WiFi: {essid} ({signalStrength}%)";
          format-ethernet = "Ethernet: {ipaddr}/{cidr} ";
          format-disconnected = "Disconnected";
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 70;
          min-length = 20;
          # on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        # ------------
        # П Р А В А Я   Ч А С Т Ь
        # ------------

        "backlight" = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];

          min-length = 13;
          max-length = 15;
          tooltip = false;

          # Управление яркостью при прокрутке
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        };


        "group/pulseaudio" = {
          orientation = "horizontal";
          valign = "center";
          modules = [ "pulseaudio#output" "pulseaudio#input" ];
          drawer = {
            transition-left-to-right = false;
          };
        };

        "pulseaudio#output" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 {volume}%";
          format-icons = {
            default =  ["󰕿" "󰖀" "󰕾"];
            headphone = "󰋋";
            headset = "󰋋";
          };
          min-length = 7;
          max-length = 10;
          tooltip-format = "Output Device: {desc}";
          
          # Управление звуком напрямую через WirePlumber без скриптов
          # on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click = "${pkgs.eww}/bin/eww open --toggle bw-volume-applet";
          on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };

        "pulseaudio#input" = {
          format = "{format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 {volume}%";
          min-length = 7;
          max-length = 10;
          tooltip-format = "Input Device: {desc}";
          
          # Управление микрофоном напрямую через WirePlumber без скриптов
          on-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SOURCE@ 5%+";
          on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
        };

        battery = {
          bat = "BAT0";
          interval = 60;
          states = {
            warning = 30;
            critical = 20;
          };
          format = "Battery: {capacity}%";
          min-length = 20;
        };

        clock = {
          interval = 60;
          format = "{:%H:%M - %d:%m:%Y}";
          format-alt = "{:%A, %B}";
          max-length = 30;
          min-length = 20;
        };

        "custom/void-right" = {
          format = "   ";
          min-length = 5;
        };
      };
    };

    # 2. Стилизация панели
    style = ./style.css; 
  };

  xdg.configFile."waybar/theme.css".source = ./theme.css;
  # xdg.configFile."waybar/images/main_logo_1.jpg".source = ./images/main_logo_1.jpg;
}
