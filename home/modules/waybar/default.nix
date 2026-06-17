{ pkgs, config, ... }:

{
  # services.network-manager-applet.enable = true;

  programs.waybar = {
    enable = true;
    systemd.enable = true; # Автоматический перезапуск при обновлении конфига

    # 1. Конфигурация панелей и модулей
    settings = {
      mainBar = {
        height = 36;

        # ------------
        # Р А С П О Л О Ж Е Н И Е
        # ------------
        modules-left = [ "custom/void-left" "niri/workspaces" ];
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
          on-click = "wofi --show drun";
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
    style = ''
      @import "theme.css";
      /* Cascadia Code */
      * {
          font-family: "JetBrainsMono Nerd Font:style=Bold";
          font-weight: bold;
          font-size: 12px;
          
          /*
          padding-top: 3px;
          padding-bottom: 0px;
          */

          color: #fff;
      }

      /* M A I N */
      window#waybar {
          background-color: #000;
          border-radius: 10px;
      }

      window#waybar > box {
          margin: 4px;
          background-color: #000;
          border-left-width: 40px;
          border-right-width: 40px;
      }

      /* C E N T E R */
      #disk {
          background-color: #000;
      }

      #memory {
          background-color: #000;
      }

      #custom-logo {
          font-size: 20px;
          background-image: url("${config.home.homeDirectory}/.config/waybar/images/main_logo_1.jpg");
          background-position: center;
          background-repeat: no-repeat;
          background-size: contain;
      }

      #cpu {
          background-color: #000;
      }

      #temperature {
          background-color: #000;
      }

      /* L E F T */

      /* R I G H T */
      #backlight
      #pulseaudio

      #pulseaudio box {
          padding: 0;
          margin: 0;
      }

      #battery {
          background-color: #000;
      }

      /* W O R K S P A C E S */
      #workspaces button {
          /* Это критически важно: обнуляем встроенную высоту GTK */
          min-height: 0;
          
          /* Убираем вертикальные отступы, которые дают лишние пиксели */
          padding-top: 0;
          padding-bottom: 0;
          
          /* Ограничиваем внешние границы */
          margin-top: 0;
          margin-bottom: 0;
      }

      #workspaces {
          /* Убираем отступы у самого контейнера */
          margin: 0;
          padding: 0;
      }
    '';
  };

  xdg.configFile."waybar/theme.css".source = ./theme.css;
  xdg.configFile."waybar/images/main_logo_1.jpg".source = ./images/main_logo_1.jpg;
}
