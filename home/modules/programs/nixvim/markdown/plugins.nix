{ unstable, ... }: {
  programs.nixvim = {
    extraPackages = with unstable; [
      markdown-oxide
    ];

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

    # --- P l u g i n s

    plugins.mkdnflow = {
      enable = true;

      # defaultMappings = false;

      settings = {
        silent = true;
        mappings = {
          MkdnNextHeading = [ "n" "]]" ];
          MkdnPrevHeading = [ "n" "[[" ];
        };
      };
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

    /*
    plugins.lsp = {
      servers.markdown_oxide = {
        enable = true;
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true;
            };
          };
        };
      };
    };
    */
  };
}
