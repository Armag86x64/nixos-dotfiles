{ unstable, ... }: {
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  services.v2raya = {
    enable = true;
    cliPackage = unstable.xray; 
  };

  environment.systemPackages = [
    unstable.throne
    unstable.v2ray-geoip
    unstable.v2ray-domain-list-community
  ];
}
