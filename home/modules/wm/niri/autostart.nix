{ ... }:

{
  programs.niri.settings.spawn-at-startup = [
    # { command = [ "waybar" ]; }
    { command = [ "xwayland-satellite" ]; }
    # { command = [ "waypaper" "--restore" ]; }
    { command = [ "awww-daemon" ]; }
    # { command = [ "./scripts/restore_wallpaper.sh" ]; }
  ];
}
