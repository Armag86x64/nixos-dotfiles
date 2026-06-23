{ unstable, ... }: {
  programs.obsidian = {
    enable = true;
    package = unstable.obsidian;

    vaults = {
      main-vault = {
        enable = true;
        target = "~/Documents/Obsidian/";

        settings = {
          corePlugins = [
            "file-explorer"
            "graph"
          ];

          appearance = {
            cssTheme = "minimal";
            theme = "obsidian";
          };

          app = {
            "community-open" = true;
            communityPlugins = [
              "obsidian-minimal-settings"
              "obsidian-style-settings"
            ];
          };
        };
      };
    };
  };
}
