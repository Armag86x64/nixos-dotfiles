{ pkgs, inputs, ... }: 
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [
    ./services
  ];

  services.libinput.enable = true;

  time.timeZone = "Europe/Moscow";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # boot.kernelPackages = pkgs.lib.mkForce pkgs.linuxPackages_6_12;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  documentation.enable = false;
  documentation.nixos.enable = false;

  environment.systemPackages = [
    inputs.home-manager.packages.${system}.default
  ];

  services.envfs.enable = true;
  programs.nix-ld.enable = true;

  system.stateVersion = "25.11"; 
}
