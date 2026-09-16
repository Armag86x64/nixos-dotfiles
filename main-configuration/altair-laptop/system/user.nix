{ pkgs, ... }: {
  users.users.soundwave = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "wireshark"];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
}
