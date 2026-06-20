{ pkgs, ... }: {
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
      theme = "robbyrussell";
      plugins = [ "git" "docker" ];
    };

    promptInit = ''
      # Переопределяем функцию отображения git из темы robbyrussell под ваш стиль
      ZSH_THEME_GIT_PROMPT_PREFIX=" ("
      ZSH_THEME_GIT_PROMPT_SUFFIX=")"
      ZSH_THEME_GIT_PROMPT_DIRTY="*"
      ZSH_THEME_GIT_PROMPT_CLEAN=""

      # Формируем ваш PROMPT с добавлением функцииgit_prompt_info
      PROMPT='[%n:%~]$(git_prompt_info) '
    '';
  };


  environment.pathsToLink = [ "/share/zsh" ];
}
