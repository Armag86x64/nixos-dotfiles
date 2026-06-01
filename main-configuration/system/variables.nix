{ config, lib,  ... }: {
    environment.variables.EDITOR = "vim";
    environment.variables.VISUAL = "vim";
 
    programs.vim.enable = true;
    programs.vim.defaultEditor = true;
}
