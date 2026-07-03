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
        foreground = "ffffff"; # Основной текст (белый)
        background = "000000"; # Фон терминала (глубокий черный)

        # Normal palette (Базовые цвета)
        regular0 = "484f58"; # Черный (используется для затенения)
        regular1 = "f85149"; # Красный (ошибки, сбои, критические логи)
        regular2 = "2ea44f"; # Зеленый (успех, статус OK, логи завершения)
        regular3 = "f2cc60"; # Желтый (предупреждения, строки 'warning:')
        regular4 = "6e7681"; # Темно-серый (подсветка команд, утилит и системного вывода)
        regular5 = "d2a8ff"; # Светло-фиолетовый (вспомогательные элементы синтаксиса)
        regular6 = "39c5bb"; # Бирюзовый (пути, ссылки или спец-символы)
        regular7 = "b9b9b9"; # Светло-серый (второстепенный текст)

        # Bright palette (Яркие / Акцентные цвета)
        bright0 = "6f7987"; # Яркий черный (серый цвет для системных утилит)
        bright1 = "ff7b72"; # Яркий красный (критические алерты и важные ошибки)
        bright2 = "aff5b4"; # Яркий зеленый (акцентный цвет успеха / тестов)
        bright3 = "f2cc60"; # Яркий желтый (акцентные предупреждения в логах NixOS)
        bright4 = "79c0ff"; # Яркий сине-серый (дополнительный оттенок для команд)
        bright5 = "d2a8ff"; # Яркий фиолетовый
        bright6 = "56d4dd"; # Яркий бирюзовый
        bright7 = "ffffff"; # Чистый белый (акцентный текст)
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
