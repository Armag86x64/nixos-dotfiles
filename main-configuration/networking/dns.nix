{ ... }: {
  networking.nameservers = [
    "1.1.1.1" # Cloudflare
    "8.8.8.8" # Google
  ];
}
