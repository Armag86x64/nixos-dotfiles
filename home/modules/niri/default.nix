{ inputs, pkgs, ... }:

{
  imports = [
    # Подключаем официальный модуль Home Manager из флейка
    inputs.niri.homeModules.niri

    ./autostart.nix
    ./input.nix
    ./output.nix
    ./hotkeys
    ./window_rules.nix
    ./layout.nix
  ];

  programs.niri = {
    enable = true;
    
    # Решаем проблему рекурсии: берем пакет из pkgs и убираем тесты
    package = pkgs.niri.overrideAttrs (oldAttrs: {
      doCheck = false;
    });

    settings = {
      animations.enable = false;

      workspaces = {
        "1" = { };
        "2" = { };
        "3" = { };
        "4" = { };
      };
    };
  };
}
