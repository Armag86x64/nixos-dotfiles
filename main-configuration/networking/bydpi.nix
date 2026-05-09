{ config, pkgs, ... }: # Начало файла

{
  # Настройка сервиса zapret
  services.zapret = {
    enable = true;
    params = [
      "--dpi-desync=fake,split2"
      "--dpi-desync-ttl=5"
      "--dpi-desync-fooling=md5sig,badsum"
      "--qnum=200"
    ];
  };

  # Исправление прав доступа (чтобы не было 'Operation not permitted')
  systemd.services.zapret.serviceConfig = {
    User = "root";
    DynamicUser = false;
    CapabilityBoundingSet = [ "CAP_NET_ADMIN" "CAP_NET_RAW" ];
    AmbientCapabilities = [ "CAP_NET_ADMIN" "CAP_NET_RAW" ];
  };

  # Правила файрвола
  networking.firewall = {
    checkReversePath = false;
    extraCommands = ''
      iptables -t mangle -A POSTROUTING -p tcp --dport 443 -j NFQUEUE --queue-num 200 --queue-bypass
      iptables -t mangle -A POSTROUTING -p udp --dport 443 -j NFQUEUE --queue-num 200 --queue-bypass
    '';
  };
}
