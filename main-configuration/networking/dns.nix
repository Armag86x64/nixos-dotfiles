{ config, lib, pkgs, ... }: {
    # Добавляем пакет zapret
  # environment.systemPackages = [ pkgs.zapret ];

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

  /*
  # 1. Инструменты для пентеста и отладки DNS
  environment.systemPackages = [ pkgs.dnsutils ];

  # 2. Сетевой стек: замыкаем DNS на себя
  networking = {
    nameservers = [ "127.0.0.1" ];
    networkmanager.dns = "none";
    resolvconf.enable = true;
    useDHCP = false; # Чтобы DHCP провайдера не лез в настройки
  };

  # 3. Отключаем мешающий resolved
  services.resolved.enable = false;

  # 4. Настройка "неубиваемого" прокси
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      # Слушать только локально на стандартном порту
      listen_addresses = [ "127.0.0.1:53" ];

      # Список серверов
      server_names = [ "cloudflare" "google" "quad9-doh-ip4-filter-pri" ];

      # Настройки выживания
      doh_servers = true;      # Маскировка под HTTPS (порт 443)
      block_ipv6 = true;       # Исключаем утечки и тормоза через IPv6
      force_tcp = true;        # TCP надежнее проходит через некоторые фильтры
      netprobe_timeout = 10;   # Даем больше времени на пробивку канала при старте

      # Игнорировать системный DNS, чтобы не зациклиться
      ignore_system_dns = true;
      
      # Отключаем пока анонимные маршруты (routes) для стабильности
      # Как только интернет заведется — добавим их для OPSEC.
    };  
  };
  */
}

/*{ config, lib, pkgs, ... }: {
  networking = {
    # Явно указываем адрес, где слушает dnscrypt-proxy2
    nameservers = [ "127.0.0.1" ];

    # ЭТО ГЛАВНОЕ: заставляет NixOS создать физический файл /etc/resolv.conf
    # вместо симлинка на неработающий systemd-resolved
    resolvconf.enable = true;

    # NetworkManager не должен пытаться управлять DNS
    networkmanager.dns = "none";
  };

  # Убедитесь, что это выключено
  services.resolved.enable = false;

  services.dnscrypt-proxy2.settings.listen_addresses = [ "127.0.0.1:53" ];

  services.dnscrypt-proxy2 = {
    enable = true; # Активирует службу. Без неё порт 53 на вашей машине будет закрыт, и резолвинг имен работать не будет.
  
    settings = {
      # server_names: Список разрешенных серверов.
      # ЗАЧЕМ: Чтобы система не подключалась к сомнительным или медленным узлам. 
      # ЧТО БУДЕТ, ЕСЛИ УБРАТЬ: Прокси будет выбирать любой сервер из общего публичного списка (сотни узлов), что может быть небезопасно.
      server_names = [ "cloudflare" "google" "quad9-doh-ip4-filter-pri" "adguard-dns" ];
    
      # doh_servers = true;
      # ЗАЧЕМ: Принуждает использовать протокол DNS-over-HTTPS (порт 443). 
      # ЧТО БУДЕТ, ЕСЛИ УБРАТЬ (false): Прокси может использовать протокол DNSCrypt (порт 443 или другие), который легче идентифицировать как DNS-трафик. DoH — лучшая маскировка под обычного пользователя.
      doh_servers = true;
    
      # netprobe_timeout = 5;
      # ЗАЧЕМ: Время в секундах, которое прокси ждет ответа от сети при старте, чтобы понять, есть ли интернет. 
      # ЧТО БУДЕТ, ЕСЛИ УБРАТЬ: По умолчанию стоит 60 сек. Если сеть нестабильна, система будет "тупить" минуту при загрузке, прежде чем начнет резолвить имена.
      netprobe_timeout = 5;
    
      # routes: Анонимизация (Oblivious DNS).
      # ЗАЧЕМ: Это "Tor для DNS". Ваш запрос идет на реле (via), которое передает его конечному серверу (server_name). Конечный сервер видит IP-адрес реле, а не ваш. 
      # ЧТО БУДЕТ, ЕСЛИ УБРАТЬ: Cloudflare/Google увидят ваш реальный IP и смогут сопоставить историю запросов с вашей личностью. Для OSINT это критично (исключает "подглядывание" за исследователем).
      routes = [
        { server_name = "cloudflare"; via = ["anon-cs-de2" "anon-cs-at1"]; }
      ];

      # static: Статические записи серверов (SDNS-штампы).
      # ЗАЧЕМ: "План Б". Если провайдер заблокирует домен, с которого скачиваются списки серверов, прокси не будет знать, куда идти. Статический штамп содержит IP, ключ и протокол в одной строке.
      # ЧТО БУДЕТ, ЕСЛИ УБРАТЬ: При жесткой блокировке (уровня "великого файервола") сервис может не запуститься, так как не сможет обновить список живых серверов.
      /*static = {
        "custom-server" = { stamp = "sdns://..."; }; 
      };
    };
  };
}*/

/*
1. Откуда брать штампы для static?
Сайт: dnscrypt.info/public-servers

2. Зачем static, если есть server_names?
Когда вы используете server_names, прокси лезет в интернет за списком public-resolvers.md. 
Если провайдер заблокировал GitHub или cdn.js (где лежат эти списки), прокси не узнает IP-адреса серверов и не запустится.
static записи работают мгновенно, так как в штампе уже жестко прописан IP-адрес сервера.

3. Как добавить сервер в работу?
Мало просто прописать его в static. Чтобы прокси начал его использовать, добавьте его имя в список server_names:

services.dnscrypt-proxy2.settings = {
  static = {
    "my-emergency-dns" = { stamp = "sdns://..."; };
  };
  server_names = [ "cloudflare" "google" "my-emergency-dns" ]; # Добавили сюда имя из секции static
};

4. На что обратить внимание:
1) IPv4 vs IPv6: Убедитесь, что штамп соответствует вашему типу сети. На сайте dnscrypt.info есть фильтры.
2) Протокол: Ищите штампы с пометкой DoH, если ваша цель — маскировка под веб-трафик.
3) No Logs / No Filter: Для OSINT и пентеста выбирайте серверы с тегами No logs и No filter, чтобы ваши запросы не цензурировались и не записывались.
*/
