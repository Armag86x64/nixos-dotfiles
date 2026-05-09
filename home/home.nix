{ config, pkgs, ... }:

{
  home.username = "soundwave";
  home.homeDirectory = "/home/soundwave";
  home.stateVersion = "25.11"; 

  # programs.niri.enable = true;

  xdg.configFile."niri" = {
    source = ./modules/niri;
    recursive = true;
  };

  xdg.configFile."foot/foot.ini".source = ./modules/foot/foot.ini;

  xdg.configFile."fastfetch/config.jsonc".source = ./modules/fastfetch/config.jsonc;

  xdg.configFile."wofi/config".source = ./modules/wofi/config;
  xdg.configFile."wofi/style.css".source = ./modules/wofi/style.css;

  # Пробрасываем основной файл конфига в корень( ~/.vimrc )
  home.file.".vimrc".source = ./modules/vim/vimrc;

  # Пробрасываем папку со всей структурой( ~/.vim/ )
  home.file.".vim" = {
    source = ./modules/vim/dot-vim;
    recursive = true;
  };

  gtk = {
    enable = true;
    
    # Решаем проблему с предупреждением GTK4
    gtk4.theme = config.gtk.theme;

    theme = {
      name = "Graphite-Dark";
      package = pkgs.graphite-gtk-theme.override {
        # 'variant' здесь не нужен, пакет сам строит нужные вариации
        # используем правильные названия аргументов для этого пакета
        tweaks = [ "darker" "rimless" ]; 
      };
    };

    iconTheme = {
      name = "Tela-circle-black-dark";
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = [ "black" ];
      };
    };

    font = {
      name = "JetBrains Mono";
      package = pkgs.jetbrains-mono;
      size = 10;
    };
  };

  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Чтобы тема применилась ко всем GTK-приложениям корректно
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # Рекомендуется добавить для корректной работы HM
  programs.home-manager.enable = true;
}
