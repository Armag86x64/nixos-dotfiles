{ pkgs, ... }: {
  networking.firewall.enable = true;  

  services.zapret = {
    enable = true;
    
    # 1. ВКЛЮЧАЕМ UDP (Критично для голосовых каналов Discord и борьбы с QUIC)
    udpSupport = true;
    # Стандартный 443 порт + диапазон портов голосовых серверов Discord (RTC)
    udpPorts = [ "443" "50000:65535" ];

    # 2. ПОДБОР СТРАТЕГИИ (Адаптировано под жесткий ТСПУ)
    params = [
      # Правило для HTTP (Оставляем базовым)
      "--filter-tcp=80"
      "--dpi-desync=fake,split2"
      "--dpi-desync-autottl=2"
      "--dpi-desync-fooling=md5sig"
      
      "--new"
      
      # Правило для HTTPS (Включаем перестановку пакетов disorder2 и сдвиг, как в вашем синтаксисе byedpi)
      "--filter-tcp=443"
      "--dpi-desync=fake,disorder2"
      "--dpi-desync-autottl=2"
      "--dpi-desync-fooling=badseq"
      "--dpi-desync-split-pos=midsld"
      
      "--new"
      
      # Правило для Discord и YouTube UDP трафика (Глушим QUIC и лечим RTC войс-пакеты)
      "--filter-udp=443,50000:65535"
      "--dpi-desync=fake"
      "--dpi-desync-repeats=6"
      "--dpi-desync-any-protocol=1"
    ];

    # 3. РАСШИРЕННЫЙ СПИСОК ДОМЕНОВ (YouTube + Discord)
    whitelist = [
      # YouTube и авторизация Google
      "youtube.com"
      "www.youtube.com"
      "googlevideo.com"
      "youtu.be"
      "ytimg.com"
      "ggpht.com"
      "googleusercontent.com"
      "accounts.google.com"
      "accounts.youtube.com"
      "://gstatic.com"
      "lh3.googleusercontent.com"
      "googleapis.com"
      "content-autofill.googleapis.com"
      "www.google.com"
      "google.com"
      
      # Discord (Все внутренние CDN, шлюзы авторизации и API)
      "discord.com"
      "www.discord.com"
      "discordapp.com"
      "discordapp.net"
      "discord.gg"
      "discord.media"
      "discordcdn.com"
      "discord.new"
      "discordstatus.com"
      "dis.gd"
      "discord-attachments-uploads-prd.storage.googleapis.com"
    ];
  };
} 
