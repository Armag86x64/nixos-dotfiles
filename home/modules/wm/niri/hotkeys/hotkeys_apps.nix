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
      hotkey-overlay.title = "Run a file manager: yazi";
      action.spawn = [ "foot" "-e" "--app-id=yazi-terminal" "yazi" ];
    };
    "Mod+W" = {
      hotkey-overlay.title = "Run a browser: chromium";
      action.spawn = [ "env" "MOZ_ENABLE_WAYLAND=1" "firefox" ];
    };
    "Mod+T" = {
      hotkey-overlay.title = "Run taskwarrior-tui";
      action.spawn = [ "foot" "-e" "--app-id=taskwarrior-tui" "taskwarrior-tui" ];
    };
    "Mod+R" = {
      hotkey-overlay.title = "Run a apps launcher: wofi";
      action.spawn = [ "wofi" "--show" "drun" ];
    };
    "Mod+B" = {
      hotkey-overlay.title = "Run bottom";
      action.spawn = [ "foot" "btm" ];
    };

    # --- С К Р И Н Ш О Т Ы ---
    "Print".action.spawn = [ "flameshot" "gui" ];
    "Ctrl+Print".action.screenshot-screen = [ ];
    "Alt+Print".action.screenshot-window = [ ];

    # --- V I M - m o d e ---
    "Shift+N" = {
      hotkey-overlay.title = "Open nixos-config in nvim";
      action.spawn-sh = [ "foot nvim $HOME/nixos-dotfiles" ];
    };
    "Mod+O" = {
      hotkey-overlay.title = "Open notes in nvim";
      action.spawn-sh =  [ "foot nvim $HOME/Notes" ];
    };
  };
}
