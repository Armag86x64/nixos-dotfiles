{ pkgs, ... }:

{
  programs.nixvim = {
    colorschemes.ashen.enable = false;

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "ashen.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "ficd0";
          repo = "ashen.nvim";
          rev = "main";
          hash = "sha256-yC9V58zieE8YvEuAnJhEOgONrudUJgQFqC59cKo97/g=";
        };
      })
    ];

    extraConfigLua = ''
      vim.cmd([[colorscheme ashen]])

      -- Кастомизация цветов меню автодополнения (Cmp) под палитру Ashen
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#181819", fg = "#c4c4c4" })                 -- Фон и текст меню
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#2d2d30", fg = "#ffffff", bold = true }) -- Выбранный элемент
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#181819", fg = "#3f3f46" })           -- Смягченные границы окон
      vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#181819" })
    '';

    plugins = {
      lualine = {
        enable = true;
        settings.options.theme = "auto"; 
      };
      web-devicons.enable = true;
    };
  };
}
