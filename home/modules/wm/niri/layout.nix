{ config, ... }:

{
  programs.niri.settings = {
    prefer-no-csd = true;

    # Динамически подтягиваем тему и размер из cursor.nix
    cursor = {
      theme = config.home.pointerCursor.name;
      size = config.home.pointerCursor.size;

      hide-when-typing = true;
    };

    layout = {
      gaps = 15;
      center-focused-column = "never";
      background-color = "#000000";

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
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
