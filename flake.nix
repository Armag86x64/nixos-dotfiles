{
  description = "Мой первый конфиг на флейках";

  inputs = {
    # Берем пакеты самой NixOS (ветка unstable для 25.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Берем Home Manager, который совместим с этими пакетами
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.altair = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # или ваша архитектура
    
      # ВОТ ЭТА СТРОКА ВАЖНА:
      specialArgs = { inherit inputs; }; 

      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # ПРАВИЛЬНОЕ МЕСТО ДЛЯ ПОДКЛЮЧЕНИЯ:
          home-manager.users.soundwave = ./home/home.nix;
        }
      ];
    };
  };
}
