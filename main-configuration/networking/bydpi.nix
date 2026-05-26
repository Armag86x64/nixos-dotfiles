{ config, pkgs, ... }: # Начало файла

{
  # Правила файрвола
  /*
  networking.firewall = {
    checkReversePath = false;
    extraCommands = ''
      iptables -t mangle -A POSTROUTING -p tcp --dport 443 -j NFQUEUE --queue-num 200 --queue-bypass
      iptables -t mangle -A POSTROUTING -p udp --dport 443 -j NFQUEUE --queue-num 200 --queue-bypass
    '';
  };
  */
}
