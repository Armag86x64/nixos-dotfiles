{ ... }:

{
  programs.niri.settings.outputs = {
    "eDP-1" = {
      mode = {
        width = 1600;
        height = 900;
        refresh = 60.0;
      };

      transform = { };
      position = { x = 0; y = 0; };
      focus-at-startup = true;
    };
  };
}
