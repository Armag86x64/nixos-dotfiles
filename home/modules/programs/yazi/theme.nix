{ pkgs, ... }:

{
  programs.yazi = {
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      yatline = pkgs.yaziPlugins.yatline;
    };

    initLua = ''
      require("full-border"):setup {
        type = ui.Border.ROUNDED,
      }
    '';

    theme = {
      # Настройки основного менеджера
      mgr = {
        cwd = { fg = "#4ce0a8"; bold = true; };

        # Поиск и выделение
        find_keyword = { fg = "#e3ba6b"; bold = true; italic = true; underline = true; };
        find_position = { fg = "#d94141"; bg = "reset"; bold = true; italic = true; };

        # Маркеры файлов
        marker_copied = { fg = "#4ce0a8"; bg = "#4ce0a8"; };
        marker_cut = { fg = "#f25c5c"; bg = "#f25c5c"; };
        marker_marked = { fg = "#45c4ba"; bg = "#45c4ba"; };
        marker_selected = { fg = "#e3ba6b"; bg = "#e3ba6b"; };

        # Счетчики и рамки панелей
        count_copied = { fg = "#080b0a"; bg = "#4ce0a8"; };
        count_cut = { fg = "#080b0a"; bg = "#f25c5c"; };
        count_selected = { fg = "#080b0a"; bg = "#e3ba6b"; };

        border_symbol = "│";
        border_style = { fg = "#264038"; };

        sort_by = "mtime";
        sort_reverse = true;
        show_hidden = true;
        linemode = "size";
      };

      # --- Полоса выделения (отдельная секция на уровне theme) ---
      indicator = {
        current = {
          fg = "#080b0a"; # Тёмный текст в активной колонке
          bg = "#2eb885"; # Мятно-изумрудный фон выделения
          bold = true;
        };
        parent = {
          fg = "#d4dedb"; # Текст выделения в родительской папке слева
          bg = "#162621"; # Приглушённый тёмно-изумрудный фон
        };
        preview = {
          fg = "#d4dedb";
          bg = "#162621";
        };
        padding = {
          open = " ";
          close = " ";
        };
      };

      # --- Вкладки (Tabs) ---
      tabs = {
        active = { fg = "#080b0a"; bg = "#2eb885"; bold = true; };
        inactive = { fg = "#6c857d"; bg = "#101514"; };
      };

      # --- Нижняя строка статуса (Mode / Status) ---
      mode = {
        normal_main = { fg = "#080b0a"; bg = "#2eb885"; bold = true; };
        normal_alt = { fg = "#d4dedb"; bg = "#162621"; };

        select_main = { fg = "#080b0a"; bg = "#e3ba6b"; bold = true; };
        select_alt = { fg = "#d4dedb"; bg = "#162621"; };

        unset_main = { fg = "#080b0a"; bg = "#f25c5c"; bold = true; };
        unset_alt = { fg = "#d4dedb"; bg = "#162621"; };
      };

      status = {
        overall = { fg = "#a3b0ac"; bg = "#101514"; };
        sep_left = { open = ""; close = ""; };
        sep_right = { open = ""; close = ""; };

        # Права доступа к файлам
        perm_sep = { fg = "#465450"; };
        perm_type = { fg = "#4ce0a8"; };
        perm_read = { fg = "#e3ba6b"; };
        perm_write = { fg = "#f25c5c"; };
        perm_exec = { fg = "#2eb885"; };

        # Индикатор прогресса задач
        progress_label = { fg = "#f0f5f3"; bold = true; };
        progress_normal = { fg = "#2eb885"; bg = "#162621"; };
        progress_error = { fg = "#f25c5c"; bg = "#162621"; };
      };

      # --- Всплывающие окна (Input / Confirm / Which) ---
      input = {
        border = { fg = "#2eb885"; };
        title = { fg = "#4ce0a8"; };
        value = { fg = "#d4dedb"; };
        selected = { reversed = true; };
      };

      confirm = {
        border = { fg = "#2eb885"; };
        title = { fg = "#4ce0a8"; };
        content = { fg = "#d4dedb"; };
        list = { fg = "#a3b0ac"; };
        btn_yes = { reversed = true; fg = "#4ce0a8"; };
        btn_no = { fg = "#a3b0ac"; };
      };

      which = {
        mask = { bg = "#080b0a"; };
        cand = { fg = "#4ce0a8"; };
        rest = { fg = "#465450"; };
        desc = { fg = "#a3b0ac"; };
        separator = " :: ";
        separator_style = { fg = "#264038"; };
      };

      # Стилизация типов файлов
      filetype = {
        rules = [
          # Директории 
          { url = "*/"; fg = "#ebebeb"; bold = true; }
          
          # Текстовые файлы и код
          { mime = "text/*"; fg = "#a4abba"; }
          
          # Исполняемые файлы / Скрипты
          { mime = "application/x-executable"; fg = "#a4abba"; }
          
          # Медиа
          { mime = "image/*"; fg = "#a4abba"; }
          { mime = "video/*"; fg = "#a4abba"; }
          { mime = "audio/*"; fg = "#a4abba"; }
          
          # Архивы
          { mime = "application/*zip";  fg = "#6a6f7a"; }
          { mime = "application/x-tar"; fg = "#6a6f7a"; }
        ];
      };

      icon = {
        dirs = [
          { name = "Desktop";   text = " "; fg = "#39c89d"; }
          { name = "Downloads"; text = " "; fg = "#39c89d"; }
          { name = "Documents"; text = " "; fg = "#39c89d"; }
          { name = "Music";     text = " "; fg = "#39c89d"; }
          { name = "Pictures";  text = " "; fg = "#39c89d"; }
          { name = "Videos";    text = " "; fg = "#39c89d"; }
        ];

        conds = [
          { "if" = "hidden & dir";  "text" = " "; "fg" = "#383838"; }
          { "if" = "hidden & !dir"; "text" = "*";  "fg" = "#383838"; }

          { "if" = "dir";           "text" = " "; "fg" = "#39c89d"; }
        ];
      };
    };
  };
}
