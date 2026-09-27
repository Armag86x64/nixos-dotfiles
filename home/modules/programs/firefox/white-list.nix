{ ... }: {
  programs.firefox = {
    policies = {
      # Исключения для куки (белый список). 
      Cookies = {
        Allow = [
          # Базовые сервисы
          "https://google.com"
          "https://www.google.com"
          "https://github.com"
          "https://www.github.com"

          # Телеграм (веб-клиенты)
          "https://web.telegram.org"
          "https://k.web.telegram.org"
          "https://a.web.telegram.org"

          # DeepSeek
          "https://deepseek.com"
          "https://chat.deepseek.com"

          # YouTube
          "https://youtube.com"
          "https://www.youtube.com"

          # Pinterest
          "https://pinterest.com"
          "https://www.pinterest.com"
          "https://ru.pinterest.com"

          # Хабр
          "https://habr.com"
          "https://www.habr.com"

          # Reddit
          "https://reddit.com"
          "https://www.reddit.com"
          "https://old.reddit.com"
          "https://new.reddit.com"
          "https://i.redd.it"           # для изображений
          "https://preview.redd.it"     # для превью изображений
          "https://v.redd.it"           # для видео
          "https://external-preview.redd.it"  # для внешних превью
          "https://a.thumbs.redditmedia.com"   # для миниатюр
          "https://b.thumbs.redditmedia.com"   # для миниатюр

          # Stepik
          "https://stepik.org"
          "https://www.stepik.org"

          # Rutracker
          "https://rutracker.org"
          "https://www.rutracker.org"
          "https://rutracker.net"
          "https://www.rutracker.net"

          # ivi.ru
          "https://ivi.ru"
          "https://www.ivi.ru"
          "https://api.ivi.ru"          # для API запросов
          "https://static.ivi.ru"       # для статического контента
          "https://img.ivi.ru"          # для изображений
          "https://video.ivi.ru"

          # VK
          "https://vk.ru"
          "https://www.vk.ru"
          "https://vk.me"
          "https://vk.cc"

          # X (Twitter)
          "https://x.com"
          "https://www.x.com"
          "https://twitter.com"
          "https://www.twitter.com"
          "https://api.x.com"
          "https://t.co"
        ];
        # Параметр Default убран, чтобы избежать блокировки сохранения
      };
    }; 
  };
}
