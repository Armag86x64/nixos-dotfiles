{ ... }:

{
  programs.niri.settings.spawn-at-startup = [
    # { command = [ "waybar" ]; }
    { command = [ "xwayland-satellite" ]; }
    # { command = [ "waypaper" "--restore" ]; }
    { command = [ "swww-daemon" ]; }
    # { command = [ "./scripts/restore_wallpaper.sh" ]; }
  ];
}
