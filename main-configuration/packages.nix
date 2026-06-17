{ pkgs, stable, unstable, freesmlauncher, ... }:
let
  # Извлекаем текущую систему напрямую из pkgs
  system = pkgs.system; 
  
in {
    # programs.niri.enable = true;

    services.blueman.enable = true;
    services.udisks2.enable = true;

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    virtualisation.docker.enable = true;

    users.users.soundwave.extraGroups = [ "libvirtd" "docker" ];

    programs.gamemode.enable = true;

    programs.hyprland.enable = true;

    environment.systemPackages = [
        # W M s (из нестабильного)
        unstable.waybar
        unstable.mako
        unstable.libnotify

        # D e v O p s
        unstable.docker-compose
        unstable.docker

        # UI
        stable.swww
        unstable.nerd-fonts.caskaydia-cove
        unstable.capitaine-cursors
        unstable.eww
        unstable.xfce.tumbler
        unstable.imagemagick

        # W A Y L A N D
        unstable.xwayland
        unstable.xwayland-satellite       
        unstable.wl-clipboard
        unstable.grim

        # G A M E S
        freesmlauncher.packages.${system}.freesmlauncher
        unstable.unciv
 
        # D e s k t o p   A p p s
        unstable.chromium
        unstable.librewolf
        unstable.flameshot
        unstable.foot
        unstable.xfce.thunar
        unstable.blueman
        unstable.obsidian
        unstable.libreoffice
        unstable.waypaper
        unstable.foliate
        unstable.neohtop
        unstable.wofi
        unstable.eog 

        # C L I   u t i l s (стабильные версии для базовых утилит)
        stable.brightnessctl
        stable.fastfetch
        stable.vim-full
        stable.udiskie
        stable.bottom
        stable.nano
        stable.wget
        stable.yazi
        stable.ncdu
        stable.tree
        stable.zsh
        stable.git

        # C o d i n g (смешанный подход)
        unstable.rust-analyzer
        unstable.zed-editor
        unstable.python311
        unstable.poetry
        unstable.rustup
        unstable.helix
        stable.gcc          # стабильный компилятор
        stable.nodejs       # стабильный Node.js

        # C o m p r e s s i o n (стабильные)
        stable.unzip
        stable.p7zip

        # G a m i n g (стабильный)
        stable.jdk8
    ];

    fonts = {
      packages = with unstable; [
        cascadia-code
        nerd-fonts.caskaydia-cove
        nerd-fonts.jetbrains-mono
        noto-fonts-color-emoji
        twemoji-color-font # Дополнительный пак, если Noto где-то забагует
      ];

      fontconfig = {
        enable = true;

        # КРИТИЧЕСКИЙ ПАРАМЕТР: Без этого Chromium видит Noto Emoji как пустые растры
        # и вместо смайликов рисует квадраты.
        useEmbeddedBitmaps = true; 

        # Настройка точного фолбека (порядка подмены)
        defaultFonts = {
          emoji     = [ "Noto Color Emoji" "Twemoji Mozilla" ];
          monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
          sansSerif = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
          serif     = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        };
      };
    };
}
