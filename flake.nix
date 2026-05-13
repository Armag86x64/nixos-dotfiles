{
  description = "My flakes";

  inputs = {
    # Берем пакеты самой NixOS (ветка unstable)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Подключаем инструмент автоматической разметки дисков Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Берем Home Manager, который совместим с этими пакетами
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, home-manager, ... }@inputs: {
    nixosConfigurations.altair = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
    
      specialArgs = { inherit inputs; }; 

      modules = [
        # Подключаем модуль Disko в систему
        disko.nixosModules.disko
        
        # Подключаем декларативную конфигурацию дисков
        ./main-configuration/disk-config.nix

        # ЗАЩИТА: отключаем генерацию файловых систем на живой системе altair.
        # Это гарантирует, что nixos-rebuild switch НЕ затронет ваши текущие диски.
        { disko.enableConfig = false; }

        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.soundwave = ./home/home.nix;
        }
      ];
    };
  };
}
