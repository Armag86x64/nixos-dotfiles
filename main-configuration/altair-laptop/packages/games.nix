{ pkgs, stable, unstable, freesmlauncher, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;  
in {
  programs.gamemode.enable = true;

  environment.systemPackages = [
    freesmlauncher.packages.${system}.freesmlauncher
    unstable.mindustry-wayland

    # For gaming
    stable.jdk8
  ];
}
