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
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = [
    freesmlauncher.packages.${system}.freesmlauncher
    # unstable.mindustry-wayland

    # For gaming
    stable.graalvmPackages.graalvm-ce
    stable.jdk8
  ];
}
