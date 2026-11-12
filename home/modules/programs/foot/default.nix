{ unstable, ... }:

{
  programs.foot = {
    enable = true;
    package = unstable.foot;
    settings = {
      main = {
        pad = "8x8 center";
        # font = "CaskaydiaCove Nerd Font:size=10, Symbols Nerd Font Mono:size=11";
        font = "Terminus:pixelsize=32:weight=bold, Symbols Nerd Font Mono:size=11";
        resize-delay-ms = 2500;
        dpi-aware = "yes";
        term = "foot";
        title = "Foot";
      };

      "colors-dark" = {
        alpha = "0.95"; # Легкая прозрачность, при желании поставьте "1.0"
        background = "000000"; # Глубокий угольно-изумрудный фон с референсов
        foreground = "d4dedb"; # Мягкий светло-серый текст

        # Выделение и курсор
        cursor = "080b0a 40d39c";
        selection-background = "162621";
        selection-foreground = "ffffff";

        # Обычные цвета (0–7)
        regular0 = "101514"; # Black (фон панелей и карточек)
        regular1 = "d94141"; # Red (красные свечи и ордера Sell)
        regular2 = "2eb885"; # Green (основной мятно-зеленый акцент)
        regular3 = "c79c52"; # Yellow (сбалансированный приглушенный янтарь)
        regular4 = "357a99"; # Blue (холодный стальной синий)
        regular5 = "8869a8"; # Magenta (приглушенный фиолетовый)
        regular6 = "2ca198"; # Cyan (бирюзовый оттенок графиков)
        regular7 = "a3b0ac"; # White (второстепенный текст интерфейса)

        # Яркие цвета (8–15)
        bright0 = "465450";  # Bright Black (рамки, разделители, комментарии)
        bright1 = "f25c5c";  # Bright Red
        bright2 = "4ce0a8";  # Bright Green (яркие кнопки Buy / Create)
        bright3 = "e3ba6b";  # Bright Yellow
        bright4 = "4b9ec2";  # Bright Blue
        bright5 = "a887c9";  # Bright Magenta
        bright6 = "45c4ba";  # Bright Cyan
        bright7 = "f0f5f3";  # Bright White (активные заголовки)
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
