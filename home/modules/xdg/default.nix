{ config, unstable, ... }:

{
  home.packages = [ unstable.xdg-user-dirs ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
      music = "${config.home.homeDirectory}/Music";
    };
  };
}
