{ unstable, ... }: {
  services.desktopManager.cosmic = {
    enable = true;
  };

  environment.systemPackages = [
    unstable.telegram-desktop
    unstable.cosmic-session
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
