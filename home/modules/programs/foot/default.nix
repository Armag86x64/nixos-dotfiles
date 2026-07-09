{ unstable, ... }:

{
  programs.foot = {
    enable = true;
    package = unstable.foot;
    settings = {
      main = {
        pad = "8x8 center";
        font = "CaskaydiaCove Nerd Font:size=8, Symbols Nerd Font Mono:size=11";
        resize-delay-ms = 2500;
        dpi-aware = "yes";
        term = "foot";
        title = "Foot";
      };

      "colors-dark" = {
        # Основные цвета текста и фона
        foreground = "bdbdbd"; # Светло-серый - основной текст
        background = "121212"; # Глубокий черный (основной фон)

        # Базовая палитра (Regular)
        regular0 = "8b8d99";   # Черный (фон системных элементов)
        regular1 = "ff5555";   # Красный (ошибки, важные предупреждения)
        regular2 = "50fa7b";   # Зеленый (успешные действия, строки кода)
        regular3 = "f1fa8c";   # Желтый (предупреждения, подсказки, кавычки)
        regular4 = "6e7681";   # Синий (имена функций, директории)
        regular5 = "ff79c6";   # Пурпурный (ключевые слова, переменные)
        regular6 = "8be9fd";   # Циан (бирюзовый: специальные символы)
        regular7 = "b9b9b9";   # Белый (второстепенный текст)

        # Яркая палитра (Bright / Bold)
        bright0 = "7c848f";    # Светло-серо-синий - цвет текста команд
        bright1 = "ff6e6e";    # Яркий красный
        bright2 = "69fa8c";    # Яркий зеленый
        bright3 = "ffffa5";    # Яркий желтый
        bright4 = "d6acff";    # Яркий синий
        bright5 = "ff92df";    # Яркий пурпурный
        bright6 = "a4ffff";    # Яркий циан
        bright7 = "ffffff";    # Яркий белый

        # Интерактивные элементы
        selection-foreground = "000000"; # Цвет текста при выделении мышью
        selection-background = "ffffff"; # Цвет фона при выделении мышью
        urls = "ff79c6";                 # Цвет кликабельных ссылок (неоново
      };

      scrollback = {
        lines = 5000;
        multiplier = 5;
        indicator-format = "percentage";
        indicator-position = "fixed";
      };

      url = {
        osc8-underline = "url-mode";
        launch = "xdg-open \${url}";
      };

      cursor = {
        style = "block";
        blink = "yes";
        beam-thickness = 1;
      };

      mouse = {
        hide-when-typing = "no";
      };
    };
  };
}
