{ unstable, ... }: {
  home.packages = [ unstable.grim ];

  services.flameshot = {
    enable = true;
    package = unstable.flameshot;

    settings = {
      General = {
        useGrimAdapter = true;
        disabledGrimWarning = true;
      };
    };
  };
}
