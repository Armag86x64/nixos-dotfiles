{ ... }: {
  imports = [
    ./cli.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
