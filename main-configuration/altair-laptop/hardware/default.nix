{ ... }: {
  imports =
  [ 
    # ./hardware-configuration.nix
    ./external-devs.nix
    ./bluetooth.nix
    ./audio.nix
    ./gpu.nix
    ./cpu.nix
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;  

  services.fstrim.enable = true; # Включает фоновую службу, которая очищает удалённые блоки данных для SSDшника
}
