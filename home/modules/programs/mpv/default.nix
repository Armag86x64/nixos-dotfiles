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

  config = {
    vo = "gpu-next";
    gpu-context = "auto";
    
    hwdec = "vaapi-copy";

    profile = "gpu-hq";

    deband = "yes";
    deband-iterations = 3;
    deband-threshold = 48;
    deband-range = 24;
    deband-grain = 16;

    scale = "spline36";
    cscale = "spline36";
    dscale = "mitchell";

    sharpen = "0.5";

    scale-antiring = "0.6";
    cscale-antiring = "0.6";

    dither-depth = "auto";
  };

    scriptOpts = {
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
