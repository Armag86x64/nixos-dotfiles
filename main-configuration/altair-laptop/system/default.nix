{ ... }: {
	imports = [
    ./user.nix
    ./variables.nix
		./bootloader.nix
    ./nix-settings.nix
    ./virtualization.nix
	];
}
