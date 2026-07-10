{ unstable, ... }: {
  programs.nixvim = {
    extraPackages = with unstable; [
      markdown-oxide
    ];

    plugins.mkdnflow = {
      enable = true;

      defaultMappings = false;

      settings = {
        silent = true;
        mappings = {
          MkdnNextHeading = [ "n" "]]" ];
          MkdnPrevHeading = [ "n" "[[" ];
        };
      };
    };

    highlight = {
      MyMarkdownH1 = { fg = "#ffffff"; bold = true; }; # Кристально белый (главный акцент)
      MyMarkdownH2 = { fg = "#dcdcdc"; bold = true; }; # Светло-серый (Gainsboro)
      MyMarkdownH3 = { fg = "#b0b0b0"; };              # Насыщенный серый
      MyMarkdownH4 = { fg = "#888888"; };              # Средний серый
      MyMarkdownH5 = { fg = "#666666"; };              # Темно-серый
      MyMarkdownH6 = { fg = "#444444"; };              # Глубокий темный серый (минимальный приоритет)

      MyMarkdownBgEmpty = { bg = "none"; ctermbg = "none"; };

      RenderMarkdownCode = { bg = "#1a1a1a"; }; 
    };

    # Рендер md-разметки
    plugins.render-markdown = {
      enable = true;
      settings = {
        heading = {
          # sign = true;
          background = false;
          position = "inline";

          foregrounds = [
            "MyMarkdownH1"
            "MyMarkdownH2"
            "MyMarkdownH3"
            "MyMarkdownH4"
            "MyMarkdownH5"
            "MyMarkdownH6"
          ];

          backgrounds = [
            "MyMarkdownH1"
            "MyMarkdownH2"
            "MyMarkdownH3"
            "MyMarkdownH4"
            "MyMarkdownH5"
            "MyMarkdownH6"
          ];
        };

        code = {
          icon = true;
          style = "normal";
          border = "thin";
          highlight = "RenderMarkdownCode";
        };
        checkbox = {
          enabled = true;
          unchecked.icon = "   ";
          checked.icon = " ";
        };
      };
    };

    plugins.obsidian = {
      enable = true;
      settings = {
        mappings = {}; # Отключение встроенных хоткеев

        workspaces = [
          {
            name = "notes";
            path = "~/Notes";
          }
          {
            name = "DevOps";
            path = "~/Notes/DevOps";
          }
          {
            name = "NixOs";
            path = "~/Notes/NixOs";
          }
        ];

        daily_notes = {
          folder = "Daily";
          date_format = "%Y-%m-%d";
          alias_format = "%B %d, %Y";
        };

        legacy_commands = false;

        # Логика генерации имен для новых файлов через [[]]
        note_id_func = {
          __raw = ''
            function(title)
              if title ~= nil then
                return title:gsub(" ", "-"):gsub("[^%w-_]", ""):lower()
              else
                return tostring(os.time())
              end
            end
          '';
        };

        # Генерация Frontmatter
        frontmatter = {
          # Включаем отображение метаданных на верхних строках
          enable = true; 
          func = {
            __raw = ''
              function(note)
                local out = { id = note.id, aliases = note.aliases, tags = note.tags }
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                  for k, v in pairs(note.metadata) do
                    out[k] = v
                  end
                end
                return out
              end
            '';
          };
        };

        # Настройки автодополнения связей [[]] через nvim-cmp
        completion = {
          nvim_cmp = true;
          min_chars = 2;
        };
      };
    };

    # 3. LSP для работы с графом и ссылками (markdown-oxide)
    plugins.lsp = {
      servers.markdown_oxide = {
        enable = true;
        # Настройка поддержки динамического отслеживания изменений в файлах
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true;
            };
          };
        };
      };
    };
  };
}
