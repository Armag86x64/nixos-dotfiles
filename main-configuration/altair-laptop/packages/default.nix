{ ... }: {
  imports = [
    ./dwl
    ./cli.nix
    ./games.nix
    ./fonts.nix
    ./docker.nix
    ./coding.nix
    ./desktop.nix
    ./graphic.nix
    ./networking.nix
  ];

  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
}
