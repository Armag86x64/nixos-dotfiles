{ config, lib, pkgs, ... }: {
    users.users.soundwave = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [];
    };
}
