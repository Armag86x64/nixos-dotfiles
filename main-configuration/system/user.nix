{ config, lib, pkgs, ... }: {
    users.users.soundwave = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.zsh;
    };

    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [ "git" "docker" ];
      };

      promptInit = ''
        # %n — имя пользователя, %~ — текущий каталог (с заменой домашней папки на ~)
        PROMPT='[%n:%~] '
      '';
    };

    environment.pathsToLink = [ "/share/zsh" ];
}
