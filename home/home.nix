{ ... }: {
  home.username = "soundwave";
  home.homeDirectory = "/home/soundwave";
  home.stateVersion = "26.05"; 

  imports = [
    ./modules
  ];

  programs.home-manager.enable = true;

}
