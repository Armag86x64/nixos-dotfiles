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
    unstable.eog     # Eye of GNOME

    stable.super-productivity
    stable.freecad
    stable.krita
  ];
}
