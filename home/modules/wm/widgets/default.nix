{ unstable, ... }: {
  imports = [
    ./sound
  ];

  programs.eww = {
    enable = true;
    package = unstable.eww;
  };

  xdg.configFile."eww" = {
    source = ./../widgets; # Укажите путь к вашей папке eww относительно home.nix
    recursive = true;
  };
}
