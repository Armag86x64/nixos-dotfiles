{ config, pkgs, ... }: {
  home.username = "soundwave";
  home.homeDirectory = "/home/soundwave";
  home.stateVersion = "25.11"; 

  imports = [
    ./modules/configs.nix
    ./modules/gtk.nix
    ./modules/cursor.nix
  ];

  programs.home-manager.enable = true;
}
