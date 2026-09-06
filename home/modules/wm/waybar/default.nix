{ unstable, ... }:
{
  imports = [
    ./modules
  ];

  programs.waybar = {
    enable = true;
    package = unstable.waybar;

    systemd.enable = true; # Автоматический перезапуск при обновлении конфига

    settings = {
      mainBar = {
        height = 40;
        fixed-center = true;

        # ------------
        # Р А С П О Л О Ж Е Н И Е
        # ------------
        modules-left = [ 
          "custom/void-left" 
          "niri/workspaces" 
          "custom/dwl" 
        ];

        modules-center = [
          # "custom/void-center"
          "cpu"
          "temperature"
          "disk"
          "memory"
          "custom/logo"
          "network"
          "bluetooth"
        ];

        modules-right = [
          "backlight"
          "group/pulseaudio"
          "battery"
          # "power-profiles-daemon"
          "clock"
          "custom/void-right"
        ];

      };
    };

    style = ./style.css; 
  };

  xdg.configFile."waybar/theme.css".source = ./theme.css;
  # xdg.configFile."waybar/images/main_logo_1.jpg".source = ./images/main_logo_1.jpg;
}
