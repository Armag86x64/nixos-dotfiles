{ config, ... }: {
	networking.hostName = "altair";
  networking.firewall.enable = true;
	networking.networkmanager.enable = true;
}
