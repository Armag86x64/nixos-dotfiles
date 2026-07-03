{ ... }:

{
  imports = [
    ./ui.nix
    ./plugins.nix
    ./hotkeys.nix
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
      mouse = "a";
      clipboard = "unnamedplus";
    };
  };
}
