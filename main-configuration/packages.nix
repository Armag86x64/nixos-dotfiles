{ config, lib, pkgs, ... }: {
    programs.hyprland.enable = true;
    services.blueman.enable = true;

    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "soundwave" ];

    environment.systemPackages = with pkgs; [
        # W M s
        hyprland
        niri
        waybar
        mako
        libnotify

        # UI
        swww
        nerd-fonts.caskaydia-cove
        capitaine-cursors
        eww
        xfce.tumbler
        imagemagick

        # W A Y L A N D
        xwayland
        xwayland-satellite       
        wl-clipboard
        grim # Захват экрана

        # G A M E S
        unciv
 
        # D e s k t o p   A p p s
        # telegram-desktop
        # google-chrome
        chromium
        librewolf
        flameshot
        foot
        xfce.thunar
        blueman
        obsidian
        libreoffice
        foliate
        neohtop
        wofi
        eog

        # C L I   u t i l s
        # vim 
        brightnessctl
        fastfetch
        vim-full
        udiskie
        bottom
        nano
        wget
        yazi
        ncdu
        git

        # C o d i n g
        rust-analyzer
        zed-editor
        python311
        poetry
        rustup
        nodejs
        helix
        gcc
       # xclip

        # C o m p r e s s i o n
        unzip
        p7zip

        # G a m i n g
        jdk8
    ];

    fonts.packages = with pkgs; [
        cascadia-code
        nerd-fonts.caskaydia-cove
    ];
}
