{ config, pkgs, ... }:

{
  # Настройки Home Manager
  home.username = "soundwave"; # Добавьте это для надежности
  home.homeDirectory = "/home/soundwave";
  home.stateVersion = "25.11"; 

  # programs.niri.enable = true;

  xdg.configFile."niri" = {
    source = ./modules/niri; # Путь относительно home.nix
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
      name = "Tela-circle-black-dark"; # Название варианта внутри пакета
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = [ "black" ]; # Генерируем только черную версию
      };
    };

    # 2. ИНЖЕНЕРНЫЙ ШРИФТ: JetBrains Mono или Iosevka
    font = {
      name = "JetBrains Mono";
      package = pkgs.jetbrains-mono;
      size = 10;
    };
  };

  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark"; # or "phinger-cursors-light"
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Чтобы тема применилась ко всем GTK-приложениям корректно
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # Рекомендуется добавить для корректной работы HM
  programs.home-manager.enable = true;
}
