{ ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com";

      padding = {
        top = 2;
      };
      
      display = {
        separator = " ::  ";
        color = {
          separator = "#465450"; # Приглушённый цвет разделителя ::
        };
      };

      logo = {
        padding = {
          top = 5;
        };
        color = {
          "1" = "#4ce0a8";
          "2" = "#4ce0a8";
          "3" = "#4ce0a8";
          "4" = "#4ce0a8";
          "5" = "#4ce0a8";
          "6" = "#4ce0a8";
        };
      };

      modules = [
        "break"
        "break"
        "break"
        {
          type = "custom";
          format = "{#264038}┌────────────────    B A S E    ────────────────┐\n";
        }
        {
          type = "chassis";
          key = "   ";
          format = "{1} {2} {3}";
          keyColor = "#4ce0a8";
        }
        {
          type = "os";
          key = "   ";
          format = "{2}";
          keyColor = "#4ce0a8";
        }
        {
          type = "kernel";
          key = "  󰌽 ";
          format = "{2}";
          keyColor = "#4ce0a8";
        }
        {
          type = "packages";
          key = "   ";
          keyColor = "#4ce0a8";
        }
        {
          type = "display";
          key = "  󰍹 ";
          format = "{1}x{2} @ {3}Hz [{7}]";
          keyColor = "#4ce0a8";
        }
        {
          type = "terminal";
          key = "   ";
          keyColor = "#4ce0a8";
        }
        {
          type = "wm";
          key = "   ";
          format = "{2}";
          keyColor = "#4ce0a8";
        }
        {
          type = "custom";
          format = "";
        }

        /* Basic hardware */ 
        {
          type = "custom";
          format = "├────────────────    H A R D    ────────────────┤\n";
        }

        {
          type = "cpu";
          format = "{name}";
          key = "   ";
          keyColor = "#4ce0a8";
        }
        {
          type = "gpu";
          format = "{1} {2} ({3})";
          key = "  󰨇 ";
          keyColor = "#4ce0a8";
        }
        {
          type = "memory";
          key = "   ";
          keyColor = "#4ce0a8";
        }
        {
          type = "disk";
          key = "   "; 
          folders = "/"; 
          format = "{1} / {2} ({3})"; 
          keyColor = "#4ce0a8";
        }
        {
          type = "battery";
          key = "   ";
          format = "{capacity} [{status}]";
          keyColor = "#4ce0a8";
        }

        { type = "custom"; format = ""; }
        {
          type = "custom";
          format = "├────────────────    T I M E    ────────────────┤";
        }
        { type = "custom"; format = ""; }

        /* T i m e */
        {
          type = "disk";
          key = "  󰃰 ";
          folders = "/";
          keyColor = "#4ce0a8";
          format = "{days} days"; # OS Age
        }
        {
          type = "uptime";
          key = "  󰃰 ";
          keyColor = "#4ce0a8";
        }

        { type = "custom"; format = ""; }
        {
          type = "custom";
          format = "└───────────────────────────────────────────────┘";
        }
        /*
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
        */
        "break"
        "break"
        "break"
      ];
    };
  };
}
