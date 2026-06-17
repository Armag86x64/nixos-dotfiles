{ ... }:

{
  programs.wofi = {
    enable = true;
    
    settings = {
      width = 650;        # Немного увеличили ширину для более широкого шрифта
      height = 450;       # Добавили высоты для лучшего распределения строк
      no_actions = true;
      hide_scroll = true;
      show_icons = true;
      allow_images = true;
      columns = 2;        # Переключили на 2 колонки, как на вашем скриншоте
      image_size = 24;    # Увеличили иконки до 24px, чтобы они не казались мелкими рядом с JetBrainsMono
      icon_theme = "Tela-circle-black-dark";
      term = "foot bash -i -c";
      prompt = "Search programm";
    };

    style = ''
      /* Общее окно */
      window {
          background-color: #000000;
          color: #d1d1d1;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 13px; /* Оптимальный размер для JetBrainsMono */
          border: 1px solid #333333;
      }

      /* Поле поиска */
      #input {
          background-color: #111111;
          color: #ffffff;
          padding: 8px 12px; /* Добавили внутренние отступы в строку поиска */
          border: none;
          border-bottom: 2px solid #ffffff;
          margin: 15px;
      }

      /* Внутренний контейнер */
      #inner-box {
          padding: 10px;
          margin: 0px;
      }

      /* Элементы списка */
      #entry {
          padding: 12px; /* Увеличили кликабельную зону */
          margin: 6px;   /* Разделили плитки друг от друга */
          border: 1px solid transparent;
          border-radius: 6px;
      }

      /* Активный элемент */
      #entry:selected {
          border: 1px solid #ffffff;
          background-color: rgba(255, 255, 255, 0.05);
          box-shadow: 0 0 6px rgba(255, 255, 255, 0.15);
      }

      /* Текст выделенного пункта */
      #entry:selected #text {
          color: #ffffff;
          font-weight: bold;
      }

      /* Чередование строк */
      #entry:nth-child(even) {
          background-color: rgba(255, 255, 255, 0.01);
      }

      #text {
          margin: 0;
          vertical-align: middle; /* Выравнивание текста строго по центру иконки */
      }

      #scroll {
          border: none;
      }

      #viewport {
          border: none;
      }

      scrollbar {
          opacity: 0;
      }

      /* Иконки приложений */
      #img {
          margin-right: 12px;
          vertical-align: middle;
          opacity: 0.8;
      }

      #entry:selected #img {
          opacity: 1.0;
      }
    '';
  };
}
