{ unstable, stable, ... }: { 
  environment.systemPackages = [
    unstable.rust-analyzer
    unstable.zed-editor
    unstable.python311
    unstable.poetry
    unstable.rustup
    unstable.helix
    stable.nodejs
    stable.gcc

    # unstable.radare2
    # unstable.ghidra
    # unstable.gdb
    # unstable.gef

    stable.pkg-config
    stable.openssl
  ];
}
