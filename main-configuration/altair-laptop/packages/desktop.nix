{ stable, unstable, ... }: {
  services.desktopManager.cosmic = {
    enable = true;
  };

  environment.systemPackages = [
    unstable.telegram-desktop
    unstable.cosmic-session
    unstable.qbittorrent
    unstable.librewolf
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
