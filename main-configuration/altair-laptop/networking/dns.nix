{ ... }: {
  # networking.networkmanager.insertNameservers = [ "8.8.8.8" "1.1.1.1" ];
  networking.nameservers = [
    "1.1.1.1" # Cloudflare
    "8.8.8.8" # Google
  ];
  # networking.networkmanager.dns = "none";
}
