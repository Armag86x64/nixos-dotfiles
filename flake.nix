{
  description = "My flakes";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    stable.url = "github:nixos/nixpkgs/nixos-25.11";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "stable";
    };

    freesmlauncher = {
      url = "github:FreesmTeam/FreesmLauncher";
      inputs.nixpkgs.follows = "unstable"; 
    };
  };

  outputs = { self, stable, unstable, disko, home-manager, freesmlauncher, ... }@inputs: 
  let
    system = "x86_64-linux";
    
    nixpkgsConfig = {
      allowUnfree = true;
    };

    stable-pkgs = import stable {
      inherit system;
      config = nixpkgsConfig;
    };

    unstable-pkgs = import unstable {
      inherit system;
      config = nixpkgsConfig;
    };
  in {
    nixosConfigurations.altair = stable.lib.nixosSystem {
      system = "x86_64-linux";
    
      specialArgs = { 
        inherit inputs;
        stable = stable-pkgs; 
        unstable = unstable-pkgs; 
        freesmlauncher = freesmlauncher; 
      }; 

      modules = [
        # Подключаем модуль Disko в систему
        disko.nixosModules.disko
        
        # Подключаем декларативную конфигурацию дисков
        ./main-configuration/disko-config.nix

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
