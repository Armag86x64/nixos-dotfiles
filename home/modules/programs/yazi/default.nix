{ stable, ... }: {
  imports = [
    ./settings.nix
    ./keymap.nix
  ];

  programs.yazi = {
    enable = true;
    package = stable.yazi;
  };
}
