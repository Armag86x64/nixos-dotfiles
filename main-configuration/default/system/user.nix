{ pkgs, ... }: {
  users.users.soundwave = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  # programs.zsh.enable = true;
  # environment.pathsToLink = [ "/share/zsh" ];
}
