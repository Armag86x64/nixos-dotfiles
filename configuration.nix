{ config, lib, pkgs, inputs, ... }: {
    imports =
      [
          #./home/default.nix
          ./main-configuration/system
          ./main-configuration/hardware
          ./main-configuration/networking
          ./main-configuration/packages.nix
      ];  

    time.timeZone = "Europe/Moscow";

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.kernelPackages = pkgs.lib.mkForce pkgs.linuxPackages_6_12;

    documentation.enable = false;
    documentation.nixos.enable = false;

    # services.flatpak.enable = true;

    environment.systemPackages = [
        inputs.home-manager.packages.${pkgs.system}.default
    ];

    services.udisks2.enable = true;  

    programs.niri.enable = true;

    services.envfs.enable = true;

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    system.stateVersion = "25.11"; 
}
