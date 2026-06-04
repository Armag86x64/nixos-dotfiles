{ config, pkgs, stable, unstable, ... }: {
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;

    theme = {
      name = "Graphite-Dark";
      package = pkgs.graphite-gtk-theme.override {
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
      name = "JetBrainsMono Nerd Font"; # Имя шрифта и его размер
      size = 11;
      package = unstable.nerd-fonts.jetbrains-mono; # Автоматическая установка пакета
    };
  };

  gtk.gtk4.theme = config.gtk.theme;

  # fonts.fontconfig.enable = true;

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
