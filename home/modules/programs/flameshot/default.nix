{ pkgs, ... }: {
  home.packages = [ pkgs.grim ];

  services.flameshot = {
    enable = true;
    package = pkgs.flameshot;

    settings = {
      General = {
        useGrimAdapter = true;
        disabledGrimWarning = true;
        showStartupLaunchMessage = false;
      };
    };
  };
}
