{ ... }:

{
  services.zapret = {
    enable = true;
    
    # Включаем перехват UDP (критично для Discord Voice и подавления QUIC)
    udpSupport = true;
    udpPorts = [ "443" "50000:65535" ];

    # Чистый NixOS-синтаксис параметров БЕЗ опасных разделителей --new
    params = [
      "--dpi-desync=fake,disorder2"
      "--dpi-desync-repeats=6"
      "--dpi-desync-ttl=2"
      "--dpi-desync-autottl=2"
      "--dpi-desync-fooling=badseq"
      "--dpi-desync-split-pos=midsld"
      "--dpi-desync-any-protocol=1"
    ];

    # Полный список доменов для обработки
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
      
      # Discord
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
