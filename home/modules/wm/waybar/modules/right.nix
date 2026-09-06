{ pkgs, ... }: {

  programs.waybar.settings.mainBar = {
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

      min-length = 10;
      max-length = 15;
      tooltip = false;

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
	    events = {
		    on-discharging-warning = "notify-send -t 10000 -u low \'Low Battery\'";
		    on-discharging-critical = "notify-send -t 60000 -u critical \'Very Low Battery\'";
		    on-charging-100 = "notify-send -u critical \'Battery Full!\'";
		    on-discharging = "notify-send -t 3000 -u normal \'Power Switch\' Discharging";
		    on-charging = "notify-send -t 3000 -u normal \'Power Switch\' Charging'";
	    };
      format = "BAT: {capacity}%";
      min-length = 12;
      max-length = 25;
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
}

    /* power-profiles-daemon = {
      format = "Power: {icon}";
      tooltip-format = "Power profile: {profile}nCPU driver: {cpu_driver}nPlatform driver: {platform_driver}";
      tooltip = true;
      format-icons = {
        default = "DEF";
        performance = "AC";
        balanced = "BAL";
        power-saver = "BAT";
      };
    }; */

