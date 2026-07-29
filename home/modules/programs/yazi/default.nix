{ stable, ... }: {
  imports = [
    ./settings.nix
    ./keymap.nix
    ./theme.nix
  ];

  programs.yazi = {
    enable = true;
    package = stable.yazi;
  };
}
