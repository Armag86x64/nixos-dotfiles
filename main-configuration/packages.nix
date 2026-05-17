{ config, lib, pkgs, ... }: {
    # programs.hyprland.enable = true;

    programs.niri.enable = true;

    services.blueman.enable = true;
    services.udisks2.enable = true;

    # virtualisation.virtualbox.host.enable = true;
    # users.extraGroups.vboxusers.members = [ "soundwave" ];

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    virtualisation.docker.enable = true;

    users.users.soundwave.extraGroups = [ "libvirtd" "docker"];


    environment.systemPackages = with pkgs; [
        # W M s
        # hyprland
        # niri
        waybar
        mako
        libnotify

        # D e v O p s
        docker-compose
        docker

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
        chromium
        librewolf
        flameshot
        foot
        xfce.thunar
        blueman
        obsidian
        libreoffice
        waypaper
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
        tree
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
