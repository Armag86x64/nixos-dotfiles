{ ... }:

{
  programs.niri.settings.gestures.hot-corners.enable = false;

  programs.niri.settings.input = {
    keyboard.xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };

    touchpad = {
      tap = true;
      natural-scroll = true;
    };

    # ДОБАВЛЯЕМ СЮДА: Чистый игровой ввод для мыши в сессии Niri
    mouse = {
      # accel-profile = "flat"; # Отключает любое программное ускорение (акселерацию)
      accel-speed = 1.0;      # Базовая скорость «один к одному» (диапазон от -1.0 до 1.0)
    };
  };
}
