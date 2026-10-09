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
    gpu-context = "wayland";

    hwdec = "vaapi";

    dither-depth = "auto";
    temporal-dither = "yes";

    deband = "yes";
    deband-iterations = 2;
    deband-threshold = 32;
    deband-range = 16;
    deband-grain = 8;
  
    scale = "spline36";
    cscale = "spline36";
    dscale = "mitchell";

    sharpen = "0.0";
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

      thumbfast = {
        max_height = 200;
        max_width = 200;
        hwdec = "yes";
        spawn_first = "yes";
      };
    };

    bindings = {
      "TAB" = "script-binding uosc/toggle-ui";
      # "ESC" = "script-binding uosc/toggle-ui";
      "MBTN_RIGHT" = "script-binding uosc/menu";
    };
  };
}
