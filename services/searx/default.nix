{ unstable, ... }: {
  services.searx = {
    enable = false;
    package = unstable.searxng;

    # configureUwsgi = true;

    settings = {
      general = {
        debug = false;
        instance_name = "SearXNG Instance";
        donation_url = false;
        contact_url = false;
        privacypolicy_url = false;
        enable_metrics = false;
      };

      server = {
        port = 2016;
        bind_address = "127.0.0.1";
        secret_key = "05c580227a2c6d14289a95a283a1c7a3b4628d5c25cde501244ad6ed7b0b3273";
      };

      engines = unstable.lib.mapAttrsToList (name: value: { inherit name; } // value) { 
        # Основные быстрые движки (работают напрямую)
        "duckduckgo".disabled = false;
        "brave".disabled = false;
        "qwant".disabled = true;
      
        # Капризные движки (заворачиваем в Tor)
        "google" = {
          disabled = true;
          # use_mobile_ui = true; # Меньше капч
          # use_embedded_visibility = true;
          #send_accept_language_header = true;
          # proxies = torProxy;
        };
      
        "yandex" = {
          disabled = true;
        };

        # Дополнительные полезные источники
        "wikidata".disabled = false;
        "wikipedia".disabled = false;
  
        # Отключаем тяжелые или ненужные вам по умолчанию движки
        "bing".disabled = true;
        "mojeek".disabled = true;
      };

      ui = {
        static_use_hash = true;
        default_locale = "en";
        query_in_title = true;
        infinite_scroll = false;
        center_alignment = true;
        default_theme = "simple";
        theme_args.simple_style = "auto";
        search_on_category_select = false;
        hotkeys = "vim";
      };
    };
  };
}
