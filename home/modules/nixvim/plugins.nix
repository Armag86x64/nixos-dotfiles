{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
  ];

  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings.highlight.enable = true;
      };

      telescope.enable = true;
      neo-tree.enable = true;

      lsp = {
        enable = true;
        servers = {
          # Надежная и быстрая конфигурация nixd
          nixd = {
            enable = true;
          };

          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };

      lsp-lines.enable = false;

      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; priority = 1000; } # Ставим LSP наивысший приоритет
            { name = "buffer"; priority = 500; }
            { name = "path"; priority = 250; }
          ];

          window = {
            completion.border = "rounded";
            documentation.border = "rounded";
          };

          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "W" = "cmp.mapping.select_prev_item()";
            "<Up>" = "cmp.mapping.select_prev_item()";
            "S" = "cmp.mapping.select_next_item()";
            "<Down>" = "cmp.mapping.select_next_item()";
            "<C-e>" = "cmp.mapping.close()";
          };
        };
      };

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
    };

    opts.updatetime = 300;

    extraConfigLua = ''
      vim.diagnostic.config({
        virtual_text = false,
        signs = false,
        underline = false,
        float = false,
      })
    '';
  };
}
