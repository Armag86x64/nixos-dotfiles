{ ... }:

{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      # --- Файловый менеджер и поиск ---
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<CR>"; options.desc = "Toggle Neo-tree"; }
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Find files"; }
      { mode = "n"; key = "<C-l>"; action = "<cmd>Neotree toggle<CR>"; options.desc = "Toggle Neo-tree via Ctrl+l"; }
      { mode = "i"; key = "<C-l>"; action = "<Esc><cmd>Neotree toggle<CR>"; options.desc = "Toggle Neo-tree via Ctrl+l"; }
      { mode = [ "n" "i" ]; key = "<C-f>"; action = "<cmd>Telescope current_buffer_fuzzy_find<CR>"; options.desc = "Find string in current file"; }

      # --- Сохранение и Выход ---
      { mode = [ "n" "i" "v" ]; key = "<C-s>"; action = "<cmd>stopinsert | w<CR>"; options = { desc = "Save file and go to Normal mode"; silent = true; }; }
      { mode = "n"; key = "<C-q>"; action = "<cmd>q<CR>"; options.desc = "Quit Vim"; }

      # --- Навигация по строке и файлу ---
      # ИСПРАВЛЕНО: Теперь <C-d> работает везде. В Normal переходит к тексту и включает Insert, в Insert — просто прыгает к тексту.
      { mode = "n"; key = "<C-d>"; action = "I"; options.desc = "Go to start of text and insert"; }
      { mode = "i"; key = "<C-d>"; action = "<Esc>I"; options.desc = "Go to start of text and insert"; }
      
      { mode = [ "n" "i" ]; key = "<C-Space>"; action = "^"; options.desc = "Go to first non-blank char"; }
      { mode = [ "n" "i" ]; key = "<C-e>"; action = "gM"; options.desc = "Go to middle of line"; }
      { mode = "n"; key = "<C-a>"; action = "$a"; options.desc = "Go to end of line and insert"; }
      { mode = "i"; key = "<C-a>"; action = "<Esc>$a"; options.desc = "Go to end of line and insert"; }
      { mode = "n"; key = "G"; action = "G"; options.desc = "Go to end of file"; }

      # --- Кастомное перемещение (Заменяет стандартные W и S) ---
      { mode = "n"; key = "W"; action = "k"; options.desc = "Move cursor up"; }
      { mode = "n"; key = "S"; action = "j"; options.desc = "Move cursor down"; }
      { mode = [ "n" "i" ]; key = "<C-g>"; action = "<cmd>execute 'normal! ' . (winheight(0) / 2) . (mode() == 'i' ? 'k' : 'j')<CR>"; options.desc = "Jump half screen vertically"; }

      # --- Работа с буфером (Копирование / Вставка) ---
      { mode = "v"; key = "<C-c>"; action = "\"+y"; options.desc = "Copy selection to clipboard"; }
      { mode = "n"; key = "p"; action = "p"; options.desc = "Paste from register"; }
      { mode = "n"; key = "<C-v>"; action = "\"+p"; options.desc = "Paste from clipboard"; }
      { mode = "i"; key = "<C-v>"; action = "<C-r>+"; options.desc = "Paste from clipboard in insert mode"; }

      # --- Отмена и повтор действий (Undo / Redo) ---
      { mode = "n"; key = "<C-z>"; action = "u"; options.desc = "Undo"; }
      { mode = "i"; key = "<C-z>"; action = "<Esc>ui"; options.desc = "Undo in insert mode"; }
      { mode = "n"; key = "<C-x>"; action = "<C-r>"; options.desc = "Redo"; }
      { mode = "i"; key = "<C-x>"; action = "<Esc><C-r>i"; options.desc = "Redo in insert mode"; }
    ];
  };
}
