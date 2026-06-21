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
    };

    # Секция для специфичных условий (критические уведомления)
    extraConfig = ''
      [urgency=critical]
      border-color=#ffffff
      border-size=2
      default-timeout=10000
      padding=10,15
    '';
  };
}
