{ config, pkgs, ... }:

{
  # Подключаем подмодули с настройками
  imports = [
    ./autostart.nix
    ./input.nix
    ./output.nix
    ./hotkeys
    ./window_rules.nix
    ./layout.nix
  ];

  programs.niri = {
    enable = true;
    
    # Добавляем новые глобальные параметры
    settings = {
      # Отключаем анимации интерфейса
      animations.enable = false;

      # Декларируем статические рабочие пространства
      workspaces = {
        "1" = { };
        "2" = { };
        "3" = { };
        "4" = { };
      };
    };
  };
}
