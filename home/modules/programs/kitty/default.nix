{ unstable, ... }:

{
  programs.kitty = {
    enable = true;
    package = unstable.kitty;

    font = {
      name = "JetBrainsMonoNL Nerd Font:weight=bold, Symbols Nerd Font Mono:size=15";
      size = 16;
    };

    settings = {
      # --- Окно и отступы ---
      window_padding_width = 8; # Аналог pad = "8x8 center"
      placement_strategy = "center";
      background_opacity = "0.95"; # Аналог alpha = "0.95"
      resize_debounce_time = "0.1";
      confirm_os_window_close = 0;

      # --- Прокрутка ---
      scrollback_lines = 5000; # Аналог scrollback.lines = 5000
      wheel_scroll_multiplier = 5; # Аналог scrollback.multiplier = 5

      # --- Курсор ---
      cursor_shape = "block";
      cursor_blink_interval = "0.5"; # Аналог blink = "yes"
      cursor_beam_thickness = "1.0";

      # --- Мышь и ссылки ---
      mouse_hide_wait = 0; # Аналог hide-when-typing = "no"
      url_style = "curly";
      open_url_with = "xdg-open";

      # --- Основные цвета (из вашего foot) ---
      background = "#000000";
      foreground = "#d4dedb";

      cursor = "#40d39c";
      cursor_text_color = "#080b0a";

      selection_background = "#162621";
      selection_foreground = "#ffffff";

      # Обычные цвета (0–7)
      color0 = "#101514"; # Black
      color1 = "#d94141"; # Red
      color2 = "#2eb885"; # Green
      color3 = "#c79c52"; # Yellow
      color4 = "#357a99"; # Blue
      color5 = "#8869a8"; # Magenta
      color6 = "#2ca198"; # Cyan
      color7 = "#a3b0ac"; # White

      # Яркие цвета (8–15)
      color8 = "#465450";  # Bright Black
      color9 = "#f25c5c";  # Bright Red
      color10 = "#4ce0a8"; # Bright Green
      color11 = "#e3ba6b"; # Bright Yellow
      color12 = "#4b9ec2"; # Bright Blue
      color13 = "#a887c9"; # Bright Magenta
      color14 = "#45c4ba"; # Bright Cyan
      color15 = "#f0f5f3"; # Bright White
    };
  };
}
