{ config, pkgs, unstable, ... }: {
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
      name = "JetBrainsMono Nerd Font";
      size = 11;
      package = unstable.nerd-fonts.jetbrains-mono;
    };
  };

  gtk.gtk4.theme = config.gtk.theme;

  xdg.portal = {
    enable = true;
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
