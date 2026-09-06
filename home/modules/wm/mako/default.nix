{ unstable, ... }:

{
  services.mako = {
    enable = true;
    package = unstable.mako;
    
    settings = {
      font = "JetBrainsMono Nerd Font 10";
      width = 400;
      height = 200;
      background-color = "#000000";
      text-color = "#ffffff";
      border-size = 1;
      border-color = "#333333";
      padding = "20";
      margin = "10";
      border-radius = 0;
      text-alignment = "left";
      default-timeout=2000;
      ignore-timeout=1;
    };

    extraConfig = ''
      [urgency=critical]
      border-color=#fc0b03
      border-size=2
      default-timeout=10000
      padding=10,15

      [urgency=low]
      border-color=#ffb700
      border-size=2
      default-timeout=10000
      padding=10,15
    '';
  };
}
