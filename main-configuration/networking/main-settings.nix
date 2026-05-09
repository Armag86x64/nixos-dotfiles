{ config, pkgs, ... }: {
	networking.hostName = "altair";
	networking.networkmanager.enable = true;
}
