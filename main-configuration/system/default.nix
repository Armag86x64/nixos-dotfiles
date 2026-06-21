{ ... }: {
	imports = [
		./bootloader.nix
		./nix-settings.nix
		./user.nix
		./variables.nix
	];
}
