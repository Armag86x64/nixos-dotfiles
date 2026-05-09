{ ... }: {
    imports =
        [ 
          ./hardware-configuration.nix
          ./bluetooth.nix
          ./audio.nix
          ./gpu.nix
          ./cpu.nix
        ];  
}
