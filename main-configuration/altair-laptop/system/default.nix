{ ... }: {
	imports = [
    ./kernel.nix
    ./user.nix
    ./variables.nix
		./bootloader.nix
    ./localization.nix
    ./nix-settings.nix
    ./virtualization.nix
	];
}
