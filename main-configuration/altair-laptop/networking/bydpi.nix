{ pkgs, ... }: {
  # Создаем автоматическую фоновую службу ByeDPI
  systemd.services.byedpi = {
    description = "ByeDPI - DPI bypass service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # Прямая ссылка на бинарник из пакета byedpi с вашими рабочими флагами
      ExecStart = "${pkgs.byedpi}/bin/ciadpi --ip 127.0.0.1 --port 1080 -d1 -d3+s -s6+s -d9+s -s12+s -d15+s -s20+s -d25+s -s30+s -d35+s -r1+s -S -a1 -As -d1 -d3+s -s6+s -d9+s -s12+s -d15+s -s20+s -d25+s -s30+s -d35+s -S -a1";
      Restart = "always";
      RestartSec = "5s";
      User = "nobody";
    };
  };

  # Обязательно добавляем сам пакет byedpi в систему, чтобы NixOS видела его при сборке
  environment.systemPackages = with pkgs; [
    byedpi
  ];
}
