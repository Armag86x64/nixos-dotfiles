{ config, unstable, ... }: {
  /*networking.enableIPv6 = false;

  environment.systemPackages = [ unstable.byedpi ];

  systemd.services.byedpi = {
    description = "ByeDPI Proxy Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # Проверенный синтаксис коротких флагов (комбинация против жесткого ТСПУ)
      ExecStart = "${unstable.byedpi}/bin/ciadpi -i 127.0.0.1 -p 1080 -o 1 -d 3 -s 8 -s 8+s -o 30+s -r 26+s -T 5 -A t -X -b 65536";
      Restart = "always";
      User = "nobody";
    };
  };
  */
}
