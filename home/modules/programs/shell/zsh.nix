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
      # Заворачиваем настройку в функцию, которая выполнится после загрузки плагинов
      zsh_style_monochrome() {
        # Если плагин еще не загрузился, выходим без ошибки
        (( $+ZSH_HIGHLIGHT_STYLES )) || return

        # Назначаем для всех типов команд bright0
        ZSH_HIGHLIGHT_STYLES[command]='fg=8'     # Обычные команды
        ZSH_HIGHLIGHT_STYLES[precommand]='fg=8'  # <--- Фикс для sudo! Теперь он тоже серый
        ZSH_HIGHLIGHT_STYLES[alias]='fg=8'       # Алиасы
        ZSH_HIGHLIGHT_STYLES[builtin]='fg=8'     # Встроенные команды оболочки
        ZSH_HIGHLIGHT_STYLES[function]='fg=8'    # Функции
      
        # Аргументы, опции и пути — нейтральные серые/белые оттенки
        ZSH_HIGHLIGHT_STYLES[default]='fg=default'
        ZSH_HIGHLIGHT_STYLES[path]='fg=default'
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=248'
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=248'
      
        # Ошибки синтаксиса (несуществующая команда) — сигнальный красный
        ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=167,bold'
      }

      # Добавляем нашу функцию в список хуков, которые выполняются перед отрисовкой строки
      autoload -Uz add-zsh-hook
      add-zsh-hook precmd zsh_style_monochrome


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
