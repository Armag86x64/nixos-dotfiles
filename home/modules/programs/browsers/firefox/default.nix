{ inputs, config, pkgs, stable, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  programs.firefox = {
    enable = true;
    package = stable.firefox;

    configPath = "${config.xdg.configHome}/mozilla/firefox";

    # === Глобальные корпоративные политики Firefox ===
    policies = {
      ExtensionSettings = {
        "*" = {
          default_area = "navbar"; # Автоматически выносить все иконки на панель навигации
        };
      };

      # === УМНАЯ ОЧИСТКА ПРИ ЗАКРЫТИИ ===
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        History = true;
        Sessions = true;      # Очищает активные сессии вкладок
        FormData = true;      # Очищает историю поиска и форм
        SiteSettings = false; # ВАЖНО: сохраняет белый список исключений
      };
    };

    profiles.soundwave = {
      isDefault = true;
      id = 0;

      extensions.packages = with inputs.firefox-addons.packages.${system}; [
        darkreader
        bitwarden
        vimium

        istilldontcareaboutcookies
        privacy-badger
        decentraleyes
        ublock-origin
      ];

      settings = {
        "extensions.autoDisableScopes" = 0;
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # УДАЛЕНО: Все параметры "privacy.clearOnShutdown.*" удалены отсюда,
        # чтобы они не перезаписывали поведение белого списка из политик.
        "browser.urlbar.suggest.weather" = false;
        "browser.newtabpage.activity-stream.showWeather" = false;

        "browser.startup.homepage" = "about:newtab";
        "browser.startup.page" = 1;

        "ui.systemUsesDarkTheme" = 1;
        "devtools.theme" = "dark";
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "ui.key.menuAccessKeyFocuses" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      
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
