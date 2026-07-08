{ pkgs, ... }:
{
  programs.nixvim = {
    opts = {
      # Превращает табы в пробелы при вводе (очень важно для плагинов отступов)
      expandtab = true;
      shiftwidth = 2; # или 4, в зависимости от вашего стиля
      tabstop = 2;
      smarttab = true;
      # Управление отображением скрытых символов
      list = false;
    };

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
		
    extraConfigLua = ''
      -- Применяем тему оформления
      vim.cmd('colorscheme bearded-arc-blueberry')

      -- Переопределяем цвета для rainbow-delimiters через событие ColorScheme
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'bearded-arc-blueberry',
        callback = function()
          vim.api.nvim_set_hl(0, 'RainbowDelimiterRed',    { fg = '#ec75aa' }) -- Розовый
          vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#eec45c' }) -- Желтый
          vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue',   { fg = '#589ed7' }) -- Синий
          vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#f0935d' }) -- Оранжевый
          vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen',  { fg = '#78ce90' }) -- Зеленый
          vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#ca8bf4' }) -- Фиолетовый
          vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan',   { fg = '#62dfdb' }) -- Бирюзовый

          -- Цвета для indent-blankline (ibl)
          -- Обычные линии: приглушенный сине-серый под фон темы
          vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#2e3a50', nocombine = true })
          vim.api.nvim_set_hl(0, 'IblScope',  { fg = '#ec75aa', nocombine = true })
        end,
      })

      -- Вызываем один раз принудительно, чтобы цвета встали немедленно при первой загрузке
      vim.api.nvim_set_hl(0, 'RainbowDelimiterRed',    { fg = '#ec75aa' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#eec45c' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue',   { fg = '#589ed7' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#f0935d' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen',  { fg = '#78ce90' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#ca8bf4' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan',   { fg = '#62dfdb' })

      vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#2e3a50', nocombine = true })
      vim.api.nvim_set_hl(0, 'IblScope',  { fg = '#ec75aa', nocombine = true })

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
          char = "▏"; # Тонкий элегантный символ вертикальной линии
            highlight = [
              "IblIndent"
            ];
        };
        
        scope = {
          enabled = true;
         
          highlight = [
            "IblScope"
          ];
          show_start = false; # Горизонтальные линии отключены, чтобы не перегружать Nix-структуру
          show_end = false;

          # Настройка интеллектуального отслеживания узлов Tree-sitter для Nix
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
*/
