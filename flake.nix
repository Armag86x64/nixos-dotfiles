{
  description = "My flakes";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-25.11";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "unstable";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

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

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "unstable"; # Следуем за вашей основной системной веткой
    };
  };

  outputs = { self, stable, unstable, disko, home-manager, freesmlauncher, niri, nixvim, firefox-addons, ... }@inputs: 
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
    nixosConfigurations.altair-laptop = stable.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = { 
            inherit inputs;
            stable = stable-pkgs; 
            unstable = unstable-pkgs; 
            freesmlauncher = freesmlauncher; 
        }; 

        modules = [
            disko.nixosModules.disko
            ./main-configuration/altair-laptop/disko-config.nix

            # --- ВСЕ НАСТРОЙКИ ---
            ./main-configuration/altair-laptop/default.nix

            # Фиксация имени хоста
            ({ ... }: { networking.hostName = "altair-laptop"; })
            # ------------------------------------------

            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = {
                    inherit inputs;
                    stable = stable-pkgs;
                    unstable = unstable-pkgs;
                };

                home-manager.users.soundwave = {
                    imports = [
                        nixvim.homeModules.nixvim
                        ./home/home.nix
                    ];
                };
            }
        ];
    };
  };
}
