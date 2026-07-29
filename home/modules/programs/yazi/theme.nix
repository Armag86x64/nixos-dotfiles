{ ... }:

{
  programs.yazi = {
    theme = {
      # Настройки основного менеджера
      manager = {
        cwd = { fg = "#fd1b7c"; bold = true; };

        # Цвета для колонок
        preview_border = { fg = "#262626"; };
        active_border  = { fg = "#fd1b7c"; };
        inactive_border = { fg = "#171717"; };

        # Состояние файлов в списке
        hovered       = { fg = "#ffffff"; bg = "#262626"; bold = true; };
        selected      = { fg = "#fd1b7c"; bg = "#1a1a1a"; };
        find_keyword  = { fg = "#fd1b7c"; underline = true; };
      };

      # Нижняя статус-панель
      status = {
        separator_style = { fg = "#262626"; bg = "#262626"; };
        
        # Режимы (Normal, Select, Input)
        mode_normal = { fg = "#0a0a0a"; bg = "#ffffff"; bold = true; };
        mode_select = { fg = "#0a0a0a"; bg = "#fd1b7c"; bold = true; };
        mode_unset  = { fg = "#ffffff"; bg = "#404040"; };

        # Правая часть статус-бара (Инфо о файле / прогресс)
        progress_label  = { fg = "#ffffff"; bold = true; };
        progress_normal = { fg = "#ffffff"; bg = "#262626"; };
        progress_error  = { fg = "#ef4444"; bg = "#262626"; };
      };

      # Стилизация типов файлов
      filetype = {
        rules = [
          # Директории 
          { url = "*/"; fg = "#a3a3a3"; bold = true; }
          
          # Текстовые файлы и код
          { mime = "text/*"; fg = "#f1f1f1"; }
          
          # Исполняемые файлы / Скрипты
          { mime = "application/x-executable"; fg = "#f1f1f1"; }
          
          # Медиа
          { mime = "image/*"; fg = "#f1f1f1"; }
          { mime = "video/*"; fg = "#f1f1f1"; }
          { mime = "audio/*"; fg = "#f1f1f1"; }
          
          # Архивы
          { mime = "application/*zip";  fg = "#f1f1f1"; }
          { mime = "application/x-tar"; fg = "#f1f1f1"; }
        ];
      };

      icon = {
        dirs = [
          { name = "Desktop";   text = " "; fg = "#737373"; }
          { name = "Downloads"; text = " "; fg = "#737373"; }
          { name = "Documents"; text = " "; fg = "#737373"; }
          { name = "Music";     text = " "; fg = "#737373"; }
          { name = "Pictures";  text = " "; fg = "#737373"; }
          { name = "Videos";    text = " "; fg = "#737373"; }
        ];

        conds = [
          { "if" = "hidden & dir";  "text" = " "; "fg" = "#383838"; }
          { "if" = "hidden & !dir"; "text" = "*";  "fg" = "#383838"; }

          { "if" = "dir";           "text" = " "; "fg" = "#7a7a7a"; }
        ];
      };

      input = {
        border = { fg = "#fd1b7c"; };
        title  = { fg = "#ffffff"; };
        value  = { fg = "#e5e5e5"; };
      };

      select = {
        border = { fg = "#262626"; };
        active = { fg = "#fd1b7c"; bold = true; };
      };

      completion = {
        border = { fg = "#262626"; };
        active = { fg = "#0a0a0a"; bg = "#ffffff"; };
      };
    };
  };
}
