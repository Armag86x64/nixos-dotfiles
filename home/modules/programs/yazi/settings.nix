{ pkgs, ... }:

{
  home.packages = with pkgs; [
    peazip     
    zathura    
    xdg-utils  
  ];

  programs.yazi = {
    settings = {
      opener = {
        video = [
          { run = "mpv \"$@\""; orphan = true; desc = "Открыть видео в MPV"; }
        ];
        audio = [
          { run = "mpv --no-video \"$@\""; block = true; desc = "Слушать аудио в MPV"; }
        ];
        image = [
          { run = "eog \"$@\""; orphan = true; desc = "Открыть в Eye of Gnome"; }
        ];
        archives = [
          { run = "peazip \"$@\""; orphan = true; desc = "Менеджер архивов PeaZip"; }
        ];
        web = [
          { run = "firefox \"$@\""; orphan = true; desc = "Открыть вкладку в Firefox"; }
        ];
        books = [
          { run = "foliate \"$@\""; orphan = true; desc = "Читать в Foliate"; }
        ];
        pdf = [
          { run = "zathura \"$@\""; orphan = true; desc = "Просмотр PDF в Zathura"; }
        ];
        text = [
          { run = "nvim \"$@\""; block = true; desc = "Редактировать в Neovim"; }
        ];
      };

      open = {
        rules = [
          # 1. Веб-страницы
          { mime = "text/html"; use = "web"; }
          { url = "*.html"; use = "web"; }
          { url = "*.xhtml"; use = "web"; }

          # 2. Картинки и фото графики
          { mime = "image/*"; use = "image"; }
          { url = "*.png"; use = "image"; }
          { url = "*.jpg"; use = "image"; }
          { url = "*.jpeg"; use = "image"; }
          { url = "*.webp"; use = "image"; }
          { url = "*.svg"; use = "image"; }
          { url = "*.gif"; use = "image"; }

          # 3. Видео-форматы
          { mime = "video/*"; use = "video"; }
          { url = "*.mp4"; use = "video"; }
          { url = "*.mkv"; use = "video"; }
          { url = "*.avi"; use = "video"; }
          { url = "*.mov"; use = "video"; }
          { url = "*.flv"; use = "video"; }
          { url = "*.webm"; use = "video"; }

          # 4. Аудио-форматы
          { mime = "audio/*"; use = "audio"; }
          { url = "*.mp3"; use = "audio"; }
          { url = "*.flac"; use = "audio"; }
          { url = "*.wav"; use = "audio"; }
          { url = "*.m4a"; use = "audio"; }
          { url = "*.ogg"; use = "audio"; }

          # 5. Форматы архивов
          { mime = "application/zip"; use = "archives"; }
          { mime = "application/x-7z-compressed"; use = "archives"; }
          { mime = "application/vnd.rar"; use = "archives"; }
          { mime = "application/x-tar"; use = "archives"; }
          { mime = "application/x-gzip"; use = "archives"; }
          { mime = "application/x-bzip2"; use = "archives"; }
          { mime = "application/x-xz"; use = "archives"; }
          { url = "*.zip"; use = "archives"; }
          { url = "*.7z"; use = "archives"; }
          { url = "*.rar"; use = "archives"; }
          { url = "*.tar"; use = "archives"; }
          { url = "*.gz"; use = "archives"; }
          { url = "*.bz2"; use = "archives"; }
          { url = "*.xz"; use = "archives"; }

          # 6. Электронные книги
          { mime = "application/epub+zip"; use = "books"; }
          { mime = "application/x-mobipocket-ebook"; use = "books"; }
          { url = "*.epub"; use = "books"; }
          { url = "*.fb2"; use = "books"; }
          { url = "*.mobi"; use = "books"; }

          # 7. Документы PDF
          { mime = "application/pdf"; use = "pdf"; }
          { url = "*.pdf"; use = "pdf"; }

          # 8. Текстовые форматы по MIME-типу
          { mime = "text/*"; use = "text"; }

          # 9. КОРРЕКТНЫЙ ФОЛБЕК ДЛЯ ОСТАЛЬНЫХ ФАЙЛОВ (Использует url вместо name)
          { url = "*"; use = "text"; }
        ];
      };
    };
  };
}
