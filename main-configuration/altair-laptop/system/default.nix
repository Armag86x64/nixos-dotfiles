{ ... }: {
	imports = [
    ./kernel.nix
    ./user.nix
    ./variables.nix
		./bootloader.nix
    ./nix-settings.nix
    ./virtualization.nix
	];
}
