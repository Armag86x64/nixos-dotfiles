{ ... }:

{
  programs.niri.settings.binds = {
    # Запуск графической утилиты для смены обоев
    "Mod+Shift+W".action.spawn = [ "waypaper" ];

    # Виджеты
    "Shift+V".action.spawn = [ "eww" "open" "--toggle" "bw-volume-applet" ];
  };
}
