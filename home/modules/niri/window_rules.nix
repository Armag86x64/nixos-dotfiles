{ ... }:

{
  programs.niri.settings.window-rules = [
    {
      matches = [
        { app-id = "^org\\.wezfurlong\\.wezterm$"; }
      ];
      # Сюда можно добавлять действия для этого правила, например:
      # default-column-width = { };
    }
    # Исправленное правило для mpv
    {
      matches = [
        { app-id = "^mpv$"; }
      ];
      
      # Заставляем открываться в плавающем режиме
      open-floating = true;
      
      # Правильный синтаксис Niri для задания размеров плавающего окна (1280x720)
      default-column-width = { fixed = 1280; };
      default-window-height = { fixed = 720; };
      
      # Полностью убираем радиус скругления для этого окна
      geometry-corner-radius = {
        bottom-left = 0.0;
        bottom-right = 0.0;
        top-left = 0.0;
        top-right = 0.0;
      };
    }
  ];
}
