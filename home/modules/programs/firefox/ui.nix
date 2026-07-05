{ ... }: {
  programs.firefox.profiles.soundwave = {
    userContent = ''
  @-moz-document url("about:newtab"), url("about:home") {
    /* 1. Скрываем стандартную лису и текст Firefox внутри контейнера */
    .logo-and-wordmark .wordmark,
    .logo-and-wordmark .logo {
      display: none !important;
    }

    /* 2. Задаем контейнеру размеры и центрируем yаш собственный логотип */
    .logo-and-wordmark {
      background-image: url("file://${../../wm/waybar/images/main_logo_1.jpg}") !important;
      background-size: contain !important;
      background-position: center !important;
      background-repeat: no-repeat !important;
      
      /* Задайте фиксированную ширину и высоту, чтобы логотип не сжимался */
      width: 200px !important;
      height: 82px !important;
      margin-left: auto !important;
      margin-right: auto !important;
    }
  }


  /* ==========================================================================
   1. НАСТРОЙКИ ДЛЯ СТРАНИЦЫ НОВОЙ ВКЛАДКИ (about:newtab / about:home)
   ========================================================================== */
  @-moz-document url("about:newtab"), url("about:home") {
    /* Абсолютно черный фон страницы */
    body, #newtab-customize-overlay {
      background-color: #000000 !important;
    }

    /* Овальная поисковая строка */
    button.search-handoff-button,
    .search-wrapper .search-handoff-button,
    .search-inner-wrapper {
      background-color: #121214 !important;
      border: 1px solid #1a1a1c !important;
      box-shadow: none !important;
      border-radius: 24px !important; 
    }

    /* Фикс фокуса при клике на поисковую строку */
    .search-wrapper input:focus,
    .search-inner-wrapper:focus-within {
      /* outline: 1px solid #ffffff !important;*/
      background-color: #000000 !important;
      box-shadow: none !important;
    }

    /* ПОЛНОСТЬЮ ВЫРЕЗАЕМ БЛОК ЯРЛЫКОВ (Shortcuts вместе с кнопкой "+") */
    .top-sites, .top-sites-list, #topSites {
      display: none !important;
    }
  }


  /* ==========================================================================
   2. ОСТАЛЬНОЕ
   ========================================================================== */

'';
  };
}

/*

  /* ==========================================================================
    2. МОНОХРОМ ДЛЯ ВСЕХ СТРАНИЦ about:* (Фон, Переменные, Элементы)
   ========================================================================== */

  /*
  @-moz-document url-prefix("about:") {
    :root, body, html {
      --in-content-page-background: #000000 !important;
      --in-content-box-background: #000000 !important;
      --in-content-table-background: #000000 !important;
      --in-content-accent-color: #ffffff !important;
      --in-content-page-color: #ffffff !important;
      --in-content-text-color: #ffffff !important;
      --card-background-color: #000000 !important;
      --card-outline-color: #ffffff !important;
      background-color: #000000 !important;
      color: #ffffff !important;
    }

  * {
    scrollbar-color: #ffffff #000000 !important;
  }

  /* Принудительный монохром для встроенных иконок, чекбоксов и радио-кнопок
  input[type="checkbox"] {
    accent-color: #ffffff !important;
    appearance: none !important;
    width: 14px !important;
    height: 14px !important;
    border: 1px solid #ffffff !important;
    background-color: #141414 !important;
    position: relative !important;
    display: inline-block !important;
    vertical-align: middle !important;
  } */

  /* Отцентрованная галочка для активного чекбокса
  input[type="checkbox"]:checked::before {
    content: "✓" !important;
    color: #000000 !important;
    background-color: #ffffff !important;
    font-size: 20px !important;
    font-weight: bold !important;
    position: absolute !important;
    top: 0 !important;
    left: 0 !important;
    width: 100% !important;
    height: 100% !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
  } */

  /* Белая точка для активной радио-кнопки
  input[type="radio"]:checked::before {
    content: "" !important;
    display: block !important;
    width: 6px !important;
    height: 6px !important;
    background: #ffffff !important;
    margin: 3px !important;
    border-radius: 50% !important;
  } */

  /* Настройка кнопок и полей ввода (НЕ ломающая строку поиска)
  input:not([id*="search"]), 
  select, 
  textarea,
  /* Применяем к кнопкам, кроме кнопки поиска на новой вкладке
  button:not(.search-handoff-button) {
    background: #000000 !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 10px !important; 
  }
  */
