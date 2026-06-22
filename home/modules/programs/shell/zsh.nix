{ ... }: {
programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "docker" ];
    };

    initContent = ''
      # Настройка отображения git из темы robbyrussell
      ZSH_THEME_GIT_PROMPT_PREFIX=" ("
      ZSH_THEME_GIT_PROMPT_SUFFIX=")"
      ZSH_THEME_GIT_PROMPT_DIRTY="*"
      ZSH_THEME_GIT_PROMPT_CLEAN=""

      # Промпт-лайн: [пользователь, текущая папка] (статус git)
      PROMPT='[%n:%~]$(git_prompt_info) '
    '';
  };
}
