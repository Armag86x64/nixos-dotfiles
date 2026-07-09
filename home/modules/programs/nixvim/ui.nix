{ pkgs, ... }:
{
  programs.nixvim = {
    opts = {
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smarttab = true;
      list = false;
    };
   
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "monoglow-nvim";
        src  = pkgs.fetchFromGitHub {
          owner = "wnkz";
          repo  = "monoglow.nvim";
          rev   = "main";
          hash  = "sha256-EIslqnOIOLfQ7e7L1FvwfVfel6h+UPFIUcSgvp8zf0E=";
        };
      })
    ];

    colorscheme = "monoglow";
		
    extraConfigLua = ''
      -- Применяем тему оформления
      require("monoglow").setup({
      -- Настройки
      })

      -- Переопределяем цвета для rainbow-delimiters через событие ColorScheme
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.api.nvim_set_hl(0, 'RainbowDelimiterRed',    { fg = '#ffffff' }) -- Внешние скобки
          vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#e0e0e0' }) 
          vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue',   { fg = '#bcbcbc' }) 
          vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#9e9e9e' }) 
          vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen',  { fg = '#757575' }) 
          vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#616161' }) 
          vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan',   { fg = '#424242' }) -- Самые глубокие скобки

          -- Цвета для indent-blankline (ibl)
          vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#262626', nocombine = true }) -- Едва заметные направляющие
          vim.api.nvim_set_hl(0, 'IblScope',  { fg = '#1bfd9c', nocombine = true }) -- Яркий фокус текущего блока

          -- Перекрашиваем измененные git-папки и файлы в neo-tree
          vim.api.nvim_set_hl(0, 'NeoTreeGitModified',     { fg = '#1bfd9c' })
          vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked',    { fg = '#1bfd9c' })
          vim.api.nvim_set_hl(0, 'NeoTreeGitAdded',        { fg = '#1bfd9c' })
          vim.api.nvim_set_hl(0, 'GitSignsChange',         { fg = '#1bfd9c' })
        end,
      })

      -- Постепенное затухание скобок (от ярко-белого к темно-серому)
      vim.api.nvim_set_hl(0, 'RainbowDelimiterRed',    { fg = '#ffffff' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#e0e0e0' }) 
      vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue',   { fg = '#bcbcbc' }) 
      vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#9e9e9e' }) 
      vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen',  { fg = '#757575' }) 
      vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#616161' }) 
      vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan',   { fg = '#424242' })

      -- Цвета для indent-blankline (ibl)
      vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#262626', nocombine = true })
      vim.api.nvim_set_hl(0, 'IblScope',  { fg = '#4ddb9e', nocombine = true })

      -- Перекрашиваем измененные git-папки и файлы в neo-tree
      vim.api.nvim_set_hl(0, 'NeoTreeGitModified',     { fg = '#1bfd9c' })
      vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked',    { fg = '#1bfd9c' })
      vim.api.nvim_set_hl(0, 'NeoTreeGitAdded',        { fg = '#1bfd9c' })
      vim.api.nvim_set_hl(0, 'GitSignsChange',         { fg = '#1bfd9c' })

      -- Автоматически включаем IBL при открытии любого файла 
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        pattern = "*",
        command = "IBLEnable",
      })
    '';
		
		# Разноцветные скобки
    plugins.rainbow-delimiters = {
      enable = true;

      settings = {
        enable = true;
        
        query = {
          "" = "rainbow-delimiters";
        };

        highlight = [
          "RainbowDelimiterRed"
          "RainbowDelimiterYellow"
          "RainbowDelimiterBlue"
          "RainbowDelimiterOrange"
          "RainbowDelimiterGreen"
          "RainbowDelimiterViolet"
          "RainbowDelimiterCyan"
        ];
      };
    };
		
		# Подсветка отступов
		plugins.indent-blankline = {
		  enable = true;

      settings = {
        indent = {
          char = "▏";
            highlight = [
              "IblIndent"
            ];
        };
        
        scope = {
          enabled = true;
         
          highlight = [
            "IblScope"
          ];
          show_start = false; # Горизонтальные линии отключены
          show_end = false;

          # Настройка отслеживания узлов Tree-sitter для Nix
          include = {
            node_type = {
              # Заставляем плагин реагировать только на реальные блоки кода и структуры данных
              nix = [ "attrset" "let_expression" "rec_attrset" "binding" ];
            };
          };

          exclude = {
            node_type = {
              # Запрещаем плагину считать весь файл одной большой областью видимости
              nix = [ "source_file" "root" ];
            };
          };
        };
      };
		};

    # Разноцветные комментарии
    plugins.todo-comments = {
      enable = true;
    };

    plugins = {
      lualine = {
        enable = true;
        settings.options.theme = "auto"; 
      };
      web-devicons.enable = true;
    };
  };
}

/*
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

programs.nixvim = {
    
		extraPlugins = [
		  (pkgs.vimUtils.buildVimPlugin {
		    name = "bearded-nvim";
		    src = pkgs.fetchFromGitHub {
		      owner = "Ferouk";
		      repo = "bearded-nvim";
		      rev = "master";
		      hash = "sha256-o6S6M31EMxl5dDxUNFAqG/3J8LRImGAayq7oUPWRSMo="; 
		    };
		  })
		];
    */
    
    /*
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
        transparent = true; # Меняйте на false, если не хотите прозрачность
      };
    };
}
*/
