{ stable, ... }: {
  programs.git = {
    enable = true;
    package = stable.git;

    ignores = [
      ".idea/"
      ".vscode/"
      "*.swp"
      "*~"

      ".direnv/"
      ".envrc.local"
    ];

    settings = {
      user = {
        name =  "Armag86x64";
        email = "120749588+Armag86x64@users.noreply.github.com"; 
      };
      init.defaultBranch = "main";
    };
  };
}
