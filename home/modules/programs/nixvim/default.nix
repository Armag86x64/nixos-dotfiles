{ ... }:

{
  imports = [
    ./ui.nix
    ./plugins.nix
    ./hotkeys.nix
    ./markdown
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts = {
      number = true;
      relativenumber = false;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      smarttab = true;
      list = false;
      mouse = "a";
      clipboard = "unnamedplus";
    };
  };
}
