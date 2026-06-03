{ ... }:

{
  programs.niri.settings.input = {
    keyboard.xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };

    touchpad = {
      tap = true;
      natural-scroll = true;
    };
  };
}
