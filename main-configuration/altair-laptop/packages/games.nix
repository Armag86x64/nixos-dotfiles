{ pkgs, stable, unstable, freesmlauncher, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;  
in {
  programs.gamemode.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override {
        extraArgs = "-cef-disable-gpu-compositing";
      };
    })   
  ];

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    remotePlay.openFirewall = true; # Открывает порты для Steam Remote Play
    dedicatedServer.openFirewall = true; # Открывает порты для выделенных серверов
  };

  environment.systemPackages = [
    freesmlauncher.packages.${system}.freesmlauncher
    unstable.mindustry-wayland

    # For gaming
    stable.jdk8
  ];
}
