{ ... }: {
	imports = [
    ./main-settings.nix
    ./firewall.nix
    ./zapret.nix
    ./bydpi.nix
    ./dns.nix
	];
}

