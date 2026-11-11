{ pkgs, ... }: {
  # Создаем автоматическую фоновую службу ByeDPI
  systemd.services.byedpi = {
    description = "ByeDPI - DPI bypass service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # Прямая ссылка на бинарник из пакета byedpi с вашими рабочими флагами
      ExecStart = "${pkgs.byedpi}/bin/ciadpi --ip 127.0.0.1 --port 10800 -d1 -s1+s -d1+s -s3+s -d6+s -s12+s -d14+s -s20+s -d24+s -s30+s -a1";
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
