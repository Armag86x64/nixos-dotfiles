{ ... }:

{
  programs.niri.settings.window-rules = [
    {
      matches = [
        { app-id = "^org\\.wezfurlong\\.wezterm$"; }
      ];
      # Сюда можно добавлять действия для этого правила, например:
      # default-column-width = { };
    }
  ];
}
