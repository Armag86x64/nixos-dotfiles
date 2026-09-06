{ ... }: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            "leftshift+leftmeta+f23" = "leftmeta";
          };
        };
      };
    };
  };
}
