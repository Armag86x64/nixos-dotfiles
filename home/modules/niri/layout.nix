{ config, ... }:

{
  programs.niri.settings = {
    prefer-no-csd = true;

    # Динамически подтягиваем тему и размер из cursor.nix
    cursor = {
      theme = config.home.pointerCursor.name;
      size = config.home.pointerCursor.size;
    };

    layout = {
      gaps = 4;
      center-focused-column = "never";
      background-color = "#000000";

      preset-column-widths = [
        0.33333
        0.5
        0.66667
      ];

      default-column-width = { proportion = 1.0; };

      focus-ring = {
        width = 1;
        active.color = "#d1d1d1";
        inactive.color = "#595959";
        urgent.color = "#9b0000";
      };

      border = {
        enable = false;
        width = 2;
        active.color = "#d1d1d1";
        inactive.color = "#595959";
        urgent.color = "#9b0000";
      };
    };
  };
}
