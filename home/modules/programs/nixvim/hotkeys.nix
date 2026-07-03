{ ... }:

{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      # --- Файловый менеджер и поиск ---
      { mode = "n";         key = "<leader>e";  action = "<cmd>Neotree toggle<CR>";                      options.desc = "Toggle Neo-tree"; }
      { mode = "n";         key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>";                options.desc = "Find files"; }
      { mode = "n";         key = "<C-l>";      action = "<cmd>Neotree toggle<CR>";                      options.desc = "Toggle Neo-tree via Ctrl+l"; }
      { mode = "i";         key = "<C-l>";      action = "<Esc><cmd>Neotree toggle<CR>";                 options.desc = "Toggle Neo-tree via Ctrl+l"; }
      { mode = [ "n" "i" ]; key = "<C-f>";      action = "<cmd>Telescope current_buffer_fuzzy_find<CR>"; options.desc = "Find string in current file"; }

      # --- Сохранение и Выход ---
      { mode = [ "n" "i" "v" ]; key = "<C-s>";     action = "<cmd>stopinsert | w<CR>"; options = { desc = "Save file and go to Normal mode"; silent = true; }; }
      { mode = "n";             key = "<C-q>";     action = "<cmd>q<CR>";              options.desc = "Quit Vim"; }

      # --- Навигация по строке и файлу ---
      { mode = "n"; key = "<C-d>";                 action = "I";       options.desc = "Go to start of text and insert"; }
      { mode = "i"; key = "<C-d>";                 action = "<Esc>I";  options.desc = "Go to start of text and insert"; }

      { mode = [ "n" "v" "s" ]; key = "<S-Space>"; action = "w";       options = { desc = "Move forward past spaces"; silent = true; }; }
      { mode = [ "i" ];         key = "<S-Space>"; action = "<C-o>w";  options = { desc = "Move forward past spaces"; silent = true; }; }

      { mode = [ "n" "v" "s" ]; key = "<C-Space>"; action = "b";       options = { desc = "Move backward past spaces"; silent = true; }; }
      { mode = [ "i" ];         key = "<C-Space>"; action = "<C-o>b";  options = { desc = "Move backward past spaces"; silent = true; }; }

      { mode = [ "n" "i" ];     key = "<C-e>";     action = "gM";      options.desc = "Go to middle of line"; }
      { mode = "n";             key = "<C-a>";     action = "$a";      options.desc = "Go to end of line and insert"; }
      { mode = "i";             key = "<C-a>";     action = "<Esc>$a"; options.desc = "Go to end of line and insert"; }
      { mode = "n";             key = "G";         action = "G";       options.desc = "Go to end of file"; }

      # --- Кастомное перемещение (Заменяет стандартные W и S) ---
      { mode = "n"; key = "W"; action = "k"; options.desc = "Move cursor up"; }
      { mode = "n"; key = "S"; action = "j"; options.desc = "Move cursor down"; }

      # --- Работа с буфером (Копирование / Вставка) ---
      { mode = "v"; key = "<C-c>"; action = "\"+y";   options.desc = "Copy selection to clipboard"; }
      { mode = "n"; key = "p";     action = "\"+p";   options.desc = "Paste from register"; }
      { mode = "n"; key = "<C-v>"; action = "\"+p";   options.desc = "Paste from clipboard"; }
      { mode = "i"; key = "<C-v>"; action = "<C-r>+"; options.desc = "Paste from clipboard in insert mode"; }

      # --- Отмена и повтор действий (Undo / Redo) ---
      { mode = "n"; key = "<C-z>"; action = "u";           options.desc = "Undo"; }
      { mode = "i"; key = "<C-z>"; action = "<Esc>ui";     options.desc = "Undo in insert mode"; }
      { mode = "n"; key = "<C-x>"; action = "<C-r>";       options.desc = "Redo"; }
      { mode = "i"; key = "<C-x>"; action = "<Esc><C-r>i"; options.desc = "Redo in insert mode"; }

      # --- Перемещение по вкладкам ---
      # Переход по Alt + номер вкладки (1-9)
      { mode = "n"; key = "<Tab>"; action = "<cmd>tabn<CR>";     options.silent = true; }
      { mode = "n"; key = "<M-1>"; action = "<cmd>1tabnext<CR>"; options.silent = true; }
      { mode = "n"; key = "<M-2>"; action = "<cmd>2tabnext<CR>"; options.silent = true; }
      { mode = "n"; key = "<M-3>"; action = "<cmd>3tabnext<CR>"; options.silent = true; }
      { mode = "n"; key = "<M-4>"; action = "<cmd>4tabnext<CR>"; options.silent = true; }
      { mode = "n"; key = "<M-5>"; action = "<cmd>5tabnext<CR>"; options.silent = true; }
      { mode = "n"; key = "<M-6>"; action = "<cmd>6tabnext<CR>"; options.silent = true; }
      { mode = "n"; key = "<M-7>"; action = "<cmd>7tabnext<CR>"; options.silent = true; }
      { mode = "n"; key = "<M-8>"; action = "<cmd>8tabnext<CR>"; options.silent = true; }
      { mode = "n"; key = "<M-9>"; action = "<cmd>9tabnext<CR>"; options.silent = true; }
    ];
  };
}
