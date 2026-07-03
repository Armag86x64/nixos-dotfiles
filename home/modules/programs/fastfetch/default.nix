{ ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com";
      
      display = {
        separator = ": ";
      };

      logo = {
        color = {
          "1" = "#d5d5d5"; # Белый
          "2" = "#6f7987"; # Серый
          "3" = "#d5d5d5";
          "4" = "#b12a31";
          "5" = "#d5d5d5";
          "6" = "#b12a31";
        };
      };

      modules = [
        {
          type = "custom";
          format = "┌──────────────────────────────────────────┐\n";
        }
        {
          type = "chassis";
          key = "  Chassis";
          format = "{1} {2} {3}";
          keyColor = "#6f7987";
        }
        {
          type = "os";
          key = "  OS";
          format = "{2}";
          keyColor = "#6f7987";
        }
        {
          type = "kernel";
          key = "  Kernel";
          format = "{2}";
          keyColor = "#6f7987";
        }
        {
          type = "packages";
          key = "  Packages";
          keyColor = "#6f7987";
        }
        {
          type = "display";
          key = "  Display";
          format = "{1}x{2} @ {3}Hz [{7}]";
          keyColor = "#6f7987";
        }
        {
          type = "terminal";
          key = "  Terminal";
          keyColor = "#6f7987";
        }
        {
          type = "wm";
          key = "  DE/WM";
          format = "{2}";
          keyColor = "#6f7987";
        }
        {
          type = "custom";
          format = "";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────┘";
        }
        "break"
        {
          type = "title";
          key = " ";
          color = {
            user = "#d5d5d5";
            at = "#d5d5d5";
            host = "#d5d5d5";
          };
        }
        {
          type = "custom";
          format = "┌──────────────────────────────────────────┐\n";
        }
        {
          type = "cpu";
          format = "{1} @ {7}";
          key = "  CPU";
          keyColor = "#6f7987";
        }
        {
          type = "gpu";
          format = "{1} {2}";
          key = "  GPU:";
          keyColor = "#6f7987";
        }
        {
          type = "gpu";
          format = "{3}";
          key = "  GPU Driver";
          keyColor = "#6f7987";
        }
        {
          type = "memory";
          key = "  Memory";
          keyColor = "#6f7987";
        }
        {
          type = "disk";
          key = "  OS Age";
          folders = "/";
          keyColor = "#6f7987";
          format = "{days} days";
        }
        {
          type = "uptime";
          key = "  Uptime";
          keyColor = "#6f7987";
        }
        {
          type = "custom";
          format = "";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
        "break"
      ];
    };
  };
}
