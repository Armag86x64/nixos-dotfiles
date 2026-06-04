{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "8x8 center";
        font = "CaskaydiaCove Nerd Font:size=8, Symbols Nerd Font Mono:size=11";
        resize-delay-ms = 2500;
        dpi-aware = "yes";
        term = "foot";
        title = "Foot";
      };

      colors-dark = {
        foreground = "ffffff";
        background = "000000";

        # Normal palette
        regular0 = "222222";
        regular1 = "f85149";
        regular2 = "8b949e";
        regular3 = "f2cc60";
        regular4 = "6e7681";
        regular5 = "d2a8ff";
        regular6 = "39c5bb";
        regular7 = "b9b9b9";

        # Bright palette
        bright0 = "484f58";
        bright1 = "ff7b72";
        bright2 = "aff5b4";
        bright3 = "f2cc60";
        bright4 = "79c0ff";
        bright5 = "d2a8ff";
        bright6 = "56d4dd";
        bright7 = "ffffff";
      };

      scrollback = {
        lines = 5000;
        multiplier = 5;
        indicator-format = "percentage";
        indicator-position = "fixed";
      };

      url = {
        osc8-underline = "url-mode";
        launch = "xdg-open \${url}";
      };

      cursor = {
        style = "block";
        blink = "yes";
        beam-thickness = 1;
      };

      mouse = {
        hide-when-typing = "no";
      };
    };
  };
}
