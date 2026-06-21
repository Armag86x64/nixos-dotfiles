{ pkgs, inputs, ... }: 
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [
    ./services
    ./main-configuration/system
    ./main-configuration/hardware
    ./main-configuration/networking
    ./main-configuration/packages.nix
  ];

  services.libinput.enable = true;

  time.timeZone = "Europe/Moscow";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # boot.kernelPackages = pkgs.lib.mkForce pkgs.linuxPackages_6_12;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  documentation.enable = false;
  documentation.nixos.enable = false;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = [
    inputs.home-manager.packages.${system}.default
  ];

  services.envfs.enable = true;
  programs.nix-ld.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  system.stateVersion = "25.11"; 
}
