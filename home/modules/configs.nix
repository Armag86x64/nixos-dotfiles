{ config, ... }: {
  imports = [
    ./niri
    ./foot
  ];
  /*
  xdg.configFile."niri" = {
    source = ./niri;
    recursive = true;
  };
  */

  xdg.configFile."mako/config".source = ./mako/config;
  # xdg.configFile."foot/foot.ini".source = ./foot/foot.ini;
  xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch/config.jsonc;
  xdg.configFile."wofi/config".source = ./wofi/config;
  xdg.configFile."wofi/style.css".source = ./wofi/style.css;
  xdg.configFile."waybar" = {
    source = ./waybar;
    recursive = true;
  };

  home.file.".vimrc".source = ./vim/vimrc;
  home.file.".vim" = {
    source = ./vim/dot-vim;
    recursive = true;
  };
}

