{ config, pkgs, ... }:

{
  xdg = {
    portal = {
      enable = true;

      extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-cosmic 
        pkgs.xdg-desktop-portal-termfilechooser
      ];

      config = {  
        common = {
          default = [ "wlr" "gtk" ];
          "org.freedesktop.portal.Screenshot" = pkgs.lib.mkForce [ "cosmic" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
        };
      };
    };
    
    userDirs = {
      enable = true;
      createDirectories = true;

      setSessionVariables = false;
      
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
      music = "${config.home.homeDirectory}/Music";
    };
  };

  home.sessionVariables = {
    GDK_DEBUG = "portals";
    GTK_USE_PORTAL = "1";
  };
}
