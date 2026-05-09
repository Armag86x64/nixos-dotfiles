{ ... }: {
    imports =
        [ 
          ./hardware.nix
          ./bluetooth.nix
          ./audio.nix
          ./gpu.nix
          ./cpu.nix
        ];  
}
