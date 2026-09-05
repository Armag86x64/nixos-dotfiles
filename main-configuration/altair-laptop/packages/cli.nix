{ stable, ... }: {
  services.udisks2.enable = true;

  environment.systemPackages = [
    # D e s k t o p
    stable.taskwarrior-tui
    stable.taskwarrior3
    stable.ffmpeg
    stable.yt-dlp         # Download video from youtube
    
    # I m p o r t a n t
    stable.brightnessctl
    stable.fastfetch
    stable.vim-full
    stable.udiskie
    stable.bottom
    stable.nano
    stable.wget
    stable.ncdu
    stable.tree
    stable.zsh

    # C o m p r e s s i o n (стабильные)
    stable.unzip
    stable.p7zip
    stable.rar
  ];
}
