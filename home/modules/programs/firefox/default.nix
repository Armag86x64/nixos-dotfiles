{ inputs, pkgs, stable, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  programs.firefox = {
    enable = true;
    package = stable.firefox;

    # === Глобальные корпоративные политики Firefox ===
    policies = {
      ExtensionSettings = {
        "*" = {
          default_area = "navbar"; # Автоматически выносить все иконки на панель навигации
        };
      };

      # === УМНАЯ ОЧИСТКА ПРИ ЗАКРЫТИИ ===
      # Сюда мы передаем жесткий контроль. Поля выставлены в true.
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        History = true;
        Sessions = true;     # Очищает активные сессии вкладок
        FormData = true;     # Очищает историю поиска и форм
        SiteSettings = false; # ВАЖНО: сохраняет белый список исключений
      };

      # Исключения для куки (белый список). 
      # Firefox НЕ будет трогать куки, локальное хранилище и авторизацию для этих доменов.
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
          "https://old.reddit.com"      # если используете старую версию
          "https://new.reddit.com"      # если используете новую версию
          "https://i.redd.it"           # для изображений
          "https://preview.redd.it"     # для превью изображений
          "https://v.redd.it"           # для видео
          "https://external-preview.redd.it"  # для внешних превью
          "https://a.thumbs.redditmedia.com"   # для миниатюр
          "https://b.thumbs.redditmedia.com"   # для миниатюр

          # Stepik
          "https://stepik.org"
          "https://www.stepik.org"
        ];
        # Параметр Default убран, чтобы избежать блокировки сохранения
      };
    };

    profiles.soundwave = {
      isDefault = true;

      extensions.packages = with inputs.firefox-addons.packages.${system}; [
        ublock-origin
        bitwarden
        darkreader
        privacy-badger
        # smartproxy
      ];

      settings = {
        "extensions.autoDisableScopes" = 0;

        # УДАЛЕНО: Все параметры "privacy.clearOnShutdown.*" удалены отсюда,
        # чтобы они не перезаписывали поведение белого списка из политик.

        "browser.startup.homepage" = "https://google.com";
        "browser.startup.page" = 1;

        "ui.systemUsesDarkTheme" = 1;
        "devtools.theme" = "dark";
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
      
        # === 1. АППАРАТНОЕ УСКОРЕНИЕ ===
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true;

        # === 2. СНИЖЕНИЕ НАГРУЗКИ НА ПРОЦЕССОР ===
        "dom.ipc.processCount" = 8;
        "dom.ipc.processCount.webIsolated" = 4;
        "browser.tabs.unloadOnLowMemory" = true;

        # === 3. ОТКЛЮЧЕНИЕ ЛИШНЕЙ АНИМАЦИИ И ДИСКОВЫХ ОПЕРАЦИЙ ===
        "image.mem.decode_on_draw" = true;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.enable" = true;
        "browser.cache.memory.capacity" = 1048576;

        # 5. ОПТИМИЗАЦИЯ СЕТИ ДЛЯ СВЯЗКИ С BYEDPI
        "network.dns.disablePrefetch" = true;
        "network.proxy.socks_remote_dns" = true;
        "network.http.http3.enable" = false;
      };
    };
  };
}
