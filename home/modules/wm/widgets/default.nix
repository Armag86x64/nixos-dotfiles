{ unstable, ... }: {
  imports = [
    ./sound
  ];

  programs.eww = {
    enable = true;
    package = unstable.eww;
  };
}
