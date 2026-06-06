{ ... }: # Аргумент unstable здесь больше не требуется

{
  imports = [
    ./ui.nix
    ./plugins.nix
    ./hotkeys.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # УДАЛЕНО: строка package = unstable.neovim; убрана!
    # NixVim теперь сам возьмет правильный и свежий Neovim из своего инпута.

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      mouse = "a";
      clipboard = "unnamedplus";
    };
  };
}
