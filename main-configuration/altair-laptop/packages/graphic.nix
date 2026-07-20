{ unstable, stable, ... }: {
  programs.hyprland.enable = true;
  programs.xwayland.enable = true;

  environment.systemPackages = [
    # W A L L P A P E R
    stable.mpvpaper
    stable.awww

    # В с п о м о г а т е л ь н о е
    unstable.capitaine-cursors
    unstable.imagemagick
    unstable.libnotify
    unstable.tumbler
    unstable.eww

    # W A Y L A N D
    unstable.xwayland-satellite
    unstable.wl-clipboard
    unstable.xwayland
  ];
}
