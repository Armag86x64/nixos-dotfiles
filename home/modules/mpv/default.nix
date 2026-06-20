{ unstable, ... }:

{
  programs.mpv = {
    enable = true;

    package = unstable.mpv.override {
      scripts = [ 
        unstable.mpvScripts.uosc 
        unstable.mpvScripts.thumbfast 
      ];
    };

    # Конфигурация mpv.conf
    config = {
      gpu-context = "wayland";
      vo = "gpu-next";
      hwdec = "auto-safe";
      osc = false;
      border = false;
    };

    # Настройка параметров плагинов
    scriptOpts = {
      # Секция настроек для uosc
      uosc = {
        autohide = false;
        timeline_proximity_threshold = 0;
        controls_proximity_threshold = 0;
        timeline_size_min = 0;
        timeline_size_max = 40;
        refreshrate = 60;
      };

      # Секция настроек для thumbfast
      thumbfast = {
        max_height = 200;
        max_width = 200;
        hwdec = "yes";
        spawn_first = "yes";
      };
    };

    # Горячие клавиши
    bindings = {
      "TAB" = "script-binding uosc/toggle-ui";
      # "ESC" = "script-binding uosc/toggle-ui";
      "MBTN_RIGHT" = "script-binding uosc/menu";
    };
  };
}
