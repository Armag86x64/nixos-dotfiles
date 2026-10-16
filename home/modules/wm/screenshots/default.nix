{ unstable, ... }: {
  home.packages = [ 
    unstable.grim 
    unstable.slurp
    unstable.wayfreeze
  ];

  programs.satty = {
    enable = true;
    package = unstable.satty;

    settings = {
      general = {
        save-after-copy = true;
        output-filename = "~/Pictures/Screenshots/screenshot-%Y-%m-%d_%H:%M:%S.png";
      };
    };
  };
}
