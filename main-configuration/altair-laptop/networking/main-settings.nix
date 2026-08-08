{ ... }: {
  networking.networkmanager.enable = true;
  networking.enableIPv6 = true;
  
  # For KVM:
  networking.bridges.default.interfaces = [ ];  
}
