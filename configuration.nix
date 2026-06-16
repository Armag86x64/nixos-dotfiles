{ pkgs, inputs, ... }: {
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
        inputs.home-manager.packages.${pkgs.system}.default
    ];

    services.envfs.enable = true;
    programs.nix-ld.enable = true;

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    system.stateVersion = "25.11"; 
}
