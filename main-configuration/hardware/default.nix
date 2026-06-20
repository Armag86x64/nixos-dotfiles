{ ... }: {
  imports =
  [ 
    # ./hardware-configuration.nix
    ./bluetooth.nix
    ./audio.nix
    ./gpu.nix
    ./cpu.nix
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;  
}
