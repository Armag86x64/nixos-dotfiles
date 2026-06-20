{ ... }:

{
  programs.niri.settings.binds = {
    # --- П Р И Л О Ж Е Н И Я ---
    "Mod+Q" = {
      hotkey-overlay.title = "Open a Terminal: foot";
      action.spawn = [ "foot" ];
    };
    "Mod+D" = {
      hotkey-overlay.title = "Run an Application: fuzzel";
      action.spawn = [ "fuzzel" ];
    };
    "Mod+F" = {
      hotkey-overlay.title = "Run a file manager: thunar";
      action.spawn = [ "thunar" ];
    };
    "Mod+W" = {
      hotkey-overlay.title = "Run a browser: chromium";
      action.spawn = [ "env" "MOZ_ENABLE_WAYLAND=1" "firefox" ];
      # action.spawn = [ "chromium" "--enable-features=UseOzonePlatform" "--ozone-platform=wayland" ];
    };
    "Mod+T" = {
      hotkey-overlay.title = "Run a telegram";
      action.spawn = [ "Telegram" ];
    };
    "Mod+R" = {
      hotkey-overlay.title = "Run a apps launcher: wofi";
      action.spawn = [ "wofi" "--show" "drun" ];
    };
    "Mod+O" = {
      hotkey-overlay.title = "Run a obsidian";
      action.spawn = [ "obsidian" ];
    };
    "Mod+B" = {
      hotkey-overlay.title = "Run a bottom";
      action.spawn = [ "foot" "btm" ];
    };
    "Mod+G" = {
      hotkey-overlay.title = "Run a GIMP";
      action.spawn = [ "flatpak" "run" "org.gimp.GIMP" ];
    };
    /*
    "Mod+Alt+L" = {
      hotkey-overlay.title = "Run a Librewolf";
      action.spawn = [ "librewolf" ];
    };
    */

    # --- С К Р И Н Ш О Т Ы ---
    "Print".action.spawn = [ "flameshot" "gui" ];
    "Ctrl+Print".action.screenshot-screen = [ ];
    "Alt+Print".action.screenshot-window = [ ];

    # --- V I M - m o d e ---
    "Shift+N".action.spawn-sh = [ "foot nvim $HOME/nixos-config" ];

    # --- A T L A S   E C O S Y S T E M ---
    "Mod+A".action.spawn-sh = [ "foot $HOME/nixos-config/home/modules/niri/scripts/atlas_ecosystem/atlas_minimalism" ];
  };
}
