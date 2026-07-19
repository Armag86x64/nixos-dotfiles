{ ... }:

{
  programs.niri.settings = {
    binds = {
      "Alt+Tab".action.spawn = "";

      "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

      "Super+Alt+S" = {
        allow-when-locked = true;
        hotkey-overlay.title = ""; # Заменили null на пустую строку для прохождения типизации
        action.spawn-sh = [ "pkill orca || exec orca" ];
      };

      # --- РЕЖИМ ОБЗОРА И ЗАКРЫТИЕ ---
      "Mod+I" = {
        repeat = false;
        action.toggle-overview = [ ];
      };
      "Mod+C" = {
        repeat = false;
        action.close-window = [ ];
      };

      # --- НАВИГАЦИЯ ПО ОКНАМ (Стрелочки и Vim-binds) ---
      "Mod+Left".action.focus-column-left = [ ];
      "Mod+Down".action.focus-workspace-down = [ ];
      "Mod+Up".action.focus-workspace-up = [ ];
      "Mod+Right".action.focus-column-right = [ ];
      "Mod+H".action.focus-column-left = [ ];
      "Mod+J".action.focus-workspace-down = [ ];
      "Mod+K".action.focus-workspace-up = [ ];
      "Mod+L".action.focus-column-right = [ ];

      # --- ПЕРЕМЕЩЕНИЕ ОКОН ---
      "Mod+Ctrl+Left".action.move-column-left = [ ];
      "Mod+Ctrl+Down".action.move-window-to-workspace-down = [ ];
      "Mod+Ctrl+Up".action.move-window-to-workspace-up = [ ];
      "Mod+Ctrl+Right".action.move-column-right = [ ];
      
      "Mod+Ctrl+H".action.move-column-left = [ ];
      "Mod+Ctrl+J".action.move-window-to-workspace-down = [ ];
      "Mod+Ctrl+K".action.move-window-to-workspace-up = [ ];
      "Mod+Ctrl+L".action.move-column-right = [ ];

      # --- БЫСТРЫЙ ПЕРЕХОД В НАЧАЛО/КОНЕЦ ---
      "Mod+Home".action.focus-column-first = [ ];
      "Mod+End".action.focus-column-last = [ ];
      "Mod+Ctrl+Home".action.move-column-to-first = [ ];
      "Mod+Ctrl+End".action.move-column-to-last = [ ];

      # --- НАВИГАЦИЯ МЕЖДУ МОНИТОРАМИ ---
      # "Mod+Shift+Left".action.focus-monitor-left = [ ];
      # "Mod+Shift+Down".action.focus-monitor-down = [ ];
      # "Mod+Shift+Up".action.focus-monitor-up = [ ];
      # "Mod+Shift+Right".action.focus-monitor-right = [ ];
      # "Mod+Shift+H".action.focus-monitor-left = [ ];
      # "Mod+Shift+J".action.focus-monitor-down = [ ];
      # "Mod+Shift+K".action.focus-monitor-up = [ ];
      # "Mod+Shift+L".action.focus-monitor-right = [ ];

      # --- ПЕРЕМЕЩЕНИЕ КОЛОНОК МЕЖДУ МОНИТОРАМИ ---
      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [ ];
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [ ];
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [ ];
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [ ];
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [ ];
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [ ];
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [ ];
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [ ];

      # --- НАВИГАЦИЯ ПО РАБОЧИМ ОБЛАСТЯМ (WORKSPACES) ---
      "Mod+Page_Down".action.focus-workspace-down = [ ];
      "Mod+Page_Up".action.focus-workspace-up = [ ];
      "Mod+U".action.focus-workspace-down = [ ];
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [ ];
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [ ];
      "Mod+Ctrl+U".action.move-column-to-workspace-down = [ ];
      "Mod+Ctrl+I".action.move-column-to-workspace-up = [ ];

      # --- ПЕРЕМЕЩЕНИЕ САМИХ РАБОЧИХ ОБЛАСТЕЙ ---
      "Mod+Shift+Page_Down".action.move-workspace-down = [ ];
      "Mod+Shift+Page_Up".action.move-workspace-up = [ ];
      "Mod+Shift+U".action.move-workspace-down = [ ];
      "Mod+Shift+I".action.move-workspace-up = [ ];

      # ---СКРОЛЛ МЫШИ (С ограничением задержки кулдауна) ---
      "Mod+WheelScrollDown" = { cooldown-ms = 150; action.focus-workspace-down = [ ]; };
      "Mod+WheelScrollUp" = { cooldown-ms = 150; action.focus-workspace-up = [ ]; };
      "Mod+Ctrl+WheelScrollDown" = { cooldown-ms = 150; action.move-column-to-workspace-down = [ ]; };
      "Mod+Ctrl+WheelScrollUp" = { cooldown-ms = 150; action.move-column-to-workspace-up = [ ]; };

      "Mod+WheelScrollRight".action.focus-column-right = [ ];
      "Mod+WheelScrollLeft".action.focus-column-left = [ ];
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = [ ];
      "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [ ];

      "Mod+Shift+WheelScrollDown".action.focus-column-right = [ ];
      "Mod+Shift+WheelScrollUp".action.focus-column-left = [ ];
      "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [ ];
      "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [ ];

      # --- ПЕРЕКЛЮЧЕНИЕ НА ЦИФРОВЫЕ ВОРКСПЕЙСЫ (1-9) ---
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      "Mod+Shift+1".action.move-window-to-workspace = 1;
      "Mod+Shift+2".action.move-window-to-workspace = 2;
      "Mod+Shift+3".action.move-window-to-workspace = 3;
      "Mod+Shift+4".action.move-window-to-workspace = 4;
      "Mod+Shift+5".action.move-window-to-workspace = 5;
      "Mod+Shift+6".action.move-window-to-workspace = 6;
      "Mod+Shift+7".action.move-window-to-workspace = 7;
      "Mod+Shift+8".action.move-window-to-workspace = 8;
      "Mod+Shift+9".action.move-window-to-workspace = 9;

      # --- УПРАВЛЕНИЕ КОЛОНКАМИ (Дробление и Слияние) ---
      "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
      "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
      "Mod+Comma".action.consume-window-into-column = [ ];
      "Mod+Period".action.expel-window-from-column = [ ];

      # --- РАЗМЕРЫ ОКНА И ФУЛЛСКРИН ---
      "Mod+Shift+R".action.switch-preset-column-width = [ ];
      "Mod+Ctrl+R".action.reset-window-height = [ ];
      "Mod+Shift+F".action.fullscreen-window = [ ];
      "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];
      "Mod+Shift+C".action.center-column = [ ];
      "Mod+Ctrl+C".action.center-visible-columns = [ ];

      # --- ТОНКАЯ РЕГУЛИРОВКА ШИРИНЫ И ВЫСОТЫ ---
      "Mod+Minus".action.set-column-width = "-5%";
      "Mod+Equal".action.set-column-width = "+5%";
      "Mod+Shift+Minus".action.set-window-height = "-5%";
      "Mod+Shift+Equal".action.set-window-height = "+5%";

      # --- СИСТЕМНЫЕ ДЕЙСТВИЯ (Блокировка / Выход) ---
      "Mod+Escape" = {
        allow-inhibiting = false;
        action.toggle-keyboard-shortcuts-inhibit = [ ];
      };
      "Mod+Shift+E".action.quit = [ ];
      "Ctrl+Alt+Delete".action.quit = [ ];
      "Mod+Shift+P".action.power-off-monitors = [ ];
    };

    # Конфигурация оверлея подсказок на верхнем уровне настроек
    hotkey-overlay = {
      # Если захотите отключить всплывающее окно при старте, раскомментируйте строку ниже:
      # skip-at-startup = true;
    };
  };
}
