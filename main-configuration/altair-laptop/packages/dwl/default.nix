{ config, pkgs, ... }:

let
  myDwl = pkgs.dwl.overrideAttrs (oldAttrs: {
    postPatch = (oldAttrs.postPatch or "") + ''
      cp ${./config.h} config.h
      cp ${./autostart.h} autostart.h
      cp ${./appearance.h} appearance.h
      cp ${./keys.h} keys.h
      cp ${./rules.h} rules.h
      cp ${./layouts.h} layouts.h
      cp ${./monitors.h} monitors.h
      cp ${./input.h} input.h
    '';

    buildInputs = oldAttrs.buildInputs or [] ++ [
      pkgs.dwlb
    ];

    patches = oldAttrs.patches or [ ] ++ [
      ./patches/autostart-0.8.patch
    ];
  });
in {
  programs.dwl = {
    enable = true;
    package = myDwl;
    extraSessionCommands = ''
      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    
      systemctl --user stop xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-wlr 2>/dev/null || true
      systemctl --user start xdg-desktop-portal
    '';
  };

  services.dbus.enable = true;
  xdg.portal.enable = true;

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "dwl-start" ''
      #!/bin/sh

      export XDG_CURRENT_DESKTOP="dwl"
      export XDG_SESSION_DESKTOP="dwl"
      export XDG_SESSION_TYPE="wayland"

      export MOZ_ENABLE_WAYLAND=1
      export QT_QPA_PLATFORM="wayland;xcb"
      export GDK_BACKEND="wayland,x11"
      export SDL_VIDEODRIVER="wayland"
      export CLUTTER_BACKEND="wayland"

      mkdir -p "$HOME"/.cache
      > "$HOME"/.cache/dwltags

      exec dwl > "$HOME"/.cache/dwltags 2>&1
      # exec dbus-launch --exit-with-session dwl > "$HOME"/.cache/dwltags 2>&1
    '')
  ];
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
