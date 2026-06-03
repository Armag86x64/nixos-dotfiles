{ ... }:

{
  # Подключаем все файлы с категориями горячих клавиш
  imports = [
    ./hotkeys_apps.nix
    ./hotkeys_hardware.nix
    ./hotkeys_scripts.nix
    ./hotkeys_windows.nix
  ];

  # Инициализируем пустой набор биндов, 
  # который остальные файлы будут наполнять
  programs.niri.settings.binds = { };
}
