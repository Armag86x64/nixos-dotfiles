{ config, pkgs, ... }:

let
  myDwl = pkgs.dwl.overrideAttrs (oldAttrs: {
    preConfigure = ''
      # Копируем все файлы конфигурации
      cp ${./config.h} config.h
      cp ${./appearance.h} appearance.h
      cp ${./keys.h} keys.h
      cp ${./rules.h} rules.h
      cp ${./layouts.h} layouts.h
      cp ${./monitors.h} monitors.h
      cp ${./input.h} input.h
    '';
    
    # Если у вас есть патчи
    patches = oldAttrs.patches or [] ++ [
      # ./some-patch.patch
    ];
  });
in {
  programs.dwl = {
    enable = true;
    package = myDwl;
  };
}

/*
├── default.nix          # ваш файл с конфигурацией Nix
├── config.h             # главный файл с #include
├── appearance.h         # внешний вид
├── keys.h              # горячие клавиши
├── rules.h             # правила для окон
├── layouts.h           # раскладки
├── monitors.h          # мониторы
└── input.h             # клавиатура и тачпад
*/
