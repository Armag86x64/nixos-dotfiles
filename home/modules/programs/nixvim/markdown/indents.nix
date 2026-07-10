{ ... }: {
  programs.nixvim = {
    # Настроки красивого смещения текста
    plugins.no-neck-pain = {
      enable = true;
      settings = {
        width = 80;
      
        integrations = {
          neo-tree = {
            position = "left";
            reopen = true;
          };
        };

        buffers = {
          left.enabled = true;
          right.enabled = true;
          wo = {
            wrap = true;
            linebreak = true;
          };
        };
      };
    };

    # 2. Автокоманда для запуска плагина
    autoCmd = [
      {
        event = "FileType";
        pattern = "markdown";
        callback.__raw = ''
          function()
            vim.cmd("NoNeckPain")
          end
        '';
      }
    ];
  };
}
