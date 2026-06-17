{ ... }: {
	networking.hostName = "altair";
  networking.enableIPv6 = false;
  networking.firewall.enable = true;
	networking.networkmanager.enable = true;
}
