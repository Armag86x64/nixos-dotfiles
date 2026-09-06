{ pkgs, ... }: 
let
  waybar-dwl-script = pkgs.writeShellApplication {
    name = "waybar-dwl";
    
    runtimeInputs = with pkgs; [ 
      coreutils 
      procps 
      gnugrep 
      gnused 
      gawk 
      inotify-tools 
    ];

    text = builtins.readFile ../scripts/waybar-dwl.sh;
  };
in
{
  /* L E F T */
  home.packages = [ waybar-dwl-script ];

  programs.waybar.settings.mainBar = {
    "custom/void-left" = {
      format = "   ";
      min-length = 1;
    };

    "custom/dwl" = {
      exec = "${waybar-dwl-script}/bin/waybar-dwl eDP-1";
      format = "{}";
      return-type = "json";
      max-length = 80;
    };

    "niri/workspaces" = {
      format = "{icon}";
      persistent-workspaces = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
      };
      format-icons = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        active = "";
        default = "";
      };
      all-outputs = true;
      sort-by-number = true;
    };
  };
}
