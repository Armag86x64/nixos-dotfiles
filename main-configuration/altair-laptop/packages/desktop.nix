{ unstable, ... }: {
  environment.systemPackages = [
    unstable.telegram-desktop
    # unstable.penpot-desktop
    unstable.libreoffice
    unstable.qbittorrent
    unstable.librewolf
    unstable.chromium
    unstable.waypaper
    unstable.foliate
    unstable.thunar
    unstable.eog     # Eye of GNOME
  ];
}
