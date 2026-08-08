{ stable, ... }: {
  services.udisks2.enable = true;

  environment.systemPackages = [    
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

    # C o m p r e s s i o n
    stable.unzip
    stable.p7zip
    stable.rar
  ];
}
