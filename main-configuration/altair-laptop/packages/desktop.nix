{ stable, unstable, ... }: {
  environment.systemPackages = [
    unstable.telegram-desktop
    unstable.qbittorrent
    unstable.librewolf
    unstable.keepassxc
    unstable.chromium
    unstable.waypaper
    unstable.foliate
    unstable.blanket
    unstable.thunar
    unstable.motrix

    stable.super-productivity
    stable.freecad
    stable.krita
  ];
}
