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

      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true; 
        };
      };

      telescope.enable = true;
      neo-tree.enable = true;

      lsp = {
        enable = true;
        servers = {
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
            { name = "nvim_lsp"; priority = 1000; }
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
            "<Tab>" = "cmp.mapping.select_next_item()";
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
      -- 1. Сохраняем оригинальный метод записи диагностики Neovim
      local original_set_diagnostic = vim.diagnostic.set

      -- 2. Переопределяем метод на самом глубоком системном уровне ядра
      vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
        -- Проверяем тип файла для буфера, куда пришла диагностика
        if vim.bo[bufnr].filetype == "nix" then
          -- Разрешаем запись в память и обработку ТОЛЬКО для nix-файлов
          original_set_diagnostic(namespace, bufnr, diagnostics, opts)
        else
          -- Для всех остальных файлов (Rust и др.) полностью очищаем кэш и игнорируем входящие данные
          original_set_diagnostic(namespace, bufnr, {}, opts)
        end
      end

      -- 3. Настройка внешнего вида (отработает только там, где диагностика разрешена)
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          severity_sort = true,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        float = {
          border = "rounded",
          source = "always",
        },
      })
    '';
  };
}
