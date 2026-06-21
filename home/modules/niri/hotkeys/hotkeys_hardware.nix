{ ... }:

{
  programs.niri.settings.binds = {
    # --- З В У К (Wireplumber) ---
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0" ];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-" ];
    };
    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" ];
    };

    # --- П Л Е Е Р (Playerctl) ---
    "XF86AudioPlay" = {
      allow-when-locked = true;
      action.spawn-sh = [ "playerctl play-pause" ];
    };
    "XF86AudioStop" = {
      allow-when-locked = true;
      action.spawn-sh = [ "playerctl stop" ];
    };
    "XF86AudioPrev" = {
      allow-when-locked = true;
      action.spawn-sh = [ "playerctl previous" ];
    };
    "XF86AudioNext" = {
      allow-when-locked = true;
      action.spawn-sh = [ "playerctl next" ];
    };

    # --- Я Р К О С Т Ь (Brightnessctl) ---
    "XF86MonBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "--class=backlight" "set" "+10%" ];
    };
    "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "--class=backlight" "set" "10%-" ];
    };
  };
}
