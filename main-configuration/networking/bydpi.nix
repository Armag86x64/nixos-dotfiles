{ config, pkgs, ... }: {
  networking.enableIPv6 = false;

  environment.systemPackages = [ pkgs.byedpi ];

  systemd.services.byedpi = {
    description = "ByeDPI Proxy Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # Параметры -d 1 -f 1 -e 1 разбивают HTTP/HTTPS запросы
      ExecStart = "${pkgs.byedpi}/bin/ciadpi -i 127.0.0.1 -p 1080 -d 1 -f 1 -e 1";
      Restart = "always";
      User = "nobody";
    };
  };
}
