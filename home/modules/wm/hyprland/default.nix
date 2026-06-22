{ unstable,... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    package = unstable.hyprland;

    importantPrefixes = [ "Hyprland" "systemd-run" ]; 

    settings = {
      monitor = ", 1600x900@60, auto, 1";

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "rgba(ffffffff)";
        "col.inactive_border" = "rgba(333333ff)";
        layout = "dwindle";
        allow_tearing = true;
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = false;
        };
        shadow = {
          enabled = false;
        };
      };

      animations = {
        enabled = false;
      };

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
      };

      misc = {
        force_default_wallpaper = 0;
        background_color = "0x000000"; 
        vrr = 1; 
      };

      "$mainMod" = "SUPER";
      
      bind = [
        "$mainMod, Q, exec, foot"                 # Super + Q - Терминал Foot
        "$mainMod, R, exec, wofi --show drun"     # Super + R - Лаунчер Wofi
        "$mainMod, B, exec, firefox"              # Super + B - Браузер Firefox
        "$mainMod, C, killactive,"                # Super + C - Закрыть активное окно
        "$mainMod SHIFT, M, exit,"                # Super + Shift + M - Выйти из Hyprland
        "$mainMod, F, exec, thunar"               # Super + F - Проводник Thunar
        "$mainMod, Space, fullscreen,"            # Super + Space - Полноэкранный режим
        
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
