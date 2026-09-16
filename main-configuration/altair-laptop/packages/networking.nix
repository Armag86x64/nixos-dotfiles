{ unstable, stable, ... }: {
  # VPN-client
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  programs.wireshark = {
    enable = true;
    package = unstable.wireshark;
  };

  /*
  services.v2raya = {
    enable = true;
    cliPackage = unstable.xray; 
  };
  */

  environment.systemPackages = [
    unstable.localsend
    
    stable.nginx


    # unstable.v2ray-geoip
    # unstable.v2ray-domain-list-community
  ];
}
