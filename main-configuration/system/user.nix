{ config, lib, pkgs, ... }: {
    users.users.soundwave = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [];
        shell = pkgs.zsh;
    };

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [ "git" "docker" ];
      };
    };
}
