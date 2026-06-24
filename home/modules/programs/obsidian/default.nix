{ unstable, ... }: {
  home.packages = [
    unstable.obsidian
  ];

  xdg.configFile."obsidian/obsidian.json".enable = false;
}
