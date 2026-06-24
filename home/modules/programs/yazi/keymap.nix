{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pinta
  ];

  programs.yazi = {
    enable = true;

    keymap = {
      mgr.prepend_keymap = [
        # --- [Перемещение и навигация (WASD)] ---
        { on = [ "W" ]; run = "arrow -1";       desc = "Шаг вверх"; }
        { on = [ "S" ]; run = "arrow 1";        desc = "Шаг вниз"; }
        { on = [ "A" ]; run = "leave";          desc = "Перейти в родительский каталог"; }
        { on = [ "D" ]; run = "enter";          desc = "Открыть папку / войти"; }

        # --- [Действия с файлами] ---
        { on = [ "<Delete>" ]; run = "remove --permanently"; desc = "Удалить файл навсегда (без корзины)"; }
        { on = [ "n" ];        run = "create";               desc = "Создать новый файл или папку (имя/ для папки)"; }

        # --- [Раздельное открытие текстового и графического редактора] ---
        # Строчная 'e' принудительно открывает абсолютно любой файл в Neovim через шелл
        { 
          on = [ "e" ]; 
          run = "shell --block 'nvim \"$@\"'"; 
          desc = "Открыть в Neovim (Текст/Код/Любой файл)"; 
        } 
        # Заглавная 'E' вызывает pinta_opener. Сработает ТОЛЬКО на картинках благодаря правилам из settings.nix
        { 
          on = [ "E" ]; 
          run = "shell --block 'pinta \"$1\"'"; 
          desc = "Открыть в графическом редакторе Pinta с блокировкой Yazi"; 
        }

        # --- [Интеграция с системой] ---
        { on = [ "T" ]; run = "shell --orphan 'foot'"; desc = "Открыть терминал Foot в текущей папке"; }

        # --- [Навигация по вкладкам] ---
        { on = [ "<C-Tab>" ];       run = "tab_switch 1 --relative";  desc = "Следующая вкладка (вправо)"; }
        { on = [ "<C-S-Tab>" ];     run = "tab_switch -1 --relative"; desc = "Предыдущая вкладка (влево)"; }

        { on = [ "<A-1>" ];         run = "tab_switch 0";             desc = "Перейти на вкладку 1"; }
        { on = [ "<A-2>" ];         run = "tab_switch 1";             desc = "Перейти на вкладку 2"; }
        { on = [ "<A-3>" ];         run = "tab_switch 2";             desc = "Перейти на вкладку 3"; }
        { on = [ "<A-4>" ];         run = "tab_switch 3";             desc = "Перейти на вкладку 4"; }
        { on = [ "<A-5>" ];         run = "tab_switch 4";             desc = "Перейти на вкладку 5"; }
        { on = [ "<A-6>" ];         run = "tab_switch 5";             desc = "Перейти на вкладку 6"; }
        { on = [ "<A-7>" ];         run = "tab_switch 6";             desc = "Перейти на вкладку 7"; }
        { on = [ "<A-8>" ];         run = "tab_switch 7";             desc = "Перейти на вкладку 8"; }
        { on = [ "<A-9>" ];         run = "tab_switch 8";             desc = "Перейти на вкладку 9"; }

        # --- [Управление вкладками] ---
        { on = [ "t" ];             run = "tab_create --current";     desc = "Создать новую вкладку (текущий путь)"; }
        { on = [ "<C-x>" ];         run = "tab_close";                desc = "Закрыть текущую вкладку"; }
      ];
    };
  };
}
