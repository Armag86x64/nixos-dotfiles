{ ... }:

{
  programs.niri.settings.window-rules = [
    {
      matches = [
        { app-id = "^org\\.wezfurlong\\.wezterm$"; }
      ];
    }
    {
      matches = [ { app-id = "^foot$"; } ];
      default-column-width = { proportion = 0.5; };
    }
    {
      matches = [ { app-id = "^yazi-terminal$"; } ];
      open-maximized = true;
    }
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
    {
      matches = [ { title = "bw-volume-applet"; } ];
      # Включаем для него плавное скольжение
      open-maximized = false;
    }
  ];
}
