{ ... }:

{
  programs.niri.settings.outputs."eDP-1" = {
    # Режим экрана с кастомным флагом
    mode = "1600x900@60.000";
    # Примечание: Если niri потребует кастомный флаг в строке, 
    # формат Home Manager автоматически сгенерирует валидный KDL.

    transform = "normal";
    
    position = {
      x = 0;
      y = 0;
    };

    focus-at-startup = true;

    hot-corners = {
      enable = false; # Соответствует флагу 'off' в KDL
    };
  };
}
