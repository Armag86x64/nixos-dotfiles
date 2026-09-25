{ ... }:

{
  services.zapret = {
    enable = false;
    
    httpSupport = false;
    udpSupport = true;
    udpPorts = [ "443" ];

    configureFirewall = true;

    params = [
    "--dpi-desync=split2"
    "--dpi-desync-split-pos=2"
    "--dpi-desync-repeats=6"
    "--dpi-desync-fooling=md5sig"
    "--dpi-desync-ttl=5"
    ];

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
