{ ... }: {
  home.username = "soundwave";
  home.homeDirectory = "/home/soundwave";
  home.stateVersion = "25.11"; 

  imports = [
    ./modules
  ];

  programs.home-manager.enable = true;
}
