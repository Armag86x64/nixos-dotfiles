{ unstable, stable, ... }: { 
  environment.systemPackages = [
    unstable.rust-analyzer
    unstable.zed-editor
    unstable.python311
    unstable.poetry
    unstable.rustup
    unstable.helix
    stable.nodejs       # стабильный Node.js
    stable.gcc          # стабильный компилятор

    stable.pkg-config
    stable.openssl
  ];
}
